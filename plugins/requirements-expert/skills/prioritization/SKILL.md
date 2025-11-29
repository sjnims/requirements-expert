---
name: Prioritization
description: This skill should be used when the user asks to "prioritize requirements", "prioritize epics", "prioritize stories", "prioritize tasks", "prioritize backlog", "use MoSCoW", "apply MoSCoW priorities", "assign priorities", "set priority labels", "rank features", "what should I build first", "what's most important", "order by importance", "must have vs should have", or when they need to determine the priority order of epics, user stories, or tasks using the MoSCoW framework.
version: 0.2.0
---

# Prioritization

## Overview

Prioritization is the process of determining the relative importance and sequence of requirements at any level—epics, user stories, or tasks. Using the MoSCoW framework (Must Have, Should Have, Could Have, Won't Have), teams can make informed decisions about what to build first, ensuring maximum value delivery within constraints.

## Purpose

Effective prioritization:
- Focuses effort on highest-value work
- Enables incremental delivery of working software
- Manages scope within time and budget constraints
- Aligns team and stakeholders on what matters most
- Provides clear rationale for sequencing decisions

## When to Use This Skill

Apply this skill when:
- Epics exist and need to be ordered by importance
- Stories within an epic need priority ranking
- Tasks need sequencing for implementation
- User asks what to build first or what's most important
- Applying MoSCoW labels or priority fields in GitHub Projects

**Prerequisites:** Items must exist before prioritizing. If none exist:
- No epics? Use the **epic-identification** skill first
- No stories? Use the **user-story-creation** skill first
- No tasks? Use the **task-breakdown** skill first

## MoSCoW Framework

### Must Have

**Definition:** Requirements critical for success. Without these, the product fails to deliver core value or is fundamentally broken.

**Characteristics:**
- Non-negotiable for initial release
- Product is not viable without these
- Legal, regulatory, or safety requirements
- Core functionality essential to vision

**Examples:**
- User authentication (for a product requiring accounts)
- Payment processing (for an e-commerce product)
- Core workflow (the main thing users do)

**Classification Criteria** (evaluate each before classifying):
- Cannot ship without this feature
- Delivers essential core value to primary users
- Legal, regulatory, or contractual requirement
- Users would reject the product without this

**Typical Percentage:** 60% of total requirements

### Should Have

**Definition:** Important requirements that significantly enhance value but aren't absolutely critical for initial release. Can be deferred if necessary.

**Characteristics:**
- High impact, not mission-critical
- Significantly improves user experience
- Differentiates from competitors
- Can work around absence (though painful)

**Examples:**
- Advanced filtering and search
- Batch operations
- Export to multiple formats
- Email notifications

**Classification Criteria** (evaluate each before classifying):
- Significantly improves user experience or value
- Users can achieve goals without this, but with difficulty
- Provides important competitive differentiation
- Delay causes pain but not product failure

**Typical Percentage:** 20% of total requirements

### Could Have

**Definition:** Nice-to-have requirements that provide marginal value. Include only if time and resources permit.

**Characteristics:**
- Low impact on core value
- "Nice to have" enhancements
- Polish and convenience features
- Easy to cut if needed

**Examples:**
- Customizable themes
- Additional chart types
- Keyboard shortcuts
- Tooltips and help text

**Classification Criteria** (evaluate each before classifying):
- Users unlikely to notice if missing
- Provides marginal or incremental value only
- Primarily a convenience or polish feature
- Easily added in a future release

**Typical Percentage:** 20% of total requirements

### Won't Have (This Time)

**Definition:** Requirements explicitly excluded from current scope. May be considered for future releases but are off the table now.

**Characteristics:**
- Out of current scope
- Lower priority than other work
- Not aligned with current goals
- Explicitly deferred or rejected

**Examples:**
- Mobile app (when focusing on web first)
- AI-powered features (for MVP)
- Advanced analytics (phase 2 feature)
- Third-party integrations (beyond core)

**Classification Criteria** (evaluate each before classifying):
- Does not align with current vision and goals
- Better suited for a future release
- Including this risks delaying more important work
- Can be explicitly documented as "not now"

**Purpose:** Prevents scope creep by making exclusions explicit

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

### Prioritizing Epics

**Context:** Determining which major capabilities to build first

**Considerations:**
- Strategic alignment with vision
- Foundation vs. enhancement (build foundation first)
- User journey completeness (can users accomplish goals?)
- Market differentiation (what differentiates the product?)

**Example:**
- Must Have: User Authentication, Core Workflow, Payment Processing
- Should Have: Advanced Analytics, Team Collaboration
- Could Have: Custom Branding, API Access
- Won't Have: Mobile App (Web-first strategy)

### Prioritizing User Stories

**Context:** Determining which stories within an epic to implement first

**Considerations:**
- Happy path before edge cases
- Core functionality before enhancements
- Foundation before polish
- High-frequency use cases before rare ones

**Example (within "Campaign Management" epic):**
- Must Have: Create campaign, View campaign list, Edit campaign basics
- Should Have: Duplicate campaign, Archive campaign, Bulk operations
- Could Have: Campaign templates, Custom fields
- Won't Have: Campaign scheduling (separate epic)

### Prioritizing Tasks

**Context:** Determining sequence of implementation tasks within a story

**Considerations:**
- Technical dependencies (backend before frontend)
- Iterative progress (working slice early, then enhance)
- Testing alongside feature work (not all at end)
- Documentation concurrent with implementation

**Example (within "Filter campaigns by date" story):**
- Must Have: Backend date filtering logic, Basic UI with date pickers, Integration
- Should Have: Validation and error handling, Unit tests
- Could Have: Date range presets (Last 7 days, Last 30 days)
- Won't Have: Save filter preferences (separate story)

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

- **Everything is a "Must Have"** - If everything is critical, nothing is
- **Ignoring Technical Dependencies** - Prioritize prerequisites appropriately
- **Forgetting "Won't Have"** - Explicitly identify what's out of scope
- **Prioritizing Based on Who Shouts Loudest** - Use objective criteria, not volume
- **Never Re-Prioritizing** - Stay flexible; revisit priorities regularly

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

## Additional Resources

### Reference Files

Load references as needed:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **moscow-worksheet.md** | Load when executing a multi-phase prioritization session or needing step-by-step workflow guidance | `references/moscow-worksheet.md` |
| **best-practices.md** | Load when reviewing prioritization decisions, resolving disputes, or validating distribution balance | `references/best-practices.md` |

### Example Files

Review examples for concrete patterns:

| Example | What It Shows | Path |
|---------|---------------|------|
| **example-prioritized-backlog.md** | Load when needing output format reference for backlog structure, rationale documentation, or GitHub integration | `examples/example-prioritized-backlog.md` |
| **example-prioritization-session.md** | Load when facilitating stakeholder sessions or needing trade-off discussion patterns | `examples/example-prioritization-session.md` |

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

| Skill | Relationship |
|-------|-------------|
| **epic-identification** | Apply prioritization after identifying epics |
| **user-story-creation** | Apply prioritization after creating stories |
| **task-breakdown** | Apply prioritization after breaking down tasks |
| **requirements-feedback** | Use feedback to inform priority adjustments |
