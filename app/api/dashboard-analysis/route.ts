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
};

type UpcomingAssignment = {
  name: string;
  due_at: string | null;
  course_code: string;
};

type RequestBody = {
  courses: Course[];
  upcomingAssignments: UpcomingAssignment[];
};

const dashboardSchema = z.object({
  briefing: z.string().describe("A 2-3 sentence encouraging daily briefing for the student"),
  priorities: z.array(z.object({
    title: z.string(),
    description: z.string(),
    urgency: z.enum(["high", "medium", "low"]),
    course: z.string(),
  })).describe("Top 3 priorities for today"),
  insight: z.string().describe("A strategic insight about the upcoming workload"),
  workloadWarning: z.string().optional().describe("A warning if a cluster of deadlines is approaching"),
});

export async function POST(req: Request) {
  const { courses, upcomingAssignments } = (await req.json()) as RequestBody;

  const { object } = await generateObject({
    model: openrouter("arcee-ai/trinity-large-preview:free"),
    schema: dashboardSchema,
    prompt: `You are an expert academic AI assistant. Analyze this student's academic landscape and provide a structured daily briefing.

Courses: ${courses.map((course) => `${course.name} (${course.code})`).join(", ")}

Upcoming Assignments:
${upcomingAssignments.map((assignment) => `- ${assignment.name} in ${assignment.course_code} (Due: ${assignment.due_at ? new Date(assignment.due_at).toLocaleDateString() : "No due date"})`).join("\n")}

Provide a helpful, personalized analysis. Be specific, not generic.`,
  });

  return Response.json(object);
}
