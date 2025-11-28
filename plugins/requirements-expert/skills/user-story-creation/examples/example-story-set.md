# Example Story Set

This document shows a complete set of 8 user stories for the **Team Collaboration** epic in a Task Management Application. It demonstrates:

- Stories that follow the standard template
- INVEST criteria applied to each story
- Proper story independence (can be built in any order after dependencies)
- MoSCoW prioritization
- Clear acceptance criteria patterns

Use this as a reference when breaking down an epic into user stories.

---

## Epic Summary

**Epic:** Team Collaboration

**Epic Description:** Enable team members to work together on tasks and projects through real-time collaboration features including task assignment, comments, mentions, and activity tracking.

**Epic Value:** Users can collaborate on tasks without switching to external tools. Team members see real-time updates, can discuss tasks in context, and stay informed about relevant changes.

---

## Story Overview

| # | Story | Priority | Size | Dependencies |
|---|-------|----------|------|--------------|
| 1 | Assign task to team member | Must Have | M | None |
| 2 | View who is assigned to a task | Must Have | S | Story 1 |
| 3 | Add comments to a task | Must Have | M | None |
| 4 | @mention colleagues in comments | Should Have | M | Story 3 |
| 5 | View task activity history | Should Have | M | Stories 1, 3 |
| 6 | Receive notification when mentioned | Should Have | S | Story 4 |
| 7 | See who is viewing a task | Could Have | M | None |
| 8 | Configure notification preferences | Could Have | S | Story 6 |

**Size Key:** S = Small (1-2 days), M = Medium (3-5 days)

---

## Story Details

### Story 1: Assign task to team member

**Priority:** Must Have

**As a** team lead,
**I want** to assign a task to a team member,
**So that** work is clearly delegated and team members know their responsibilities.

**Acceptance Criteria:**

- [ ] "Assign" button visible on task cards and detail view
- [ ] Dropdown shows all workspace members with avatars
- [ ] Selected assignee displayed on task
- [ ] Assigned tasks appear in assignee's "My Tasks" list
- [ ] Assigning sends notification to assignee (if enabled)

**INVEST Check:** Independent (no story dependencies), clear value, estimable at 3-4 days, testable criteria.

---

### Story 2: View who is assigned to a task

**Priority:** Must Have

**As a** team member,
**I want** to see who is assigned to a task,
**So that** I know who is responsible and who to contact about it.

**Acceptance Criteria:**

- [ ] Assignee avatar and name visible on task list cards
- [ ] Assignee prominently displayed on task detail page
- [ ] Clicking assignee opens their profile/contact info
- [ ] "Unassigned" label shown for tasks with no assignee
- [ ] Assignee visible in search results and filtered views

**Dependencies:** Story 1 (assignment must exist to be viewed)

**INVEST Check:** Small scope, clear value for team visibility, easily testable.

---

### Story 3: Add comments to a task

**Priority:** Must Have

**As a** team member,
**I want** to add comments to a task,
**So that** I can discuss details and ask questions in context.

**Acceptance Criteria:**

- [ ] Comment input field visible on task detail page
- [ ] Comments display with author, timestamp, and content
- [ ] Comments appear in chronological order (oldest first)
- [ ] Comments support basic formatting (bold, italic, links)
- [ ] Author can edit their own comments within 15 minutes
- [ ] Author can delete their own comments

**INVEST Check:** Independent of assignment, delivers core collaboration value, 3-4 days work.

---

### Story 4: @mention colleagues in comments

**Priority:** Should Have

**As a** team member,
**I want** to @mention colleagues in comments,
**So that** they are notified and can join the conversation.

**Acceptance Criteria:**

- [ ] Typing "@" triggers autocomplete dropdown of team members
- [ ] Autocomplete filters by name as user types
- [ ] Selected @mention displays as linked name in comment
- [ ] @mentioned users receive notification (see Story 6)
- [ ] Clicking @mention shows user profile

**Dependencies:** Story 3 (comments must exist to add mentions)

**INVEST Check:** Builds on comments, clear value for team notification, testable autocomplete behavior.

---

### Story 5: View task activity history

**Priority:** Should Have

**As a** team member,
**I want** to see the history of changes on a task,
**So that** I understand what happened and who made changes.

**Acceptance Criteria:**

- [ ] Activity feed visible on task detail page
- [ ] Shows assignment changes with old/new assignee
- [ ] Shows status changes with timestamp and actor
- [ ] Shows when comments were added (not full comment text)
- [ ] Shows task creation event
- [ ] Activity entries ordered newest-first
- [ ] Each entry shows actor, action, and timestamp

**Dependencies:** Stories 1 and 3 (needs assignment and comment events to track)

**INVEST Check:** Independent implementation, valuable for transparency, clearly testable.

---

### Story 6: Receive notification when mentioned

**Priority:** Should Have

**As a** team member,
**I want** to receive a notification when I'm @mentioned,
**So that** I can respond quickly to relevant discussions.

**Acceptance Criteria:**

- [ ] In-app notification appears when @mentioned in comment
- [ ] Notification shows task name and who mentioned me
- [ ] Clicking notification navigates to the task/comment
- [ ] Email notification sent if user has email notifications enabled
- [ ] Notifications respect user's preference settings (see Story 8)

**Dependencies:** Story 4 (@mentions must exist to trigger notifications)

**INVEST Check:** Small scope, clear value, testable notification delivery.

---

### Story 7: See who is viewing a task

**Priority:** Could Have

**As a** team member,
**I want** to see who else is currently viewing a task,
**So that** I can coordinate and avoid conflicting edits.

**Acceptance Criteria:**

- [ ] Presence indicator shows avatars of users viewing task
- [ ] Updates in real-time as users enter/leave task view
- [ ] Shows "1 other" or "2 others" when many viewers
- [ ] Hovering shows full list of viewing users
- [ ] Only shows users who viewed in last 2 minutes (session timeout)

**INVEST Check:** Independent feature, nice-to-have value, requires WebSocket infrastructure.

---

### Story 8: Configure notification preferences

**Priority:** Could Have

**As a** team member,
**I want** to configure my notification preferences,
**So that** I control how and when I'm notified.

**Acceptance Criteria:**

- [ ] Notification settings page accessible from user profile
- [ ] Toggle for in-app notifications (on/off)
- [ ] Toggle for email notifications (on/off)
- [ ] Option to mute notifications for specific tasks
- [ ] Settings persist across sessions

**Dependencies:** Story 6 (notifications must exist to configure)

**INVEST Check:** Small scope, gives users control, clearly testable settings UI.

---

## MoSCoW Distribution

| Priority | Stories | Count | Percentage |
|----------|---------|-------|------------|
| Must Have | Stories 1, 2, 3 | 3 | 37.5% |
| Should Have | Stories 4, 5, 6 | 3 | 37.5% |
| Could Have | Stories 7, 8 | 2 | 25% |
| Won't Have | - | 0 | 0% |

**Note:** Distribution stays well under the 60% Must Have threshold, allowing flexibility for iteration planning.

---

## Dependency Graph

```text
Story 1: Assign task ──────► Story 2: View assignee
                    \
                     ──────► Story 5: Activity history ◄────┐
                                                            │
Story 3: Add comments ────► Story 4: @mentions             │
                     \                  │                   │
                      ─────────────────────────────────────┘
                                        │
                                        ▼
                           Story 6: Mention notifications
                                        │
                                        ▼
                           Story 8: Notification preferences

Story 7: Presence indicators (independent)
```

---

## Implementation Phases

### Phase 1: Core Collaboration (MVP)

- Story 1: Assign task to team member
- Story 2: View who is assigned
- Story 3: Add comments to a task

**Outcome:** Teams can assign work and discuss tasks in context.

### Phase 2: Enhanced Communication

- Story 4: @mention colleagues
- Story 5: View activity history
- Story 6: Mention notifications

**Outcome:** Proactive notifications and full transparency on task changes.

### Phase 3: Polish & Preferences

- Story 7: Presence indicators
- Story 8: Notification preferences

**Outcome:** Real-time awareness and user control over notifications.

---

## Story Splitting Techniques Used

This story set demonstrates several splitting patterns:

| Pattern | Applied To | Example |
|---------|------------|---------|
| **Operations** | Assignment | Write (Story 1) vs. Read (Story 2) |
| **Workflow Steps** | Notifications | Create mention (Story 4) → Send notification (Story 6) → Configure preferences (Story 8) |
| **Business Rules** | Notifications | In-app vs. email handled together, preferences separate |
| **Happy Path vs. Variations** | Comments | Basic comments (Story 3) → Enhanced with mentions (Story 4) |

---

## Summary

This story set demonstrates:

1. **Clear user perspective** in all story statements
2. **INVEST criteria** validated for each story
3. **Balanced priorities** with Must Have under 60%
4. **Explicit dependencies** allowing parallel work
5. **Consistent size** keeping all stories at 1-5 days
6. **Testable acceptance criteria** for every story

Use this pattern when decomposing your own epics into user stories.
