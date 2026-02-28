import { createOpenRouter } from "@openrouter/ai-sdk-provider";
import {
  convertToModelMessages,
  createIdGenerator,
  stepCountIs,
  streamText,
  type UIMessage,
  validateUIMessages,
} from "ai";
import { createChatTools } from "@/lib/ai/chat-tools";
import {
  appendChatTranscript,
  extractMemoriesFromUserText,
  loadChatSession,
  recomputePlannerState,
  saveChatSession,
  withChatLock,
} from "@/lib/ai/chat-store";

export const maxDuration = 60;

const openrouter = createOpenRouter({
  apiKey: process.env.OPENROUTER_API_KEY,
});

const messageIdGenerator = createIdGenerator({
  prefix: "msg",
  size: 16,
});

const MAX_MESSAGES_BEFORE_COMPACTION = 30;
const MESSAGES_TO_KEEP_AFTER_COMPACTION = 18;

function normalizeChatId(value: unknown): string {
  if (typeof value === "string" && value.trim().length > 0) {
    return value.trim();
  }
  return `chat-${Date.now()}`;
}

function normalizeContext(value: unknown): string | null {
  if (typeof value === "string") return value;
  return null;
}

function normalizeIncomingMessages(value: unknown): UIMessage[] {
  if (Array.isArray(value)) return value as UIMessage[];
  return [];
}

function normalizeIncomingMessage(value: unknown): UIMessage | null {
  if (value && typeof value === "object") return value as UIMessage;
  return null;
}

function extractTextFromMessage(message: UIMessage): string {
  return message.parts
    .filter((part): part is { type: "text"; text: string } => part.type === "text")
    .map((part) => part.text.trim())
    .filter(Boolean)
    .join("\n");
}

function compactMessages({
  messages,
  existingSummary,
}: {
  messages: UIMessage[];
  existingSummary: string | null;
}): { messages: UIMessage[]; summary: string | null; compacted: boolean } {
  if (messages.length <= MAX_MESSAGES_BEFORE_COMPACTION) {
    return {
      messages,
      summary: existingSummary,
      compacted: false,
    };
  }

  const olderMessages = messages.slice(0, -MESSAGES_TO_KEEP_AFTER_COMPACTION);
  const recentMessages = messages.slice(-MESSAGES_TO_KEEP_AFTER_COMPACTION);

  const compactableLines = olderMessages
    .map((message) => {
      const role = message.role === "assistant" ? "Assistant" : "User";
      const text = extractTextFromMessage(message);
      if (!text) return null;
      return `- ${role}: ${text.replace(/\s+/g, " ").slice(0, 220)}`;
    })
    .filter((line): line is string => Boolean(line));

  const deltaSummary =
    compactableLines.length > 0
      ? compactableLines.slice(-20).join("\n")
      : "- Prior conversation context retained.";

  const mergedSummary = [existingSummary, "Compacted history", deltaSummary]
    .filter(Boolean)
    .join("\n\n")
    .slice(0, 3200);

  const summaryMessage: UIMessage = {
    id: `summary-${Date.now()}`,
    role: "system",
    parts: [
      {
        type: "text",
        text: `Conversation summary (compressed context):\n${mergedSummary}`,
      },
    ],
  };

  return {
    messages: [summaryMessage, ...recentMessages],
    summary: mergedSummary,
    compacted: true,
  };
}

export async function GET(req: Request) {
  const url = new URL(req.url);
  const chatId = url.searchParams.get("chatId");

  if (!chatId) {
    return Response.json({ error: "chatId is required." }, { status: 400 });
  }

  const storedSession = await loadChatSession(chatId);
  const validatedMessages = await validateUIMessages<UIMessage>({
    messages: storedSession.messages,
  });

  return Response.json({
    chatId,
    context: storedSession.contextData,
    summary: storedSession.summary,
    messages: validatedMessages,
  });
}

export async function POST(req: Request) {
  const body = await req.json();
  const chatId = normalizeChatId(body.id);
  const context = normalizeContext(body.context);
  const incomingMessages = normalizeIncomingMessages(body.messages);
  const incomingMessage = normalizeIncomingMessage(body.message);

  return withChatLock(chatId, async () => {
    const startedAt = Date.now();
    const tools = createChatTools({ chatId });
    const storedSession = await loadChatSession(chatId);

    let mergedMessages: UIMessage[] = storedSession.messages;
    if (incomingMessages.length > 0) {
      mergedMessages = incomingMessages;
    } else if (incomingMessage) {
      mergedMessages = [...storedSession.messages, incomingMessage];
    }

    if (incomingMessage?.role === "user") {
      const extracted = await extractMemoriesFromUserText({
        chatId,
        text: extractTextFromMessage(incomingMessage),
      });
      if (extracted > 0) {
        await appendChatTranscript(chatId, [
          {
            type: "event",
            event: "memory-auto-extracted",
            details: { count: extracted },
          },
        ]);
      }

      await appendChatTranscript(chatId, [
        {
          type: "message",
          role: "user",
          message: incomingMessage,
        },
      ]);
    }

    const planner = await recomputePlannerState(chatId);
    if (planner.changed && planner.eventType) {
      await appendChatTranscript(chatId, [
        {
          type: "event",
          event: planner.eventType,
          details: {
            dueTodayCount: planner.snapshot.dueToday.length,
            overdueCount: planner.snapshot.overdue.length,
            announcementsCount: planner.snapshot.recentAnnouncements.length,
            todayEventsCount: planner.snapshot.todayEvents.length,
          },
        },
      ]);
    }

    const validatedMessages = await validateUIMessages<UIMessage>({
      messages: mergedMessages,
    });

    const compacted = compactMessages({
      messages: validatedMessages,
      existingSummary: storedSession.summary,
    });

    if (compacted.compacted) {
      await appendChatTranscript(chatId, [
        {
          type: "event",
          event: "context-compacted",
          details: {
            originalMessageCount: validatedMessages.length,
            compactedMessageCount: compacted.messages.length,
          },
        },
      ]);
    }

    const modelMessages = await convertToModelMessages(compacted.messages, {
      tools,
    });

    const result = streamText({
      model: openrouter("openai/gpt-4o-mini"),
      messages: modelMessages,
      tools,
      stopWhen: stepCountIs(8),
      system: `You are Personal Canvas, an academic planning AI orchestrator.
Use tools whenever the user asks for concrete, up-to-date course data.
Prefer tool-grounded answers over assumptions.
When tool output includes "uiTarget", summarize it clearly so the UI can render and the user can understand.
If context is missing for the request, ask targeted follow-up questions.

Current context:
${context ?? "No context provided."}

Reactive planner snapshot:
- due today: ${planner.snapshot.dueToday.length}
- overdue: ${planner.snapshot.overdue.length}
- recent announcements: ${planner.snapshot.recentAnnouncements.length}
- today's events: ${planner.snapshot.todayEvents.length}`,
    });

    result.consumeStream();

    return result.toUIMessageStreamResponse({
      originalMessages: compacted.messages,
      generateMessageId: messageIdGenerator,
      onFinish: async ({ messages: finalMessages, responseMessage }) => {
        await saveChatSession({
          chatId,
          contextData: context,
          summary: compacted.summary,
          messages: finalMessages,
        });

        await appendChatTranscript(chatId, [
          {
            type: "message",
            role: "assistant",
            message: responseMessage,
          },
          {
            type: "event",
            event: "turn-finished",
            details: {
              messageCount: finalMessages.length,
              durationMs: Date.now() - startedAt,
            },
          },
        ]);
      },
    });
  });
}
