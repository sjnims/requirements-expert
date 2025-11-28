# Example Story Issue

This is a complete, copy-able example of a user story issue for a Task Management Application. Use this as a reference when creating your own story issues.

---

## User Story: Assign task to team member

### Story

**As a** team lead,
**I want** to assign a task to a team member,
**So that** work is clearly delegated and team members know their responsibilities.

---

### Context

Task assignment is a core collaboration feature that enables team leads to delegate work effectively. Currently, tasks exist but have no owner, making it unclear who is responsible for completing them. This story enables the fundamental "who does what" aspect of team task management.

This story is part of the Team Collaboration epic and depends on having users and tasks already in the system.

---

### Acceptance Criteria

**Given-When-Then Format:**

- **Given** I am viewing a task in my workspace
  **When** I click the "Assign" button
  **Then** I see a dropdown list of all team members in the workspace

- **Given** I have opened the assignee dropdown
  **When** I select a team member from the list
  **Then** the task shows that team member as the assignee

- **Given** I have assigned a task to a team member
  **When** that team member views their "My Tasks" list
  **Then** this task appears in their assigned tasks

- **Given** I am the task assignee
  **When** I view the task detail page
  **Then** I see myself listed as the assignee with a visual indicator

- **Given** a task is assigned to me
  **When** someone reassigns the task to another team member
  **Then** the task is removed from my "My Tasks" list

**Checklist Format:**

- [ ] "Assign" button visible on task cards and task detail view
- [ ] Assignee dropdown shows all workspace members with their avatars
- [ ] Dropdown includes search/filter for workspaces with many members
- [ ] Only one assignee allowed per task (single assignment)
- [ ] Assigned tasks appear in assignee's "My Tasks" view
- [ ] Assigning a task sends notification to the assignee (if notifications enabled)
- [ ] Task creator can reassign tasks at any time
- [ ] Assignee can unassign themselves from a task

---

### Notes & Assumptions

**Assumptions:**

- Users already have accounts and are members of the workspace
- Tasks already exist and can be viewed
- Notification system exists (separate story covers notification preferences)
- Single assignee per task for MVP (multi-assignee is a future enhancement)

**Constraints:**

- Must work on both web and mobile views
- Assignment changes should reflect immediately (real-time or near-real-time)
- Must handle cases where assigned user leaves the workspace

**Out of Scope:**

- Multiple assignees per task (covered in separate story)
- Due date reminders for assignees (covered in Notifications epic)
- Workload balancing or capacity planning
- Auto-assignment rules or suggestions

---

### Technical Considerations

- Add `assignee_id` field to tasks table (foreign key to users)
- Consider indexing for "My Tasks" queries (filter by assignee_id)
- WebSocket event for real-time assignment updates
- Handle edge case: assigned user deleted/deactivated

---

### Definition of Done

At story level, done means:

- [ ] All acceptance criteria met
- [ ] Code reviewed and merged
- [ ] Unit tests cover assignment logic
- [ ] Integration tests verify assignee filtering
- [ ] API endpoint documented
- [ ] Tested in staging environment
- [ ] Acceptance confirmed by product owner

---

### INVEST Validation

- [x] **Independent**: Can be completed after basic tasks exist; doesn't require comments or other collaboration features
- [x] **Negotiable**: UI details and exact workflow can be discussed with design
- [x] **Valuable**: Enables core team coordination functionality
- [x] **Estimable**: Clear scope, team can estimate confidently
- [x] **Small**: Estimated 3-4 days of work (within 1-5 day range)
- [x] **Testable**: Clear acceptance criteria that can be verified

---

**Parent:** [Epic: Team Collaboration]
**Priority:** Must Have
**Type:** Story
**Status:** Not Started

---

**Labels:** `type:story`, `priority:must-have`
