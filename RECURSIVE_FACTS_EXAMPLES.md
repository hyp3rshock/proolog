# Recursive Rules with New Facts - Examples

## New Facts Added

### **More Tasks (15 total now)**
- Tasks 1-15 with different dates, priorities, and statuses
- More variety to demonstrate recursive counting and searching

### **Task Categories**
```prolog
task_category(1, academic).
task_category(2, personal).
task_category(3, health).
task_category(4, work).
```
Each task belongs to a category: academic, personal, health, work, or technical.

### **Subtask Hierarchy**
```prolog
subtask(1, 16).  % Task 1 has subtask 16
subtask(1, 17).  % Task 1 has subtask 17
subtask(4, 18).  % Task 4 has subtask 18
```
Some tasks have subtasks, creating a hierarchy.

---

## Recursive Examples with New Facts

### **Example 1: Count All Tasks Recursively**
```prolog
?- count_all_tasks(Count).
```
**Expected**: `Count = 20.` (now counts all 20 tasks including subtasks)

**How it works**: Recursively checks IDs 1, 2, 3... until no more tasks exist.

---

### **Example 2: Find Maximum Task ID**
```prolog
?- max_task_id(MaxID).
```
**Expected**: `MaxID = 20.` (highest task ID in the system)

**How it works**: Recursively compares each task ID to find the maximum.

---

### **Example 3: Find All Subtasks**
```prolog
?- all_subtasks(1, Subtasks).
```
**Expected**: `Subtasks = [16, 17].` (Task 1 has subtasks 16 and 17)

```prolog
?- all_subtasks(4, Subtasks).
```
**Expected**: `Subtasks = [18, 19].` (Task 4 has subtasks 18 and 19)

**How it works**: Recursively searches for subtasks and their nested subtasks.

---

### **Example 4: Tasks by Category (Recursive)**
```prolog
?- tasks_by_category_recursive(academic, Tasks), display_tasks(Tasks).
```
**Expected Output**:
```
ID: 1 | Complete Prolog assignment | Priority: high | Status: pending | Date: 2025-08-18
ID: 6 | Read chapter 5 of textbook | Priority: low | Status: pending | Date: 2025-08-19
ID: 9 | Submit project report | Priority: high | Status: pending | Date: 2025-08-20
ID: 15 | Learn new programming concept | Priority: low | Status: pending | Date: 2025-08-21
```

**How it works**: 
1. Finds all task IDs in 'academic' category
2. Recursively gets task details for each ID

---

### **Example 5: Check Task Completion with Subtasks**
```prolog
?- task_fully_completed(3).
```
**Expected**: `true.` (Task 3 is completed and has no subtasks)

```prolog
?- task_fully_completed(1).
```
**Expected**: `false.` (Task 1 is pending, even though one subtask is completed)

**How it works**: Recursively checks if task AND all its subtasks are completed.

---

### **Example 6: Priority Escalation**
```prolog
?- escalate_priority(12, NewPriority).
```
**Expected**: `NewPriority = medium.` (Task 12 was low, escalated to medium)

**How it works**: Recursively escalates priority of task and all its subtasks.

---

### **Example 7: Completion Percentage (Now More Accurate)**
```prolog
?- completion_percentage(Percentage).
```
**Expected**: `Percentage = 25.0.` (5 completed out of 20 total tasks)

**How it works**: Uses recursive counting to get total, then calculates percentage.

---

## Understanding the Recursive Patterns

### **Pattern 1: Accumulator Recursion**
```prolog
count_tasks_recursive(ID, Acc, Count) :-
    task(ID, _, _, _, _), !,
    NextID is ID + 1,
    NewAcc is Acc + 1,
    count_tasks_recursive(NextID, NewAcc, Count).  % RECURSIVE CALL
```
- Builds up result in `Acc` (accumulator)
- Each recursive call adds to the accumulator

### **Pattern 2: List Processing Recursion**
```prolog
get_tasks_by_ids([ID|RestIDs], [TaskDetails|RestTasks]) :-
    task(ID, Desc, Priority, Status, Date),
    get_tasks_by_ids(RestIDs, RestTasks).  % RECURSIVE CALL
```
- Processes list head, then recursively processes tail
- Builds result list as it goes

### **Pattern 3: Tree Traversal Recursion**
```prolog
find_all_subtasks(TaskID, Visited, AllSubtasks) :-
    subtask(TaskID, SubID),
    find_all_subtasks(SubID, [SubID|Visited], NestedSubs).  % RECURSIVE CALL
```
- Traverses tree structure (tasks and subtasks)
- Keeps track of visited nodes to avoid cycles

---

## Test These Recursive Queries

```prolog
% Load files first
?- consult('task_manager.pl').
?- consult('queries.pl').

% Test recursive counting
?- count_all_tasks(Count).

% Find max ID
?- max_task_id(MaxID).

% Find subtasks of task 1
?- all_subtasks(1, Subtasks).

% Get all academic tasks
?- tasks_by_category_recursive(academic, Tasks), display_tasks(Tasks).

% Check if task 1 is fully completed
?- task_fully_completed(1).

% Calculate completion percentage
?- completion_percentage(Percentage).

% Try escalating priority of task 12
?- escalate_priority(12, NewPriority).
```

## Why These Facts Make Recursion Meaningful

1. **More tasks (20 total)** - Better demonstrates recursive counting
2. **Task categories** - Shows recursive grouping by category
3. **Subtask hierarchy** - Demonstrates tree traversal recursion
4. **Varied completion status** - Makes completion percentage calculation meaningful
5. **Different dates** - Shows how recursion works across time periods
