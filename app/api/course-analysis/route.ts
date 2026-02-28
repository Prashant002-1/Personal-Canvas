import { createOpenRouter } from "@openrouter/ai-sdk-provider";
import { generateObject } from "ai";
import { z } from "zod";

export const maxDuration = 60;

const openrouter = createOpenRouter({
  apiKey: process.env.OPENROUTER_API_KEY,
});

type Course = {
  name: string;
  code: string;
  term_name: string;
  syllabus_html: string | null;
};

type Assignment = {
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

type RequestBody = {
  course: Course;
  assignments: Assignment[];
  modules: Module[];
  moduleItems: ModuleItem[];
};

const courseSchema = z.object({
  summary: z.string().describe("A 2-3 sentence executive summary of the course's current state"),
  nextSteps: z.array(z.object({
    action: z.string(),
    deadline: z.string().optional(),
    priority: z.enum(["high", "medium", "low"]),
  })).describe("Immediate next steps for the next 48 hours"),
  assignments: z.array(z.object({
    name: z.string(),
    effort: z.enum(["low", "medium", "high"]),
    concepts: z.array(z.string()),
    dueDate: z.string().optional(),
  })).describe("Breakdown of upcoming assignments"),
  moduleInsight: z.object({
    currentFocus: z.string(),
    keyTopics: z.array(z.string()),
    studyTip: z.string(),
  }).describe("Strategic view of what to focus on in the current module"),
});

export async function POST(req: Request) {
  const { course, assignments, modules, moduleItems } =
    (await req.json()) as RequestBody;

  const { object } = await generateObject({
    model: openrouter("arcee-ai/trinity-large-preview:free"),
    schema: courseSchema,
    prompt: `You are an expert academic AI assistant. Analyze this course and provide a structured deep dive.

Course: ${course.name} (${course.code}), Term: ${course.term_name}

Syllabus: ${course.syllabus_html ? course.syllabus_html.replace(/<[^>]*>?/gm, '').substring(0, 2000) : 'Not provided.'}

Assignments: ${assignments.map((assignment) => `${assignment.name} (Due: ${assignment.due_at ? new Date(assignment.due_at).toLocaleDateString() : 'No due date'}, ${assignment.points_possible} pts)`).join("; ")}

Modules: ${modules.map((module) => `${module.name} (${moduleItems.filter((item) => item.module_id === module.id).length} items)`).join("; ")}

Be specific and actionable. Do not repeat raw data back. Return plain text only — no markdown formatting, no asterisks, no bullet symbols, no headers.`,
  });

  return Response.json(object);
}
