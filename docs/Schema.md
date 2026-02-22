# Database Schema

PostgreSQL 16 with the `pgvector` extension, running via Docker.

## Tables

### courses

The central table. Each row is one college course. The syllabus HTML is the primary document the AI consumes — it should be the full, cleaned syllabus text.

| Column | Type | Nullable | Description |
|---|---|---|---|
| `id` | `INTEGER` | No (PK) | Unique course identifier. Use the Canvas course ID or any stable integer. |
| `name` | `TEXT` | No | Full course name (e.g., "Data Analytics in Python"). |
| `code` | `TEXT` | No | Short course code (e.g., "CMPS-240-01"). |
| `start_date` | `TIMESTAMPTZ` | Yes | When the course begins. ISO 8601 format. |
| `end_date` | `TIMESTAMPTZ` | Yes | When the course ends. ISO 8601 format. |
| `syllabus_html` | `TEXT` | Yes | The full syllabus content as HTML. This is the most important field — it feeds directly into the AI prompt. Can be tens of thousands of characters. PostgreSQL handles large text transparently via TOAST compression. |
| `term_name` | `TEXT` | Yes | Academic term label (e.g., "Spring 2026"). |
| `created_at` | `TIMESTAMPTZ` | No | Row creation timestamp. Auto-populated via `DEFAULT NOW()`. |
| `embedding` | `vector(1536)` | Yes | Reserved for future semantic search. Leave `NULL` for now. |

**Content guidance for `syllabus_html`:**
- Should contain the course schedule, grading policies, weekly topics, and learning objectives.
- Strip any personally identifiable information (professor real names, student IDs, institutional identifiers).
- HTML tags are fine — the AI can parse them. Raw text also works.
- If the syllabus is missing, leave `NULL`. The AI will still work from assignments and modules, but its output will be less useful.

---

### assignments

Individual graded items within a course. Each assignment belongs to exactly one course.

| Column | Type | Nullable | Description |
|---|---|---|---|
| `id` | `INTEGER` | No (PK) | Unique assignment identifier. |
| `course_id` | `INTEGER` | No (FK → courses) | The course this assignment belongs to. Cascades on delete. |
| `name` | `TEXT` | No | Assignment title (e.g., "Midterm Exam", "HW3: Regression Analysis"). |
| `description` | `TEXT` | Yes | Full assignment description. Can be HTML or plain text. Useful for the AI to understand what the student needs to do. |
| `due_at` | `TIMESTAMPTZ` | Yes | When the assignment is due. ISO 8601. `NULL` means no due date set. |
| `points_possible` | `REAL` | Yes | Maximum points for this assignment (e.g., 100.0). |
| `grading_type` | `TEXT` | Yes | How it's graded: `"points"`, `"percent"`, `"pass_fail"`, `"letter_grade"`, `"gpa_scale"`. |
| `submission_types` | `TEXT[]` | Yes | PostgreSQL array of submission types: `"online_text_entry"`, `"online_upload"`, `"online_quiz"`, `"discussion_topic"`, `"on_paper"`, `"none"`, etc. |
| `position` | `INTEGER` | Yes | Sort order within the course's assignment list. |
| `created_at` | `TIMESTAMPTZ` | No | Row creation timestamp. Auto-populated. |
| `embedding` | `vector(1536)` | Yes | Reserved for future semantic search. Leave `NULL` for now. |

**Content guidance:**
- `due_at` is critical for the AI to prioritize what the student should focus on next.
- `description` helps the AI understand the scope and topic of the assignment. Include it when available.
- Anonymize any student-specific references in the description.

---

### modules

Organizational containers within a course. Modules group related content (lectures, readings, assignments) into logical units like "Week 1" or "Chapter 3: Linear Algebra."

| Column | Type | Nullable | Description |
|---|---|---|---|
| `id` | `INTEGER` | No (PK) | Unique module identifier. |
| `course_id` | `INTEGER` | No (FK → courses) | The course this module belongs to. Cascades on delete. |
| `name` | `TEXT` | No | Module title (e.g., "Week 5: Hypothesis Testing"). |
| `position` | `INTEGER` | Yes | Sort order within the course. Lower numbers appear first. |
| `created_at` | `TIMESTAMPTZ` | No | Row creation timestamp. Auto-populated. |

---

### module_items

Individual pieces of content inside a module: assignments, pages, quizzes, files, external links, etc.

| Column | Type | Nullable | Description |
|---|---|---|---|
| `id` | `INTEGER` | No (PK) | Unique item identifier. |
| `module_id` | `INTEGER` | No (FK → modules) | The module this item belongs to. Cascades on delete. |
| `course_id` | `INTEGER` | No (FK → courses) | The course this item belongs to. Cascades on delete. |
| `title` | `TEXT` | No | Item title (e.g., "Lecture 5 Slides", "Quiz: Probability Basics"). |
| `type` | `TEXT` | No | What kind of content this is. One of: `"Assignment"`, `"Quiz"`, `"File"`, `"Page"`, `"Discussion"`, `"SubHeader"`, `"ExternalUrl"`, `"ExternalTool"`. |
| `content_id` | `INTEGER` | Yes | References the actual content object (e.g., an assignment ID). `NULL` for `SubHeader` and `ExternalUrl` types. |
| `position` | `INTEGER` | Yes | Sort order within the module. |
| `created_at` | `TIMESTAMPTZ` | No | Row creation timestamp. Auto-populated. |

---

## Relationships

```
courses (1) ──→ (many) assignments
courses (1) ──→ (many) modules
modules (1) ──→ (many) module_items
courses (1) ──→ (many) module_items
```

All foreign keys cascade on delete — removing a course removes all its assignments, modules, and module items.

## Indexes

| Index | Table | Column(s) | Purpose |
|---|---|---|---|
| `idx_assignments_course_id` | assignments | `course_id` | Fast lookup of assignments by course |
| `idx_assignments_due_at` | assignments | `due_at` | Sort/filter assignments by deadline |
| `idx_modules_course_id` | modules | `course_id` | Fast lookup of modules by course |
| `idx_module_items_module_id` | module_items | `module_id` | Fast lookup of items by module |
| `idx_module_items_course_id` | module_items | `course_id` | Fast lookup of items by course |

## How the AI Uses This Data

The Next.js application queries these tables and injects the results into the Gemini system prompt. The priority order for the AI is:

1. **`courses.syllabus_html`** — The richest source of course structure, topics, and policies
2. **`assignments.due_at` + `assignments.name`** — Deadline awareness for prioritization
3. **`assignments.description`** — Understanding what each deliverable requires
4. **`modules.name` + `module_items.title`** — Topic sequencing and course progression
