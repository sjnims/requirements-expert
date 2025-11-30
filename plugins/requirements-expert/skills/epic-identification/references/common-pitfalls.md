# Common Pitfalls to Avoid

This reference provides detailed guidance on common epic identification pitfalls and how to avoid them. Load this when reviewing epics for quality or when helping users troubleshoot epic definition issues.

For the core epic identification process, see the main skill documentation.

---

## ❌ Wrong Granularity

Epic granularity problems typically fall into two categories:

### Too Many Epics (more than 15-20)

Signs of over-decomposition:

- ❌ "Add login button" → This is a task, not an epic
- ❌ "Create password reset form" → This is a user story, not an epic
- ❌ Individual features treated as separate epics

**How to fix:**

- ✅ Combine related items into cohesive epics
- ✅ Group by capability area (e.g., "User Authentication" instead of separate login/logout/reset epics)
- ✅ Large products may need epic grouping into themes/initiatives

### Too Few Epics (fewer than 5)

Signs of under-decomposition:

- ❌ Insufficient breakdown of vision
- ❌ Monolithic "Build the platform" epic
- ❌ Missing user types or journeys

**How to fix:**

- ✅ Consider all user types, journeys, and infrastructure needs
- ✅ Decompose vision into more specific capabilities
- ✅ Apply discovery techniques (user journey mapping, capability decomposition)

---

## ❌ Implementation-Focused Names

Epic names should describe capabilities, not technical implementations.

**DO NOT** use technical/implementation language:

| ❌ Wrong | ✅ Better |
|----------|-----------|
| "API Development" | "Third-party Integration Support" |
| "Database Schema" | "Data Storage & Management" |
| "Build React components" | "Analytics Dashboard" |
| "Set up CI/CD" | "Deployment Automation" |
| "Create microservices" | "Scalable Architecture" |

**Why this matters:**

- Technical names don't communicate value to stakeholders
- Implementation may change; capability remains stable
- Focus on "what" not "how"

---

## ❌ Vague or Outcome-Focused Names

Epic names should be descriptive capabilities, not phases or outcomes.

**DO NOT** use non-descriptive names:

| ❌ Wrong | ✅ Better |
|----------|-----------|
| "Phase 1" | Specific capability name |
| "Make users happy" | "User Onboarding Experience" |
| "Build the backend" | Split into specific capabilities |
| "Improvements" | "Performance Optimization" or specific feature |
| "Tech debt" | Specific technical capability being addressed |

**Why this matters:**

- Vague names provide no scope boundaries
- Outcome names don't specify what will be built
- Makes prioritization and estimation impossible

---

## ❌ Missing Infrastructure Epics

Don't forget necessary enablers that support user-facing features.

**Commonly missed infrastructure epics:**

- ❌ Forgetting authentication/authorization
- ❌ Missing data migration requirements
- ❌ Overlooking compliance/security needs
- ❌ Ignoring performance optimization (if critical to UX)
- ❌ Missing monitoring/observability
- ❌ Forgetting admin/operational tooling

**How to find missing infrastructure:**

1. Review each user-facing epic and ask: "What must exist for this to work?"
2. Consider: security, data, integrations, operations, compliance
3. Check if any epics assume infrastructure that doesn't exist yet

---

## Quick Reference: Granularity Checklist

Use this checklist to validate epic granularity:

| Check | Pass |
|-------|------|
| Epic count is 5-15 for typical product? | ☐ |
| Each epic takes multiple sprints to complete? | ☐ |
| Each epic contains 3-12 user stories? | ☐ |
| No epic is a single task or story? | ☐ |
| No epic is "the whole product"? | ☐ |
| Epic names describe capabilities, not implementations? | ☐ |
| Epic names are specific and bounded? | ☐ |
| Infrastructure needs are captured? | ☐ |
