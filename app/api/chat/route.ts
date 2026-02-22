import { createOpenRouter } from '@openrouter/ai-sdk-provider';
import { generateText } from 'ai';

export const maxDuration = 30;

const openrouter = createOpenRouter({
  apiKey: process.env.OPENROUTER_API_KEY,
});

export async function POST(req: Request) {
  const { messages, context } = await req.json();

  const { text } = await generateText({
    model: openrouter('arcee-ai/trinity-large-preview:free'),
    messages,
    system: `You are an expert academic advisor and study planner.
Your goal is to help the student understand their courses, assignments, and deadlines.
Keep your tone encouraging, concise, and structured. Use markdown for formatting.

Current context:
${context}`,
  });

  return Response.json({ reply: text });
}
