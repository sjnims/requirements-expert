---
name: prioritization
description: This skill should be used when the user asks to "prioritize requirements", "prioritize epics", "prioritize stories", "prioritize tasks", "prioritize backlog", "use MoSCoW", "apply MoSCoW priorities", "assign priorities", "set priority labels", "rank features", "what should I build first", "what's most important", "order by importance", "must have vs should have", or when they need to determine the priority order of epics, user stories, or tasks using the MoSCoW framework.
version: 0.4.0
---

# Prioritization

## Quick Actions & Routing

| User Intent | Action | Resource |
|-------------|--------|----------|
| Gathering context | Define scope and constraints | Step 1: Define Context |
| Classifying priorities | Apply MoSCoW decision tree | MoSCoW Framework section |
| Validating balance | Check distribution rules | Step 4: Validate and Balance |
| Updating GitHub | Apply priority fields and labels | Step 6: Update GitHub Projects |
| Step-by-step workflow | Load complete worksheet | `references/moscow-worksheet.md` |
| Viewing examples | Load prioritization session | `examples/example-prioritization-session.md` |

## Command Integration

The `/re:prioritize` command applies MoSCoW priorities to requirements in GitHub Projects. This skill provides the MoSCoW framework, decision criteria, and prioritization worksheets that the command uses. Load this skill for deeper understanding of prioritization concepts or when you need guidance beyond what the command provides.

## Overview

Prioritization is the process of determining the relative importance and sequence of requirements at any level—epics, user stories, or tasks. Using the MoSCoW framework (Must Have, Should Have, Could Have, Won't Have), teams can make informed decisions about what to build first, ensuring maximum value delivery within constraints.

## Purpose

Effective prioritization:
- Focuses effort on highest-value work
- Enables incremental delivery of working software
- Manages scope within time and budget constraints
- Aligns team and stakeholders on what matters most
- Provides clear rationale for sequencing decisions

## Prerequisite

Items must exist before prioritizing. If none exist, use **epic-identification**, **user-story-creation**, or **task-breakdown** as appropriate.

## MoSCoW Framework

Categorize requirements into four priority levels. For detailed definitions, characteristics, and examples, see `references/moscow-framework.md`.

| Category | Definition | Target % |
|----------|------------|----------|
| **Must Have** | Critical for success; product fails without these | <60% |
| **Should Have** | Important but deferrable; significantly enhances value | ~20% |
| **Could Have** | Nice-to-have; marginal value, include if time permits | ~20% |
| **Won't Have** | Explicitly excluded from current scope | Variable |

### Classification Decision Tree

Apply these questions in order for each item:

1. **Is this legally, contractually, or safety-required?**
   - Yes → **Must Have**

2. **Would the product be fundamentally broken or fail to deliver core value without this?**
   - Yes → **Must Have**

3. **Does this significantly improve value but have a viable workaround?**
   - Yes → **Should Have**

4. **Is this a nice-to-have enhancement with marginal impact?**
   - Yes → **Could Have**

5. **Is this explicitly out of scope for this release?**
   - Yes → **Won't Have**

## Prioritization Process

### Step 1: Define Context

Establish the scope and constraints using AskUserQuestion to gather:

**Scope:**
- What are we prioritizing? (Epics? Stories? Tasks?)
- What are the constraints? (Time, budget, resources)
- What's the target? (MVP? V1.0? Next sprint?)

**Boundaries:**
- Total number of items to prioritize
- Decision criteria weights (value, risk, effort, dependencies)
- Time frame for this prioritization

For detailed context collection workflow, see `references/moscow-worksheet.md`.

### Step 2: Retrieve and Assess Items

First, retrieve items from GitHub Projects:

```bash
gh project item-list [project-number] --owner [owner] --format json
```

For each item, evaluate against these criteria:

| Criterion | Assessment Factors |
|-----------|-------------------|
| **User Value** | UX improvement, user count affected, frequency of use |
| **Business Value** | Revenue impact, strategic importance, competitive advantage |
| **Risk** | Technical complexity, unknowns, third-party dependencies |
| **Effort** | Time required, resource needs, ROI |
| **Dependencies** | Prerequisites, blockers, external dependencies |

Rate each factor as High/Medium/Low. See `references/moscow-worksheet.md` for detailed assessment workflow.

### Step 3: Apply MoSCoW Categories

Use AskUserQuestion to capture priority decisions for each item. Present MoSCoW options with clear descriptions:

**Classification Order:**

1. **Must Haves** - Identify absolute essentials first (target: <60%)
2. **Should Haves** - High-value but deferrable items
3. **Could Haves** - Nice-to-have if time permits
4. **Won't Haves** - Explicitly out of scope (document rationale)

Use the classification criteria from each MoSCoW category above to guide decisions.

### Step 4: Validate and Balance

Review the prioritization against these validation rules:

**Distribution Check:**
- Must Haves <60%? If exceeded, use AskUserQuestion to challenge: "Can we really not ship without [item]?"
- At least one Won't Have documented? If none, identify explicit exclusions
- Dependencies respected? High-priority items must not depend on low-priority items

**MVP Viability Check:**
- Do Must Haves collectively deliver minimum viable product?
- Can we ship with just Must Haves if needed?
- Are all critical user journeys covered?

If validation fails, use AskUserQuestion to present adjustment options. See `references/moscow-worksheet.md` for detailed validation workflow.

### Step 5: Sequence Within Categories

Within each MoSCoW category, establish order:

**Sequencing Factors:**
- Dependencies (blockers first)
- Risk (tackle unknowns early for learning)
- Value (highest value first within category)
- Effort (quick wins can build momentum)

**Common Strategies:**
- **Risk-driven:** Tackle high-risk, high-uncertainty items early
- **Value-driven:** Deliver highest-value items first
- **Dependency-driven:** Respect technical dependencies
- **Quick wins:** Mix in some easy, visible wins for morale

### Step 6: Update GitHub Projects

Persist prioritization decisions using GitHub CLI:

**Retrieve Field ID First:**

Before updating fields, retrieve the Priority field ID:

```bash
gh project field-list [project-number] --owner [owner] --format json | jq '.fields[] | select(.name=="Priority") | .id'
```

**Update Priority Custom Field:**

Use the retrieved field ID to update items:

```bash
gh project item-edit --id [item-id] --field-id [priority-field-id] --value "[priority]"
```

**Apply Priority Labels:**

```bash
gh issue edit [issue-number] --repo [owner/repo] --add-label "priority:must-have"
```

**Add Rationale Comments** (for Must Haves and Won't Haves):

```bash
gh issue comment [issue-number] --repo [owner/repo] --body "Priority: [level]\n\nRationale: [explanation]"
```

See `references/moscow-worksheet.md` for the complete GitHub update workflow.

## Prioritization at Different Levels

Apply MoSCoW at each level of the requirements hierarchy:

| Level | Focus | Key Consideration |
|-------|-------|-------------------|
| **Epics** | Major capabilities | Foundation vs. enhancement, strategic alignment |
| **Stories** | Features within epic | Happy path first, core before polish |
| **Tasks** | Implementation steps | Technical dependencies, vertical slices |

For detailed examples and level-specific patterns, see `references/prioritization-examples.md`.

## Best Practices

Key practices for effective prioritization:

- **Challenge "Must Haves"** - Use strict criteria; aim for <60% in this category
- **Be Explicit About "Won't Haves"** - Document exclusions to prevent scope creep
- **Consider Technical Dependencies** - Foundation before features; respect prerequisites
- **Revisit and Refine** - Re-prioritize regularly as new information emerges
- **Involve Stakeholders** - Build consensus across product, development, and users
- **Use Data When Available** - Inform decisions with usage analytics, research, and revenue data

For detailed guidance on each practice, see `references/best-practices.md`.

## Common Pitfalls to Avoid

Watch for these prioritization anti-patterns:

| Pitfall | Problem | Solution |
|---------|---------|----------|
| **Everything is "Must Have"** | If everything is critical, nothing is | Apply strict criteria; target <60% Must Have |
| **Ignoring Dependencies** | High-priority items blocked by low-priority | Map dependencies; prioritize prerequisites |
| **Forgetting "Won't Have"** | Scope creep when exclusions are implicit | Explicitly document what's out of scope |
| **Loudest Voice Wins** | Decisions based on volume, not value | Use objective criteria and data |
| **Never Re-Prioritizing** | Priorities become stale as context changes | Review and adjust priorities regularly |

For detailed mitigation strategies, see `references/best-practices.md`.

## Quick Reference: Prioritization Flow

1. **Define Context** → What are we prioritizing? Constraints? Goals?
2. **Assess Items** → Evaluate value, risk, effort, dependencies
3. **Apply MoSCoW** → Assign each item to a category
4. **Validate Balance** → Check distribution, sanity check, stakeholder review
5. **Sequence** → Order within categories (dependencies, risk, value)
6. **Document** → Update GitHub Projects, record rationale
7. **Communicate** → Share with team and stakeholders
8. **Execute** → Build in priority order (Must → Should → Could)
9. **Revisit** → Re-prioritize as needed based on learning

## Reference Files

Load references as needed:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **moscow-framework.md** | Detailed MoSCoW definitions, characteristics, examples, and classification criteria | `references/moscow-framework.md` |
| **moscow-worksheet.md** | Executing a multi-phase prioritization session or needing step-by-step workflow guidance | `references/moscow-worksheet.md` |
| **best-practices.md** | Reviewing prioritization decisions, resolving disputes, or validating distribution balance | `references/best-practices.md` |
| **prioritization-examples.md** | Level-specific examples for epics, stories, or tasks | `references/prioritization-examples.md` |

## Examples

Working examples that can be copied and adapted:

| Example | Use Case | Path |
|---------|----------|------|
| **example-prioritized-backlog.md** | Viewing backlog structure, rationale documentation, or GitHub integration format | `examples/example-prioritized-backlog.md` |
| **example-prioritization-session.md** | Facilitating stakeholder sessions or trade-off discussions | `examples/example-prioritization-session.md` |

## Integration with Requirements Lifecycle

**When to Prioritize:**
- After identifying epics (prioritize which epics to build first)
- After creating user stories (prioritize which stories within an epic)
- During sprint planning (prioritize tasks for the iteration)
- During refinement (adjust priorities based on new information)

**Updating GitHub Projects:**
- Set "Priority" custom field on issues
- Apply priority labels
- Order backlog by priority
- Review and adjust regularly

Prioritization is an ongoing activity throughout the requirements lifecycle—use it to focus effort on what matters most and deliver maximum value incrementally.

## Related Skills

Load these skills when prioritization reveals needs beyond this skill's scope:

| Prioritization Context | Load Skill | Routing Trigger |
|------------------------|------------|-----------------|
| Epics need identification or refinement | `epic-identification` | User needs to create or adjust epic scope |
| Stories need creation or refinement | `user-story-creation` | User needs to create or adjust user stories |
| Tasks need breakdown or refinement | `task-breakdown` | User needs to create or adjust tasks |
| Priorities need validation with stakeholders | `requirements-feedback` | User needs to gather feedback on priority decisions |
