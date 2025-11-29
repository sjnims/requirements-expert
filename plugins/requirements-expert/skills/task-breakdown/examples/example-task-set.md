# Example Task Set

This document shows a complete set of 8 tasks that implement the "Assign task to team member" user story. It demonstrates:

- Tasks organized by implementation layer (frontend, backend, database, testing)
- Clear acceptance criteria for each task
- Proper sequencing with dependencies noted
- Right-sized tasks (2-8 hours each)
- Full traceability to parent story

This example demonstrates how to break down a user story into implementation tasks.

---

## User Story Summary

**Story:** Assign task to team member

**As a** team lead,
**I want** to assign a task to a team member,
**So that** work is clearly delegated and team members know their responsibilities.

**Story Acceptance Criteria (abbreviated):**

- "Assign" button visible on task cards and detail view
- Dropdown shows workspace members with avatars
- Assigned tasks appear in assignee's "My Tasks" list
- Assignment triggers notification to assignee

---

## Task Overview

| # | Task | Layer | Estimate | Dependencies |
|---|------|-------|----------|--------------|
| 1 | Add assignee_id column to tasks table | Database | 2h | None |
| 2 | Create assignee dropdown component | Frontend | 4-6h | None |
| 3 | Implement GET /api/workspace/members endpoint | Backend | 3h | None |
| 4 | Implement PATCH /api/tasks/:id/assign endpoint | Backend | 3h | Task 1 |
| 5 | Connect dropdown to assignment API | Frontend | 2-3h | Tasks 2, 4 |
| 6 | Display assignee on task cards and detail view | Frontend | 3h | Task 1 |
| 7 | Add assigned tasks to "My Tasks" filter | Backend | 2h | Task 1 |
| 8 | Write integration tests for assignment flow | Testing | 3-4h | Tasks 4, 5, 7 |

**Total Estimate:** 22-27 hours (3-4 days)

---

## Task Details

### Task 1: Add assignee_id column to tasks table

**Layer:** Database

**Description:**
Create database migration to add `assignee_id` foreign key column to the tasks table, enabling task-to-user assignment relationship.

**Acceptance Criteria:**

- [ ] Migration creates `assignee_id` column on tasks table (nullable UUID)
- [ ] Foreign key constraint references users.id
- [ ] Index created on assignee_id for "My Tasks" query performance
- [ ] Migration includes rollback script
- [ ] Migration runs successfully in development environment
- [ ] Rollback tested and verified

**Technical Notes:**

Files to Create:
- `/migrations/20250128120000_add_task_assignee.sql`
- `/migrations/20250128120000_add_task_assignee_down.sql`

SQL:
```sql
ALTER TABLE tasks ADD COLUMN assignee_id UUID REFERENCES users(id);
CREATE INDEX idx_tasks_assignee_id ON tasks(assignee_id);
```

**Dependencies:** None (can start immediately)

**Estimate:** 2 hours

---

### Task 2: Create assignee dropdown component

**Layer:** Frontend

**Description:**
Implement React component that displays dropdown list of workspace members when "Assign" button is clicked, allowing user selection.

**Acceptance Criteria:**

- [ ] Component renders "Assign" button with appropriate styling
- [ ] Clicking button opens dropdown with workspace members
- [ ] Dropdown displays member avatar, name, and role
- [ ] Dropdown includes search filter for teams >10 members
- [ ] Selecting member calls `onAssign` callback with user ID
- [ ] Dropdown closes after selection or clicking outside
- [ ] Component handles loading, empty, and error states
- [ ] Keyboard accessible (arrow keys, Enter, Escape)
- [ ] Unit tests achieve >80% coverage

**Technical Notes:**

Files to Create:
- `/src/components/task/AssigneeDropdown.tsx`
- `/src/components/task/AssigneeDropdown.test.tsx`

Patterns to Follow:
- Use existing Dropdown primitive from design system
- Follow StatusDropdown.tsx component structure

**Dependencies:** None (can start immediately, uses mock data)

**Estimate:** 4-6 hours

---

### Task 3: Implement GET /api/workspace/members endpoint

**Layer:** Backend

**Description:**
Create API endpoint that returns list of all members in the current workspace, used to populate the assignee dropdown.

**Acceptance Criteria:**

- [ ] Endpoint returns array of workspace members
- [ ] Response includes id, name, email, avatarUrl, role for each member
- [ ] Results sorted alphabetically by name
- [ ] Only returns members of current workspace (not all users)
- [ ] Returns 401 if user not authenticated
- [ ] Returns 403 if user not a workspace member
- [ ] Response time <100ms for workspaces with up to 100 members
- [ ] Endpoint documented in API docs

**Technical Notes:**

Files to Create/Modify:
- `/src/api/workspace/routes.ts` (add route)
- `/src/api/workspace/controller.ts` (add getMembers)
- `/src/api/workspace/service.ts` (add member query)

Response Schema:
```json
{
  "members": [
    { "id": "uuid", "name": "string", "email": "string", "avatarUrl": "string|null", "role": "string" }
  ]
}
```

**Dependencies:** None (can start immediately)

**Estimate:** 3 hours

---

### Task 4: Implement PATCH /api/tasks/:id/assign endpoint

**Layer:** Backend

**Description:**
Create API endpoint that assigns a task to a user by updating the assignee_id field.

**Acceptance Criteria:**

- [ ] Endpoint accepts `{ assigneeId: string | null }` in request body
- [ ] Returns updated task object with assignee populated
- [ ] Setting assigneeId to null unassigns the task
- [ ] Returns 400 if assigneeId is not a valid workspace member
- [ ] Returns 404 if task does not exist
- [ ] Returns 403 if user lacks permission to assign task
- [ ] Triggers assignment notification event (for notification service)
- [ ] Logs assignment change in task activity history
- [ ] Endpoint documented in API docs

**Technical Notes:**

Files to Create/Modify:
- `/src/api/tasks/routes.ts` (add PATCH route)
- `/src/api/tasks/controller.ts` (add assignTask)
- `/src/api/tasks/service.ts` (add assignment logic)
- `/src/events/taskEvents.ts` (emit assignment event)

**Dependencies:** Task 1 (needs assignee_id column)

**Estimate:** 3 hours

---

### Task 5: Connect dropdown to assignment API

**Layer:** Frontend

**Description:**
Integrate the assignee dropdown component with the assignment API, handling the full user flow from selection to confirmation.

**Acceptance Criteria:**

- [ ] Dropdown fetches members from GET /api/workspace/members
- [ ] Selection triggers PATCH /api/tasks/:id/assign
- [ ] Shows loading state during API call
- [ ] Shows success toast after successful assignment
- [ ] Shows error toast if assignment fails
- [ ] Optimistically updates UI, rolls back on failure
- [ ] Refreshes task data after assignment

**Technical Notes:**

Files to Modify:
- `/src/components/task/AssigneeDropdown.tsx`
- `/src/hooks/useTaskAssignment.ts` (create new)

Hooks to Use:
- `useMutation` from React Query for assignment
- `useWorkspaceMembers` for fetching members

**Dependencies:** Tasks 2 and 4 (needs component and API)

**Estimate:** 2-3 hours

---

### Task 6: Display assignee on task cards and detail view

**Layer:** Frontend

**Description:**
Show the assigned user's avatar and name on task list cards and the task detail page.

**Acceptance Criteria:**

- [ ] Task cards show assignee avatar (small, right side)
- [ ] Hovering avatar shows assignee name tooltip
- [ ] Task detail page shows assignee in prominent location
- [ ] Clicking assignee opens their profile
- [ ] Unassigned tasks show "Unassigned" label or dash icon
- [ ] Assignee displays update immediately after assignment
- [ ] Works responsively on mobile views

**Technical Notes:**

Files to Modify:
- `/src/components/task/TaskCard.tsx`
- `/src/components/task/TaskDetail.tsx`

Components to Use:
- Existing Avatar component from design system
- Tooltip component for hover state

**Dependencies:** Task 1 (needs assignee data from API)

**Estimate:** 3 hours

---

### Task 7: Add assigned tasks to "My Tasks" filter

**Layer:** Backend

**Description:**
Extend the tasks API to support filtering by assignee, enabling the "My Tasks" view that shows only tasks assigned to the current user.

**Acceptance Criteria:**

- [ ] GET /api/tasks accepts `assigneeId` query parameter
- [ ] `assigneeId=me` returns tasks assigned to current user
- [ ] `assigneeId=<uuid>` returns tasks assigned to specific user
- [ ] Filter combines correctly with other filters (status, date)
- [ ] Query uses index for performance (<50ms response)
- [ ] Frontend "My Tasks" view uses this filter
- [ ] Empty state shown when no tasks assigned

**Technical Notes:**

Files to Modify:
- `/src/api/tasks/routes.ts` (add query param)
- `/src/api/tasks/service.ts` (add filter logic)
- `/src/pages/MyTasks.tsx` (use filter)

Query Example:
```
GET /api/tasks?assigneeId=me&status=in_progress
```

**Dependencies:** Task 1 (needs assignee_id column populated)

**Estimate:** 2 hours

---

### Task 8: Write integration tests for assignment flow

**Layer:** Testing

**Description:**
Create comprehensive integration tests that verify the complete task assignment flow from UI interaction through database persistence.

**Acceptance Criteria:**

- [ ] Test: Assigning task updates database correctly
- [ ] Test: Assigned task appears in assignee's "My Tasks"
- [ ] Test: Unassigning task removes from "My Tasks"
- [ ] Test: Cannot assign to non-workspace member
- [ ] Test: Assignment permission checks work correctly
- [ ] Test: API returns correct error codes for edge cases
- [ ] Test: UI shows loading and success states
- [ ] Test: UI handles and displays API errors
- [ ] All tests pass in CI pipeline

**Technical Notes:**

Files to Create:
- `/tests/integration/task-assignment.test.ts`
- `/tests/e2e/task-assignment.spec.ts`

Test Utilities:
- Use existing test factory for creating users, tasks
- Use MSW for mocking API in frontend tests

**Dependencies:** Tasks 4, 5, 7 (needs full implementation to test)

**Estimate:** 3-4 hours

---

## Dependency Graph

```text
Task 1: Add assignee_id column
    │
    ├──► Task 4: PATCH assign endpoint
    │        │
    │        └──► Task 5: Connect dropdown to API ─────────────┐
    │                                                          │
    ├──► Task 6: Display assignee on cards                     │
    │                                                          ▼
    └──► Task 7: My Tasks filter ──────────────────────► Task 8: Integration tests

Task 2: Create dropdown component ────► Task 5: Connect dropdown to API

Task 3: GET workspace members ─────────► Task 5: Connect dropdown to API
```

---

## Implementation Phases

### Phase 1: Foundation (Day 1)

**Parallel work:**

- Task 1: Database migration (2h)
- Task 2: Dropdown component with mocks (4-6h)
- Task 3: Workspace members endpoint (3h)

**Outcome:** Database ready, UI component ready (with mocks), members API ready.

### Phase 2: Core Integration (Day 2)

**Sequential work:**

- Task 4: Assignment endpoint (3h) - depends on Task 1
- Task 5: Connect frontend to APIs (2-3h) - depends on Tasks 2, 3, 4
- Task 6: Display assignee on cards (3h) - depends on Task 1

**Outcome:** Full assignment flow working end-to-end.

### Phase 3: Polish & Validation (Day 3)

- Task 7: My Tasks filter (2h)
- Task 8: Integration tests (3-4h)

**Outcome:** Feature complete with tests.

---

## Layer Distribution

| Layer | Tasks | Percentage |
|-------|-------|------------|
| Database | Task 1 | 12.5% |
| Backend | Tasks 3, 4, 7 | 37.5% |
| Frontend | Tasks 2, 5, 6 | 37.5% |
| Testing | Task 8 | 12.5% |

This distribution reflects a typical full-stack feature with balanced frontend and backend work.

---

## Summary

This task set demonstrates:

1. **Layer-based organization** - Tasks grouped by frontend, backend, database, testing
2. **Right-sized tasks** - Each task is 2-8 hours (half day to full day)
3. **Clear dependencies** - Sequence allows parallel work where possible
4. **Specific acceptance criteria** - Each task has 6-10 testable criteria
5. **Technical context** - Files to modify and patterns to follow included
6. **Full traceability** - All tasks link back to parent user story

This pattern demonstrates the expected structure for task decomposition.
