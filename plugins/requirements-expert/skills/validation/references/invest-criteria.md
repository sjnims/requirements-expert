# INVEST Criteria

Detailed guidance for validating user stories against INVEST criteria.

## Overview

INVEST is an acronym for six criteria that make user stories effective:

| Letter | Criterion | Key Question |
|--------|-----------|--------------|
| **I** | Independent | Can it be completed without depending on others? |
| **N** | Negotiable | Is there room for discussion on implementation? |
| **V** | Valuable | Does it deliver clear user/business value? |
| **E** | Estimable | Can the team estimate the effort? |
| **S** | Small | Can it be completed in 1-5 days? |
| **T** | Testable | Are there specific acceptance criteria? |

## Independent

### What It Means

The story can be developed, tested, and delivered independently of other stories. Dependencies don't block progress.

### Validation Checks

- [ ] Story can be completed without waiting for other stories
- [ ] No hard dependencies that block development
- [ ] Can be deployed independently (or with minimal coordination)

### Warning Signs

- "This story requires Story X to be done first"
- Shared data models that must be built together
- Tightly coupled frontend/backend stories

### How to Fix

- Combine dependent stories into one larger story, then split differently
- Include enough of the dependency to make story self-contained
- Create a thin vertical slice through all layers

### Examples

**Dependent (Bad):**

```text
Story A: Create user database schema
Story B: Implement user registration (depends on A)
```

**Independent (Good):**

```text
Story: User can register with email
(Includes schema, API, and UI for registration)
```

## Negotiable

### What It Means

The story describes WHAT and WHY, not HOW. Implementation details are open for discussion between team and product owner.

### Validation Checks

- [ ] Story focuses on user goal, not technical solution
- [ ] Implementation approach is not prescribed
- [ ] Room for team to choose best technical approach

### Warning Signs

- "Use React component with Redux state management"
- Specific database queries or API designs in story
- Prescribed UI layouts or technical patterns

### How to Fix

- Remove implementation details from story description
- Move technical details to task level
- Focus story on user-visible outcome

### Examples

**Not Negotiable (Bad):**

```text
As a user, I want a REST API endpoint at /api/users
that returns JSON with pagination using cursor-based navigation
```

**Negotiable (Good):**

```text
As a user, I want to browse the user directory
So that I can find colleagues to collaborate with
```

## Valuable

### What It Means

The story delivers clear value to users or the business. Someone cares about the outcome.

### Validation Checks

- [ ] "So that" clause articulates clear benefit
- [ ] Story delivers user-visible functionality
- [ ] Value is understandable to non-technical stakeholders

### Warning Signs

- No "so that" clause or generic benefit
- Pure technical work with no user impact
- Value only apparent to developers

### How to Fix

- Articulate the user benefit clearly
- Connect technical work to user outcomes
- If no user value, consider if it's a task, not a story

### Examples

**No Clear Value (Bad):**

```text
As a developer, I want to refactor the authentication module
So that the code is cleaner
```

**Valuable (Good):**

```text
As a user, I want to stay logged in for 30 days
So that I don't have to re-enter credentials every session
```

## Estimable

### What It Means

The team can reasonably estimate how much effort the story requires. There are no major unknowns blocking estimation.

### Validation Checks

- [ ] Team understands what needs to be built
- [ ] Technical approach is clear enough to estimate
- [ ] No significant unknowns or research required

### Warning Signs

- "We need to investigate this first"
- New technology the team hasn't used
- Unclear scope or acceptance criteria
- External dependencies with unknown timelines

### How to Fix

- Create a spike/research story first
- Break down into smaller, understood pieces
- Clarify acceptance criteria
- Consult with experts or do quick prototyping

### Examples

**Not Estimable (Bad):**

```text
As a user, I want AI-powered recommendations
(Team has no ML experience, unclear what "AI-powered" means)
```

**Estimable (Good):**

```text
As a user, I want to see my 5 most recently viewed items
So that I can quickly return to what I was looking at
```

## Small

### What It Means

The story can be completed within a single iteration/sprint. Typically 1-5 days of work.

### Validation Checks

- [ ] Story fits within one iteration (1-5 days)
- [ ] Not an epic disguised as a story
- [ ] Scope is focused on one capability

### Warning Signs

- Story has many acceptance criteria (>7-10)
- Multiple user flows or scenarios
- "And" in the story title (multiple goals)
- Team estimates weeks, not days

### How to Fix

Split the story using these techniques:

| Technique | Example |
|-----------|---------|
| Workflow steps | View, Edit, Delete as separate stories |
| Operations (CRUD) | Create, Read, Update, Delete separately |
| Happy path first | Core flow, then error handling |
| Data variations | One data type at a time |
| User roles | Different stories per role |

### Examples

**Too Large (Bad):**

```text
As a user, I want complete account management
including profile, settings, billing, and notifications
```

**Small (Good):**

```text
As a user, I want to update my display name
So that my profile shows my preferred name
```

## Testable

### What It Means

The story has specific, verifiable acceptance criteria. You can determine when the story is done.

### Validation Checks

- [ ] Acceptance criteria are specific and unambiguous
- [ ] Criteria are verifiable without looking at code
- [ ] At least 3-5 acceptance criteria defined
- [ ] Edge cases and error conditions addressed

### Warning Signs

- No acceptance criteria
- Vague criteria like "should be fast" or "user-friendly"
- Criteria that require subjective judgment
- Missing error handling scenarios

### How to Fix

- Write specific, measurable criteria
- Use Given-When-Then format for clarity
- Include success and failure scenarios
- Define performance thresholds numerically

### Examples

**Not Testable (Bad):**

```text
Acceptance Criteria:
- Should be fast
- Should look good
- Should work properly
```

**Testable (Good):**

```text
Acceptance Criteria:
- [ ] Search results display within 2 seconds
- [ ] Results show item name, price, and thumbnail
- [ ] Empty search shows "No results found" message
- [ ] Search with special characters doesn't cause errors
```

## INVEST Scoring

For each story, score against all six criteria:

| Rating | Description |
|--------|-------------|
| Pass | Meets criterion fully |
| Partial | Meets criterion with minor issues |
| Fail | Does not meet criterion |

**Overall story rating:**

- **Fully Compliant**: Pass on all 6 criteria
- **Partial Compliance**: 1-2 Partial or Fail ratings
- **Non-Compliant**: 3+ Partial or Fail ratings

## Common INVEST Issues

| Issue | Most Common Cause | Quick Fix |
|-------|-------------------|-----------|
| Dependent | Horizontal slicing (layers) | Slice vertically |
| Not negotiable | Tech specs in story | Move to tasks |
| No value | Technical focus | Reframe as user outcome |
| Not estimable | Too much unknown | Spike first |
| Too large | Multiple features | Split story |
| Not testable | Vague criteria | Add specific criteria |
