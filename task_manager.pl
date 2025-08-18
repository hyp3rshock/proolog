% Daily Task Management System in Prolog
% Basic project for managing daily tasks

% Task structure: task(ID, Description, Priority, Status, Date)
% Priority: high, medium, low
% Status: pending, in_progress, completed
% Date: format YYYY-MM-DD

% Sample task data
task(1, 'Complete Prolog assignment', high, pending, '2025-08-18').
task(2, 'Buy groceries', medium, pending, '2025-08-18').
task(3, 'Call dentist for appointment', low, completed, '2025-08-18').
task(4, 'Prepare presentation slides', high, in_progress, '2025-08-18').
task(5, 'Exercise for 30 minutes', medium, pending, '2025-08-18').
task(6, 'Read chapter 5 of textbook', low, pending, '2025-08-19').
task(7, 'Team meeting at 2 PM', high, pending, '2025-08-19').
task(8, 'Review code changes', medium, pending, '2025-08-19').
task(9, 'Submit project report', high, pending, '2025-08-20').
task(10, 'Plan weekend trip', low, pending, '2025-08-20').
task(11, 'Fix laptop issue', medium, completed, '2025-08-17').
task(12, 'Water plants', low, pending, '2025-08-18').
task(13, 'Backup important files', high, completed, '2025-08-17').
task(14, 'Schedule doctor visit', medium, in_progress, '2025-08-19').
task(15, 'Learn new programming concept', low, pending, '2025-08-21').

% Task categories for recursive categorization
task_category(1, academic).
task_category(2, personal).
task_category(3, health).
task_category(4, work).
task_category(5, health).
task_category(6, academic).
task_category(7, work).
task_category(8, work).
task_category(9, academic).
task_category(10, personal).
task_category(11, technical).
task_category(12, personal).
task_category(13, technical).
task_category(14, health).
task_category(15, academic).

% Task subtasks for recursive hierarchy
subtask(1, 16).  % Task 1 has subtask 16
subtask(1, 17).  % Task 1 has subtask 17
subtask(4, 18).  % Task 4 has subtask 18
subtask(4, 19).  % Task 4 has subtask 19
subtask(9, 20).  % Task 9 has subtask 20

% Subtask details
task(16, 'Research Prolog syntax', low, completed, '2025-08-18').
task(17, 'Write Prolog code', medium, pending, '2025-08-18').
task(18, 'Create slide outline', low, completed, '2025-08-18').
task(19, 'Add presentation graphics', medium, pending, '2025-08-18').
task(20, 'Proofread final report', low, pending, '2025-08-20').
