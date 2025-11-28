# Example Epic Issue

This is a complete, copy-able example of an epic issue for a Task Management Application. Use this as a reference when creating your own epic issues.

---

## Epic: Team Collaboration

### Overview

Enable team members to work together on tasks and projects through real-time collaboration features including task assignment, comments, mentions, and activity tracking.

**Category:** Collaboration

---

### User Value

**Who benefits:**

- Team members collaborating on shared projects
- Team leads assigning and monitoring work
- Project managers tracking team activity

**Value delivered:**

Users can collaborate on tasks without switching to external tools. Team members see real-time updates, can discuss tasks in context, and stay informed about relevant changes. This reduces communication friction and keeps all task-related discussions in one place.

**Alignment with Vision:**

Directly supports the vision's goal of "enabling teams to work together seamlessly" and addresses the pain point of "scattered communication across multiple tools."

---

### Scope

**Included in this epic:**

- Task assignment to one or more team members
- Threaded comments on tasks
- @mentions to notify specific users
- Activity feed showing task changes
- Real-time notifications for assigned/mentioned users
- Presence indicators (who's viewing a task)

**Explicitly excluded:**

- Video/voice calls (separate integration epic)
- File sharing (covered in File Management epic)
- External guest access (covered in Sharing & Permissions epic)
- Direct messaging between users (out of MVP scope)

**Related Epics:**

- User Management (provides user/team structure)
- Notifications & Alerts (notification delivery infrastructure)
- Task Management (core task functionality this epic extends)

---

### Success Criteria

**This epic is complete when:**

1. Users can assign tasks to team members
2. Users can add comments with @mentions
3. Mentioned users receive real-time notifications
4. Activity feed shows all task changes with attribution
5. Team members can see who else is viewing a task

**Acceptance at Epic Level:**

- All collaboration features work in real-time (< 2 second latency)
- Notifications delivered within 5 seconds of triggering action
- Activity history preserved for audit purposes
- Features work across web and mobile platforms

**Metrics:**

- Collaboration engagement: Target 60% of tasks have at least one comment
- Notification read rate: Target > 80% within 1 hour
- User satisfaction: Target 4.0/5.0 for collaboration features

---

### Dependencies

**Prerequisite Epics:**

- User Management: User profiles and team structure must exist before assignment
- Task Management: Core task CRUD operations must exist before extending with collaboration

**External Dependencies:**

- Real-time messaging infrastructure (WebSocket server)
- Push notification service (for mobile notifications)

**Blocks:**

- Project Templates (templates may include default assignees)
- Workflow Automation (automation can trigger assignments/notifications)

---

### Technical Considerations

**Key Technical Requirements:**

- WebSocket connections for real-time updates
- Efficient activity log storage (time-series optimized)
- Notification queuing for reliable delivery

**Known Constraints:**

- Must support 100 concurrent users per workspace
- Activity history retention: 2 years minimum

**Risks:**

- Real-time sync complexity: Mitigate with conflict resolution strategy
- Notification volume: Mitigate with smart batching and user preferences

---

### User Stories

**Planned Stories:** 8

- As a team lead, I want to assign a task to a team member, so that work is clearly delegated
- As a team member, I want to add comments to a task, so that I can discuss details in context
- As a user, I want to @mention colleagues in comments, so that they are notified
- As a user, I want to see who is assigned to a task, so that I know who is responsible
- As a team member, I want to see task activity history, so that I understand what changed
- As a user, I want real-time notifications when mentioned, so that I can respond quickly
- As a team member, I want to see who else is viewing a task, so that I can coordinate
- As a user, I want to configure notification preferences, so that I control my notification volume

---

### Estimation & Planning

**Effort Estimate:** L (Large) - Estimated 15-20 story points

**Target Timeline:** Q2 - Part of MVP release

**Team/Owner:** Product Team - Collaboration Squad

---

### Notes

This epic is critical for the MVP as collaboration is a key differentiator from simple to-do apps. Consider phased rollout: basic assignment first, then comments, then real-time features.

---

### Definition of Done

At epic level, done means:

- [ ] All user stories created and completed
- [ ] Success criteria met
- [ ] User testing/validation completed
- [ ] Documentation updated
- [ ] Epic reviewed and accepted by stakeholders

---

**Parent:** [Vision: Task Management Application]
**Children:** [User Story Issues will be linked here]
