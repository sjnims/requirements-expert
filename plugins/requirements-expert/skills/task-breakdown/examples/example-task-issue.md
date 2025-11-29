# Example Task Issue

This is a complete, copy-able example of a task issue for a Task Management Application. Use this as a reference when creating your own task issues.

---

## Task: Create assignee dropdown component

### Description

Implement a React component that displays a dropdown list of all workspace team members when the "Assign" button is clicked on a task. The component should allow users to select a team member to assign to the task.

This task is part of the "Assign task to team member" user story in the Team Collaboration epic.

---

### Acceptance Criteria

- [ ] Component renders an "Assign" button with appropriate styling
- [ ] Clicking "Assign" button opens dropdown with workspace members
- [ ] Dropdown displays member avatar, name, and role
- [ ] Dropdown includes search/filter input for large teams (>10 members)
- [ ] Selecting a member calls `onAssign` callback with selected user ID
- [ ] Dropdown closes after selection
- [ ] Clicking outside dropdown closes it without selection
- [ ] Component handles empty workspace (shows "No team members" message)
- [ ] Component handles loading state while fetching members
- [ ] Component handles error state if member fetch fails
- [ ] Component is accessible (ARIA labels, keyboard navigation)
- [ ] Escape key closes dropdown
- [ ] Unit tests achieve >80% coverage

---

### Technical Notes

**Files to Create/Modify:**

- `/src/components/task/AssigneeDropdown.tsx` (create new)
- `/src/components/task/AssigneeDropdown.test.tsx` (create new)
- `/src/components/task/index.ts` (add export)
- `/src/types/user.ts` (add WorkspaceMember type if needed)

**Patterns to Follow:**

- Use existing `Dropdown` primitive from `/src/components/ui/Dropdown`
- Follow component structure in `/src/components/task/StatusDropdown.tsx`
- Use `useWorkspaceMembers` hook for fetching members
- Apply focus trap for accessibility (see `Modal` component for pattern)

**Dependencies:**

- `useWorkspaceMembers` hook (already exists)
- Design system Dropdown and Avatar components
- React Testing Library for unit tests

**API Data Structure:**

```typescript
interface WorkspaceMember {
  id: string;
  name: string;
  email: string;
  avatarUrl: string | null;
  role: 'owner' | 'admin' | 'member';
}
```

---

### Definition of Done

At task level, done means:

- [ ] All acceptance criteria met
- [ ] Code written and works as expected
- [ ] Unit tests written and passing
- [ ] Component storybook story created
- [ ] Code reviewed via PR process
- [ ] No new TypeScript errors or warnings
- [ ] Changes committed with clear commit message

---

### Out of Scope

- Backend API changes (separate task)
- Saving assignment to database (separate task)
- Notification to assignee (separate task)
- Multi-select for multiple assignees (future enhancement)

---

**Parent:** [Story: Assign task to team member]
**Estimate:** 4-6 hours
**Assignee:** [Developer name]

---

**Labels:** `type:task`, `frontend`, `component`
**Priority:** Must Have
**Type:** Task
**Status:** Not Started
