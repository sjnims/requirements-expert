# MoSCoW Prioritization Process Guide

This reference provides structured process guidance for conducting MoSCoW prioritization sessions. Load this when facilitating prioritization of epics, stories, or tasks.

For a complete worked example, see `examples/example-prioritization-session.md`.

---

## Session Setup

Before starting prioritization, ensure the following context is established:

### Required Context

Gather and document:

- **Session date** - When the prioritization is occurring
- **Facilitator** - Who is leading the session
- **Participants** - Names and roles of stakeholders involved
- **Scope** - What is being prioritized (epics for Q1, stories for Sprint 5, etc.)
- **Target/Goal** - What the prioritization aims to achieve (MVP, V1.0, next release)
- **Constraints** - Time, budget, team size, deadlines affecting decisions

### Prerequisite Checks

Before proceeding:

- [ ] Items to prioritize exist in GitHub Projects
- [ ] All participants understand the MoSCoW framework
- [ ] Decision criteria are agreed upon
- [ ] Time is allocated (60-90 minutes for 10-20 items)

---

## Decision Criteria

Establish and weight the criteria that will guide prioritization decisions:

### Standard Criteria

Assess each criterion's importance for this prioritization:

**Value to Users:**

- Impact on user experience
- Number of users affected
- Frequency of use

**Business Value:**

- Revenue impact
- Strategic importance
- Competitive advantage

**Risk:**

- Technical complexity
- Uncertainty / unknowns
- Market assumptions

**Effort:**

- Time required
- Resources needed
- Technical dependencies

### Weighting

For each criterion, determine its weight for this session:

- **High** - Primary driver of decisions
- **Medium** - Important consideration
- **Low** - Secondary factor

---

## Item Assessment

For each item being prioritized, capture:

### Required Information

| Field | What to Capture |
|-------|-----------------|
| ID | Item number or identifier |
| Name | Clear, descriptive title |
| Description | Brief summary of the item |
| Value | High/Medium/Low user and business value |
| Risk | High/Medium/Low technical and market risk |
| Effort | High/Medium/Low resource requirement |
| Dependencies | Other items this depends on or blocks |

### Assessment Process

For each item:

1. Review the item's description and acceptance criteria
2. Discuss value from user and business perspectives
3. Assess technical risk and complexity
4. Estimate relative effort
5. Identify dependencies on other items
6. Note any constraints or blockers

---

## MoSCoW Classification

Apply the MoSCoW framework to categorize each item.

### Must Have (Target: ≤60% of items)

Requirements critical for success. Without these, the product fails to deliver core value.

**Classification criteria:**

- Non-negotiable for this release
- Product is not viable without this
- Legal, regulatory, or safety requirement
- Core functionality essential to vision

**For each Must Have, document:**

- Item ID and name
- Rationale explaining why this is absolutely essential
- What would break without it

### Should Have (Target: ~20% of items)

Important requirements that significantly enhance value but can be deferred if necessary.

**Classification criteria:**

- High impact but not mission-critical
- Significantly improves user experience
- Differentiates from competitors
- Can work around absence (though painful)

**For each Should Have, document:**

- Item ID and name
- Rationale explaining importance
- Workaround if deferred

### Could Have (Target: ~20% of items)

Nice-to-have requirements that provide marginal value.

**Classification criteria:**

- Low impact on core value
- Enhancement or polish feature
- Convenience improvement
- Easy to cut if needed

**For each Could Have, document:**

- Item ID and name
- Rationale explaining low priority

### Won't Have (This Time)

Requirements explicitly excluded from current scope.

**Classification criteria:**

- Out of current scope
- Lower priority than other work
- Not aligned with current goals
- Explicitly deferred or rejected

**For each Won't Have, document:**

- Item ID and name
- Rationale explaining exclusion
- When to reconsider (future release, condition, or never)

---

## Sequencing Within Categories

After classification, establish execution order within each category.

### Sequencing Factors

Consider when ordering:

- **Dependencies** - Prerequisite items must come first
- **Risk** - High-uncertainty items early for learning
- **Value** - Higher-value items first within category
- **Effort** - Quick wins can build momentum

### Sequencing Output

For each category, document ordered list with position rationale:

1. Item name - Reason for this sequence position
2. Item name - Reason for this sequence position
3. ...continue for all items in category

---

## Validation Checks

Before finalizing, run these validation checks:

### Distribution Check

Calculate and verify:

- **Must Haves:** Count / Total = percentage (Target: ≤60%)
- **Should Haves:** Count / Total = percentage (Target: ~20%)
- **Could Haves:** Count / Total = percentage (Target: ~20%)
- **Won't Haves:** Count documented

**If Must Haves exceed 60%:**

- Challenge each Must Have: "Can we really not ship without this?"
- Move borderline items to Should Have
- Look for items that are important but not critical

### MVP Viability Check

Verify the Must Haves alone deliver a viable product:

- [ ] Can the product ship with just Must Haves?
- [ ] Does it deliver core value to users?
- [ ] Would users pay for / use this?
- [ ] Are all critical user journeys covered?

### Dependency Check

Verify sequencing respects dependencies:

- [ ] All dependencies are respected in sequencing
- [ ] No high-priority items depend on low-priority items
- [ ] Prerequisite items are appropriately prioritized

### Stakeholder Alignment

Confirm alignment before proceeding:

- [ ] Key stakeholders have reviewed the prioritization
- [ ] Major disagreements are resolved or documented
- [ ] Consensus achieved on Must Haves and Won't Haves

---

## Decisions and Trade-offs

Document key decisions made during prioritization:

### Decision Template

For each significant decision:

- **What:** Description of the decision
- **Rationale:** Why this decision was made
- **Trade-off:** What was sacrificed or deferred
- **Alternatives considered:** Other options evaluated

### Common Trade-off Patterns

Watch for and document decisions about:

- Feature scope vs. timeline
- User experience vs. development effort
- Must Have inflation vs. focused scope
- Technical debt vs. delivery speed

---

## Action Items

After prioritization, execute these actions:

### Immediate Actions

- [ ] Update GitHub Projects Priority custom field on all issues
- [ ] Apply priority labels (priority:must-have, priority:should-have, etc.)
- [ ] Order backlog by priority in project views
- [ ] Communicate prioritization decisions to team
- [ ] Begin work on first Must Have item

### Follow-up Actions

- [ ] Schedule re-prioritization review at appropriate interval
- [ ] Gather user/stakeholder feedback on priorities
- [ ] Re-assess Won't Haves for future releases
- [ ] Update priorities based on new information

---

## Session Notes

Capture any additional context:

- Discussion points not captured elsewhere
- Minority opinions or dissent to revisit
- Assumptions made during prioritization
- Questions to investigate before next session

---

## Revision Tracking

When priorities change, document:

- Date of change
- What changed (item, old priority, new priority)
- Why the change was made
- Who approved the change

---

## Quick Reference

### MoSCoW at a Glance

| Category | Target % | Question to Ask |
|----------|----------|-----------------|
| Must Have | ≤60% | "Can we ship without this?" |
| Should Have | ~20% | "Important but not critical?" |
| Could Have | ~20% | "Nice to have if time permits?" |
| Won't Have | N/A | "Explicitly out of scope?" |

### Red Flags

Watch for these issues:

- **>60% Must Haves** - Challenge assumptions, apply stricter criteria
- **No Won't Haves** - Scope creep risk, explicitly exclude items
- **Dependency conflicts** - High-priority items depending on low-priority ones
- **No stakeholder buy-in** - Revisit decisions with key stakeholders
