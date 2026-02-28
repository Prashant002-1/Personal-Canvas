"use client";

import { useState, useRef, useEffect } from "react";
import { useChat } from "@ai-sdk/react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Bot, Send, User, Sparkles } from "lucide-react";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import {
  DefaultChatTransport,
  lastAssistantMessageIsCompleteWithToolCalls,
  type UIMessage,
} from "ai";

type ToolOutputPart = Extract<
  UIMessage["parts"][number],
  { type: `tool-${string}` | "dynamic-tool" }
>;

function isToolOutputPart(
  part: UIMessage["parts"][number]
): part is ToolOutputPart {
  return part.type === "dynamic-tool" || part.type.startsWith("tool-");
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null;
}

function extractMessageText(message: UIMessage): string {
  return message.parts
    .filter((part): part is { type: "text"; text: string } => part.type === "text")
    .map((part) => part.text)
    .join("\n");
}

export function ChatInterface({
  chatId,
  contextData,
  className,
}: {
  chatId: string;
  contextData: string;
  className?: string;
}) {
  const [input, setInput] = useState("");
  const scrollRef = useRef<HTMLDivElement>(null);
  const { messages, sendMessage, status, error, setMessages } = useChat({
    id: chatId,
    transport: new DefaultChatTransport({
      api: "/api/chat",
      prepareSendMessagesRequest: ({ id, messages }) => ({
        body: {
          id,
          message: messages[messages.length - 1],
          context: contextData,
        },
      }),
    }),
    sendAutomaticallyWhen: lastAssistantMessageIsCompleteWithToolCalls,
  });

  const isLoading = status === "submitted" || status === "streaming";

  useEffect(() => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  }, [messages, status]);

  useEffect(() => {
    let ignore = false;

    async function loadHistory() {
      const res = await fetch(`/api/chat?chatId=${encodeURIComponent(chatId)}`);
      if (!res.ok) return;

      const data: { messages?: UIMessage[] } = await res.json();
      if (!ignore && Array.isArray(data.messages)) {
        setMessages(data.messages);
      }
    }

    loadHistory();

    return () => {
      ignore = true;
    };
  }, [chatId, setMessages]);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const text = input.trim();
    if (!text || isLoading) return;

    await sendMessage({ text });
    setInput("");
  }

  return (
    <div className={`flex flex-col border rounded-3xl bg-card shadow-sm overflow-hidden ${className ?? "h-[500px]"}`}>
      <div className="p-4 border-b bg-muted/30 flex items-center gap-2">
        <Sparkles className="w-5 h-5 text-primary" />
        <h3 className="font-semibold">AI Assistant</h3>
      </div>

      <ScrollArea className="flex-1 p-4" ref={scrollRef}>
        <div className="space-y-4">
          {messages.length === 0 && (
            <div className="text-center text-muted-foreground py-8">
              <Bot className="w-8 h-8 mx-auto mb-3 opacity-50" />
              <p className="text-sm">Ask about coursework, deadlines, or planning.</p>
            </div>
          )}

          {messages.map((m) => {
            const text = extractMessageText(m);
            const toolParts = m.parts.filter(isToolOutputPart);

            return (
            <div key={m.id} className={`flex gap-3 ${m.role === "user" ? "flex-row-reverse" : ""}`}>
              <div className={`w-8 h-8 rounded-full flex items-center justify-center shrink-0 ${m.role === "user" ? "bg-primary text-primary-foreground" : "bg-muted text-foreground"}`}>
                {m.role === "user" ? <User className="w-4 h-4" /> : <Bot className="w-4 h-4" />}
              </div>
              <div className={`px-4 py-3 rounded-2xl max-w-[80%] ${m.role === "user" ? "bg-primary text-primary-foreground rounded-tr-sm" : "bg-muted/50 rounded-tl-sm"}`}>
                {text && (
                  <div className="prose prose-sm dark:prose-invert max-w-none prose-p:leading-relaxed">
                    <ReactMarkdown remarkPlugins={[remarkGfm]}>{text}</ReactMarkdown>
                  </div>
                )}

                {m.role === "assistant" && toolParts.length > 0 && (
                  <div className={`space-y-2 ${text ? "mt-3" : ""}`}>
                    {toolParts.map((part) => {
                      if (part.state === "output-error") {
                        return (
                          <div key={part.toolCallId} className="rounded-lg border border-red-300/40 bg-red-500/5 p-2 text-xs">
                            Tool error: {part.errorText ?? "Unknown error"}
                          </div>
                        );
                      }

                      if (part.state === "output-available") {
                        const output = part.output;
                        const summary =
                          isRecord(output) && typeof output.summary === "string"
                            ? output.summary
                            : null;
                        const uiTarget =
                          isRecord(output) && typeof output.uiTarget === "string"
                            ? output.uiTarget
                            : null;

                        return (
                          <div key={part.toolCallId} className="rounded-lg border bg-background/70 p-2 text-xs">
                            <p className="font-medium">
                              {summary ?? (uiTarget ? "Data loaded for this request." : "Analysis updated.")}
                            </p>
                          </div>
                        );
                      }

                      return (
                        <div key={part.toolCallId} className="rounded-lg border bg-background/50 p-2 text-xs text-muted-foreground">
                          Processing your request...
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>
          )})}

          {isLoading && (
            <div className="flex gap-3">
              <div className="w-8 h-8 rounded-full bg-muted flex items-center justify-center shrink-0">
                <Bot className="w-4 h-4" />
              </div>
              <div className="px-4 py-3 rounded-2xl bg-muted/50 rounded-tl-sm flex items-center gap-1">
                <div className="w-2 h-2 bg-foreground/30 rounded-full animate-bounce" />
                <div className="w-2 h-2 bg-foreground/30 rounded-full animate-bounce [animation-delay:0.2s]" />
                <div className="w-2 h-2 bg-foreground/30 rounded-full animate-bounce [animation-delay:0.4s]" />
              </div>
            </div>
          )}

          {error && (
            <div className="rounded-xl border border-red-300/40 bg-red-500/5 p-3 text-sm text-red-700 dark:text-red-300">
              {error.message}
            </div>
          )}
        </div>
      </ScrollArea>

      <div className="p-4 border-t bg-background">
        <form onSubmit={handleSubmit} className="flex gap-2">
          <Input
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Ask a question..."
            className="rounded-full bg-muted/50 border-transparent focus-visible:bg-background"
          />
          <Button type="submit" size="icon" className="rounded-full shrink-0" disabled={isLoading || !input.trim()}>
            <Send className="w-4 h-4" />
          </Button>
        </form>
      </div>
    </div>
  );
}
