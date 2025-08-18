# Prolog Task Management - Beginner Tutorial

## Step-by-Step Learning Guide

### Step 1: Understanding the Basics

**What you'll learn**: How Prolog facts work

**Try this prompt**:
```prolog
?- task(1, Desc, Priority, Status, Date).
```

**What it does**: Asks "What are the details of task 1?"
**Expected output**: `Desc = 'Complete Prolog assignment', Priority = high, Status = pending, Date = '2025-08-18'`

**Explanation**: Prolog matches the pattern and fills in the variables with actual values.

---

### Step 2: Simple Existence Checks

**What you'll learn**: Boolean queries (true/false questions)

**Try this prompt**:
```prolog
?- task_exists(1).
```

**What it does**: Asks "Does task 1 exist?"
**Expected output**: `true.`

**Try this prompt**:
```prolog
?- task_exists(99).
```

**What it does**: Asks "Does task 99 exist?"
**Expected output**: `false.`

**Explanation**: Prolog returns `true` if it can prove something, `false` if it can't.

---

### Step 3: Finding Multiple Results

**What you'll learn**: How to get lists of results

**Try this prompt**:
```prolog
?- tasks_by_status(pending, Tasks).
```

**What it does**: Finds all pending tasks
**Expected output**: A list containing all tasks with status 'pending'

**Try this prompt**:
```prolog
?- tasks_by_priority(high, Tasks).
```

**What it does**: Finds all high priority tasks
**Expected output**: A list of high priority tasks

**Explanation**: `findall` collects all matching results into a list.

---

### Step 4: Displaying Results Nicely

**What you'll learn**: How to format output

**Try this prompt**:
```prolog
?- tasks_by_status(pending, Tasks), display_tasks(Tasks).
```

**What it does**: Finds pending tasks AND displays them in a readable format
**Expected output**: 
```
ID: 1 | Complete Prolog assignment | Priority: high | Status: pending | Date: 2025-08-18
ID: 2 | Buy groceries | Priority: medium | Status: pending | Date: 2025-08-18
...
```

**Explanation**: The comma `,` means "AND" - do both things in sequence.

---

### Step 5: Counting Results

**What you'll learn**: How to count items

**Try this prompt**:
```prolog
?- count_tasks_by_status(pending, Count).
```

**What it does**: Counts how many pending tasks exist
**Expected output**: `Count = 5` (or whatever the actual count is)

**Try this prompt**:
```prolog
?- count_tasks_by_status(completed, Count).
```

**What it does**: Counts completed tasks
**Expected output**: `Count = 1`

---

### Step 6: Date-Based Queries

**What you'll learn**: Filtering by date

**Try this prompt**:
```prolog
?- tasks_for_date('2025-08-18', Tasks), display_tasks(Tasks).
```

**What it does**: Shows all tasks for today
**Expected output**: List of today's tasks

**Try this prompt**:
```prolog
?- tasks_for_date('2025-08-19', Tasks), display_tasks(Tasks).
```

**What it does**: Shows all tasks for tomorrow
**Expected output**: List of tomorrow's tasks

---

### Step 7: Complex Queries

**What you'll learn**: Combining conditions

**Try this prompt**:
```prolog
?- urgent_tasks(Tasks), display_tasks(Tasks).
```

**What it does**: Finds tasks that are both high priority AND pending
**Expected output**: Only high priority pending tasks

**Try this prompt**:
```prolog
?- todays_incomplete_tasks(Tasks), display_tasks(Tasks).
```

**What it does**: Finds today's tasks that are not completed
**Expected output**: Today's pending and in_progress tasks

---

### Step 8: Individual Task Display

**What you'll learn**: Formatted single task display

**Try this prompt**:
```prolog
?- display_task(1).
```

**What it does**: Shows task 1 in a nice format
**Expected output**:
```
Task 1: Complete Prolog assignment
  Priority: high
  Status: pending
  Date: 2025-08-18
```

---

## Common Prolog Patterns You'll See

### Variables vs Atoms
- **Variables**: Start with uppercase (`Tasks`, `ID`, `Date`)
- **Atoms**: Start with lowercase or in quotes (`pending`, `'Buy groceries'`)

### The `:-` Symbol
- Means "if" or "is true when"
- `head :- body` means "head is true if body is true"

### The `,` Symbol
- Means "AND"
- `A, B` means "A AND B must both be true"

### The `findall` Pattern
```prolog
findall(Template, Goal, List)
```
- **Template**: What you want to collect
- **Goal**: The condition to match
- **List**: Where results go

### Anonymous Variables `_`
- Use when you don't care about a value
- `task(ID, _, _, pending, _)` means "find tasks with any description, any priority, pending status, any date"

---

## Practice Exercises

Try these queries to test your understanding:

1. **Find all medium priority tasks**:
   ```prolog
   ?- tasks_by_priority(medium, Tasks), display_tasks(Tasks).
   ```

2. **Count high priority tasks**:
   ```prolog
   ?- count_tasks_by_status(high, Count).
   ```
   Wait, this won't work! Can you figure out why? (Hint: check what the predicate actually counts)

3. **Check if task 5 exists**:
   ```prolog
   ?- task_exists(5).
   ```

4. **Get details of task 3**:
   ```prolog
   ?- get_task(3, Desc, Priority, Status, Date).
   ```

5. **Display task 4 nicely**:
   ```prolog
   ?- display_task(4).
   ```

## Next Steps
Once you're comfortable with these basics, you can:
- Add new task facts
- Create new query rules
- Modify existing rules
- Add more complex conditions
