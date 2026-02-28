-- ==========================================
-- CLEAN SLATE
-- ==========================================
TRUNCATE TABLE
  course_grade_snapshots,
  calendar_events,
  files,
  pages,
  discussions,
  quizzes,
  submissions,
  announcements,
  course_enrollments,
  module_items,
  modules,
  assignments,
  assignment_groups,
  users,
  courses
CASCADE;

-- ==========================================
-- USERS
-- ==========================================
INSERT INTO users (id, name, sortable_name, short_name, login_id, pronouns) VALUES
(1, 'Maya Patel', 'Patel, Maya', 'Maya', 'maya.patel', 'she/her'),
(2, 'Prof. Alan Torres', 'Torres, Alan', 'Prof. Torres', 'alan.torres', NULL);

-- ==========================================
-- COURSES
-- ==========================================
-- Syllabi are ~100 words of readable text for embedding quality
INSERT INTO courses (id, name, code, term_name, workflow_state, start_date, end_date, syllabus_html) VALUES
(1, 'Applied Statistics', 'STAT401', 'Spring 2026', 'available', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z',
'<p>Applied Statistics (STAT401) develops probability theory, random variables, and statistical inference for analyzing real-world data. Topics by week: 1-2 descriptive statistics and data types; 3-4 probability rules and Bayes theorem; 5-6 binomial, Poisson, and normal distributions; 7-8 sampling distributions and CLT; 9-10 hypothesis testing with t-tests and chi-square; 11-12 ANOVA and non-parametric tests; 13-14 simple linear regression; 15-16 multiple regression and final project. Grading: Homework 30%, Quizzes 20%, Midterm 25%, Final Project 25%. Required text: Devore Probability and Statistics 8th edition. Midterm exam March 7. Final project report due May 8.</p>'),
(2, 'Advanced Machine Learning', 'DS450', 'Spring 2026', 'available', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z',
'<p>Advanced Machine Learning (DS450) covers modern supervised learning, deep neural networks, and generative AI from foundations to deployment. Topics by week: 1-2 ML review and model evaluation; 3-4 optimization and regularization; 5-6 deep neural networks and backpropagation; 7-8 CNNs and training techniques; 9-10 natural language processing and text preprocessing; 11-12 transformers and attention mechanisms; 13-14 large language models and fine-tuning; 15-16 RAG systems and deployment. Grading: Quizzes 20%, Labs 30%, Midterm Project 25%, Final Presentation 25%. Python with PyTorch required. Midterm project due March 8. Final presentation May 1.</p>'),
(3, 'Mobile Application Development', 'CS430', 'Spring 2026', 'available', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z',
'<p>Mobile Application Development (CS430) teaches native Android development using Kotlin and Jetpack Compose for modern production apps. Topics by week: 1-2 Kotlin fundamentals and Android Studio; 3-4 activities, intents, and XML layouts; 5-6 Jetpack Compose and declarative UI; 7-8 RecyclerView and lazy lists; 9-10 Jetpack Navigation and MVVM architecture; 11-12 Retrofit and REST API integration; 13-14 Room database and local storage; 15-16 testing, polish, and final submission. Grading: Labs 35%, Midterm App 25%, Final App 40%. Android Studio required. Midterm app due April 11. Final APK and source due May 1.</p>'),
(4, 'Full Stack Web Development', 'CS460', 'Spring 2026', 'available', '2026-01-10T00:00:00Z', '2026-05-15T00:00:00Z',
'<p>Full Stack Web Development (CS460) builds production-grade web applications using React, Next.js App Router, Tailwind CSS, and PostgreSQL. Topics by week: 1-2 React components and hooks; 3-4 advanced state and context; 5-6 Next.js App Router and layouts; 7-8 server components and server actions; 9-10 Prisma ORM and PostgreSQL integration; 11-12 NextAuth authentication and sessions; 13-14 testing and performance optimization; 15-16 Vercel deployment and capstone. Grading: Assignments 25%, Labs 30%, Database Project 20%, Capstone 25%. Node.js and VS Code required. Database project due March 21. Capstone deployment due May 8.</p>');

-- ==========================================
-- ASSIGNMENT GROUPS
-- ==========================================
-- STAT401
INSERT INTO assignment_groups (id, course_id, name, group_weight, position, rules) VALUES
(1,  1, 'Homework',           30, 1, '{}'),
(2,  1, 'Quizzes',            20, 2, '{"drop_lowest":0}'),
(3,  1, 'Midterm',            25, 3, '{}'),
(4,  1, 'Final Project',      25, 4, '{}'),
-- DS450
(5,  2, 'Quizzes',            20, 1, '{"drop_lowest":0}'),
(6,  2, 'Labs',               30, 2, '{}'),
(7,  2, 'Midterm Project',    25, 3, '{}'),
(8,  2, 'Final Presentation', 25, 4, '{}'),
-- CS430
(9,  3, 'Labs',               35, 1, '{}'),
(10, 3, 'Midterm App',        25, 2, '{}'),
(11, 3, 'Final App',          40, 3, '{}'),
-- CS460
(12, 4, 'Assignments',        25, 1, '{}'),
(13, 4, 'Labs',               30, 2, '{}'),
(14, 4, 'Database Project',   20, 3, '{}'),
(15, 4, 'Capstone',           25, 4, '{}');

-- ==========================================
-- ASSIGNMENTS
-- ==========================================
-- STAT401 (6 assignments)
INSERT INTO assignments (id, course_id, assignment_group_id, name, description, due_at, points_possible, grading_type, published, workflow_state) VALUES
(101, 1, 1, 'HW1: Descriptive Statistics',
  'Problem set covering measures of central tendency, variability, and data visualization. Use the provided dataset to compute means, medians, standard deviations, and build histograms.',
  '2026-01-23T23:59:59Z', 50.0, 'points', true, 'published'),
(102, 1, 2, 'Quiz 1: Probability Rules',
  'In-class quiz on probability axioms, conditional probability, multiplication rule, and Bayes theorem. Closed book, 30 minutes.',
  '2026-02-06T23:59:59Z', 20.0, 'points', true, 'published'),
(103, 1, 1, 'HW2: Probability Distributions',
  'Problem set on binomial, Poisson, and normal distributions. Calculate probabilities, find quantiles, and apply the normal approximation to binomial.',
  '2026-02-20T23:59:59Z', 50.0, 'points', true, 'published'),
(104, 1, 3, 'Midterm Examination',
  'In-class midterm covering Weeks 1-8: descriptive statistics, probability, distributions, and sampling distributions. 80 minutes, formula sheet provided.',
  '2026-03-07T09:00:00Z', 100.0, 'points', true, 'published'),
(105, 1, 1, 'HW3: Regression Analysis',
  'Apply simple and multiple linear regression to a provided real-world dataset. Include diagnostics, residual analysis, and a brief write-up interpreting results.',
  '2026-04-11T23:59:59Z', 75.0, 'points', true, 'published'),
(106, 1, 4, 'Final Project: Statistical Report',
  'Full statistical analysis report using a dataset of your choice. Must include EDA, hypothesis tests, and a regression model with interpretation. 8-10 pages.',
  '2026-05-08T23:59:59Z', 100.0, 'points', true, 'published'),

-- DS450 (6 assignments)
(201, 2, 5, 'Quiz 1: ML Fundamentals',
  'Online quiz covering supervised vs unsupervised learning, bias-variance tradeoff, cross-validation, precision/recall, and ROC curves.',
  '2026-01-30T23:59:59Z', 40.0, 'points', true, 'published'),
(202, 2, 6, 'Lab 1: Model Evaluation',
  'Train and evaluate classifiers (Logistic Regression, SVM, Random Forest) on the provided tabular dataset. Compare using accuracy, F1, and AUC. Submit Jupyter notebook.',
  '2026-02-13T23:59:59Z', 75.0, 'points', true, 'published'),
(203, 2, 6, 'Lab 2: Neural Networks Problem Set',
  'Implement a 3-layer MLP in PyTorch from scratch. Train on MNIST, experiment with activations and learning rates, plot training curves. Submit notebook and a 1-page analysis.',
  '2026-02-27T23:59:59Z', 60.0, 'points', true, 'published'),
(204, 2, 7, 'Midterm Project: CNN Image Classifier',
  'Build a convolutional neural network to classify images from CIFAR-10. Must achieve >80% test accuracy. Include data augmentation, batch normalization, and a written report.',
  '2026-03-08T23:59:59Z', 100.0, 'points', true, 'published'),
(205, 2, 6, 'Lab 3: NLP Text Classification',
  'Fine-tune a pre-trained BERT model on the AG News dataset for text classification. Report accuracy, confusion matrix, and error analysis. Submit notebook and 2-page write-up.',
  '2026-04-10T23:59:59Z', 80.0, 'points', true, 'published'),
(206, 2, 8, 'Final Presentation: ML System Design',
  'Design and present a production ML pipeline for a problem of your choice. Cover data ingestion, model selection, evaluation, deployment strategy, and monitoring. 12-minute presentation.',
  '2026-05-01T17:00:00Z', 100.0, 'points', true, 'published'),

-- CS430 (6 assignments)
(301, 3, 9, 'Lab 1: Kotlin Basics',
  'Complete the provided Kotlin exercises covering variables, control flow, functions, and null safety. Submit via Android Studio project export.',
  '2026-01-16T23:59:59Z', 10.0, 'points', true, 'published'),
(302, 3, 9, 'Lab 2: Activities and Layouts',
  'Build a multi-screen Android app with at least 3 activities, explicit and implicit intents, and XML layouts using ConstraintLayout. Include a splash screen.',
  '2026-01-30T23:59:59Z', 50.0, 'points', true, 'published'),
(303, 3, 9, 'Lab 3: Jetpack Compose UI',
  'Rebuild one of your Lab 2 screens using Jetpack Compose. Implement state hoisting, reusable composables, and theming with Material 3. Include light/dark mode support.',
  '2026-02-13T23:59:59Z', 80.0, 'points', true, 'published'),
(304, 3, 9, 'Lab 4: RecyclerView and LazyColumn',
  'Implement a scrollable list screen using both RecyclerView (XML) and LazyColumn (Compose). Fetch data from a local JSON file, support click events, and add swipe-to-delete.',
  '2026-02-28T23:59:59Z', 80.0, 'points', true, 'published'),
(305, 3, 10, 'Midterm App: Task Manager',
  'Build a full Task Manager Android app with CRUD operations, local persistence using SharedPreferences or DataStore, and a polished Jetpack Compose UI. Due for in-lab demo.',
  '2026-04-11T23:59:59Z', 150.0, 'points', true, 'published'),
(306, 3, 11, 'Final App Submission',
  'Submit final Android application as APK and source code. App must demonstrate Retrofit networking, Room database, Jetpack Navigation, and MVVM architecture. Include a demo video.',
  '2026-05-01T23:59:59Z', 200.0, 'points', true, 'published'),

-- CS460 (6 assignments)
(401, 4, 12, 'React Hooks Assignment',
  'Build a React app that uses useState, useEffect, useReducer, and a custom hook. Implement a multi-step form wizard with local state and validation. Deploy to Vercel.',
  '2026-01-23T23:59:59Z', 50.0, 'points', true, 'published'),
(402, 4, 13, 'Next.js Routing Lab',
  'Implement a multi-page Next.js app using App Router with dynamic routes, route groups, parallel routes, and intercepting routes. Include loading.tsx and error.tsx for each segment.',
  '2026-02-06T23:59:59Z', 60.0, 'points', true, 'published'),
(403, 4, 13, 'Server Components Lab',
  'Refactor an existing React client component app into Next.js Server Components and Server Actions. Minimize client bundle size and demonstrate data fetching patterns with streaming.',
  '2026-02-21T23:59:59Z', 70.0, 'points', true, 'published'),
(404, 4, 14, 'Database Integration Project',
  'Build a full-stack Next.js app with Prisma ORM connecting to PostgreSQL. Implement CRUD operations, database migrations, and relations. Include a seeding script and README.',
  '2026-03-21T23:59:59Z', 100.0, 'points', true, 'published'),
(405, 4, 13, 'Auth Implementation Lab',
  'Add NextAuth.js authentication to the Database Integration Project. Support credentials and GitHub OAuth, protect routes with middleware, and implement session management.',
  '2026-04-12T23:59:59Z', 80.0, 'points', true, 'published'),
(406, 4, 15, 'Capstone Deployment',
  'Deploy a complete full-stack Next.js application to Vercel with a production Postgres database. Must include auth, at least 3 data models, a polished UI, and a live demo URL.',
  '2026-05-08T23:59:59Z', 150.0, 'points', true, 'published');

-- ==========================================
-- MODULES
-- ==========================================
-- STAT401 (8 modules, weekly-aligned)
INSERT INTO modules (id, course_id, name, position, published, state) VALUES
(1001, 1, 'Week 1-2: Descriptive Statistics',         1, true, 'completed'),
(1002, 1, 'Week 3-4: Probability Theory',             2, true, 'completed'),
(1003, 1, 'Week 5-6: Probability Distributions',      3, true, 'completed'),
(1004, 1, 'Week 7-8: Sampling Distributions and CLT', 4, true, 'unlocked'),
(1005, 1, 'Week 9-10: Hypothesis Testing',            5, true, 'locked'),
(1006, 1, 'Week 11-12: ANOVA',                        6, true, 'locked'),
(1007, 1, 'Week 13-14: Linear Regression',            7, true, 'locked'),
(1008, 1, 'Week 15-16: Multiple Regression and Final',8, true, 'locked'),
-- DS450
(2001, 2, 'Week 1-2: ML Review and Model Evaluation', 1, true, 'completed'),
(2002, 2, 'Week 3-4: Optimization and Regularization',2, true, 'completed'),
(2003, 2, 'Week 5-6: Neural Network Foundations',     3, true, 'completed'),
(2004, 2, 'Week 7-8: Deep Learning Techniques',       4, true, 'unlocked'),
(2005, 2, 'Week 9-10: Natural Language Processing',   5, true, 'locked'),
(2006, 2, 'Week 11-12: Transformers and Attention',   6, true, 'locked'),
(2007, 2, 'Week 13-14: LLMs and Fine-tuning',         7, true, 'locked'),
(2008, 2, 'Week 15-16: RAG Systems and Deployment',   8, true, 'locked'),
-- CS430
(3001, 3, 'Week 1-2: Kotlin and Android Studio',      1, true, 'completed'),
(3002, 3, 'Week 3-4: Activities, Intents, Layouts',   2, true, 'completed'),
(3003, 3, 'Week 5-6: Jetpack Compose',                3, true, 'completed'),
(3004, 3, 'Week 7-8: RecyclerView and LazyColumn',    4, true, 'unlocked'),
(3005, 3, 'Week 9-10: Navigation and MVVM',           5, true, 'locked'),
(3006, 3, 'Week 11-12: Networking with Retrofit',     6, true, 'locked'),
(3007, 3, 'Week 13-14: Room Database',                7, true, 'locked'),
(3008, 3, 'Week 15-16: Final App Polish',             8, true, 'locked'),
-- CS460
(4001, 4, 'Week 1-2: React Fundamentals',             1, true, 'completed'),
(4002, 4, 'Week 3-4: Advanced Hooks and Context',     2, true, 'completed'),
(4003, 4, 'Week 5-6: Next.js App Router',             3, true, 'completed'),
(4004, 4, 'Week 7-8: Server Components and Actions',  4, true, 'unlocked'),
(4005, 4, 'Week 9-10: Database Integration',          5, true, 'locked'),
(4006, 4, 'Week 11-12: Authentication with NextAuth', 6, true, 'locked'),
(4007, 4, 'Week 13-14: Testing and Performance',      7, true, 'locked'),
(4008, 4, 'Week 15-16: Deployment and Capstone',      8, true, 'locked');

-- ==========================================
-- MODULE ITEMS
-- ==========================================
INSERT INTO module_items (id, module_id, course_id, title, type, content_id, position, published) VALUES
-- STAT401 Module 1001: Descriptive Statistics (completed)
(10001, 1001, 1, 'Lecture 1-2 Slides: Data Types and Summaries', 'File', 1001, 1, true),
(10002, 1001, 1, 'Chapter 1: Descriptive Statistics Study Notes', 'Page', NULL, 2, true),
(10003, 1001, 1, 'HW1: Descriptive Statistics', 'Assignment', 101, 3, true),
-- STAT401 Module 1002: Probability Theory (completed)
(10004, 1002, 1, 'Lecture 3-4 Slides: Probability Rules', 'File', 1002, 1, true),
(10005, 1002, 1, 'Probability Cheat Sheet', 'Page', NULL, 2, true),
(10006, 1002, 1, 'Quiz 1: Probability Rules', 'Assignment', 102, 3, true),
-- STAT401 Module 1003: Distributions (completed)
(10007, 1003, 1, 'Lecture 5-6 Slides: Distributions', 'File', 1003, 1, true),
(10008, 1003, 1, 'NIST Engineering Statistics Handbook', 'ExternalUrl', NULL, 2, true),
(10009, 1003, 1, 'HW2: Probability Distributions', 'Assignment', 103, 3, true),
-- STAT401 Module 1004: Sampling Distributions (current)
(10010, 1004, 1, 'Lecture 7-8 Slides: Sampling and CLT', 'File', 1004, 1, true),
(10011, 1004, 1, 'Week 7-8 Study Guide: Sampling Distributions', 'Page', NULL, 2, true),
(10012, 1004, 1, 'CLT Interactive Visualizer (Seeing Theory)', 'ExternalUrl', NULL, 3, true),
-- STAT401 Module 1005: Hypothesis Testing (future)
(10013, 1005, 1, 'Lecture 9-10 Slides: Hypothesis Testing', 'File', 1005, 1, true),
(10014, 1005, 1, 'Midterm Examination', 'Assignment', 104, 2, true),
-- STAT401 Module 1006: ANOVA (future)
(10015, 1006, 1, 'ANOVA Lecture Notes', 'Page', NULL, 1, true),
(10016, 1006, 1, 'ANOVA and Non-parametric Tests Reference', 'ExternalUrl', NULL, 2, true),
-- STAT401 Module 1007: Linear Regression (future)
(10017, 1007, 1, 'Regression Lecture Notes and Worked Examples', 'Page', NULL, 1, true),
(10018, 1007, 1, 'HW3: Regression Analysis', 'Assignment', 105, 2, true),
-- STAT401 Module 1008: Multiple Regression (future)
(10019, 1008, 1, 'Multiple Regression and Model Selection Slides', 'File', 1008, 1, true),
(10020, 1008, 1, 'Final Project: Statistical Report', 'Assignment', 106, 2, true),

-- DS450 Module 2001: ML Review (completed)
(20001, 2001, 2, 'Lecture 1-2 Slides: Supervised Learning Review', 'File', 2001, 1, true),
(20002, 2001, 2, 'Scikit-learn User Guide', 'ExternalUrl', NULL, 2, true),
(20003, 2001, 2, 'Quiz 1: ML Fundamentals', 'Assignment', 201, 3, true),
-- DS450 Module 2002: Optimization (completed)
(20004, 2002, 2, 'Lecture 3-4 Slides: Optimization', 'File', 2002, 1, true),
(20005, 2002, 2, 'Lab 1 Instructions: Model Evaluation', 'Page', NULL, 2, true),
(20006, 2002, 2, 'Lab 1: Model Evaluation', 'Assignment', 202, 3, true),
-- DS450 Module 2003: Neural Networks (completed)
(20007, 2003, 2, 'Lecture 5-6 Slides: Neural Network Foundations', 'File', 2003, 1, true),
(20008, 2003, 2, 'PyTorch Official Documentation', 'ExternalUrl', NULL, 2, true),
(20009, 2003, 2, 'Lab 2: Neural Networks Problem Set', 'Assignment', 203, 3, true),
-- DS450 Module 2004: Deep Learning (current)
(20010, 2004, 2, 'Lecture 7-8 Slides: CNNs and Deep Learning', 'File', 2004, 1, true),
(20011, 2004, 2, 'CNN Architecture Reference Sheet', 'Page', NULL, 2, true),
(20012, 2004, 2, 'CS231n Stanford Course Notes: CNNs', 'ExternalUrl', NULL, 3, true),
-- DS450 Module 2005: NLP (future)
(20013, 2005, 2, 'Lecture 9-10 Slides: NLP Foundations', 'File', 2005, 1, true),
(20014, 2005, 2, 'Lab 3: NLP Text Classification', 'Assignment', 205, 2, true),
-- DS450 Module 2006: Transformers (future)
(20015, 2006, 2, 'Attention is All You Need (Vaswani et al.)', 'ExternalUrl', NULL, 1, true),
(20016, 2006, 2, 'Transformer Architecture Notes', 'Page', NULL, 2, true),
-- DS450 Module 2007: LLMs (future)
(20017, 2007, 2, 'Fine-tuning Large Language Models Guide', 'Page', NULL, 1, true),
(20018, 2007, 2, 'HuggingFace Transformers Documentation', 'ExternalUrl', NULL, 2, true),
-- DS450 Module 2008: RAG (future)
(20019, 2008, 2, 'RAG System Architecture Overview', 'Page', NULL, 1, true),
(20020, 2008, 2, 'Final Presentation: ML System Design', 'Assignment', 206, 2, true),

-- CS430 Module 3001: Kotlin + Studio (completed)
(30001, 3001, 3, 'Android Studio Setup and Installation Guide', 'File', 3001, 1, true),
(30002, 3001, 3, 'Kotlin Language Reference Card', 'Page', NULL, 2, true),
(30003, 3001, 3, 'Lab 1: Kotlin Basics', 'Assignment', 301, 3, true),
-- CS430 Module 3002: Activities + Layouts (completed)
(30004, 3002, 3, 'Lecture 3-4 Slides: Activities and Layouts', 'File', 3002, 1, true),
(30005, 3002, 3, 'Android Developer Documentation', 'ExternalUrl', NULL, 2, true),
(30006, 3002, 3, 'Lab 2: Activities and Layouts', 'Assignment', 302, 3, true),
-- CS430 Module 3003: Jetpack Compose (completed)
(30007, 3003, 3, 'Jetpack Compose Basics Codelab Guide', 'File', 3003, 1, true),
(30008, 3003, 3, 'Jetpack Compose Official Documentation', 'ExternalUrl', NULL, 2, true),
(30009, 3003, 3, 'Lab 3: Jetpack Compose UI', 'Assignment', 303, 3, true),
-- CS430 Module 3004: RecyclerView (current)
(30010, 3004, 3, 'Lecture 7-8 Slides: RecyclerView and LazyColumn', 'File', 3004, 1, true),
(30011, 3004, 3, 'Lab 4 Instructions: RecyclerView Implementation', 'Page', NULL, 2, true),
(30012, 3004, 3, 'Lab 4: RecyclerView and LazyColumn', 'Assignment', 304, 3, true),
-- CS430 Module 3005: Navigation + MVVM (future)
(30013, 3005, 3, 'Jetpack Navigation Architecture Guide', 'Page', NULL, 1, true),
(30014, 3005, 3, 'Jetpack Navigation Component Documentation', 'ExternalUrl', NULL, 2, true),
-- CS430 Module 3006: Networking (future)
(30015, 3006, 3, 'Retrofit HTTP Client Setup Guide', 'File', 3006, 1, true),
(30016, 3006, 3, 'Square Retrofit Documentation', 'ExternalUrl', NULL, 2, true),
-- CS430 Module 3007: Room DB (future)
(30017, 3007, 3, 'Room Persistence Library Guide', 'Page', NULL, 1, true),
(30018, 3007, 3, 'Android Room Codelab', 'ExternalUrl', NULL, 2, true),
-- CS430 Module 3008: Final Polish (future)
(30019, 3008, 3, 'Final App Requirements and Grading Rubric', 'Page', NULL, 1, true),
(30020, 3008, 3, 'Final App Submission', 'Assignment', 306, 2, true),

-- CS460 Module 4001: React Fundamentals (completed)
(40001, 4001, 4, 'React 19 Official Documentation', 'ExternalUrl', NULL, 1, true),
(40002, 4001, 4, 'Hooks Reference Cheat Sheet', 'File', 4001, 2, true),
(40003, 4001, 4, 'React Hooks Assignment', 'Assignment', 401, 3, true),
-- CS460 Module 4002: Advanced Hooks (completed)
(40004, 4002, 4, 'Context API and Zustand State Guide', 'Page', NULL, 1, true),
(40005, 4002, 4, 'Next.js Official Documentation', 'ExternalUrl', NULL, 2, true),
(40006, 4002, 4, 'Next.js Routing Lab', 'Assignment', 402, 3, true),
-- CS460 Module 4003: Next.js App Router (completed)
(40007, 4003, 4, 'App Router Architecture Slides', 'File', 4003, 1, true),
(40008, 4003, 4, 'Route Groups and Layouts Reference', 'Page', NULL, 2, true),
(40009, 4003, 4, 'Server Components Lab', 'Assignment', 403, 3, true),
-- CS460 Module 4004: Server Components (current)
(40010, 4004, 4, 'Server vs Client Components Decision Guide', 'Page', NULL, 1, true),
(40011, 4004, 4, 'Next.js Server Actions Documentation', 'ExternalUrl', NULL, 2, true),
(40012, 4004, 4, 'Vercel Blog: Server Actions Deep Dive', 'ExternalUrl', NULL, 3, true),
-- CS460 Module 4005: DB Integration (future)
(40013, 4005, 4, 'Prisma ORM Setup and Migration Guide', 'File', 4005, 1, true),
(40014, 4005, 4, 'Database Integration Project', 'Assignment', 404, 2, true),
-- CS460 Module 4006: Auth (future)
(40015, 4006, 4, 'NextAuth.js v5 Documentation', 'ExternalUrl', NULL, 1, true),
(40016, 4006, 4, 'Auth Implementation Lab', 'Assignment', 405, 2, true),
-- CS460 Module 4007: Testing (future)
(40017, 4007, 4, 'Jest and Playwright Setup for Next.js', 'Page', NULL, 1, true),
(40018, 4007, 4, 'Web Performance Optimization Guide', 'File', 4007, 2, true),
-- CS460 Module 4008: Deployment (future)
(40019, 4008, 4, 'Vercel Deployment with Production Postgres', 'ExternalUrl', NULL, 1, true),
(40020, 4008, 4, 'Capstone Deployment', 'Assignment', 406, 2, true);

-- ==========================================
-- COURSE ENROLLMENTS
-- ==========================================
-- Scores reflect graded work through Feb 28, 2026
-- STAT401: HW1(43/50) + Quiz1(17/20) + HW2(44/50) active → 86.2%
-- DS450: Quiz1(38/40) + Lab1(68/75) active → 92.4%
-- CS430: Lab1(10/10) + Lab2(46/50) + Lab3(69/80) active → 89.3%
-- CS460: Assign1(48/50) + Lab1(54/60) + Lab2(63/70) active → 92.7%
INSERT INTO course_enrollments (id, course_id, user_id, type, role, enrollment_state, current_score, current_grade, last_activity_at) VALUES
(1, 1, 1, 'StudentEnrollment', 'student', 'active', 86.2, 'B',  '2026-02-28T18:45:00Z'),
(2, 2, 1, 'StudentEnrollment', 'student', 'active', 92.4, 'A-', '2026-02-28T16:20:00Z'),
(3, 3, 1, 'StudentEnrollment', 'student', 'active', 89.3, 'B+', '2026-02-28T19:10:00Z'),
(4, 4, 1, 'StudentEnrollment', 'student', 'active', 92.7, 'A-', '2026-02-27T21:30:00Z');

-- ==========================================
-- SUBMISSIONS
-- ==========================================
-- Only assignments with a due date on or before Feb 28, 2026
-- Assignment 304 (Lab 4, due tonight Feb 28) has no submission row yet
INSERT INTO submissions (assignment_id, course_id, user_id, submitted_at, graded_at, score, grade, entered_score, entered_grade, late, missing, workflow_state, submission_type, seconds_late) VALUES
-- STAT401
(101, 1, 1, '2026-01-23T21:40:00Z', '2026-01-25T14:00:00Z', 43.0, 'B+', 43.0, 'B+', false, false, 'graded',    'online_upload', 0),
(102, 1, 1, '2026-02-06T10:55:00Z', '2026-02-06T23:00:00Z', 17.0, 'B+', 17.0, 'B+', false, false, 'graded',    'online_quiz',   0),
(103, 1, 1, '2026-02-20T22:15:00Z', '2026-02-22T11:00:00Z', 44.0, 'B+', 44.0, 'B+', false, false, 'graded',    'online_upload', 0),
-- DS450
(201, 2, 1, '2026-01-30T09:30:00Z', '2026-02-01T10:00:00Z', 38.0, 'A',  38.0, 'A',  false, false, 'graded',    'online_quiz',   0),
(202, 2, 1, '2026-02-13T18:50:00Z', '2026-02-15T09:00:00Z', 68.0, 'A-', 68.0, 'A-', false, false, 'graded',    'online_upload', 0),
-- Submitted last night, pending grade
(203, 2, 1, '2026-02-27T23:58:00Z', NULL,                   NULL, NULL, NULL, NULL,  false, false, 'submitted', 'online_upload', 0),
-- CS430
(301, 3, 1, '2026-01-16T15:00:00Z', '2026-01-17T08:30:00Z', 10.0, 'A',  10.0, 'A',  false, false, 'graded',    'online_upload', 0),
(302, 3, 1, '2026-01-30T20:10:00Z', '2026-02-01T09:00:00Z', 46.0, 'A-', 46.0, 'A-', false, false, 'graded',    'online_upload', 0),
(303, 3, 1, '2026-02-13T23:45:00Z', '2026-02-15T10:30:00Z', 69.0, 'B+', 69.0, 'B+', false, false, 'graded',    'online_upload', 0),
-- CS460
(401, 4, 1, '2026-01-23T17:20:00Z', '2026-01-25T11:00:00Z', 48.0, 'A',  48.0, 'A',  false, false, 'graded',    'online_upload', 0),
(402, 4, 1, '2026-02-06T19:35:00Z', '2026-02-08T09:30:00Z', 54.0, 'A-', 54.0, 'A-', false, false, 'graded',    'online_upload', 0),
(403, 4, 1, '2026-02-21T14:50:00Z', '2026-02-23T10:00:00Z', 63.0, 'A-', 63.0, 'A-', false, false, 'graded',    'online_upload', 0);

-- ==========================================
-- QUIZZES
-- ==========================================
INSERT INTO quizzes (id, course_id, assignment_id, title, description, quiz_type, scoring_policy, due_at, unlock_at, lock_at, time_limit, allowed_attempts, points_possible, published, html_url) VALUES
(1, 1, 102, 'Quiz 1: Probability Rules',
  'Covers probability axioms, conditional probability, multiplication rule, and Bayes theorem. Closed book.',
  'graded', 'keep_highest',
  '2026-02-06T23:59:59Z', '2026-02-03T00:00:00Z', '2026-02-06T23:59:59Z',
  30, 1, 20.0, true, 'https://canvas.university.edu/courses/1/quizzes/1'),
(2, 1, NULL, 'Quiz 2: Sampling Distributions',
  'Covers sampling distributions, standard error, and the Central Limit Theorem. Formula sheet allowed.',
  'graded', 'keep_highest',
  '2026-03-06T23:59:59Z', '2026-03-03T00:00:00Z', '2026-03-06T23:59:59Z',
  30, 1, 20.0, true, 'https://canvas.university.edu/courses/1/quizzes/2'),
(3, 2, 201, 'Quiz 1: ML Fundamentals',
  'Supervised vs unsupervised learning, bias-variance tradeoff, cross-validation, and evaluation metrics.',
  'graded', 'keep_highest',
  '2026-01-30T23:59:59Z', '2026-01-27T00:00:00Z', '2026-01-30T23:59:59Z',
  40, 1, 40.0, true, 'https://canvas.university.edu/courses/2/quizzes/3'),
(4, 2, NULL, 'Quiz 2: Deep Learning Concepts',
  'Covers CNNs, pooling layers, batch normalization, dropout, and common architectures.',
  'graded', 'keep_highest',
  '2026-03-06T23:59:59Z', '2026-03-03T00:00:00Z', '2026-03-06T23:59:59Z',
  40, 1, 40.0, true, 'https://canvas.university.edu/courses/2/quizzes/4'),
(5, 3, NULL, 'Jetpack Compose Theory Quiz',
  'Tests understanding of composable functions, state hoisting, recomposition, and Material 3 theming.',
  'graded', 'keep_highest',
  '2026-03-06T23:59:59Z', '2026-03-03T00:00:00Z', '2026-03-06T23:59:59Z',
  25, 1, 25.0, true, 'https://canvas.university.edu/courses/3/quizzes/5'),
(6, 4, NULL, 'Next.js Server Components Quiz',
  'Covers server vs client components, data fetching patterns, caching strategies, and Suspense boundaries.',
  'graded', 'keep_highest',
  '2026-03-06T23:59:59Z', '2026-03-03T00:00:00Z', '2026-03-06T23:59:59Z',
  30, 1, 30.0, true, 'https://canvas.university.edu/courses/4/quizzes/6');

-- ==========================================
-- CALENDAR EVENTS
-- ==========================================
INSERT INTO calendar_events (id, course_id, assignment_id, title, description, start_at, end_at, all_day, workflow_state, html_url) VALUES
-- STAT401
(1,  1, NULL, 'STAT401 Office Hours',
  'Weekly office hours with Prof. Torres. Room 312 Mathematics Building.',
  '2026-03-03T14:00:00Z', '2026-03-03T16:00:00Z', false, 'active',
  'https://canvas.university.edu/courses/1/calendar_events/1'),
(2,  1, NULL, 'Midterm Review Session',
  'Optional review session covering Weeks 1-8 material. Bring your questions.',
  '2026-03-05T18:00:00Z', '2026-03-05T20:00:00Z', false, 'active',
  'https://canvas.university.edu/courses/1/calendar_events/2'),
(3,  1, 104, 'Midterm Examination',
  'In-class midterm exam. Closed book, formula sheet provided. Room 101 Engineering Hall.',
  '2026-03-07T09:00:00Z', '2026-03-07T10:20:00Z', false, 'active',
  'https://canvas.university.edu/courses/1/calendar_events/3'),
(4,  1, 105, 'HW3 Regression Analysis Due',
  'Final day to submit HW3 on regression analysis via Canvas.',
  '2026-04-11T23:59:59Z', '2026-04-11T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/1/calendar_events/4'),
(5,  1, 106, 'Final Project Report Due',
  'Statistical analysis report final submission deadline.',
  '2026-05-08T23:59:59Z', '2026-05-08T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/1/calendar_events/5'),
-- DS450
(6,  2, NULL, 'Midterm Project Checkpoint',
  'Brief 5-minute check-in with instructor on CNN architecture plan. Sign up slot required.',
  '2026-03-03T16:00:00Z', '2026-03-03T17:30:00Z', false, 'active',
  'https://canvas.university.edu/courses/2/calendar_events/6'),
(7,  2, 204, 'Midterm Project Due: CNN Classifier',
  'Submit CNN image classifier project via Canvas by 11:59 PM.',
  '2026-03-08T23:59:59Z', '2026-03-08T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/2/calendar_events/7'),
(8,  2, NULL, 'Guest Lecture: ML in Production at Scale',
  'Industry guest from a tech company on deploying ML systems. Attendance optional but encouraged.',
  '2026-03-20T15:00:00Z', '2026-03-20T17:00:00Z', false, 'active',
  'https://canvas.university.edu/courses/2/calendar_events/8'),
(9,  2, 205, 'Lab 3 NLP Assignment Due',
  'NLP text classification notebook and write-up submission deadline.',
  '2026-04-10T23:59:59Z', '2026-04-10T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/2/calendar_events/9'),
(10, 2, 206, 'Final Presentations',
  'ML system design final presentations. 12 minutes each plus Q&A. Attendance mandatory.',
  '2026-05-01T14:00:00Z', '2026-05-01T18:00:00Z', false, 'active',
  'https://canvas.university.edu/courses/2/calendar_events/10'),
-- CS430
(11, 3, 304, 'Lab 4 Due: RecyclerView',
  'Submit Lab 4 RecyclerView implementation to Canvas by 11:59 PM tonight.',
  '2026-02-28T23:59:59Z', '2026-02-28T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/3/calendar_events/11'),
(12, 3, NULL, 'Spring Break - No Class',
  'Spring recess. No classes or office hours. Midterm App work-in-progress expected upon return.',
  '2026-03-16T00:00:00Z', '2026-03-20T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/3/calendar_events/12'),
(13, 3, NULL, 'Midterm App Demo and Review',
  'In-class demo walkthrough and rubric review before final Midterm App submission.',
  '2026-04-09T17:00:00Z', '2026-04-09T19:00:00Z', false, 'active',
  'https://canvas.university.edu/courses/3/calendar_events/13'),
(14, 3, 305, 'Midterm App Due: Task Manager',
  'Midterm Task Manager app submission deadline including APK and source.',
  '2026-04-11T23:59:59Z', '2026-04-11T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/3/calendar_events/14'),
(15, 3, 306, 'Final App Submission Due',
  'Final Android application APK, source code, and demo video submission.',
  '2026-05-01T23:59:59Z', '2026-05-01T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/3/calendar_events/15'),
-- CS460
(16, 4, NULL, 'Guest Lecture: Next.js in Production',
  'Engineering talk on running Next.js apps at scale. Real-world case studies on caching and edge deployments.',
  '2026-03-10T15:00:00Z', '2026-03-10T17:00:00Z', false, 'active',
  'https://canvas.university.edu/courses/4/calendar_events/16'),
(17, 4, 404, 'Database Integration Project Due',
  'Full-stack Prisma + PostgreSQL project submission deadline.',
  '2026-03-21T23:59:59Z', '2026-03-21T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/4/calendar_events/17'),
(18, 4, 405, 'Auth Lab Due',
  'NextAuth.js authentication lab submission deadline.',
  '2026-04-12T23:59:59Z', '2026-04-12T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/4/calendar_events/18'),
(19, 4, NULL, 'Capstone Code Freeze',
  'All new features must be merged. Only bug fixes and deployment config changes after this date.',
  '2026-05-05T23:59:59Z', '2026-05-05T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/4/calendar_events/19'),
(20, 4, 406, 'Capstone Deployment Due',
  'Final live Vercel deployment with production database. Submit URL and project report.',
  '2026-05-08T23:59:59Z', '2026-05-08T23:59:59Z', true, 'active',
  'https://canvas.university.edu/courses/4/calendar_events/20');

-- ==========================================
-- COURSE GRADE SNAPSHOTS
-- ==========================================
-- Three captured points per course showing grade trajectory
INSERT INTO course_grade_snapshots (id, course_id, user_id, captured_at, current_score, current_grade, final_score, final_grade, source) VALUES
-- STAT401: started strong, stable B range
(1,  1, 1, '2026-01-24T12:00:00Z', 86.0, 'B',  NULL, NULL, 'system'),
(2,  1, 1, '2026-02-08T12:00:00Z', 85.6, 'B',  NULL, NULL, 'system'),
(3,  1, 1, '2026-02-28T12:00:00Z', 86.2, 'B',  NULL, NULL, 'system'),
-- DS450: excellent, consistently A-
(4,  2, 1, '2026-01-31T12:00:00Z', 95.0, 'A',  NULL, NULL, 'system'),
(5,  2, 1, '2026-02-15T12:00:00Z', 92.4, 'A-', NULL, NULL, 'system'),
(6,  2, 1, '2026-02-28T12:00:00Z', 92.4, 'A-', NULL, NULL, 'system'),
-- CS430: dipped slightly as labs got harder
(7,  3, 1, '2026-01-17T12:00:00Z', 100.0,'A',  NULL, NULL, 'system'),
(8,  3, 1, '2026-02-01T12:00:00Z', 93.3, 'A-', NULL, NULL, 'system'),
(9,  3, 1, '2026-02-28T12:00:00Z', 89.3, 'B+', NULL, NULL, 'system'),
-- CS460: high throughout
(10, 4, 1, '2026-01-25T12:00:00Z', 96.0, 'A',  NULL, NULL, 'system'),
(11, 4, 1, '2026-02-09T12:00:00Z', 92.7, 'A-', NULL, NULL, 'system'),
(12, 4, 1, '2026-02-28T12:00:00Z', 92.7, 'A-', NULL, NULL, 'system');

-- ==========================================
-- ANNOUNCEMENTS
-- ==========================================
INSERT INTO announcements (id, course_id, author_id, title, message_html, posted_at, published, html_url) VALUES
-- STAT401
(1,  1, 2, 'Welcome to Applied Statistics',
  '<p>Welcome to STAT401! The syllabus, course schedule, and Week 1-2 materials are now posted on Canvas. Please complete the required textbook setup before Monday.</p>',
  '2026-01-12T08:00:00Z', true,
  'https://canvas.university.edu/courses/1/discussion_topics/1'),
(2,  1, 2, 'Midterm Exam: What to Expect',
  '<p>The Midterm Exam is on <strong>Saturday, March 7 at 9:00 AM</strong> in Room 101 Engineering Hall. It covers Weeks 1-8. A formula sheet covering distributions and CLT will be provided. Review all problem sets and the sampling distribution slides from Week 7-8.</p>',
  '2026-02-27T09:00:00Z', true,
  'https://canvas.university.edu/courses/1/discussion_topics/2'),
(3,  1, 2, 'HW2 Graded and Returned',
  '<p>HW2 grades are posted. Class average was 41/50. Common mistakes: incorrect use of z-scores for non-normal distributions and missing units. See detailed feedback in SpeedGrader.</p>',
  '2026-02-22T11:00:00Z', true,
  'https://canvas.university.edu/courses/1/discussion_topics/3'),
-- DS450
(4,  2, 2, 'Course Overview and Expectations',
  '<p>Welcome to DS450. This semester we move fast — please ensure PyTorch and CUDA are set up by Wednesday. Lab 1 will be released on Monday. See the syllabus for full project expectations.</p>',
  '2026-01-12T08:30:00Z', true,
  'https://canvas.university.edu/courses/2/discussion_topics/4'),
(5,  2, 2, 'Lab 2 Grading in Progress',
  '<p>Lab 2 (Neural Networks Problem Set) submissions are being reviewed. Grades will be returned by March 5. Most common issue so far: training curves not included in the submitted notebook.</p>',
  '2026-02-28T10:00:00Z', true,
  'https://canvas.university.edu/courses/2/discussion_topics/5'),
(6,  2, 2, 'Midterm Project Requirements Posted',
  '<p>The Midterm Project specification for the CNN Image Classifier is now available on the Module 2004 page. Target: >80% test accuracy on CIFAR-10. Start early — training takes time. Due March 8.</p>',
  '2026-02-21T09:00:00Z', true,
  'https://canvas.university.edu/courses/2/discussion_topics/6'),
-- CS430
(7,  3, 2, 'Welcome to CS430',
  '<p>Welcome to Mobile App Development! Install Android Studio Hedgehog before Wednesday. Lab 1 is a quick Kotlin warmup — should take 30-60 minutes if you have any programming background.</p>',
  '2026-01-12T08:00:00Z', true,
  'https://canvas.university.edu/courses/3/discussion_topics/7'),
(8,  3, 2, 'Lab 4 Due Tonight at 11:59 PM',
  '<p>Just a reminder that <strong>Lab 4: RecyclerView and LazyColumn is due tonight at 11:59 PM</strong>. Make sure swipe-to-delete is implemented and your APK runs on the emulator before submitting. No late submissions accepted.</p>',
  '2026-02-28T08:00:00Z', true,
  'https://canvas.university.edu/courses/3/discussion_topics/8'),
(9,  3, 2, 'Midterm App Requirements Released',
  '<p>The Midterm App (Task Manager) requirements and rubric are now available in Module 3005. You have 6 weeks. Focus on Compose UI, DataStore persistence, and a clean architecture before adding features.</p>',
  '2026-02-20T10:00:00Z', true,
  'https://canvas.university.edu/courses/3/discussion_topics/9'),
-- CS460
(10, 4, 2, 'Getting Started with React 19',
  '<p>Welcome to CS460! We are using React 19 this semester. If you completed CS360 with React 18, review the migration guide linked in Module 4001. The hooks fundamentals are the same but there are important changes to transitions and actions.</p>',
  '2026-01-12T08:00:00Z', true,
  'https://canvas.university.edu/courses/4/discussion_topics/10'),
(11, 4, 2, 'Server Components Lab Guidance',
  '<p>A few notes on Lab 3 before the deadline: use <code>use server</code> only inside Server Actions, not at the top of page files. Several submissions this week had this reversed. The grading rubric is strict on this point.</p>',
  '2026-02-24T09:30:00Z', true,
  'https://canvas.university.edu/courses/4/discussion_topics/11'),
(12, 4, 2, 'Database Integration Project Kickoff',
  '<p>The Database Integration Project is now available in Module 4005. You will use Prisma with a provided PostgreSQL instance. The schema must include at least 3 models with relations. Plan your schema before you write any code — migrations are painful to undo.</p>',
  '2026-02-26T10:00:00Z', true,
  'https://canvas.university.edu/courses/4/discussion_topics/12');

-- ==========================================
-- PAGES
-- ==========================================
INSERT INTO pages (course_id, url, title, body_html, front_page, published, last_edited_by_id, updated_at_canvas) VALUES
-- STAT401
(1, 'syllabus', 'Course Syllabus',
  '<h2>STAT401 Syllabus</h2><p>Applied Statistics (STAT401) develops probability theory, random variables, and statistical inference for analyzing real-world data. Topics by week: 1-2 descriptive statistics and data types; 3-4 probability rules and Bayes theorem; 5-6 binomial, Poisson, and normal distributions; 7-8 sampling distributions and CLT; 9-10 hypothesis testing with t-tests and chi-square; 11-12 ANOVA and non-parametric tests; 13-14 simple linear regression; 15-16 multiple regression and final project. Grading: Homework 30%, Quizzes 20%, Midterm 25%, Final Project 25%. Midterm exam March 7. Final project due May 8.</p>',
  true, true, 2, '2026-01-12T08:00:00Z'),
(1, 'week-7-8-study-guide', 'Week 7-8 Study Guide: Sampling Distributions',
  '<h2>Sampling Distributions and the Central Limit Theorem</h2><p>Key concepts: sampling distribution of the sample mean, standard error SE=σ/√n, the CLT statement and conditions, normal approximation for large samples, and t-distribution for small samples. Focus problem types: finding probabilities for sample means, constructing confidence intervals, and identifying when to use z vs t.</p>',
  false, true, 2, '2026-02-21T10:00:00Z'),
(1, 'midterm-review', 'Midterm Review Notes',
  '<h2>Midterm Review: Weeks 1-8</h2><p>Covers: descriptive stats (mean, median, SD, IQR, boxplots), probability (axioms, conditional, independence, Bayes), distributions (binomial, Poisson, normal, exponential), and sampling (CLT, standard error, confidence intervals). Know how to use the z-table. Practice: HW1, HW2, both quizzes.</p>',
  false, true, 2, '2026-02-27T12:00:00Z'),
-- DS450
(2, 'syllabus', 'Course Syllabus',
  '<h2>DS450 Syllabus</h2><p>Advanced Machine Learning (DS450) covers modern supervised learning, deep neural networks, and generative AI from foundations to deployment. Topics by week: 1-2 ML review and model evaluation; 3-4 optimization and regularization; 5-6 deep neural networks and backpropagation; 7-8 CNNs and training techniques; 9-10 natural language processing and text preprocessing; 11-12 transformers and attention mechanisms; 13-14 large language models and fine-tuning; 15-16 RAG systems and deployment. Grading: Quizzes 20%, Labs 30%, Midterm Project 25%, Final Presentation 25%. Midterm project due March 8. Final presentation May 1.</p>',
  true, true, 2, '2026-01-12T08:00:00Z'),
(2, 'cnn-architecture-reference', 'CNN Architecture Reference Sheet',
  '<h2>CNN Key Concepts for Midterm Project</h2><p>Convolutional layers: filter size, stride, padding. Pooling: max vs average. Batch normalization: placement before or after activation. Dropout: training vs inference mode. Common architectures: LeNet, AlexNet, VGG, ResNet skip connections. For CIFAR-10: use at least 3 conv blocks, global average pooling before FC layers, and data augmentation (random crops, horizontal flips).</p>',
  false, true, 2, '2026-02-21T09:00:00Z'),
(2, 'midterm-project-requirements', 'Midterm Project: CNN Classifier Requirements',
  '<h2>CNN Image Classifier Rubric</h2><p>Dataset: CIFAR-10. Minimum test accuracy: 80%. Required: data augmentation pipeline, batch normalization in at least 2 layers, dropout before final FC layer, training/validation loss curves, confusion matrix. Bonus: residual connections, learning rate scheduling. Submit: notebook + report (max 4 pages) + saved model checkpoint. Due March 8.</p>',
  false, true, 2, '2026-02-21T10:00:00Z'),
-- CS430
(3, 'syllabus', 'Course Syllabus',
  '<h2>CS430 Syllabus</h2><p>Mobile Application Development (CS430) teaches native Android development using Kotlin and Jetpack Compose for modern production apps. Topics by week: 1-2 Kotlin fundamentals and Android Studio; 3-4 activities, intents, and XML layouts; 5-6 Jetpack Compose and declarative UI; 7-8 RecyclerView and lazy lists; 9-10 Jetpack Navigation and MVVM architecture; 11-12 Retrofit and REST API integration; 13-14 Room database and local storage; 15-16 testing, polish, and final submission. Grading: Labs 35%, Midterm App 25%, Final App 40%. Midterm app due April 11. Final APK and source due May 1.</p>',
  true, true, 2, '2026-01-12T08:00:00Z'),
(3, 'lab-4-instructions', 'Lab 4 Instructions: RecyclerView and LazyColumn',
  '<h2>Lab 4: RecyclerView and LazyColumn</h2><p>Part A: Implement a RecyclerView using ViewHolder pattern in an XML-based Activity. Load items from a provided local JSON file using Gson. Part B: Implement the same screen as a LazyColumn in Jetpack Compose. Both parts: support item click events (show Toast), implement swipe-to-delete (ItemTouchHelper for Part A, DismissToDelete for Part B). Submit as a single Android Studio project. Graded on: functionality (50%), code quality (20%), both implementations present (30%). Due Feb 28 at 11:59 PM.</p>',
  false, true, 2, '2026-02-20T10:00:00Z'),
(3, 'kotlin-reference', 'Kotlin Language Reference Card',
  '<h2>Kotlin Quick Reference</h2><p>Variables: val (immutable) vs var (mutable). Null safety: ?, !!, ?.let, ?: elvis. Functions: fun, default args, named args, extension functions. Collections: List, MutableList, Map, filter/map/reduce. Coroutines: suspend fun, launch, async/await, Dispatchers.IO vs Main. Data classes: auto-generated equals, hashCode, copy, toString. Sealed classes for state modeling. Companion objects for static-like members.</p>',
  false, true, 2, '2026-01-15T10:00:00Z'),
-- CS460
(4, 'syllabus', 'Course Syllabus',
  '<h2>CS460 Syllabus</h2><p>Full Stack Web Development (CS460) builds production-grade web applications using React, Next.js App Router, Tailwind CSS, and PostgreSQL. Topics by week: 1-2 React components and hooks; 3-4 advanced state and context; 5-6 Next.js App Router and layouts; 7-8 server components and server actions; 9-10 Prisma ORM and PostgreSQL integration; 11-12 NextAuth authentication and sessions; 13-14 testing and performance optimization; 15-16 Vercel deployment and capstone. Grading: Assignments 25%, Labs 30%, Database Project 20%, Capstone 25%. Database project due March 21. Capstone deployment due May 8.</p>',
  true, true, 2, '2026-01-12T08:00:00Z'),
(4, 'server-components-guide', 'Server vs Client Components Decision Guide',
  '<h2>When to Use Server vs Client Components</h2><p>Server Components (default in App Router): data fetching, database queries, accessing env vars, heavy computation, rendering static content. Client Components (add ''use client''): event handlers, useState/useEffect, browser APIs, third-party libraries needing DOM. Rule: push ''use client'' as far down the tree as possible. Never import a Client Component into a Server Component without a boundary. Server Actions: async functions with ''use server'', used for form submissions and mutations — they run on the server but can be called from clients.</p>',
  false, true, 2, '2026-02-22T10:00:00Z'),
(4, 'db-integration-setup', 'Database Integration Project Setup Guide',
  '<h2>Getting Started: Prisma + PostgreSQL</h2><p>Step 1: npm install prisma @prisma/client. Step 2: npx prisma init --datasource-provider postgresql. Step 3: Define your schema in prisma/schema.prisma with at least 3 models and at least one relation. Step 4: Run npx prisma migrate dev --name init. Step 5: npx prisma generate. Step 6: Create lib/db.ts with PrismaClient singleton. Common mistake: importing PrismaClient directly in component files causes multiple instances in development. Always use the singleton pattern.</p>',
  false, true, 2, '2026-02-26T11:00:00Z');

-- ==========================================
-- FILES
-- ==========================================
INSERT INTO files (id, course_id, display_name, filename, content_type, size_bytes, url, hidden, created_at_canvas, updated_at_canvas) VALUES
-- STAT401
(1001, 1, 'Lecture 1-2 Slides: Data Types and Summaries', 'stat401_lec1_2.pdf',      'application/pdf', 2400000, 'https://canvas.university.edu/files/1001', false, '2026-01-12T07:00:00Z', '2026-01-12T07:00:00Z'),
(1002, 1, 'Lecture 3-4 Slides: Probability Rules',        'stat401_lec3_4.pdf',      'application/pdf', 2100000, 'https://canvas.university.edu/files/1002', false, '2026-01-26T07:00:00Z', '2026-01-26T07:00:00Z'),
(1003, 1, 'Lecture 5-6 Slides: Distributions',            'stat401_lec5_6.pdf',      'application/pdf', 2600000, 'https://canvas.university.edu/files/1003', false, '2026-02-09T07:00:00Z', '2026-02-09T07:00:00Z'),
(1004, 1, 'Lecture 7-8 Slides: Sampling and CLT',         'stat401_lec7_8.pdf',      'application/pdf', 2300000, 'https://canvas.university.edu/files/1004', false, '2026-02-23T07:00:00Z', '2026-02-23T07:00:00Z'),
-- DS450
(2001, 2, 'Lecture 1-2 Slides: Supervised Learning Review','ds450_lec1_2.pdf',       'application/pdf', 3100000, 'https://canvas.university.edu/files/2001', false, '2026-01-12T07:00:00Z', '2026-01-12T07:00:00Z'),
(2002, 2, 'Lecture 3-4 Slides: Optimization',             'ds450_lec3_4.pdf',        'application/pdf', 2800000, 'https://canvas.university.edu/files/2002', false, '2026-01-26T07:00:00Z', '2026-01-26T07:00:00Z'),
(2003, 2, 'Lecture 5-6 Slides: Neural Network Foundations','ds450_lec5_6.pdf',       'application/pdf', 3400000, 'https://canvas.university.edu/files/2003', false, '2026-02-09T07:00:00Z', '2026-02-09T07:00:00Z'),
(2004, 2, 'Lecture 7-8 Slides: CNNs and Deep Learning',   'ds450_lec7_8.pdf',        'application/pdf', 4200000, 'https://canvas.university.edu/files/2004', false, '2026-02-23T07:00:00Z', '2026-02-23T07:00:00Z'),
-- CS430
(3001, 3, 'Android Studio Setup and Installation Guide',   'cs430_android_setup.pdf', 'application/pdf', 1800000, 'https://canvas.university.edu/files/3001', false, '2026-01-12T07:00:00Z', '2026-01-12T07:00:00Z'),
(3002, 3, 'Lecture 3-4 Slides: Activities and Layouts',   'cs430_lec3_4.pdf',        'application/pdf', 2500000, 'https://canvas.university.edu/files/3002', false, '2026-01-26T07:00:00Z', '2026-01-26T07:00:00Z'),
(3003, 3, 'Jetpack Compose Basics Codelab Guide',          'cs430_compose_guide.pdf', 'application/pdf', 3200000, 'https://canvas.university.edu/files/3003', false, '2026-02-09T07:00:00Z', '2026-02-09T07:00:00Z'),
(3004, 3, 'Lecture 7-8 Slides: RecyclerView and LazyColumn','cs430_lec7_8.pdf',      'application/pdf', 2700000, 'https://canvas.university.edu/files/3004', false, '2026-02-23T07:00:00Z', '2026-02-23T07:00:00Z'),
-- CS460
(4001, 4, 'React Hooks Reference Cheat Sheet',             'cs460_hooks_ref.pdf',     'application/pdf', 1200000, 'https://canvas.university.edu/files/4001', false, '2026-01-12T07:00:00Z', '2026-01-12T07:00:00Z'),
(4002, 4, 'Lecture 5-6 Slides: Next.js App Router',        'cs460_lec5_6.pdf',        'application/pdf', 2900000, 'https://canvas.university.edu/files/4002', false, '2026-02-09T07:00:00Z', '2026-02-09T07:00:00Z'),
(4003, 4, 'App Router Architecture Overview Slides',       'cs460_lec7_8.pdf',        'application/pdf', 2600000, 'https://canvas.university.edu/files/4003', false, '2026-02-23T07:00:00Z', '2026-02-23T07:00:00Z'),
(4004, 4, 'Prisma ORM Setup and Migration Guide',          'cs460_prisma_setup.pdf',  'application/pdf', 1900000, 'https://canvas.university.edu/files/4004', false, '2026-02-26T07:00:00Z', '2026-02-26T07:00:00Z');

-- ==========================================
-- DISCUSSIONS
-- ==========================================
INSERT INTO discussions (id, course_id, assignment_id, user_id, title, message_html, discussion_type, pinned, locked, published, posted_at, html_url) VALUES
(1, 1, NULL, 2, 'Week 7-8 Questions: Sampling and CLT',
  '<p>Use this thread for questions about sampling distributions, CLT, and standard error from this week''s lectures. Please check if your question was already asked before posting.</p>',
  'threaded', true, false, true, '2026-02-23T08:00:00Z',
  'https://canvas.university.edu/courses/1/discussion_topics/21'),
(2, 2, 204, 2, 'Midterm Project: Questions and Clarifications',
  '<p>Ask all questions about the CNN Image Classifier Midterm Project here. Review the requirements page and rubric before asking — most questions are answered there.</p>',
  'threaded', true, false, true, '2026-02-21T09:00:00Z',
  'https://canvas.university.edu/courses/2/discussion_topics/22'),
(3, 3, 304, 2, 'Lab 4 Help: RecyclerView and LazyColumn',
  '<p>Questions about Lab 4 due tonight. For swipe-to-delete in Compose use SwipeToDismissBox (not the deprecated Dismissible). For RecyclerView use ItemTouchHelper with SimpleCallback.</p>',
  'threaded', true, false, true, '2026-02-24T09:00:00Z',
  'https://canvas.university.edu/courses/3/discussion_topics/23'),
(4, 4, NULL, 2, 'Server Actions and Database Project Discussion',
  '<p>Use this thread for questions about Server Actions (Lab 3 and Module 4004) and the upcoming Database Integration Project. Include relevant code snippets when asking implementation questions.</p>',
  'threaded', true, false, true, '2026-02-22T09:00:00Z',
  'https://canvas.university.edu/courses/4/discussion_topics/24');
