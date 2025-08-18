# Prolog Task Management - Examples with Expected Outputs

## How to Run These Examples

1. Start SWI-Prolog
2. Load both files:
   ```prolog
   ?- consult('task_manager.pl').
   ?- consult('queries.pl').
   ```
3. Copy and paste the queries below

---

## Example 1: Check if a task exists

**Query**: 
```prolog
?- task_exists(1).
```

**Expected Output**:
```
true.
```

**Explanation**: Task 1 exists in our database, so Prolog returns `true`.

---

## Example 2: Get task details

**Query**: 
```prolog
?- get_task(1, Desc, Priority, Status, Date).
```

**Expected Output**:
```
Desc = 'Complete Prolog assignment',
Priority = high,
Status = pending,
Date = '2025-08-18'.
```

**Explanation**: Prolog finds task 1 and binds the variables to the actual values.

---

## Example 3: Display a single task nicely

**Query**: 
```prolog
?- display_task(1).
```

**Expected Output**:
```
Task 1: Complete Prolog assignment
  Priority: high
  Status: pending
  Date: 2025-08-18
true.
```

**Explanation**: The `display_task` rule formats and prints the task information.

---

## Example 4: Find all pending tasks

**Query**: 
```prolog
?- tasks_by_status(pending, Tasks), display_tasks(Tasks).
```

**Expected Output**:
```
ID: 1 | Complete Prolog assignment | Priority: high | Status: pending | Date: 2025-08-18
ID: 2 | Buy groceries | Priority: medium | Status: pending | Date: 2025-08-18
ID: 5 | Exercise for 30 minutes | Priority: medium | Status: pending | Date: 2025-08-18
ID: 6 | Read chapter 5 of textbook | Priority: low | Status: pending | Date: 2025-08-19
ID: 7 | Team meeting at 2 PM | Priority: high | Status: pending | Date: 2025-08-19
true.
```

**Explanation**: Finds all tasks with status 'pending' and displays them in a formatted list.

---

## Example 5: Find urgent tasks

**Query**: 
```prolog
?- urgent_tasks(Tasks), display_tasks(Tasks).
```

**Expected Output**:
```
ID: 1 | Complete Prolog assignment | Priority: high | Status: pending | Date: 2025-08-18
ID: 7 | Team meeting at 2 PM | Priority: high | Status: pending | Date: 2025-08-19
true.
```

**Explanation**: Only shows tasks that are both high priority AND pending status.

---

## Example 6: Count tasks by status

**Query**: 
```prolog
?- count_tasks_by_status(pending, Count).
```

**Expected Output**:
```
Count = 5.
```

**Explanation**: Counts how many tasks have 'pending' status.

**Try also**:
```prolog
?- count_tasks_by_status(completed, Count).
```
**Expected**: `Count = 1.`

---

## Example 7: Find today's incomplete tasks

**Query**: 
```prolog
?- todays_incomplete_tasks(Tasks), display_tasks(Tasks).
```

**Expected Output**:
```
ID: 1 | Complete Prolog assignment | Priority: high | Status: pending | Date: 2025-08-18
ID: 2 | Buy groceries | Priority: medium | Status: pending | Date: 2025-08-18
ID: 4 | Prepare presentation slides | Priority: high | Status: in_progress | Date: 2025-08-18
ID: 5 | Exercise for 30 minutes | Priority: medium | Status: pending | Date: 2025-08-18
true.
```

**Explanation**: Shows today's tasks that are not completed (both pending and in_progress).

---

## Example 8: Find tasks for a specific date

**Query**: 
```prolog
?- tasks_for_date('2025-08-19', Tasks), display_tasks(Tasks).
```

**Expected Output**:
```
ID: 6 | Read chapter 5 of textbook | Priority: low | Status: pending | Date: 2025-08-19
ID: 7 | Team meeting at 2 PM | Priority: high | Status: pending | Date: 2025-08-19
true.
```

**Explanation**: Shows only tasks scheduled for tomorrow (2025-08-19).

---

## Example 9: Find high priority tasks

**Query**: 
```prolog
?- tasks_by_priority(high, Tasks), display_tasks(Tasks).
```

**Expected Output**:
```
ID: 1 | Complete Prolog assignment | Priority: high | Status: pending | Date: 2025-08-18
ID: 4 | Prepare presentation slides | Priority: high | Status: in_progress | Date: 2025-08-18
ID: 7 | Team meeting at 2 PM | Priority: high | Status: pending | Date: 2025-08-19
true.
```

**Explanation**: Shows all tasks with high priority, regardless of status or date.

---

## Common Beginner Mistakes

### 1. Forgetting the period
❌ Wrong: `?- task_exists(1)`
✅ Correct: `?- task_exists(1).`

### 2. Case sensitivity
❌ Wrong: `?- task_exists(ID).` (ID is a variable, not the number 1)
✅ Correct: `?- task_exists(1).` (1 is a specific value)

### 3. Atom vs String confusion
❌ Wrong: `?- tasks_by_status("pending", Tasks).` (double quotes)
✅ Correct: `?- tasks_by_status(pending, Tasks).` (atom without quotes)

### 4. Variable naming
❌ Wrong: `?- get_task(1, desc, priority, status, date).` (lowercase = atoms)
✅ Correct: `?- get_task(1, Desc, Priority, Status, Date).` (uppercase = variables)

---

## Quick Reference

### Load Files
```prolog
?- consult('task_manager.pl').
?- consult('queries.pl').
```

### Essential Queries for Beginners
```prolog
% Check if task exists
?- task_exists(1).

% Get task details
?- get_task(1, Desc, Priority, Status, Date).

% Show task nicely
?- display_task(1).

% Find pending tasks
?- tasks_by_status(pending, Tasks), display_tasks(Tasks).

% Count completed tasks
?- count_tasks_by_status(completed, Count).

% Find urgent tasks
?- urgent_tasks(Tasks), display_tasks(Tasks).
```

## Pro Tips

1. **Always end queries with a period (`.`)**
2. **Use uppercase for variables you want Prolog to fill in**
3. **Use lowercase for specific values you're looking for**
4. **Use `display_tasks(Tasks)` to see lists in readable format**
5. **If a query returns `false`, it means no matches were found**
6. **If a query returns `true`, it means the condition was satisfied**
