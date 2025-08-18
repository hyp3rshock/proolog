# Prolog Task Management - Line by Line Documentation

## Understanding Prolog Basics

### What is Prolog?
Prolog is a logic programming language that works with **facts** and **rules**. You ask questions (queries) and Prolog finds answers based on the facts and rules you've defined.

---

## File 1: task_manager.pl (Line by Line)

```prolog
% Daily Task Management System in Prolog
% Basic project for managing daily tasks
```
**Lines 1-2**: Comments in Prolog start with `%`. These are just descriptions.

```prolog
% Task structure: task(ID, Description, Priority, Status, Date)
% Priority: high, medium, low
% Status: pending, in_progress, completed
% Date: format YYYY-MM-DD
```
**Lines 4-7**: Documentation explaining our data structure. Each task has 5 pieces of information.

```prolog
% Sample task data
task(1, 'Complete Prolog assignment', high, pending, '2025-08-18').
```
**Line 10**: This is a **fact**. It says "Task 1 is 'Complete Prolog assignment' with high priority, pending status, on 2025-08-18"

```prolog
task(2, 'Buy groceries', medium, pending, '2025-08-18').
task(3, 'Call dentist for appointment', low, completed, '2025-08-18').
task(4, 'Prepare presentation slides', high, in_progress, '2025-08-18').
task(5, 'Exercise for 30 minutes', medium, pending, '2025-08-18').
task(6, 'Read chapter 5 of textbook', low, pending, '2025-08-19').
task(7, 'Team meeting at 2 PM', high, pending, '2025-08-19').
```
**Lines 11-16**: More task facts. Each line defines one task with its properties.

---

## File 2: queries.pl (Line by Line)

```prolog
% Task Management Queries
% Load this file after consulting task_manager.pl
```
**Lines 1-2**: Comments explaining this file contains queries.

```prolog
% 1. Find all tasks for a specific date
tasks_for_date(Date, Tasks) :-
    findall(task(ID, Desc, Priority, Status, Date), 
            task(ID, Desc, Priority, Status, Date), 
            Tasks).
```
**Lines 4-7**: This is a **rule** named `tasks_for_date`.
- `:-` means "if" 
- `findall` collects all matching tasks
- `task(ID, Desc, Priority, Status, Date)` is the pattern to find
- `Tasks` will contain the list of found tasks

```prolog
% 2. Find tasks by status
tasks_by_status(Status, Tasks) :-
    findall(task(ID, Desc, Priority, Status, Date), 
            task(ID, Desc, Priority, Status, Date), 
            Tasks).
```
**Lines 9-12**: Rule to find tasks with a specific status (pending, in_progress, completed).

```prolog
% 4. Find high priority pending tasks
urgent_tasks(Tasks) :-
    findall(task(ID, Desc, high, pending, Date), 
            task(ID, Desc, high, pending, Date), 
            Tasks).
```
**Lines 19-22**: Rule to find urgent tasks. Notice `high` and `pending` are hardcoded - this only finds tasks that are both high priority AND pending.

```prolog
% 5. Count tasks by status
count_tasks_by_status(Status, Count) :-
    findall(ID, task(ID, _, _, Status, _), Tasks),
    length(Tasks, Count).
```
**Lines 24-27**: 
- `_` means "don't care" - we only want the ID
- `length(Tasks, Count)` counts how many items are in the Tasks list

```prolog
% 6. Check if a task exists
task_exists(ID) :-
    task(ID, _, _, _, _).
```
**Lines 29-31**: Simple rule that succeeds (returns true) if a task with the given ID exists.

```prolog
% 10. Display task in readable format
display_task(ID) :-
    task(ID, Desc, Priority, Status, Date),
    format('Task ~w: ~w~n', [ID, Desc]),
    format('  Priority: ~w~n', [Priority]),
    format('  Status: ~w~n', [Status]),
    format('  Date: ~w~n', [Date]).
```
**Lines 43-49**: 
- `format` prints formatted text
- `~w` is a placeholder for variables
- `~n` means new line
- This rule prints task details in a nice format

```prolog
% Helper predicate to display all tasks in a list
display_tasks([]).
display_tasks([task(ID, Desc, Priority, Status, Date)|Rest]) :-
    format('ID: ~w | ~w | Priority: ~w | Status: ~w | Date: ~w~n', 
           [ID, Desc, Priority, Status, Date]),
    display_tasks(Rest).
```
**Lines 51-56**: 
- First line handles empty list (base case)
- Second line handles list with at least one task
- `[Head|Tail]` splits list into first item and remaining items
- Recursively calls itself with the remaining tasks

---

## Key Prolog Concepts Explained

### Facts vs Rules
- **Fact**: `task(1, 'Buy milk', low, pending, '2025-08-18').` - States something is true
- **Rule**: `urgent_tasks(Tasks) :- ...` - Defines how to find/compute something

### Variables
- Start with uppercase: `Tasks`, `ID`, `Date`
- `_` means "anonymous variable" (don't care about the value)

### Queries
- End with `.` and start with `?-`
- Example: `?- task_exists(1).` asks "Does task 1 exist?"

### Lists
- `[]` is empty list
- `[1,2,3]` is list with three numbers
- `[Head|Tail]` splits list into first element and rest
