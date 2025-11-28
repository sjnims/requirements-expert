# INVEST Criteria

Every user story should meet INVEST criteria. Use this reference when validating stories against each criterion.

---

## Overview

INVEST is an acronym for the six key characteristics of high-quality user stories:

| Letter | Criterion | Purpose |
|--------|-----------|---------|
| **I** | Independent | Enable flexible prioritization |
| **N** | Negotiable | Encourage collaboration |
| **V** | Valuable | Deliver user/business impact |
| **E** | Estimable | Enable planning |
| **S** | Small | Fit within iteration |
| **T** | Testable | Enable verification |

---

## I - Independent

Stories should be completable without depending on other stories.

### Why It Matters

- Enables flexible prioritization and reordering
- Allows parallel work by different team members
- Reduces risk of blocking dependencies

### How to Achieve Independence

- Minimize dependencies between stories
- If dependencies exist, sequence stories appropriately
- Consider vertical slicing (full stack per story) vs. horizontal layers

### Example: Dependent Stories (Problem)

```text
Story 1: "Build database schema"
Story 2: "Create API endpoints"
Story 3: "Build UI"
```

Each story depends on the previous one—can't be worked in parallel or reordered.

### Example: Independent Stories (Solution)

```text
Story 1: "User can view their profile data"
Story 2: "User can edit their profile name"
Story 3: "User can upload profile photo"
```

Each story is a complete vertical slice that can be delivered independently.

### Independence Checklist

- [ ] Can this story be completed without waiting for other stories?
- [ ] Can the team work on this in parallel with other stories?
- [ ] If there's a dependency, is it clearly documented and sequenced?

---

## N - Negotiable

Details are open for discussion, not fixed contracts.

### Why It Matters

- Encourages collaboration between team and stakeholders
- Allows best solution to emerge through discussion
- Prevents over-specification that limits creativity

### How to Achieve Negotiability

- Focus on WHAT and WHY, not HOW
- Leave implementation details for later
- Specify constraints, not solutions

### Example: Negotiable (Good)

```text
Display campaign performance metrics in an easy-to-scan format
```

The team can discuss and decide the best visualization approach.

### Example: Too Prescriptive (Poor)

```text
Display campaign performance in a table with exactly 5 columns:
Name, Clicks, Cost, ROI, Status, using blue headers (#0066CC)
and zebra-striped rows with 14px Arial font
```

No room for design discussion or improvement.

### Negotiability Checklist

- [ ] Does the story describe what and why, not how?
- [ ] Is there room for the team to propose solutions?
- [ ] Are constraints (not solutions) specified?
- [ ] Can this be discussed and refined with stakeholders?

---

## V - Valuable

Must deliver value to users or stakeholders.

### Why It Matters

- Every story should move toward vision/epic goals
- Prevents building features that don't matter
- Keeps focus on user outcomes, not technical tasks

### How to Achieve Value

- Describe user-facing value in the story
- Avoid purely technical stories without user impact
- If technical work is needed, frame it in terms of enabling user value

### Example: Valuable Story

```text
User can reset their password via email link
```

Clear user value: enables account recovery.

### Example: Low-Value Story

```text
Refactor authentication module
```

Technical task without clear user value. Better to tie it to user impact.

### Example: Reframed for Value

```text
Password reset completes in under 5 seconds
```

Now connected to user experience improvement.

### Value Checklist

- [ ] Can you clearly state what user benefit this delivers?
- [ ] Does it contribute to the epic/vision goals?
- [ ] Would a stakeholder understand why this matters?
- [ ] If purely technical, is it an enabler for user-facing stories?

---

## E - Estimable

Team can estimate size/effort.

### Why It Matters

- Enables planning and prioritization
- Allows commitment to iteration scope
- Identifies stories that need more clarification

### How to Achieve Estimability

- Provide enough detail to understand scope
- Clarify unknowns before committing to story
- If not estimable, spike or research story may be needed

### Example: Estimable Story

```text
User can filter campaigns by date range (start date, end date)
```

Clear scope: date picker UI, filter logic, validation. Team can estimate.

### Example: Not Estimable

```text
Improve campaign filtering
```

Too vague—how much improvement? What aspects? Team can't estimate.

### When Stories Aren't Estimable

If a story can't be estimated, consider:

1. **Spike**: Time-boxed research to reduce uncertainty
2. **Split**: Break into known parts and unknown exploration
3. **Clarify**: Discuss with stakeholders to add specifics

### Estimability Checklist

- [ ] Can the team give a rough size estimate (story points, T-shirt size)?
- [ ] Are the acceptance criteria clear enough to understand scope?
- [ ] Are there unknowns that need research first?
- [ ] If not estimable, is there a spike needed?

---

## S - Small

Fits within a single iteration.

### Why It Matters

- Enables frequent delivery and feedback
- Reduces risk of long-running incomplete work
- Allows course correction based on learning

### How to Achieve Small Size

- Aim for 1-5 days of work
- If larger, split into smaller stories
- Use vertical slicing to create small, valuable increments

### Example: Right Size

```text
User can export campaign data to CSV format
```

Focused, deliverable in a few days.

### Example: Too Large

```text
User can export campaign data to any format with custom fields and scheduling
```

This is multiple stories bundled together.

### Example: Split Appropriately

```text
Story 1: User can export campaign data to CSV
Story 2: User can select which fields to include in export
Story 3: User can schedule recurring exports
Story 4: User can export to Excel format
```

Each is small, valuable, and deliverable independently.

### Size Guidelines

| Size | Typical Duration | Action |
|------|------------------|--------|
| Too small | < 1 day | May be a task, not a story |
| Right size | 1-5 days | Good story size |
| Too large | > 1 week | Split into smaller stories |

### Smallness Checklist

- [ ] Can this be completed in 1-5 days?
- [ ] If larger, can it be split into smaller stories?
- [ ] Does each split story still deliver independent value?

---

## T - Testable

Clear acceptance criteria enable verification.

### Why It Matters

- Know when story is complete and working correctly
- Enable QA and acceptance testing
- Prevent "definition of done" disputes

### How to Achieve Testability

- Define specific, observable outcomes
- Include acceptance criteria in story description
- Focus on behavior, not implementation

### Example: Testable Story

```text
User can filter campaigns by date range

Acceptance Criteria:
- Date pickers for start and end dates
- Campaigns outside range are hidden
- Validation prevents invalid date ranges (end before start)
- Clear filters returns to showing all campaigns
```

Each criterion is specific and observable.

### Example: Not Testable

```text
System should be performant
```

What does "performant" mean? Can't verify without specifics.

### Example: Made Testable

```text
Campaign list loads in under 2 seconds with 1000 campaigns
```

Now there's a specific, measurable criterion.

### Writing Good Acceptance Criteria

**Given-When-Then Format:**

```text
Given [context or starting state]
When [action taken]
Then [expected outcome]
```

**Checklist Format:**

```text
- [ ] Specific observable outcome 1
- [ ] Specific observable outcome 2
- [ ] Specific observable outcome 3
```

### Testability Checklist

- [ ] Are there 3-5 acceptance criteria?
- [ ] Is each criterion specific and observable?
- [ ] Could QA write test cases from these criteria?
- [ ] Are edge cases and error conditions covered?

---

## Quick Reference: INVEST Validation

Use this table to quickly validate a story against all criteria:

| Criterion | Question | ✅ or ❌ |
|-----------|----------|---------|
| **Independent** | Can it be completed without other stories? | |
| **Negotiable** | Is there room for discussion on implementation? | |
| **Valuable** | Does it deliver clear user/business value? | |
| **Estimable** | Can the team estimate the effort? | |
| **Small** | Can it be completed in 1-5 days? | |
| **Testable** | Are there specific acceptance criteria? | |

If any criterion fails, refine the story before committing to it.

---

## Common INVEST Problems and Solutions

| Problem | Criterion Failed | Solution |
|---------|------------------|----------|
| "Depends on Story X" | Independent | Reframe as vertical slice or document sequence |
| "Build it exactly like this mockup" | Negotiable | Focus on outcomes, allow design flexibility |
| "Refactor codebase" | Valuable | Tie to user-facing improvement |
| "Improve performance" | Estimable | Add specific metrics and scope |
| "Build entire feature" | Small | Split by workflow, CRUD, or variations |
| "System works correctly" | Testable | Add specific acceptance criteria |
