"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { ChatInterface } from "@/components/ai/ChatInterface";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Sparkles } from "lucide-react";

type ChatContext = {
  type: "dashboard" | "course";
  title: string;
  contextData: string;
};

export default function ChatPage() {
  const router = useRouter();
  const [context, setContext] = useState<ChatContext | null>(null);

  useEffect(() => {
    try {
      const raw = sessionStorage.getItem("chat-context");
      if (raw) setContext(JSON.parse(raw));
    } catch {}
  }, []);

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <div className="border-b bg-card/50 backdrop-blur-sm sticky top-0 z-10">
        <div className="max-w-4xl mx-auto px-6 py-4 flex items-center gap-4">
          <Button variant="ghost" size="icon" onClick={() => router.back()} className="rounded-full shrink-0">
            <ArrowLeft className="w-5 h-5" />
          </Button>
          <div className="flex items-center gap-2 min-w-0">
            <Sparkles className="w-5 h-5 text-primary shrink-0" />
            <div className="min-w-0">
              <h1 className="font-semibold text-base leading-tight truncate">AI Assistant</h1>
              {context?.title && (
                <p className="text-xs text-muted-foreground truncate">{context.title}</p>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="flex-1 max-w-4xl w-full mx-auto px-6 py-6 flex flex-col">
        <ChatInterface
          contextData={context?.contextData ?? ""}
          className="flex-1 rounded-3xl"
        />
      </div>
    </div>
  );
}
