"use client";

import { useState } from "react";
import { ChatInterface } from "@/components/ai/ChatInterface";
import { readLocalJson } from "@/lib/client-storage";

export default function ChatPage() {
  const [botName] = useState<string | null>(() =>
    readLocalJson<string>("canvas-bot-name")
  );

  return (
    <div className="bg-background">
      <ChatInterface
        chatId="general-chat"
        contextData=""
        botName={botName}
      />
    </div>
  );
}
