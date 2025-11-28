---
name: User Story Creation
description: This skill should be used when the user asks to "create user stories", "write user stories", "break down epic into stories", "define user stories", "what stories do I need", or when they have epics defined and need to decompose them into specific, valuable user stories following INVEST criteria.
version: 0.2.0
---

# User Story Creation

## Overview

User story creation transforms epics into specific, actionable requirements that describe functionality from a user's perspective. Well-written user stories follow the INVEST criteria and provide clear value while remaining small enough to be completed in a single iteration. This skill guides the process of breaking down epics into high-quality user stories.

## Purpose

User stories serve as the detailed requirements layer:

- **Above**: Epics (major capabilities)
- **Stories**: Specific user-facing functionality
- **Below**: Tasks (implementation steps)

Well-written user stories:

- Describe functionality from user perspective
- Deliver independent, testable value
- Fit within a single iteration/sprint
- Enable detailed estimation and planning
- Facilitate conversation and refinement

## When to Use This Skill

Use user story creation when:

- An epic exists and needs to be broken into stories
- User asks for detailed requirements for a capability
- Planning an iteration and need to define work
- Refining or adding stories to an existing epic
- Validating that stories cover the full epic scope

**Prerequisite:** Epic must exist before creating stories. If no epic exists, use epic-identification skill first.

## User Story Format

### Standard Template

```text
As a [user type/persona],
I want [goal/desire],
So that [benefit/value].
```

**Components:**

- **User type**: WHO wants this (specific role or persona)
- **Goal**: WHAT they want to do (capability or action)
- **Benefit**: WHY it matters (value or outcome)

### Example Stories

**Good:**

```text
As a marketing manager,
I want to filter campaign data by date range,
So that I can analyze performance for specific time periods.
```

**Poor:**

```text
As a user,  (too vague—which user?)
I want to see data,  (too vague—what data? how?)
So that I can use the app.  (no specific benefit)
```

### When to Deviate from Template

The template is a guideline, not a requirement:

- Use it when it clarifies value and perspective
- Deviate when it adds unnecessary words
- Alternative: Simple title + detailed description

**Alternative format:**

- **Title**: "Filter campaigns by date range"
- **Description**: Detailed explanation of functionality and value

## INVEST Criteria

Every user story should meet INVEST criteria:

| Letter | Criterion | Question |
|--------|-----------|----------|
| **I** | Independent | Can it be completed without other stories? |
| **N** | Negotiable | Is there room for discussion on implementation? |
| **V** | Valuable | Does it deliver clear user/business value? |
| **E** | Estimable | Can the team estimate the effort? |
| **S** | Small | Can it be completed in 1-5 days? |
| **T** | Testable | Are there specific acceptance criteria? |

For detailed guidance on each criterion with examples, see `references/invest-criteria.md`.

## Story Creation Process

### Step 1: Review the Epic

Understand the epic being broken down:

**Key Actions:**

- Read epic issue in GitHub Projects
- Understand scope, value, success criteria
- Identify user types and journeys covered

### Step 2: Identify User Journeys

Map out the user flows within the epic:

**Techniques:**

- **Task Analysis**: What tasks do users complete? What's the sequence?
- **Scenario Mapping**: What scenarios exist? What paths might users take?
- **User Type Breakdown**: Do different users need different stories?

### Step 3: Draft Initial Stories

Create draft stories covering the epic:

**Start with happy paths:**

- Core functionality for primary scenarios
- Most common user needs
- Essential capabilities

**Then add edge cases and variations:**

- Error handling
- Alternative flows
- Advanced features

**Ensure coverage:**

- All epic scope covered
- No gaps in user journeys
- All success criteria addressable

### Step 4: Apply INVEST Criteria

Review each story against INVEST:

- **Independence**: Can this story be completed without others?
- **Value**: Does this deliver something users care about?
- **Size**: Is this 1-5 days of work? If larger, split it.
- **Testability**: What are the acceptance criteria?

### Step 5: Add Acceptance Criteria

For each story, define clear acceptance criteria:

**Given-When-Then Format:**

```text
Given [context],
When [action],
Then [expected outcome].
```

**Or simple checklist:**

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

**Example:**

Story: "User can filter campaigns by date range"

Acceptance Criteria:

- [ ] Date picker UI for start date and end date
- [ ] Only campaigns with activity in date range are shown
- [ ] Selecting invalid range (end before start) shows error message
- [ ] Clearing filters shows all campaigns again

### Step 6: Prioritize Stories

Determine sequence and priority:

- **Sequencing**: Which stories must come first (dependencies)?
- **Prioritization**: Which deliver most value? Use MoSCoW framework.

### Step 7: Create Story Issues in GitHub Projects

For each story, create a GitHub issue:

**Issue Title:** "[Story summary in user voice]"

**Issue Description:** Full story with acceptance criteria using template from `references/story-template.md`

**Custom Fields:**

- Type: Story
- Priority: [Must Have / Should Have / Could Have]
- Status: Not Started

**Labels:**

- `type:story`
- `priority:[moscow-level]`

**Parent:** Link to Epic issue as parent

## Story Splitting

When stories are too large (more than 1 week of work), split them using these techniques:

| Technique | When to Use | Example Split |
|-----------|-------------|---------------|
| **Workflow Steps** | Multi-step process | View → Edit → Delete subscription |
| **Operations (CRUD)** | Managing entities | Invite, view, remove, change role |
| **Business Rules** | Multiple conditions | % discount, $ discount, BOGO |
| **Happy Path vs. Variations** | Simple core + complex edges | Basic upload → Multiple files → Drag & drop |
| **Data Variations** | Multiple formats/sources | CSV import → Excel → Google Contacts |
| **Platforms** | Multiple interfaces | In-app → Email → SMS notifications |
| **User Roles** | Multiple user types | Owner, admin, member views |
| **Performance Tiers** | Performance-sensitive | Basic → Cached → Optimized |

For detailed guidance and examples for each technique, see `references/splitting-techniques.md`.

## Best Practices

### Write from User Perspective

Focus on what users see and experience:

- ❌ "Implement database indexes for performance"
- ✅ "Campaign list loads in under 2 seconds"

### Keep Stories Testable

Always include acceptance criteria:

- 3-5 acceptance criteria per story
- Specific, observable outcomes
- Testable without looking at code

### Avoid Technical Tasks as Stories

Technical work should be tasks within user-facing stories:

- ❌ Story: "Set up CI/CD pipeline"
- ✅ Story: "User can see deployment status" (tasks include CI/CD setup)

### One Story, One Goal

Each story should have singular focus:

- ❌ "User can edit profile and change password and upload avatar"
- ✅ Three separate stories

### Include Non-Functional Requirements

Don't forget quality attributes:

- Performance requirements
- Security constraints
- Accessibility standards
- Usability expectations

## Common Pitfalls to Avoid

| Pitfall | Problem | Solution |
|---------|---------|----------|
| **Too Large** | Takes weeks, not days | Split using techniques above |
| **Too Small** | Trivial, just a task | Combine into meaningful story |
| **Missing Acceptance Criteria** | Can't verify completion | Add 3-5 specific criteria |
| **Pure Technical Story** | No user value | Frame in terms of user impact |

## Quick Reference: Story Creation Flow

1. **Review Epic** → Understand scope, value, success criteria
2. **Identify Journeys** → Map user flows and scenarios
3. **Draft Stories** → Cover happy paths, then edge cases
4. **Apply INVEST** → Check and refine against criteria
5. **Add Acceptance Criteria** → Define testability for each story
6. **Prioritize** → Sequence and rank by value
7. **Create Issues** → Add to GitHub Projects as children of epic
8. **Proceed** → Move to task breakdown for each story

## Reference Files

Load references based on context:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **invest-criteria.md** | Validating stories against INVEST | `references/invest-criteria.md` |
| **splitting-techniques.md** | Story is too large and needs splitting | `references/splitting-techniques.md` |
| **story-template.md** | Creating story issue content | `references/story-template.md` |

## Next Steps

After creating user stories:

1. Create story issues in GitHub Projects (as children of epic issue)
2. Prioritize stories using the prioritization skill
3. Select highest-priority story and proceed to task breakdown
4. Iterate through all stories, creating tasks for each

User stories are the bridge between epics and executable work—invest time to make them clear, valuable, and testable.
