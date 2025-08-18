# Recursive Rules in Prolog - Beginner Guide

## What is Recursion?
Recursion is when a rule calls itself. It's like a loop that keeps going until it reaches a stopping condition (base case).

---

## Recursive Rule 1: Count All Tasks

### Code Explanation:
```prolog
count_all_tasks(Count) :-
    count_tasks_recursive(1, 0, Count).
```
**Line 1**: Main rule that starts counting from ID 1 with accumulator 0

```prolog
count_tasks_recursive(ID, Acc, Count) :-
    task(ID, _, _, _, _), !,
    NextID is ID + 1,
    NewAcc is Acc + 1,
    count_tasks_recursive(NextID, NewAcc, Count).
count_tasks_recursive(_, Count, Count).
```
**Lines 2-6**: 
- Check if task with current ID exists
- `!` (cut) prevents backtracking
- Calculate next ID and increment accumulator
- **Recursively call itself** with new values
- **Base case**: When no task exists, return the count

### Try This:
```prolog
?- count_all_tasks(Count).
```
**Expected**: `Count = 7.`

---

## Recursive Rule 2: Find Maximum Task ID

### Code Explanation:
```prolog
max_task_id(MaxID) :-
    find_max_id(1, 0, MaxID).
```
**Line 1**: Start searching from ID 1 with current max 0

```prolog
find_max_id(ID, CurrentMax, MaxID) :-
    task(ID, _, _, _, _), !,
    NextID is ID + 1,
    NewMax is max(CurrentMax, ID),
    find_max_id(NextID, NewMax, MaxID).
find_max_id(_, MaxID, MaxID).
```
**Lines 2-7**:
- Check if current ID exists
- Calculate next ID and update maximum
- **Recursively continue** with next ID
- **Base case**: Return the maximum found

### Try This:
```prolog
?- max_task_id(MaxID).
```
**Expected**: `MaxID = 7.`

---

## Recursive Rule 3: Task Priority Chain

### Code Explanation:
```prolog
task_priority_chain([], []).
```
**Line 1**: **Base case** - empty list stays empty

```prolog
task_priority_chain([task(ID, Desc, Priority, Status, Date)|Rest], 
                   [task(ID, Desc, Priority, Status, Date)|SortedRest]) :-
    Priority = high,
    task_priority_chain(Rest, SortedRest).
```
**Lines 2-5**: If first task is high priority, keep it at front and **recursively sort the rest**

```prolog
task_priority_chain([task(ID, Desc, Priority, Status, Date)|Rest], SortedRest) :-
    Priority \= high,
    task_priority_chain(Rest, TempRest),
    append(TempRest, [task(ID, Desc, Priority, Status, Date)], SortedRest).
```
**Lines 6-9**: If first task is not high priority, **recursively sort the rest** first, then add this task at the end

---

## Recursive Rule 4: Search Through List

### Code Explanation:
```prolog
find_task_in_list([], _, fail).
```
**Line 1**: **Base case** - empty list returns fail

```prolog
find_task_in_list([task(ID, Desc, Priority, Status, Date)|_], ID, 
                  task(ID, Desc, Priority, Status, Date)).
```
**Lines 2-3**: If first task matches the ID, return it (found!)

```prolog
find_task_in_list([_|Rest], ID, Result) :-
    find_task_in_list(Rest, ID, Result).
```
**Lines 4-5**: If first task doesn't match, **recursively search the rest** of the list

### Try This:
```prolog
?- tasks_by_status(pending, Tasks), find_task_in_list(Tasks, 2, Result).
```

---

## Recursive Rule 5: Task Dependencies

### Code Explanation:
```prolog
task_dependency(1, 4).  % Task 1 depends on task 4
task_dependency(2, 1).  % Task 2 depends on task 1
```
**Lines 1-2**: Facts defining which tasks depend on others

```prolog
all_dependencies(TaskID, Dependencies) :-
    find_dependencies(TaskID, [], Dependencies).
```
**Line 3**: Main rule to find all dependencies

```prolog
find_dependencies(TaskID, Visited, Dependencies) :-
    task_dependency(TaskID, DepID),
    \+ member(DepID, Visited),
    find_dependencies(DepID, [DepID|Visited], SubDeps),
    Dependencies = [DepID|SubDeps].
find_dependencies(_, Dependencies, Dependencies).
```
**Lines 4-9**:
- Find direct dependency
- Check it's not already visited (prevents infinite loops)
- **Recursively find dependencies** of the dependency
- **Base case**: No more dependencies

### Try This:
```prolog
?- all_dependencies(2, Deps).
```
**Expected**: `Deps = [1, 4].` (Task 2 depends on 1, which depends on 4)

---

## Key Recursive Concepts

### 1. Base Case
Every recursive rule needs a stopping condition:
```prolog
count_tasks_recursive(_, Count, Count).  % Stop when no more tasks
find_task_in_list([], _, fail).          % Stop when list is empty
```

### 2. Recursive Case
The rule calls itself with modified parameters:
```prolog
count_tasks_recursive(NextID, NewAcc, Count).  % Call with next ID
find_task_in_list(Rest, ID, Result).           % Call with rest of list
```

### 3. Accumulator Pattern
Build up result as you go:
```prolog
count_tasks_recursive(ID, Acc, Count)  % Acc keeps running total
```

### 4. List Processing Pattern
```prolog
process_list([]).                    % Base case: empty list
process_list([Head|Tail]) :-         % Process first item
    do_something(Head),              % Handle current item
    process_list(Tail).              % Recursively handle rest
```

---

## Practice Queries for Recursion

Try these to understand recursion better:

```prolog
% Count all tasks
?- count_all_tasks(Count).

% Find highest task ID
?- max_task_id(MaxID).

% Calculate completion percentage
?- completion_percentage(Percentage).

% Find dependencies of task 2
?- all_dependencies(2, Deps).

% Search for task 3 in pending tasks
?- tasks_by_status(pending, Tasks), find_task_in_list(Tasks, 3, Result).
```
