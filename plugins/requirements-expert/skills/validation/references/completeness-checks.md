# Completeness Checks

Detailed checklists for verifying all required elements exist at each requirements level.

## Vision Level

A complete vision must include:

- [ ] **Problem statement** exists and is clear
  - Articulates the problem being solved
  - Explains why this problem matters
  - Describes impact of the problem

- [ ] **Target users** are defined with specifics
  - Primary user types/personas identified
  - User needs and pain points described
  - User context and environment noted

- [ ] **Solution overview** describes what the product does
  - High-level description of the solution
  - Key capabilities summarized
  - Differentiation from alternatives

- [ ] **Success metrics** are measurable and defined
  - Quantifiable outcomes specified
  - Timeframes for measurement included
  - Baseline and target values defined

- [ ] **Scope boundaries** clarify what's included/excluded
  - In-scope items explicitly listed
  - Out-of-scope items explicitly listed
  - Future considerations noted

- [ ] **Core value proposition** is articulated
  - Primary benefit to users stated
  - Unique value clearly expressed

**Critical if missing**: Cannot validate epics without clear vision. All downstream requirements depend on vision clarity.

## Epic Level

For each epic, verify:

- [ ] **Overview** describes the capability
  - What the epic delivers
  - Why it matters to users
  - How it fits in the product

- [ ] **User value** explains who benefits and how
  - Specific user types who benefit
  - Concrete benefits they receive
  - Problems this epic solves

- [ ] **Scope** defines included/excluded functionality
  - Features included in this epic
  - Features explicitly excluded
  - Boundaries with other epics

- [ ] **Success criteria** specify when epic is complete
  - Measurable completion criteria
  - Definition of done for the epic
  - Acceptance conditions

- [ ] **Parent link** to vision issue exists
  - Issue references vision as parent
  - Relationship is explicit in issue body

**Critical if missing**: Cannot create meaningful stories without clear epic scope.

## Story Level

For each story, verify:

- [ ] **Story format** follows "As a... I want... So that..."
  - User type specified (not generic "user")
  - Goal clearly stated
  - Benefit/value articulated

- [ ] **Acceptance criteria** are present
  - Minimum 3-5 criteria
  - Each criterion is specific
  - Each criterion is testable
  - Criteria are observable

- [ ] **Parent link** to epic issue exists
  - Story references epic as parent
  - Relationship is explicit

- [ ] **Size estimate** fits within 1-5 days
  - Story is small enough for one iteration
  - If larger, should be split

**Critical if missing**: Cannot implement without clear acceptance criteria.

## Task Level

For each task, verify:

- [ ] **Action-oriented title** starts with verb
  - Uses active voice
  - Describes specific action
  - Is unambiguous

- [ ] **Clear description** of what needs to be done
  - Implementation approach outlined
  - Context provided
  - Constraints noted

- [ ] **Acceptance criteria** are specific and testable
  - Minimum 3-5 criteria
  - Technical verification possible
  - Definition of done clear

- [ ] **Parent link** to story issue exists
  - Task references story as parent
  - Relationship is explicit

- [ ] **Right-sized** at 2-8 hours of work
  - Small enough to complete in one session
  - Large enough to be meaningful
  - If larger, should be split

**Critical if missing**: Cannot execute without clear task definition.

## Completeness Scoring

Calculate completeness percentage for each level:

```text
Completeness % = (Items with all required elements / Total items) * 100
```

| Score | Rating | Action |
|-------|--------|--------|
| >90% | Pass | Proceed with confidence |
| 70-90% | Warning | Address gaps before implementation |
| <70% | Fail | Fix critical gaps immediately |

## Common Completeness Issues

| Issue | Impact | Fix |
|-------|--------|-----|
| Missing acceptance criteria | Cannot verify completion | Add 3-5 specific criteria |
| Vague problem statement | Unclear direction | Refine with stakeholder input |
| No success metrics | Cannot measure success | Define measurable outcomes |
| Missing parent links | Broken traceability | Add parent references |
| Generic user type | Unclear who benefits | Specify concrete personas |
