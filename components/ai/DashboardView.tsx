"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { DashboardDeepDive } from "./DashboardDeepDive";
import { Button } from "@/components/ui/button";
import { Sparkles, RotateCcw, MessageSquare } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";

export function DashboardView({
  courses,
  upcomingAssignments,
  standardView,
}: {
  courses: any[];
  upcomingAssignments: any[];
  standardView: React.ReactNode;
}) {
  const router = useRouter();
  const [insightsVisible, setInsightsVisible] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    try {
      if (localStorage.getItem("dashboard-insights")) {
        setInsightsVisible(true);
      }
    } catch {}
  }, []);

  function handleGenerate() {
    setInsightsVisible(true);
  }

  function handleRefresh() {
    setRefreshKey((k) => k + 1);
  }

  function handleChat() {
    try {
      sessionStorage.setItem(
        "chat-context",
        JSON.stringify({
          type: "dashboard",
          title: "Dashboard",
          contextData: `Courses: ${courses.map((c) => c.name).join(", ")}\nUpcoming Assignments: ${upcomingAssignments.map((a) => `${a.name} (Due: ${a.due_at})`).join(", ")}`,
        })
      );
    } catch {}
    router.push("/chat");
  }

  return (
    <div className="space-y-8">
      <div className="flex items-center justify-end gap-2">
        {insightsVisible && (
          <>
            <Button variant="ghost" size="sm" onClick={handleChat} className="gap-2 text-muted-foreground hover:text-foreground">
              <MessageSquare className="w-4 h-4" />
              Chat with AI
            </Button>
            <Button variant="outline" size="sm" onClick={handleRefresh} className="gap-2">
              <RotateCcw className="w-4 h-4" />
              Refresh
            </Button>
          </>
        )}
        {!insightsVisible && (
          <Button size="sm" onClick={handleGenerate} className="gap-2">
            <Sparkles className="w-4 h-4" />
            Generate AI Insights
          </Button>
        )}
      </div>

      <AnimatePresence>
        {insightsVisible && (
          <motion.div
            key="ai-insights"
            initial={{ opacity: 0, y: -16 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -16 }}
            transition={{ duration: 0.3 }}
          >
            <DashboardDeepDive
              courses={courses}
              upcomingAssignments={upcomingAssignments}
              refreshKey={refreshKey}
            />
          </motion.div>
        )}
      </AnimatePresence>

      {standardView}
    </div>
  );
}
