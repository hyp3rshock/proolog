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

% RECURSIVE RULES

% 11. Count total tasks using recursion
count_all_tasks(Count) :-
    count_tasks_recursive(1, 0, Count).

% Helper recursive rule to count tasks
count_tasks_recursive(ID, Acc, Count) :-
    task(ID, _, _, _, _), !,  % Task exists, cut to prevent backtracking
    NextID is ID + 1,
    NewAcc is Acc + 1,
    count_tasks_recursive(NextID, NewAcc, Count).
count_tasks_recursive(_, Count, Count).  % Base case: no more tasks

% 12. Find maximum task ID using recursion
max_task_id(MaxID) :-
    find_max_id(1, 0, MaxID).

% Helper recursive rule to find maximum ID
find_max_id(ID, CurrentMax, MaxID) :-
    task(ID, _, _, _, _), !,  % Task exists
    NextID is ID + 1,
    NewMax is max(CurrentMax, ID),
    find_max_id(NextID, NewMax, MaxID).
find_max_id(_, MaxID, MaxID).  % Base case: no more tasks

% 13. Recursive task chain by priority (high -> medium -> low)
task_priority_chain([], []).
task_priority_chain([task(ID, Desc, Priority, Status, Date)|Rest], 
                   [task(ID, Desc, Priority, Status, Date)|SortedRest]) :-
    Priority = high,
    task_priority_chain(Rest, SortedRest).
task_priority_chain([task(ID, Desc, Priority, Status, Date)|Rest], SortedRest) :-
    Priority \= high,
    task_priority_chain(Rest, TempRest),
    append(TempRest, [task(ID, Desc, Priority, Status, Date)], SortedRest).

% 14. Recursive search through task list
find_task_in_list([], _, fail).
find_task_in_list([task(ID, Desc, Priority, Status, Date)|_], ID, 
                  task(ID, Desc, Priority, Status, Date)).
find_task_in_list([_|Rest], ID, Result) :-
    find_task_in_list(Rest, ID, Result).

% 15. Calculate task completion percentage recursively
completion_percentage(Percentage) :-
    count_all_tasks(Total),
    count_tasks_by_status(completed, Completed),
    (Total > 0 -> Percentage is (Completed * 100) / Total ; Percentage = 0).

% 16. Find all subtasks recursively
all_subtasks(TaskID, AllSubtasks) :-
    find_all_subtasks(TaskID, [], AllSubtasks).

find_all_subtasks(TaskID, Visited, AllSubtasks) :-
    subtask(TaskID, SubID),
    \+ member(SubID, Visited),  % Avoid cycles
    find_all_subtasks(SubID, [SubID|Visited], NestedSubs),
    AllSubtasks = [SubID|NestedSubs].
find_all_subtasks(_, AllSubtasks, AllSubtasks).  % Base case

% 17. Recursive category grouping
tasks_by_category_recursive(Category, Tasks) :-
    findall(ID, task_category(ID, Category), TaskIDs),
    get_tasks_by_ids(TaskIDs, Tasks).

get_tasks_by_ids([], []).
get_tasks_by_ids([ID|RestIDs], [task(ID, Desc, Priority, Status, Date)|RestTasks]) :-
    task(ID, Desc, Priority, Status, Date),
    get_tasks_by_ids(RestIDs, RestTasks).

% 18. Recursive task completion checker for subtasks
task_fully_completed(TaskID) :-
    task(TaskID, _, _, completed, _),
    all_subtasks_completed(TaskID).

all_subtasks_completed(TaskID) :-
    \+ subtask(TaskID, _).  % No subtasks
all_subtasks_completed(TaskID) :-
    subtask(TaskID, SubID),
    task_fully_completed(SubID),  % Recursive check
    all_other_subtasks_completed(TaskID, SubID).

all_other_subtasks_completed(TaskID, CheckedSubID) :-
    \+ (subtask(TaskID, OtherSubID), 
        OtherSubID \= CheckedSubID, 
        \+ task_fully_completed(OtherSubID)).

% 19. Recursive priority escalation
escalate_priority(TaskID, NewPriority) :-
    task(TaskID, _, CurrentPriority, _, _),
    escalate_priority_level(CurrentPriority, NewPriority),
    escalate_subtasks(TaskID, NewPriority).

escalate_priority_level(low, medium).
escalate_priority_level(medium, high).
escalate_priority_level(high, high).  % Already highest

escalate_subtasks(TaskID, Priority) :-
    \+ subtask(TaskID, _).  % No subtasks
escalate_subtasks(TaskID, Priority) :-
    subtask(TaskID, SubID),
    escalate_priority(SubID, Priority),  % Recursive escalation
    fail.  % Force backtracking to handle all subtasks
escalate_subtasks(_, _).  % Success after all subtasks processed

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
%
% RECURSIVE EXAMPLES:
% ?- count_all_tasks(Count).
% ?- max_task_id(MaxID).
% ?- completion_percentage(Percentage).
% ?- all_subtasks(1, Subtasks).
% ?- tasks_by_category_recursive(academic, Tasks), display_tasks(Tasks).
% ?- task_fully_completed(1).
% ?- escalate_priority(12, NewPriority).
