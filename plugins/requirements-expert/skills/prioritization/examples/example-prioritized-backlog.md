# Example Prioritized Backlog

This document shows a complete prioritized backlog for a **Task Management Application**. It demonstrates:

- MoSCoW prioritization applied across all requirement levels
- Proper priority distribution (Must Have ≤60%)
- Rationale for each priority assignment
- Sequencing within priority categories
- Labels and custom fields for GitHub Projects

Use this as a reference when prioritizing your own requirements.

---

## Product Context

**Product:** TaskFlow - Team Task Management

**Scope:** Prioritizing 8 epics for MVP and initial releases

**Constraints:** 2-person dev team, 4-month timeline to MVP, limited budget

**Target:** MVP launch with core functionality, followed by iterative enhancements

---

## Priority Summary

| Priority | Count | Percentage | Target |
|----------|-------|------------|--------|
| Must Have | 4 | 50% | ≤60% |
| Should Have | 2 | 25% | ~20% |
| Could Have | 2 | 25% | ~20% |
| Won't Have | 0 | 0% | Documented |

**Distribution Status:** Balanced - within recommended ranges

---

## Prioritized Backlog

### Must Have (4 epics)

> Critical requirements without which the product cannot launch or function

| Epic | Rationale | Dependencies | GitHub Labels |
|------|-----------|--------------|---------------|
| User Authentication & Accounts | Foundation - all features require authenticated users | None | `type:epic`, `priority:must-have` |
| Workspace & Team Management | Teams need shared context for collaboration | Epic 1 | `type:epic`, `priority:must-have` |
| Task Management | Core value proposition - without tasks, no product | Epic 2 | `type:epic`, `priority:must-have` |
| Team Collaboration | Key differentiator from simple to-do apps | Epics 1, 3 | `type:epic`, `priority:must-have` |

**Why these are Must Have:**

- **User Authentication:** Security foundation. Cannot have users or data without it.
- **Workspace Management:** Multi-tenant isolation. Teams need separate spaces.
- **Task Management:** The product IS task management. Non-negotiable core.
- **Collaboration:** Market differentiator. Without it, we're just another to-do app.

**Sequence within Must Have:**

1. User Authentication & Accounts (no dependencies, start immediately)
2. Workspace & Team Management (depends on users existing)
3. Task Management (depends on workspaces for organization)
4. Team Collaboration (depends on users and tasks)

---

### Should Have (2 epics)

> Important requirements that significantly enhance value but can be deferred if necessary

| Epic | Rationale | Workaround if Deferred | GitHub Labels |
|------|-----------|------------------------|---------------|
| Projects & Organization | Improves task structure for larger teams | Users organize with task lists/tags | `type:epic`, `priority:should-have` |
| Notifications & Alerts | Keeps users engaged without checking app | Users manually check for updates | `type:epic`, `priority:should-have` |

**Why these are Should Have:**

- **Projects & Organization:** Significantly improves UX for teams with many tasks, but basic task management works without hierarchical projects.
- **Notifications:** Critical for engagement and responsiveness, but users CAN manually check the app. Deferring causes friction, not failure.

**Sequence within Should Have:**

1. Projects & Organization (enables better task grouping first)
2. Notifications & Alerts (notify about organized project activity)

---

### Could Have (2 epics)

> Nice-to-have requirements that provide marginal value

| Epic | Rationale | GitHub Labels |
|------|-----------|---------------|
| Reporting & Analytics | Valuable for managers but not essential for task completion | `type:epic`, `priority:could-have` |
| Third-party Integrations | Extends ecosystem but standalone product works fine | `type:epic`, `priority:could-have` |

**Why these are Could Have:**

- **Reporting & Analytics:** Nice for insights but users can track progress manually. Primarily benefits power users and managers.
- **Integrations:** Calendar sync and Slack are convenient but not required. Users can work in TaskFlow without external connections.

**Sequence within Could Have:**

1. Reporting & Analytics (adds value to existing data first)
2. Third-party Integrations (extends to external tools)

---

### Won't Have (This Time)

> Requirements explicitly excluded from current scope

| Feature | Rationale | Future Consideration |
|---------|-----------|---------------------|
| Mobile Native Apps | Web-first strategy; responsive web works on mobile | Phase 2 after web stability |
| SSO/SAML Enterprise Auth | Enterprise feature; email/password + OAuth sufficient for SMB | When targeting enterprise |
| Custom Fields on Tasks | Adds complexity; standard fields cover most needs | After validating demand |
| Recurring Tasks | Nice automation but adds scheduling complexity | Phase 2 enhancement |
| Video/Voice Integration | Out of core scope; external tools (Zoom, Meet) work fine | Consider integration only |
| Gantt Charts | Complex visualization; Kanban and list views sufficient | If project management focus grows |

**Purpose of Won't Have:** Prevents scope creep by making exclusions explicit. These are valid features but explicitly deferred to maintain focus.

---

## Applying to GitHub Projects

### Custom Field: Priority

Set the "Priority" custom field on each issue:

| Issue | Priority Field Value |
|-------|---------------------|
| User Authentication Epic | Must Have |
| Workspace Management Epic | Must Have |
| Task Management Epic | Must Have |
| Team Collaboration Epic | Must Have |
| Projects & Organization Epic | Should Have |
| Notifications Epic | Should Have |
| Reporting Epic | Could Have |
| Integrations Epic | Could Have |

### Labels

Apply labels to each issue for cross-project filtering:

```text
Epic 1: type:epic, priority:must-have
Epic 2: type:epic, priority:must-have
Epic 3: type:epic, priority:must-have
Epic 4: type:epic, priority:must-have
Epic 5: type:epic, priority:should-have
Epic 6: type:epic, priority:should-have
Epic 7: type:epic, priority:could-have
Epic 8: type:epic, priority:could-have
```

### Project View Configuration

Create views to filter by priority:

- **MVP View:** Filter: Priority = "Must Have"
- **Phase 2 View:** Filter: Priority = "Should Have"
- **Backlog View:** Filter: Priority = "Could Have"
- **All Items View:** No filter, sorted by Priority

---

## Delivery Phases

### MVP (Months 1-4)

**Focus:** Must Have epics only

- User Authentication & Accounts
- Workspace & Team Management
- Task Management
- Team Collaboration

**Outcome:** Teams can sign up, create workspaces, manage tasks, and collaborate.

### Phase 2 (Months 5-6)

**Focus:** Should Have epics

- Projects & Organization
- Notifications & Alerts

**Outcome:** Better organization and proactive engagement.

### Phase 3 (Months 7+)

**Focus:** Could Have epics

- Reporting & Analytics
- Third-party Integrations

**Outcome:** Insights and ecosystem connectivity.

---

## Validation Checklist

- [x] Must Have ≤60% of items (50%)
- [x] MVP delivers core value (task management + collaboration)
- [x] Would users pay for MVP? (Yes - solves real problem)
- [x] Dependencies respected in sequencing
- [x] Won't Haves explicitly documented
- [x] All items have GitHub labels assigned
- [x] All items have Priority custom field set

---

## Summary

This prioritized backlog demonstrates:

1. **Strict Must Have discipline** - Only 50% are "Must Have" (below 60% threshold)
2. **Clear rationale** - Each priority assignment explained
3. **Explicit exclusions** - Won't Have items documented
4. **Practical sequencing** - Dependencies drive order within categories
5. **GitHub integration** - Labels and custom fields for filtering
6. **Phased delivery** - Clear path from MVP to full product

Use this pattern when prioritizing your own product backlog.
