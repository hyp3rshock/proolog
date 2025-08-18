# Daily Task Management System - Prolog

A basic Prolog-based task management system for organizing daily tasks.

## File Structure
- `task_manager.pl` - Main Prolog file containing task facts/data
- `queries.pl` - Separate file containing all query predicates

## Task Structure
Each task has the following format:
```prolog
task(ID, Description, Priority, Status, Date)
```

- **ID**: Unique identifier (integer)
- **Description**: Task description (string)
- **Priority**: high, medium, or low
- **Status**: pending, in_progress, or completed
- **Date**: YYYY-MM-DD format

## How to Use

1. Start SWI-Prolog
2. Load the files: 
   ```prolog
   ?- consult('task_manager.pl').
   ?- consult('queries.pl').
   ```
3. Run queries using the examples below

## Basic Queries

### View all tasks for today (2025-08-18)
```prolog
?- tasks_for_date('2025-08-18', Tasks), display_tasks(Tasks).
```

### Find all pending tasks
```prolog
?- tasks_by_status(pending, Tasks), display_tasks(Tasks).
```

### Find high priority tasks
```prolog
?- tasks_by_priority(high, Tasks), display_tasks(Tasks).
```

### Find urgent tasks (high priority + pending)
```prolog
?- urgent_tasks(Tasks), display_tasks(Tasks).
```

### Count pending tasks
```prolog
?- count_tasks_by_status(pending, Count).
```

### Check if task exists
```prolog
?- task_exists(1).
```

### Get specific task details
```prolog
?- get_task(1, Desc, Priority, Status, Date).
```

### Find today's incomplete tasks
```prolog
?- todays_incomplete_tasks(Tasks), display_tasks(Tasks).
```

### Display a specific task nicely
```prolog
?- display_task(1).
```

## Sample Data
The system comes with 7 sample tasks for testing purposes.
