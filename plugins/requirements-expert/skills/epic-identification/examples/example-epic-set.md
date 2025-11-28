# Example Epic Set

This document shows a complete set of 8 epics for a **Task Management Application**. It demonstrates:

- Logical epic grouping and naming
- Dependency relationships between epics
- MoSCoW prioritization applied
- Mix of user-facing and infrastructure epics

Use this as a reference when identifying epics for your own product.

---

## Product Vision Summary

**Product:** TaskFlow - Team Task Management

**Problem:** Small to medium teams struggle to track work effectively using spreadsheets or disconnected tools, leading to missed deadlines, unclear ownership, and poor visibility.

**Solution:** A collaborative task management platform that provides clear task ownership, progress tracking, and team coordination in one unified workspace.

**Target Users:** Project managers, team leads, and team members in SMB organizations (10-100 employees).

---

## Epic Overview

| # | Epic Name | Category | Priority | Dependencies |
|---|-----------|----------|----------|--------------|
| 1 | User Authentication & Accounts | Infrastructure | Must Have | None |
| 2 | Workspace & Team Management | Infrastructure | Must Have | Epic 1 |
| 3 | Task Management | User-Facing | Must Have | Epic 2 |
| 4 | Team Collaboration | User-Facing | Must Have | Epic 1, 3 |
| 5 | Projects & Organization | User-Facing | Should Have | Epic 3 |
| 6 | Notifications & Alerts | Infrastructure | Should Have | Epic 1, 4 |
| 7 | Reporting & Analytics | User-Facing | Could Have | Epic 3, 5 |
| 8 | Third-party Integrations | Integration | Could Have | Epic 3 |

---

## Epic Details

### Epic 1: User Authentication & Accounts

**Priority:** Must Have

**Description:** Secure user registration, authentication, and account management. Foundation for all user-related functionality.

**Scope:**

- Email/password registration and login
- Password reset flow
- User profile management
- Session management and security
- OAuth integration (Google, Microsoft)

**Excluded:** SSO/SAML (enterprise feature for future), 2FA (phase 2)

**Why Must Have:** All functionality requires authenticated users. Foundational infrastructure.

**Estimated Stories:** 6-8

---

### Epic 2: Workspace & Team Management

**Priority:** Must Have

**Description:** Multi-tenant workspaces where teams organize and manage members. Enables team-based access and organization.

**Scope:**

- Workspace creation and settings
- Team member invitations
- Role-based access (Admin, Member)
- Workspace switching for users in multiple workspaces

**Excluded:** Advanced permissions, custom roles (phase 2)

**Dependencies:** Epic 1 (users must exist to join workspaces)

**Why Must Have:** Teams need a shared context for their tasks. Core organizational structure.

**Estimated Stories:** 5-7

---

### Epic 3: Task Management

**Priority:** Must Have

**Description:** Core task CRUD operations - creating, editing, organizing, and completing tasks.

**Scope:**

- Create, edit, delete tasks
- Task properties: title, description, due date, priority
- Task status workflow (To Do, In Progress, Done)
- Task lists and basic organization
- Task search and filtering

**Excluded:** Recurring tasks (phase 2), custom fields (phase 2)

**Dependencies:** Epic 2 (tasks belong to workspaces)

**Why Must Have:** The core value proposition. Without tasks, there's no product.

**Estimated Stories:** 10-12

---

### Epic 4: Team Collaboration

**Priority:** Must Have

**Description:** Enable team members to work together on tasks through assignment, comments, and activity tracking.

**Scope:**

- Task assignment to team members
- Threaded comments on tasks
- @mentions in comments
- Activity feed and history
- Presence indicators

**Excluded:** Video calls, direct messaging, file attachments (separate epics)

**Dependencies:** Epic 1 (users for assignment), Epic 3 (tasks to collaborate on)

**Why Must Have:** Collaboration differentiates from simple to-do apps. Core to team value.

**Estimated Stories:** 7-9

---

### Epic 5: Projects & Organization

**Priority:** Should Have

**Description:** Organize tasks into projects with views, boards, and structured hierarchy.

**Scope:**

- Project creation and management
- Kanban board view
- List view with sorting/grouping
- Project templates
- Sections/categories within projects

**Excluded:** Gantt charts, timeline view (phase 2)

**Dependencies:** Epic 3 (tasks to organize)

**Why Should Have:** Improves organization but teams can use MVP without projects. Adds significant value for larger teams.

**Estimated Stories:** 8-10

---

### Epic 6: Notifications & Alerts

**Priority:** Should Have

**Description:** Keep users informed about relevant activity through in-app and external notifications.

**Scope:**

- In-app notification center
- Email notifications
- Push notifications (mobile/desktop)
- Notification preferences and controls
- Smart notification batching

**Excluded:** SMS notifications, Slack/Teams integration (separate epic)

**Dependencies:** Epic 1 (user preferences), Epic 4 (collaboration triggers notifications)

**Why Should Have:** Important for engagement but users can check manually. Significantly improves UX.

**Estimated Stories:** 6-8

---

### Epic 7: Reporting & Analytics

**Priority:** Could Have

**Description:** Provide insights into task completion, team productivity, and project progress.

**Scope:**

- Task completion metrics dashboard
- Team workload visualization
- Project progress reports
- Export reports (PDF, CSV)
- Date range filtering

**Excluded:** Custom report builder, AI insights

**Dependencies:** Epic 3 (task data), Epic 5 (project data)

**Why Could Have:** Nice for managers but not essential for core task management. Valuable but deferrable.

**Estimated Stories:** 5-7

---

### Epic 8: Third-party Integrations

**Priority:** Could Have

**Description:** Connect TaskFlow with other tools teams use through integrations and API.

**Scope:**

- Google Calendar sync (due dates)
- Slack notifications
- Public REST API
- Webhook events

**Excluded:** Zapier/automation platforms, full sync with other PM tools

**Dependencies:** Epic 3 (tasks to sync/integrate)

**Why Could Have:** Extends value but not required for standalone use. Valuable for adoption but deferrable.

**Estimated Stories:** 6-8

---

## Dependency Graph

```text
Epic 1: User Authentication & Accounts
    │
    ├──► Epic 2: Workspace & Team Management
    │        │
    │        └──► Epic 3: Task Management
    │                 │
    │                 ├──► Epic 5: Projects & Organization
    │                 │        │
    │                 │        └──► Epic 7: Reporting & Analytics
    │                 │
    │                 └──► Epic 8: Third-party Integrations
    │
    └──► Epic 4: Team Collaboration (also depends on Epic 3)
             │
             └──► Epic 6: Notifications & Alerts (also depends on Epic 1)
```

---

## MoSCoW Distribution

| Priority | Epics | Percentage |
|----------|-------|------------|
| Must Have | 4 (Epics 1, 2, 3, 4) | 50% |
| Should Have | 2 (Epics 5, 6) | 25% |
| Could Have | 2 (Epics 7, 8) | 25% |
| Won't Have | 0 | 0% |

**Note:** For MVP, focus on Must Have epics first. This provides a functional, differentiated product while deferring nice-to-have features.

---

## Delivery Phases

### Phase 1 (MVP)

- Epic 1: User Authentication & Accounts
- Epic 2: Workspace & Team Management
- Epic 3: Task Management
- Epic 4: Team Collaboration

**Outcome:** Teams can sign up, create workspaces, manage tasks, and collaborate.

### Phase 2

- Epic 5: Projects & Organization
- Epic 6: Notifications & Alerts

**Outcome:** Better organization and proactive engagement for larger teams.

### Phase 3

- Epic 7: Reporting & Analytics
- Epic 8: Third-party Integrations

**Outcome:** Insights and ecosystem connectivity for power users.

---

## Summary

This epic set demonstrates:

1. **Foundational infrastructure first** (Auth, Workspaces) before user-facing features
2. **Core value proposition** (Task Management, Collaboration) as Must Have
3. **Enhancement layers** (Projects, Notifications) as Should Have
4. **Nice-to-have extensions** (Reporting, Integrations) as Could Have
5. **Clear dependencies** enabling parallel work where possible
6. **Balanced distribution** staying within MoSCoW guidelines (< 60% Must Have)

Use this pattern when identifying epics for your own product vision.
