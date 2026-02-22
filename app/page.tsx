import { query } from "@/lib/db";
import Link from "next/link";
import { Calendar, BookOpen, Clock, ChevronRight, LayoutDashboard, Sparkles } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { DashboardView } from "@/components/ai/DashboardView";

export default async function Home() {
  const { rows: courses } = await query(
    "SELECT id, name, code, term_name FROM courses ORDER BY id"
  );

  const { rows: upcomingAssignments } = await query(`
    SELECT a.id, a.name, a.due_at, c.name as course_name, c.code as course_code, c.id as course_id
    FROM assignments a
    JOIN courses c ON a.course_id = c.id
    WHERE a.due_at > NOW() OR a.due_at IS NULL
    ORDER BY a.due_at ASC NULLS LAST
    LIMIT 6
  `);

  return (
    <main className="min-h-screen p-8 max-w-7xl mx-auto">
      <header className="mb-12 flex items-center justify-between">
        <div>
          <div className="flex items-center gap-3 mb-2">
            <div className="w-10 h-10 bg-primary text-primary-foreground rounded-xl flex items-center justify-center shadow-sm">
              <LayoutDashboard className="w-5 h-5" />
            </div>
            <h1 className="text-4xl font-bold tracking-tight">Personal Canvas</h1>
          </div>
          <p className="text-muted-foreground text-lg ml-13">
            Welcome back. Here's what's happening in your courses.
          </p>
        </div>
      </header>

      {courses.length === 0 ? (
        <div className="flex flex-col items-center justify-center py-24 text-center border rounded-2xl bg-card/50 backdrop-blur-sm">
          <div className="w-16 h-16 bg-muted rounded-full flex items-center justify-center mb-4">
            <span className="text-2xl">📚</span>
          </div>
          <h2 className="text-xl font-semibold">No courses found</h2>
          <p className="text-muted-foreground mt-2 max-w-md">
            Run the parser script to fetch your Canvas data and populate the database.
          </p>
        </div>
      ) : (
        <DashboardView 
          courses={courses} 
          upcomingAssignments={upcomingAssignments} 
          standardView={
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
              {/* Main Content: Courses */}
              <div className="lg:col-span-2 space-y-8">
              <div className="flex items-center justify-between">
                <h2 className="text-2xl font-semibold flex items-center gap-2">
                  <BookOpen className="w-5 h-5 text-primary" />
                  Your Courses
                </h2>
                <Badge variant="secondary" className="rounded-full px-3">
                  {courses.length} Active
                </Badge>
              </div>
              
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {courses.map((course, i) => {
                  // Generate a subtle gradient based on index for visual variety
                  const gradients = [
                    "from-blue-500/10 to-cyan-500/10",
                    "from-purple-500/10 to-indigo-500/10",
                    "from-emerald-500/10 to-teal-500/10",
                    "from-orange-500/10 to-amber-500/10"
                  ];
                  const gradient = gradients[i % gradients.length];

                  return (
                    <Link key={course.id} href={`/courses/${course.id}`}>
                      <div className={`group relative overflow-hidden rounded-2xl border bg-card p-6 hover:shadow-lg transition-all duration-300 hover:-translate-y-1 flex flex-col h-full`}>
                        <div className={`absolute inset-0 bg-gradient-to-br ${gradient} opacity-50`} />
                        
                        <div className="relative z-10 flex flex-col h-full justify-between gap-6">
                          <div>
                            <div className="flex justify-between items-start mb-3">
                              <Badge variant="outline" className="bg-background/50 backdrop-blur-sm">
                                {course.code}
                              </Badge>
                              <span className="text-xs font-medium text-muted-foreground">
                                {course.term_name}
                              </span>
                            </div>
                            <h3 className="text-xl font-semibold leading-tight group-hover:text-primary transition-colors line-clamp-2">
                              {course.name}
                            </h3>
                          </div>
                          
                          <div className="space-y-3">
                            <div className="flex justify-between text-xs text-muted-foreground">
                              <span>Course Progress</span>
                              <span>In Progress</span>
                            </div>
                            <Progress value={33} className="h-1.5" />
                            
                            <div className="pt-2 flex items-center text-sm font-medium text-primary opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all duration-300">
                              Open Workspace <ChevronRight className="w-4 h-4 ml-1" />
                            </div>
                          </div>
                        </div>
                      </div>
                    </Link>
                  );
                })}
              </div>
            </div>

            {/* Sidebar: Upcoming Deadlines */}
            <div className="space-y-8">
              <div className="flex items-center gap-2">
                <Calendar className="w-5 h-5 text-primary" />
                <h2 className="text-2xl font-semibold">Up Next</h2>
              </div>

              <div className="rounded-2xl border bg-card overflow-hidden shadow-sm">
                {upcomingAssignments.length === 0 ? (
                  <div className="p-8 text-center text-muted-foreground text-sm">
                    No upcoming assignments. You're all caught up!
                  </div>
                ) : (
                  <div className="divide-y">
                    {upcomingAssignments.map((assignment) => (
                      <Link 
                        key={assignment.id} 
                        href={`/courses/${assignment.course_id}`}
                        className="block p-4 hover:bg-muted/50 transition-colors group"
                      >
                        <div className="flex gap-4">
                          <div className="mt-1">
                            <div className="w-8 h-8 rounded-full bg-primary/10 text-primary flex items-center justify-center">
                              <Clock className="w-4 h-4" />
                            </div>
                          </div>
                          <div className="flex-1 min-w-0">
                            <h4 className="font-medium text-sm truncate group-hover:text-primary transition-colors">
                              {assignment.name}
                            </h4>
                            <div className="flex items-center gap-2 mt-1 text-xs text-muted-foreground">
                              <span className="truncate max-w-[120px]">{assignment.course_code}</span>
                              <span>•</span>
                              <span className={assignment.due_at ? "text-orange-600 dark:text-orange-400 font-medium" : ""}>
                                {assignment.due_at ? new Date(assignment.due_at).toLocaleDateString(undefined, { month: 'short', day: 'numeric' }) : "No due date"}
                              </span>
                            </div>
                          </div>
                        </div>
                      </Link>
                    ))}
                  </div>
                )}
                
                <div className="p-4 bg-muted/30 border-t">
                  <div className="flex items-center justify-center gap-2 text-sm text-muted-foreground">
                    <Sparkles className="w-4 h-4 text-primary" />
                    <span>AI Study Plans available in courses</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          }
        />
      )}
    </main>
  );
}
