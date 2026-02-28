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