import { query } from "@/lib/db";
import { CourseView } from "@/components/ai/CourseView";
import Link from "next/link";
import { LayoutList, CheckCircle2 } from "lucide-react";

export default async function CoursePage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  
  const { rows: courses } = await query(
    "SELECT id, name, code, term_name, start_date, end_date, syllabus_html FROM courses WHERE id = $1",
    [id]
  );

  if (courses.length === 0) {
    return <div>Course not found</div>;
  }

  const course = courses[0];

  const { rows: assignments } = await query(
    "SELECT id, name, due_at, points_possible, description FROM assignments WHERE course_id = $1 ORDER BY due_at ASC NULLS LAST",
    [id]
  );

  const { rows: modules } = await query(
    "SELECT id, name, position FROM modules WHERE course_id = $1 ORDER BY position",
    [id]
  );

  const { rows: moduleItems } = await query(
    "SELECT id, module_id, title, type, position FROM module_items WHERE course_id = $1 ORDER BY module_id, position",
    [id]
  );

  return (
    <main className="min-h-screen p-8 max-w-7xl mx-auto">
      <Link href="/" className="text-sm text-muted-foreground hover:text-primary mb-8 inline-block transition-colors">
        ← Back to Dashboard
      </Link>
      
      <header className="mb-12 bg-card border rounded-3xl p-8 shadow-sm relative overflow-hidden">
        <div className="absolute top-0 right-0 w-64 h-64 bg-primary/5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2" />
        <div className="relative z-10">
          <div className="flex items-center gap-3 mb-4">
            <span className="px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-semibold tracking-wide uppercase">
              {course.code}
            </span>
            <span className="text-sm font-medium text-muted-foreground">
              {course.term_name}
            </span>
          </div>
          <h1 className="text-4xl md:text-5xl font-bold tracking-tight mb-4">{course.name}</h1>
          <div className="flex flex-wrap gap-6 text-sm text-muted-foreground">
            <div className="flex items-center gap-2">
              <LayoutList className="w-4 h-4" />
              {modules.length} Modules
            </div>
            <div className="flex items-center gap-2">
              <CheckCircle2 className="w-4 h-4" />
              {assignments.length} Assignments
            </div>
          </div>
        </div>
      </header>

      <CourseView 
        course={course}
        assignments={assignments}
        modules={modules}
        moduleItems={moduleItems}
        standardView={
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div className="lg:col-span-2 space-y-8">
              <h2 className="text-2xl font-semibold flex items-center gap-2">
                <LayoutList className="w-5 h-5 text-primary" />
                Modules
              </h2>
              <div className="space-y-4">
                {modules.map((module) => (
                  <div key={module.id} className="border rounded-2xl bg-card overflow-hidden">
                    <div className="p-4 bg-muted/30 border-b font-medium">
                      {module.name}
                    </div>
                    <div className="divide-y">
                      {moduleItems
                        .filter((item) => item.module_id === module.id)
                        .map((item) => (
                          <div key={item.id} className="p-4 text-sm hover:bg-muted/50 transition-colors flex items-center gap-3">
                            <div className="w-2 h-2 rounded-full bg-primary/50" />
                            {item.title}
                          </div>
                        ))}
                      {moduleItems.filter((item) => item.module_id === module.id).length === 0 && (
                        <div className="p-4 text-sm text-muted-foreground italic">
                          No items in this module.
                        </div>
                      )}
                    </div>
                  </div>
                ))}
                {modules.length === 0 && (
                  <div className="p-8 text-center border rounded-2xl bg-card text-muted-foreground">
                    No modules found for this course.
                  </div>
                )}
              </div>
            </div>

            <div className="space-y-8">
              <h2 className="text-2xl font-semibold flex items-center gap-2">
                <CheckCircle2 className="w-5 h-5 text-primary" />
                Assignments
              </h2>
              <div className="border rounded-2xl bg-card overflow-hidden divide-y">
                {assignments.map((assignment) => (
                  <div key={assignment.id} className="p-4 hover:bg-muted/50 transition-colors">
                    <h4 className="font-medium text-sm mb-1">{assignment.name}</h4>
                    <div className="flex items-center justify-between text-xs text-muted-foreground">
                      <span>
                        {assignment.due_at ? new Date(assignment.due_at).toLocaleDateString() : "No due date"}
                      </span>
                      {assignment.points_possible !== null && (
                        <span className="font-medium text-primary/80">{assignment.points_possible} pts</span>
                      )}
                    </div>
                  </div>
                ))}
                {assignments.length === 0 && (
                  <div className="p-8 text-center text-muted-foreground text-sm">
                    No assignments found.
                  </div>
                )}
              </div>
            </div>
          </div>
        }
      />
    </main>
  );
}
