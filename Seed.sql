-- ==========================================
-- COURSES
-- ==========================================
INSERT INTO courses (id, name, code, term_name, start_date, end_date, syllabus_html) VALUES
(1, 'Applied Statistics', 'STAT401', 'Spring 2026', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z', '<h1>Applied Statistics (STAT401)</h1><h2>Course Description</h2><p>This course covers fundamental concepts in applied statistics, including probability theory, random variables, hypothesis testing, and linear regression. The goal is to equip students with the tools necessary to analyze real-world data.</p><h2>Grading Policy</h2><ul><li>Quizzes: 10%</li><li>Homework: 20%</li><li>Midterm: 30%</li><li>Final Project: 40%</li></ul><h2>Weekly Schedule</h2><p><strong>Week 1-4:</strong> Probability and Random Variables<br><strong>Week 5-8:</strong> Distributions and Sampling<br><strong>Week 9-12:</strong> Hypothesis Testing<br><strong>Week 13-16:</strong> Linear Regression and Final Projects</p>'),
(2, 'Advanced Machine Learning', 'DS450', 'Spring 2026', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z', '<h1>Advanced Machine Learning (DS450)</h1><h2>Course Description</h2><p>An in-depth exploration of modern machine learning techniques. Topics include deep learning, natural language processing, transformer architectures, and Retrieval-Augmented Generation (RAG).</p><h2>Grading Policy</h2><ul><li>Assignments: 40%</li><li>Midterm Project: 20%</li><li>Final Presentation: 40%</li></ul><h2>Weekly Schedule</h2><p><strong>Week 1-3:</strong> Supervised Learning Review<br><strong>Week 4-7:</strong> Neural Networks and Backpropagation<br><strong>Week 8-11:</strong> NLP and Embeddings<br><strong>Week 12-16:</strong> LLMs, RAG, and Deployment</p>'),
(3, 'Mobile Application Development', 'CS430', 'Spring 2026', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z', '<h1>Mobile Application Development (CS430)</h1><h2>Course Description</h2><p>Learn to build native Android applications using Kotlin and Jetpack Compose. Covers UI design, state management, API integration, and local storage.</p><h2>Grading Policy</h2><ul><li>Weekly Labs: 30%</li><li>Midterm App: 30%</li><li>Final App Submission: 40%</li></ul><h2>Weekly Schedule</h2><p><strong>Week 1-4:</strong> Kotlin Basics and Android Studio<br><strong>Week 5-8:</strong> UI Layouts and Jetpack Compose<br><strong>Week 9-12:</strong> Networking and REST APIs<br><strong>Week 13-16:</strong> Architecture Patterns and Final Polish</p>'),
(4, 'Full Stack Web Development', 'CS460', 'Spring 2026', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z', '<h1>Full Stack Web Development (CS460)</h1><h2>Course Description</h2><p>A comprehensive guide to building modern web applications. Focuses on React, Next.js (App Router), Tailwind CSS, and PostgreSQL integration.</p><h2>Grading Policy</h2><ul><li>Component Assignments: 20%</li><li>Routing & State Labs: 30%</li><li>Database Project: 20%</li><li>Capstone Deployment: 30%</li></ul><h2>Weekly Schedule</h2><p><strong>Week 1-4:</strong> React Fundamentals and Hooks<br><strong>Week 5-8:</strong> Next.js App Router and Server Components<br><strong>Week 9-12:</strong> Database Integration with Postgres<br><strong>Week 13-16:</strong> Authentication, Deployment, and Vercel</p>')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- ASSIGNMENTS
-- ==========================================
INSERT INTO assignments (id, course_id, name, description, due_at, points_possible) VALUES
-- Course 1: Applied Statistics
(101, 1, 'Probability Foundations Quiz', 'Quiz covering basic probability rules.', '2026-01-25T23:59:59Z', 20.0),
(102, 1, 'Random Variables Problem Set', 'Homework on discrete and continuous variables.', '2026-02-10T23:59:59Z', 50.0),
(103, 1, 'Midterm Examination', 'Covers chapters 1-5.', '2026-03-05T15:00:00Z', 100.0),
(104, 1, 'Linear Regression Project', 'Apply regression analysis to a real dataset.', '2026-04-15T23:59:59Z', 100.0),
(105, 1, 'Final Statistical Report', 'Comprehensive data analysis report.', '2026-05-10T23:59:59Z', 150.0),

-- Course 2: Advanced Machine Learning
(201, 2, 'Feature Visualization Report', 'Analyze and visualize model features.', '2026-01-30T23:59:59Z', 50.0),
(202, 2, 'Classification Algorithms Benchmarking', 'Compare SVM, Random Forest, and KNN.', '2026-02-20T23:59:59Z', 75.0),
(203, 2, 'RAG System Implementation', 'Build a simple Retrieval-Augmented Generation pipeline.', '2026-03-25T23:59:59Z', 100.0),
(204, 2, 'Neural Network Tuning', 'Hyperparameter tuning assignment.', '2026-04-20T23:59:59Z', 75.0),
(205, 2, 'Final Project Presentation', 'Present your final ML architecture.', '2026-05-08T17:00:00Z', 100.0),

-- Course 3: Mobile Application Development
(301, 3, 'Android Studio Environment Setup', 'Screenshot of running emulator.', '2026-01-15T23:59:59Z', 10.0),
(302, 3, 'UI Layouts in XML/Jetpack Compose', 'Design a basic login screen.', '2026-02-05T23:59:59Z', 50.0),
(303, 3, 'RecyclerView Implementation', 'Display a dynamic list of items.', '2026-03-10T23:59:59Z', 75.0),
(304, 3, 'REST API Integration', 'Fetch and display external data.', '2026-04-05T23:59:59Z', 100.0),
(305, 3, 'Final App Submission', 'Submit the final APK and source code.', '2026-05-12T23:59:59Z', 200.0),

-- Course 4: Full Stack Web Development
(401, 4, 'React Components Basics', 'Create reusable UI components.', '2026-01-28T23:59:59Z', 50.0),
(402, 4, 'Next.js Routing', 'Implement static and dynamic routes.', '2026-02-18T23:59:59Z', 50.0),
(403, 4, 'State Management Practicum', 'Manage state across multiple components.', '2026-03-15T23:59:59Z', 75.0),
(404, 4, 'Database Integration', 'Connect Next.js app to PostgreSQL.', '2026-04-10T23:59:59Z', 100.0),
(405, 4, 'Capstone Deployment', 'Deploy the final application using Vercel.', '2026-05-14T23:59:59Z', 150.0)
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- MODULES
-- ==========================================
INSERT INTO modules (id, course_id, name, position) VALUES
-- Course 1
(1001, 1, 'Week 1: Descriptive Statistics', 1),
(1002, 1, 'Week 5: Probability Distributions', 2),
(1003, 1, 'Week 10: Inferential Statistics', 3),
-- Course 2
(2001, 2, 'Week 1: Supervised Learning Fundamentals', 1),
(2002, 2, 'Week 6: Deep Learning & Embeddings', 2),
(2003, 2, 'Week 11: Generative AI & LLMs', 3),
-- Course 3
(3001, 3, 'Week 1: Kotlin & IDE Basics', 1),
(3002, 3, 'Week 4: User Interface Design', 2),
(3003, 3, 'Week 9: Background Processing', 3),
-- Course 4
(4001, 4, 'Week 1: React Fundamentals', 1),
(4002, 4, 'Week 5: Next.js Architecture', 2),
(4003, 4, 'Week 12: Production & Deployment', 3)
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- MODULE ITEMS
-- ==========================================
INSERT INTO module_items (id, module_id, course_id, title, type, position) VALUES
-- Course 1, Module 1001
(10001, 1001, 1, 'Devore Textbook: Chapter 1', 'Page', 1),
(10002, 1001, 1, 'Lecture 1: Intro to Statistics', 'File', 2),
(10003, 1001, 1, 'Probability Foundations Quiz', 'Assignment', 3),

-- Course 1, Module 1002
(10004, 1002, 1, 'Normal Distribution Tables', 'File', 1),
(10005, 1002, 1, 'Random Variables Problem Set', 'Assignment', 2),

-- Course 2, Module 2001
(20001, 2001, 2, 'Classification Overview', 'Page', 1),
(20002, 2001, 2, 'Scikit-Learn Documentation', 'ExternalUrl', 2),
(20003, 2001, 2, 'Feature Visualization Report', 'Assignment', 3),

-- Course 2, Module 2003
(20004, 2003, 2, 'Introduction to RAG Architectures', 'File', 1),
(20005, 2003, 2, 'HuggingFace Model Hub', 'ExternalUrl', 2),
(20006, 2003, 2, 'RAG System Implementation', 'Assignment', 3),

-- Course 3, Module 3001
(30001, 3001, 3, 'Installing Android Studio', 'Page', 1),
(30002, 3001, 3, 'Android Studio Environment Setup', 'Assignment', 2),

-- Course 3, Module 3002
(30003, 3002, 3, 'Material Design Guidelines', 'ExternalUrl', 1),
(30004, 3002, 3, 'UI Layouts in XML/Jetpack Compose', 'Assignment', 2),

-- Course 4, Module 4001
(40001, 4001, 4, 'React Official Tutorial', 'ExternalUrl', 1),
(40002, 4001, 4, 'React Components Basics', 'Assignment', 2),

-- Course 4, Module 4002
(40003, 4002, 4, 'Next.js App Router Docs', 'ExternalUrl', 1),
(40004, 4002, 4, 'Next.js Routing', 'Assignment', 2)
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- USERS
-- ==========================================
INSERT INTO users (id, name, sortable_name, short_name, login_id, pronouns) VALUES
(1, 'Alice Johnson', 'Johnson, Alice', 'Alice', 'alice.j', 'she/her')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- COURSE ENROLLMENTS
-- ==========================================
INSERT INTO course_enrollments (id, course_id, user_id, role, enrollment_state, current_score, current_grade, last_activity_at) VALUES
(1, 1, 1, 'student', 'active', 88.5, 'B+', '2026-02-18T09:15:00Z'),
(2, 2, 1, 'student', 'active', 92.0, 'A-', '2026-02-18T09:15:00Z'),
(3, 3, 1, 'student', 'active', 85.0, 'B', '2026-02-18T09:15:00Z'),
(4, 4, 1, 'student', 'active', 90.0, 'A-', '2026-02-18T09:15:00Z')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- ASSIGNMENT GROUPS
-- ==========================================
-- Applied Statistics
INSERT INTO assignment_groups (id, course_id, name, group_weight, position, rules) VALUES
(1, 1, 'Quizzes', 10, 1, '{"drop_lowest":1}'),
(2, 1, 'Homework', 20, 2, '{"drop_lowest":0}'),
(3, 1, 'Midterm', 30, 3, '{}'),
(4, 1, 'Final Project', 40, 4, '{}'),
-- Advanced Machine Learning
(5, 2, 'Assignments', 40, 1, '{}'),
(6, 2, 'Midterm Project', 20, 2, '{}'),
(7, 2, 'Final Presentation', 40, 3, '{}'),
-- Mobile Application Development
(8, 3, 'Labs', 30, 1, '{}'),
(9, 3, 'Midterm App', 30, 2, '{}'),
(10, 3, 'Final App', 40, 3, '{}'),
-- Full Stack Web Development
(11, 4, 'Component Assignments', 20, 1, '{}'),
(12, 4, 'Routing & State Labs', 30, 2, '{}'),
(13, 4, 'Database Project', 20, 3, '{}'),
(14, 4, 'Capstone Deployment', 30, 4, '{}')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- SUBMISSIONS
-- ==========================================
-- Alice's submissions (assignment_id references core assignments)
INSERT INTO submissions (assignment_id, course_id, user_id, submitted_at, graded_at, score, grade, entered_score, entered_grade, late, missing, workflow_state, submission_type, seconds_late) VALUES
-- Applied Statistics
(101,1,1,'2026-01-24T10:00:00Z','2026-01-25T12:00:00Z',18.5,'A',18.5,'A',false,false,'graded','online_text',0),
(102,1,1,'2026-02-10T15:30:00Z','2026-02-11T10:00:00Z',45.0,'A-',45.0,'A-',false,false,'graded','online_upload',0),
(103,1,1,'2026-03-06T09:00:00Z','2026-03-07T14:00:00Z',78.0,'C+',78.0,'C+',true,false,'graded','online_text',86400),
(104,1,1,'2026-04-15T14:45:00Z','2026-04-16T12:00:00Z',88.0,'B+',88.0,'B+',false,false,'graded','online_upload',0),
(105,1,1,NULL,NULL,0,'F',0,'F',false,true,'unsubmitted',NULL,NULL),

-- Advanced Machine Learning
(201,2,1,'2026-01-30T11:00:00Z','2026-01-31T12:00:00Z',48.0,'A-',48.0,'A-',false,false,'graded','online_text',0),
(202,2,1,'2026-02-20T14:00:00Z','2026-02-21T09:00:00Z',70.0,'B+',70.0,'B+',false,false,'graded','online_upload',0),
(203,2,1,'2026-03-25T16:00:00Z','2026-03-26T10:00:00Z',95.0,'A',95.0,'A',false,false,'graded','online_text',0),
(204,2,1,'2026-04-20T12:00:00Z','2026-04-21T09:00:00Z',72.0,'B',72.0,'B',false,false,'graded','online_upload',0),
(205,2,1,'2026-05-08T16:00:00Z','2026-05-09T12:00:00Z',90.0,'A-',90.0,'A-',false,false,'graded','online_text',0),

-- Mobile Application Development
(301,3,1,'2026-01-15T10:00:00Z','2026-01-16T09:00:00Z',10.0,'A',10.0,'A',false,false,'graded','online_upload',0),
(302,3,1,'2026-02-05T14:30:00Z','2026-02-06T12:00:00Z',48.0,'A-',48.0,'A-',false,false,'graded','online_upload',0),
(303,3,1,'2026-03-10T11:00:00Z','2026-03-11T09:00:00Z',70.0,'B+',70.0,'B+',false,false,'graded','online_upload',0),
(304,3,1,'2026-04-05T15:00:00Z','2026-04-06T10:00:00Z',85.0,'B+',85.0,'B+',false,false,'graded','online_upload',0),
(305,3,1,'2026-05-12T12:00:00Z','2026-05-13T09:00:00Z',190.0,'A-',190.0,'A-',false,false,'graded','online_upload',0),

-- Full Stack Web Development
(401,4,1,'2026-01-28T10:00:00Z','2026-01-29T11:00:00Z',48.0,'A-',48.0,'A-',false,false,'graded','online_upload',0),
(402,4,1,'2026-02-18T15:00:00Z','2026-02-19T10:00:00Z',48.0,'A-',48.0,'A-',false,false,'graded','online_upload',0),
(403,4,1,'2026-03-15T11:00:00Z','2026-03-16T09:00:00Z',70.0,'B+',70.0,'B+',false,false,'graded','online_upload',0),
(404,4,1,'2026-04-10T14:00:00Z','2026-04-11T10:00:00Z',95.0,'A',95.0,'A',false,false,'graded','online_upload',0),
(405,4,1,'2026-05-14T12:00:00Z','2026-05-15T09:00:00Z',140.0,'A-',140.0,'A-',false,false,'graded','online_upload',0)
ON CONFLICT (assignment_id, user_id) DO NOTHING;

-- ==========================================
-- ANNOUNCEMENTS
-- ==========================================
INSERT INTO announcements (id, course_id, author_id, title, message_html, posted_at, published, read_state) VALUES
-- Applied Statistics
(1,1,1,'Welcome to Applied Statistics!','<p>Welcome to STAT401. The syllabus and first assignments are now available.</p>','2026-01-09T08:00:00Z',true,'unread'),
(2,1,1,'Midterm Exam Date','<p>The midterm exam will be held on March 5th, 2026. Make sure to review chapters 1-5.</p>','2026-02-20T10:00:00Z',true,'unread'),
-- Advanced Machine Learning
(3,2,1,'Course Start','<p>Welcome to DS450. Assignments and project details are available.</p>','2026-01-10T08:00:00Z',true,'unread'),
(4,2,1,'RAG Implementation Reminder','<p>Submit your RAG system implementation by March 25th.</p>','2026-03-10T09:00:00Z',true,'unread'),
-- Mobile Application Development
(5,3,1,'Welcome to CS430','<p>Welcome to Mobile App Development. Labs are available.</p>','2026-01-10T08:00:00Z',true,'unread'),
-- Full Stack Web Development
(6,4,1,'Welcome to CS460','<p>Welcome to Full Stack Web Development. Syllabus and labs are now live.</p>','2026-01-10T08:00:00Z',true,'unread')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- PAGES
-- ==========================================
INSERT INTO pages (course_id, url, title, body_html, front_page, published, last_edited_by_id, updated_at_canvas) VALUES
(1,'syllabus','Course Syllabus','<h1>STAT401 Syllabus</h1><p>All course policies, grading, and weekly schedule are listed here.</p>',true,true,1,'2026-01-10T08:00:00Z'),
(2,'syllabus','Course Syllabus','<h1>DS450 Syllabus</h1><p>All course policies, grading, and project schedule are listed here.</p>',true,true,1,'2026-01-10T08:00:00Z'),
(3,'syllabus','Course Syllabus','<h1>CS430 Syllabus</h1><p>All labs, midterm, and final submission details are listed here.</p>',true,true,1,'2026-01-10T08:00:00Z'),
(4,'syllabus','Course Syllabus','<h1>CS460 Syllabus</h1><p>All component and deployment policies are listed here.</p>',true,true,1,'2026-01-10T08:00:00Z')
ON CONFLICT (course_id, url) DO NOTHING;

-- ==========================================
-- FILES
-- ==========================================
INSERT INTO files (id, course_id, display_name, filename, content_type, size_bytes, url, folder_id, hidden, created_at_canvas, updated_at_canvas) VALUES
(1,1,'STAT401 Syllabus PDF','syllabus.pdf','application/pdf',25000,'https://example.com/files/syllabus.pdf',NULL,false,'2026-01-10T08:00:00Z','2026-01-10T08:00:00Z'),
(2,2,'DS450 Syllabus PDF','syllabus.pdf','application/pdf',25000,'https://example.com/files/ds450_syllabus.pdf',NULL,false,'2026-01-10T08:00:00Z','2026-01-10T08:00:00Z'),
(3,3,'CS430 Syllabus PDF','syllabus.pdf','application/pdf',25000,'https://example.com/files/cs430_syllabus.pdf',NULL,false,'2026-01-10T08:00:00Z','2026-01-10T08:00:00Z'),
(4,4,'CS460 Syllabus PDF','syllabus.pdf','application/pdf',25000,'https://example.com/files/cs460_syllabus.pdf',NULL,false,'2026-01-10T08:00:00Z','2026-01-10T08:00:00Z')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- CALENDAR EVENTS
-- ==========================================
INSERT INTO calendar_events (id, course_id, assignment_id, title, description, start_at, end_at, all_day, workflow_state, html_url) VALUES
-- Applied Statistics
(1,1,103,'Midterm Exam','Midterm exam for STAT401 covering chapters 1-5.','2026-03-05T15:00:00Z','2026-03-05T17:00:00Z',false,'active','https://example.com/calendar/midterm'),
(2,1,104,'Linear Regression Project Due','Deadline for submitting Linear Regression Project.','2026-04-15T23:59:59Z','2026-04-15T23:59:59Z',true,'active','https://example.com/calendar/lrproject'),
-- Advanced Machine Learning
(3,2,203,'RAG System Due','Submit RAG system implementation.','2026-03-25T23:59:59Z','2026-03-25T23:59:59Z',true,'active','https://example.com/calendar/ragproject'),
-- Mobile Application Development
(4,3,305,'Final App Submission','Submit the final APK and source code.','2026-05-12T23:59:59Z','2026-05-12T23:59:59Z',true,'active','https://example.com/calendar/finalapp'),
-- Full Stack Web Development
(5,4,405,'Capstone Deployment','Deploy the final project using Vercel.','2026-05-14T23:59:59Z','2026-05-14T23:59:59Z',true,'active','https://example.com/calendar/capstone')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- COURSE GRADE SNAPSHOTS
-- ==========================================
INSERT INTO course_grade_snapshots (id, course_id, user_id, captured_at, current_score, current_grade, final_score, final_grade, source) VALUES
-- Applied Statistics
(1,1,1,'2026-02-01T12:00:00Z',82.0,'B-',NULL,NULL,'system'),
(2,1,1,'2026-03-01T12:00:00Z',85.0,'B',NULL,NULL,'system'),
(3,1,1,'2026-04-15T12:00:00Z',88.5,'B+',NULL,NULL,'system'),
-- Advanced Machine Learning
(4,2,1,'2026-02-01T12:00:00Z',90.0,'A-',NULL,NULL,'system'),
(5,2,1,'2026-03-01T12:00:00Z',91.5,'A-',NULL,NULL,'system'),
(6,2,1,'2026-04-15T12:00:00Z',92.0,'A-',NULL,NULL,'system'),
-- Mobile Application Development
(7,3,1,'2026-02-01T12:00:00Z',82.0,'B',NULL,NULL,'system'),
(8,3,1,'2026-03-01T12:00:00Z',84.0,'B+',NULL,NULL,'system'),
(9,3,1,'2026-04-15T12:00:00Z',85.0,'B+',NULL,NULL,'system'),
-- Full Stack Web Development
(10,4,1,'2026-02-01T12:00:00Z',88.0,'B+',NULL,NULL,'system'),
(11,4,1,'2026-03-01T12:00:00Z',89.0,'B+',NULL,NULL,'system'),
(12,4,1,'2026-04-15T12:00:00Z',90.0,'A-',NULL,NULL,'system')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- QUIZZES
-- ==========================================
INSERT INTO quizzes 
(id, course_id, assignment_id, title, description, quiz_type, scoring_policy, due_at, unlock_at, lock_at, time_limit, allowed_attempts, points_possible, published, html_url) VALUES

-- Applied Statistics (STAT401)
(1, 1, 101, 'Probability Foundations Quiz', 'Covers basic probability rules, conditional probability, and independence.', 'graded', 'keep_highest', '2026-01-25T23:59:59Z', '2026-01-20T00:00:00Z', '2026-01-25T23:59:59Z', 30, 1, 20, true, 'https://example.com/quizzes/probability'),
(2, 1, 102, 'Random Variables Quiz', 'Test on discrete and continuous random variables, expectation, and variance.', 'graded', 'keep_highest', '2026-02-10T23:59:59Z', '2026-02-05T00:00:00Z', '2026-02-10T23:59:59Z', 45, 1, 50, true, 'https://example.com/quizzes/randomvariables'),

-- Advanced Machine Learning (DS450)
(3, 2, 201, 'Feature Visualization Quiz', 'Test understanding of feature visualization techniques.', 'graded', 'keep_highest', '2026-01-30T23:59:59Z', '2026-01-25T00:00:00Z', '2026-01-30T23:59:59Z', 40, 1, 50, true, 'https://example.com/quizzes/featurevisualization'),
(4, 2, 202, 'Classification Benchmark Quiz', 'Quiz on SVM, Random Forest, and KNN concepts.', 'graded', 'keep_highest', '2026-02-20T23:59:59Z', '2026-02-15T00:00:00Z', '2026-02-20T23:59:59Z', 45, 1, 75, true, 'https://example.com/quizzes/classification'),
(5, 2, 203, 'RAG Implementation Quiz', 'Questions on building a simple RAG pipeline.', 'graded', 'keep_highest', '2026-03-25T23:59:59Z', '2026-03-20T00:00:00Z', '2026-03-25T23:59:59Z', 60, 1, 100, true, 'https://example.com/quizzes/ragsystem'),

-- Mobile Application Development (CS430)
(6, 3, 301, 'Android Studio Setup Quiz', 'Check basic IDE setup knowledge.', 'graded', 'keep_highest', '2026-01-15T23:59:59Z', '2026-01-10T00:00:00Z', '2026-01-15T23:59:59Z', 15, 1, 10, true, 'https://example.com/quizzes/androidsetup'),
(7, 3, 302, 'UI Layouts Quiz', 'Quiz on XML/Jetpack Compose UI principles.', 'graded', 'keep_highest', '2026-02-05T23:59:59Z', '2026-02-01T00:00:00Z', '2026-02-05T23:59:59Z', 30, 1, 50, true, 'https://example.com/quizzes/uilayouts'),

-- Full Stack Web Development (CS460)
(8, 4, 401, 'React Components Quiz', 'Covers creating and using React components.', 'graded', 'keep_highest', '2026-01-28T23:59:59Z', '2026-01-25T00:00:00Z', '2026-01-28T23:59:59Z', 40, 1, 50, true, 'https://example.com/quizzes/reactcomponents'),
(9, 4, 402, 'Next.js Routing Quiz', 'Quiz on static and dynamic routes in Next.js.', 'graded', 'keep_highest', '2026-02-18T23:59:59Z', '2026-02-15T00:00:00Z', '2026-02-18T23:59:59Z', 45, 1, 50, true, 'https://example.com/quizzes/nextjsrouting')
ON CONFLICT (id) DO NOTHING;

-- ==========================================
-- DISCUSSIONS
-- ==========================================
INSERT INTO discussions (id, course_id, assignment_id, user_id, title, message_html, discussion_type, pinned, locked, published, posted_at) VALUES
-- Applied Statistics (STAT401)
(1, 1, 101, 1, 'Quiz 1 Clarification', '<p>Please post your questions regarding the Probability Foundations Quiz here.</p>', 'threaded', false, false, true, '2026-01-22T08:00:00Z'),
(2, 1, NULL, 1, 'General Course Questions', '<p>Post any general questions about the course content or logistics.</p>', 'threaded', false, false, true, '2026-01-15T09:00:00Z'),

-- Advanced Machine Learning (DS450)
(3, 2, 201, 1, 'Feature Visualization Questions', '<p>Discuss any issues or doubts about the Feature Visualization Report here.</p>', 'threaded', false, false, true, '2026-01-31T10:00:00Z'),
(4, 2, NULL, 1, 'General ML Questions', '<p>Use this thread for general questions about the DS450 course material.</p>', 'threaded', false, false, true, '2026-01-12T09:00:00Z'),

-- Mobile Application Development (CS430)
(5, 3, 302, 1, 'UI Layout Questions', '<p>Ask questions related to UI layouts in XML/Jetpack Compose.</p>', 'threaded', false, false, true, '2026-02-06T11:00:00Z'),
(6, 3, NULL, 1, 'General Mobile Dev Questions', '<p>Use this thread for general queries regarding CS430 labs and assignments.</p>', 'threaded', false, false, true, '2026-01-16T09:00:00Z'),

-- Full Stack Web Development (CS460)
(7, 4, 401, 1, 'React Components Clarifications', '<p>Post questions about React components assignments here.</p>', 'threaded', false, false, true, '2026-01-29T10:00:00Z'),
(8, 4, NULL, 1, 'General Web Dev Questions', '<p>Thread for questions about CS460 general course content.</p>', 'threaded', false, false, true, '2026-01-12T09:30:00Z')
ON CONFLICT (id) DO NOTHING;