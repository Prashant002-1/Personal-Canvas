"use client";

import { useEffect, useState } from "react";
import { ChatInterface } from "@/components/ai/ChatInterface";
import { readSessionJson, readLocalJson } from "@/lib/client-storage";
import { ArrowLeft } from "lucide-react";
import Link from "next/link";

type ChatContext = {
  type: "dashboard" | "course";
  title: string;
  contextData: string;
};

function toChatId(context: ChatContext | null): string {
  if (!context) return "general-chat";

  const base =
    context.type === "course" && context.title
      ? `course-${context.title}`
      : "dashboard-chat";

  const normalized = base
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 64);

  return normalized || "general-chat";
}

export default function ChatPage() {
  const [context, setContext] = useState<ChatContext | null>(null);
  const [botName, setBotName] = useState<string | null>(null);
  const chatId = toChatId(context);

  useEffect(() => {
    const storedContext = readSessionJson<ChatContext>("chat-context");
    if (storedContext) setContext(storedContext);
    const name = readLocalJson<string>("canvas-bot-name");
    if (name) setBotName(name);
  }, []);

  return (
    <div className="bg-background">
      {context?.title && (
        <div className="border-b bg-background/80 backdrop-blur-md px-6 py-3 flex items-center gap-3">
          <Link href="/" className="text-muted-foreground hover:text-foreground transition-colors">
            <ArrowLeft className="w-4 h-4" />
          </Link>
          <span className="text-sm text-muted-foreground">{context.title}</span>
        </div>
      )}
      <ChatInterface
        chatId={chatId}
        contextData={context?.contextData ?? ""}
        botName={botName}
      />
    </div>
  );
}
