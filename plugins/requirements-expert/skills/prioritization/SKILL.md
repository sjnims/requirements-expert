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

Use prioritization when:
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

**Questions to Ask:**
- Can we ship without this?
- Does this deliver essential core value?
- Is this legally or contractually required?
- Would users reject the product without this?

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

**Questions to Ask:**
- Does this significantly improve UX or value?
- Can users achieve their goals without this (even if harder)?
- Does this provide important differentiation?
- Would delaying this cause pain but not failure?

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

**Questions to Ask:**
- Would users notice if this were missing?
- Does this provide marginal or incremental value?
- Is this primarily for convenience or polish?
- Can this easily be added later?

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

**Questions to Ask:**
- Does this align with current vision and goals?
- Is this better suited for a future release?
- Does including this risk delaying more important work?
- Can we explicitly say "not now" to this?

**Purpose:** Prevents scope creep by making exclusions explicit

## Prioritization Process

### Step 1: Define Context

Establish the scope and constraints:

**Clarify:**
- What are we prioritizing? (Epics? Stories? Tasks?)
- What are the constraints? (Time, budget, resources)
- What's the target? (MVP? V1.0? Next sprint?)
- Who are the stakeholders?

**Set Boundaries:**
- Total number of items to prioritize
- Decision criteria (value, risk, effort, dependencies)
- Time frame for this prioritization

### Step 2: Assess Each Item

For each epic/story/task, evaluate:

**Value to Users:**
- How much does this improve user experience?
- How many users benefit?
- How often will this be used?

**Business Value:**
- Revenue impact?
- Strategic importance?
- Competitive advantage?

**Risk:**
- Technical risk (complexity, unknowns)?
- Market risk (assumptions about user needs)?
- Higher risk items often prioritized earlier for learning

**Effort/Cost:**
- How much work is required?
- Resource needs (people, time, tools)?
- Return on investment?

**Dependencies:**
- What must come before this?
- What is blocked by this?
- External dependencies?

### Step 3: Apply MoSCoW Categories

For each item, assign a MoSCoW category:

**Decision Framework:**

1. **Start with Must Haves:**
   - Identify absolute essentials
   - Challenge each: "Can we really not ship without this?"
   - Aim for <60% in this category

2. **Identify Should Haves:**
   - High-value, not mission-critical
   - Important for good UX or differentiation
   - Can defer if Must Haves at risk

3. **Mark Could Haves:**
   - Nice to have if time permits
   - Easy to cut without major impact
   - Often polish or convenience features

4. **Explicitly List Won't Haves:**
   - Items that won't be in current scope
   - Document WHY to prevent revisiting
   - May be reconsidered in future

### Step 4: Validate and Balance

Review the prioritization:

**Balance Check:**
- Are <60% of items "Must Have"? (If more, challenge them)
- Is there a healthy mix across categories?
- Have we explicitly identified "Won't Haves"?

**Sanity Checks:**
- Do "Must Haves" collectively deliver minimum viable product?
- Can we ship with just "Must Haves" if needed?
- Are dependencies respected? (prerequisite items high priority)

**Stakeholder Review:**
- Share prioritization with key stakeholders
- Get feedback on category assignments
- Discuss trade-offs and rationale
- Build consensus

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

### Step 6: Document and Communicate

Record prioritization decisions:

**In GitHub Projects:**
- Update "Priority" custom field on issues
- Add priority labels (priority:must-have, etc.)
- Order issues in project views by priority

**Rationale:**
- Document WHY items are prioritized as they are
- Capture trade-offs and decisions made
- Reference for future prioritization

**Communication:**
- Share prioritized backlog with team
- Explain sequencing and rationale
- Set expectations about what's in/out of scope

## Prioritization at Different Levels

### Prioritizing Epics

**Context:** Determining which major capabilities to build first

**Considerations:**
- Strategic alignment with vision
- Foundation vs. enhancement (build foundation first)
- User journey completeness (can users accomplish goals?)
- Market differentiation (what makes you unique?)

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
| **moscow-worksheet.md** | Structured process guidance for conducting MoSCoW prioritization sessions | `references/moscow-worksheet.md` |
| **best-practices.md** | Detailed guidance on prioritization best practices and common pitfalls to avoid | `references/best-practices.md` |

### Example Files

Review examples for concrete patterns:

| Example | What It Shows | Path |
|---------|---------------|------|
| **example-prioritized-backlog.md** | Complete prioritized backlog with MoSCoW distribution, rationale, and GitHub integration | `examples/example-prioritized-backlog.md` |
| **example-prioritization-session.md** | Full prioritization session including evaluation, trade-offs, and stakeholder alignment | `examples/example-prioritization-session.md` |

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
