% Task Management Queries
% Load this file after consulting task_manager.pl

% 1. Find all tasks for a specific date
tasks_for_date(Date, Tasks) :-
    findall(task(ID, Desc, Priority, Status, Date), 
            task(ID, Desc, Priority, Status, Date), 
            Tasks).

% 2. Find tasks by status
tasks_by_status(Status, Tasks) :-
    findall(task(ID, Desc, Priority, Status, Date), 
            task(ID, Desc, Priority, Status, Date), 
            Tasks).

% 3. Find tasks by priority
tasks_by_priority(Priority, Tasks) :-
    findall(task(ID, Desc, Priority, Status, Date), 
            task(ID, Desc, Priority, Status, Date), 
            Tasks).

% 4. Find high priority pending tasks
urgent_tasks(Tasks) :-
    findall(task(ID, Desc, high, pending, Date), 
            task(ID, Desc, high, pending, Date), 
            Tasks).

% 5. Count tasks by status
count_tasks_by_status(Status, Count) :-
    findall(ID, task(ID, _, _, Status, _), Tasks),
    length(Tasks, Count).

% 6. Check if a task exists
task_exists(ID) :-
    task(ID, _, _, _, _).

% 7. Get task details by ID
get_task(ID, Desc, Priority, Status, Date) :-
    task(ID, Desc, Priority, Status, Date).

% 8. Find overdue tasks (assuming today is 2025-08-18)
overdue_tasks(Tasks) :-
    findall(task(ID, Desc, Priority, Status, Date), 
            (task(ID, Desc, Priority, Status, Date), 
             Date @< '2025-08-18', 
             Status \= completed), 
            Tasks).

% 9. Find today's incomplete tasks
todays_incomplete_tasks(Tasks) :-
    findall(task(ID, Desc, Priority, Status, '2025-08-18'), 
            (task(ID, Desc, Priority, Status, '2025-08-18'), 
             Status \= completed), 
            Tasks).

% 10. Display task in readable format
display_task(ID) :-
    task(ID, Desc, Priority, Status, Date),
    format('Task ~w: ~w~n', [ID, Desc]),
    format('  Priority: ~w~n', [Priority]),
    format('  Status: ~w~n', [Status]),
    format('  Date: ~w~n', [Date]).

% Helper predicate to display all tasks in a list
display_tasks([]).
display_tasks([task(ID, Desc, Priority, Status, Date)|Rest]) :-
    format('ID: ~w | ~w | Priority: ~w | Status: ~w | Date: ~w~n', 
           [ID, Desc, Priority, Status, Date]),
    display_tasks(Rest).

% Example usage queries:
%
% ?- tasks_for_date('2025-08-18', Tasks), display_tasks(Tasks).
% ?- tasks_by_status(pending, Tasks), display_tasks(Tasks).
% ?- tasks_by_priority(high, Tasks), display_tasks(Tasks).
% ?- urgent_tasks(Tasks), display_tasks(Tasks).
% ?- count_tasks_by_status(pending, Count).
% ?- task_exists(1).
% ?- get_task(1, Desc, Priority, Status, Date).
% ?- todays_incomplete_tasks(Tasks), display_tasks(Tasks).
% ?- display_task(1).
