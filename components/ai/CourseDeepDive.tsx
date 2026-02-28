"use client";

import { useEffect, useState } from "react";
import { motion } from "framer-motion";
import { Sparkles, ArrowRight, BookOpen, Lightbulb } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { readLocalJson, removeLocalKey, writeLocalJson } from "@/lib/client-storage";

type NextStep = { action: string; deadline?: string; priority: "high" | "medium" | "low" };
type Assignment = { name: string; effort: "low" | "medium" | "high"; concepts: string[]; dueDate?: string };
type ModuleInsight = { currentFocus: string; keyTopics: string[]; studyTip: string };
type CourseData = { summary: string; nextSteps: NextStep[]; assignments: Assignment[]; moduleInsight: ModuleInsight };
type Course = {
  id: number;
  name: string;
  code: string;
  term_name: string | null;
  syllabus_html: string | null;
};
type CourseAssignment = {
  name: string;
  due_at: string | null;
  points_possible: number | null;
};
type Module = {
  id: number;
  name: string;
};
type ModuleItem = {
  module_id: number;
};

const priorityConfig: Record<NextStep["priority"], string> = {
  high: "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400 border-red-200 dark:border-red-800",
  medium: "bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400 border-amber-200 dark:border-amber-800",
  low: "bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400 border-emerald-200 dark:border-emerald-800",
};

const effortConfig: Record<Assignment["effort"], { label: string; className: string }> = {
  high: { label: "Heavy lift", className: "bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400" },
  medium: { label: "Moderate", className: "bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400" },
  low: { label: "Light", className: "bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400" },
};

export function CourseDeepDive({
  course,
  assignments,
  modules,
  moduleItems,
  refreshKey = 0,
}: {
  course: Course;
  assignments: CourseAssignment[];
  modules: Module[];
  moduleItems: ModuleItem[];
  refreshKey?: number;
}) {
  const [data, setData] = useState<CourseData | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const cacheKey = `course-insights-${course?.id}`;

  useEffect(() => {
    if (refreshKey === 0) {
      const cached = readLocalJson<CourseData>(cacheKey);
      if (cached) {
        setData(cached);
        setIsLoading(false);
        return;
      }
    } else {
      removeLocalKey(cacheKey);
    }

    setIsLoading(true);
    setError(null);
    fetch("/api/course-analysis", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ course, assignments, modules, moduleItems }),
    })
      .then(async (response) => {
        if (!response.ok) {
          throw new Error("Failed to load course analysis.");
        }
        return (await response.json()) as CourseData;
      })
      .then((payload) => {
        writeLocalJson(cacheKey, payload);
        setData(payload);
      })
      .catch((fetchError: unknown) => {
        const message =
          fetchError instanceof Error ? fetchError.message : "Failed to load course analysis.";
        setError(message);
      })
      .finally(() => setIsLoading(false));
  }, [assignments, cacheKey, course, moduleItems, modules, refreshKey]);

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center py-24 text-center border rounded-3xl bg-card/50 backdrop-blur-sm">
        <div className="w-16 h-16 border-4 border-primary/20 border-t-primary rounded-full animate-spin mb-6" />
        <h3 className="text-xl font-semibold mb-2">AI is analyzing your course...</h3>
        <p className="text-muted-foreground max-w-md">Reading the syllabus, cross-referencing deadlines, and building your personalized deep dive.</p>
      </div>
    );
  }

  if (error || !data) return null;

  return (
    <motion.section initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-6">
      <div className="flex items-center gap-2 text-primary font-medium">
        <Sparkles className="w-5 h-5" />
        <span>Course Deep Dive</span>
      </div>

      {data.summary && (
        <div className="bg-card border rounded-3xl p-6 shadow-sm relative overflow-hidden">
          <div className="absolute top-0 right-0 w-48 h-48 bg-primary/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2" />
          <p className="relative z-10 text-base leading-relaxed text-foreground/90">{data.summary}</p>
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {data.nextSteps?.length > 0 && (
          <div className="bg-card border rounded-2xl p-5 shadow-sm">
            <div className="flex items-center gap-2 mb-4">
              <ArrowRight className="w-4 h-4 text-muted-foreground" />
              <h3 className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">Next 48 Hours</h3>
            </div>
            <div className="space-y-3">
              {data.nextSteps.map((step, i) => (
                <div key={i} className="flex items-start gap-3">
                  <Badge variant="outline" className={`text-xs shrink-0 mt-0.5 ${priorityConfig[step.priority]}`}>{step.priority}</Badge>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm leading-snug">{step.action}</p>
                    {step.deadline && <p className="text-xs text-muted-foreground mt-0.5">{step.deadline}</p>}
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {data.moduleInsight && (
          <div className="bg-card border rounded-2xl p-5 shadow-sm">
            <div className="flex items-center gap-2 mb-4">
              <Lightbulb className="w-4 h-4 text-muted-foreground" />
              <h3 className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">Current Focus</h3>
            </div>
            <p className="text-sm font-medium mb-3">{data.moduleInsight.currentFocus}</p>
            {data.moduleInsight.keyTopics?.length > 0 && (
              <div className="flex flex-wrap gap-2 mb-3">
                {data.moduleInsight.keyTopics.map((topic, i) => (
                  <Badge key={i} variant="secondary" className="text-xs">{topic}</Badge>
                ))}
              </div>
            )}
            {data.moduleInsight.studyTip && (
              <p className="text-xs text-muted-foreground leading-relaxed border-t pt-3 mt-1">{data.moduleInsight.studyTip}</p>
            )}
          </div>
        )}
      </div>

      {data.assignments?.length > 0 && (
        <div>
          <div className="flex items-center gap-2 mb-4">
            <BookOpen className="w-4 h-4 text-muted-foreground" />
            <h3 className="text-sm font-semibold uppercase tracking-wide text-muted-foreground">Assignment Breakdown</h3>
          </div>
          <div className="grid grid-cols-1 gap-3">
            {data.assignments.map((a, i) => (
              <div key={i} className="bg-card border rounded-2xl p-4 shadow-sm flex items-start gap-4">
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-2 flex-wrap">
                    <h4 className="text-sm font-medium truncate">{a.name}</h4>
                    {a.dueDate && <span className="text-xs text-muted-foreground">· {a.dueDate}</span>}
                  </div>
                  {a.concepts?.length > 0 && (
                    <div className="flex flex-wrap gap-1.5">
                      {a.concepts.map((c, j) => <Badge key={j} variant="outline" className="text-xs">{c}</Badge>)}
                    </div>
                  )}
                </div>
                {a.effort && (
                  <Badge className={`text-xs shrink-0 border-0 ${effortConfig[a.effort]?.className}`}>
                    {effortConfig[a.effort]?.label}
                  </Badge>
                )}
              </div>
            ))}
          </div>
        </div>
      )}
    </motion.section>
  );
}
