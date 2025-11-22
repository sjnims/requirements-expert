---
name: User Story Creation
description: This skill should be used when the user asks to "create user stories", "write user stories", "break down epic into stories", "define user stories", "what stories do I need", or when they have epics defined and need to decompose them into specific, valuable user stories following INVEST criteria.
version: 0.1.0
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

```
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
```
As a marketing manager,
I want to filter campaign data by date range,
So that I can analyze performance for specific time periods.
```

**Poor:**
```
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

### I - Independent

Stories should be completable without depending on other stories:

**Why**: Enables flexible prioritization and parallel work

**How to achieve**:
- Minimize dependencies between stories
- If dependencies exist, sequence stories appropriately
- Consider vertical slicing (full stack per story) vs. horizontal

**Example of dependence issue:**
- Story 1: "Build database schema"
- Story 2: "Create API endpoints"
- Story 3: "Build UI"

**Better (independent slices)**:
- Story 1: "User can view their profile data"
- Story 2: "User can edit their profile name"
- Story 3: "User can upload profile photo"

### N - Negotiable

Details are open for discussion, not fixed contracts:

**Why**: Encourages collaboration and emergence of best solution

**How to achieve**:
- Focus on WHAT and WHY, not HOW
- Leave implementation details for later
- Specify constraints, not solutions

**Negotiable:**
"Display campaign performance metrics in an easy-to-scan format"

**Too prescriptive:**
"Display campaign performance in a table with exactly 5 columns: Name, Clicks, Cost, ROI, Status, using blue headers and zebra-striped rows"

### V - Valuable

Must deliver value to users or stakeholders:

**Why**: Every story should move toward vision/epic goals

**How to achieve**:
- Describe user-facing value
- Avoid purely technical stories without user impact
- If technical work is needed, frame it in terms of enabling user value

**Valuable:**
"User can reset their password via email link"

**Low value:**
"Refactor authentication module" (unless it enables something valuable)

### E - Estimable

Team can estimate size/effort:

**Why**: Enables planning and prioritization

**How to achieve**:
- Provide enough detail to understand scope
- Clarify unknowns before committing to story
- If not estimable, spike or research story may be needed

**Estimable:**
"User can filter campaigns by date range (start date, end date)"

**Not estimable:**
"Improve campaign filtering" (too vague—how much improvement?)

### S - Small

Fits within a single iteration:

**Why**: Enables frequent delivery and feedback

**How to achieve**:
- Aim for 1-5 days of work
- If larger, split into smaller stories
- Use vertical slicing to create small, valuable increments

**Right size:**
"User can export campaign data to CSV format"

**Too large:**
"User can export campaign data to any format with custom fields and scheduling"

**Split into:**
- "User can export campaign data to CSV"
- "User can select which fields to include in export"
- "User can schedule recurring exports"

### T - Testable

Clear acceptance criteria enable verification:

**Why**: Know when story is complete and working correctly

**How to achieve**:
- Define specific, observable outcomes
- Include acceptance criteria in story description
- Focus on behavior, not implementation

**Testable:**
"User can filter campaigns by date range"
- AC: Date pickers for start and end dates
- AC: Campaigns outside range are hidden
- AC: Validation prevents invalid date ranges

**Not testable:**
"System should be performant" (what does performant mean?)

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

**Task Analysis:**
- What tasks do users need to complete?
- What's the sequence of actions?
- Example: "View → Filter → Analyze → Export" for analytics epic

**Scenario Mapping:**
- What scenarios or use cases exist?
- What different paths might users take?
- Example: "First-time setup" vs. "Daily usage" vs. "Troubleshooting"

**User Type Breakdown:**
- Do different user types need different stories?
- Admin vs. end-user flows
- Power user vs. casual user needs

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
- All epic scope is covered by stories
- No gaps in user journeys
- All success criteria are addressable

### Step 4: Apply INVEST Criteria

Review each story against INVEST:

**Refine for Independence:**
- Can this story be completed without others?
- If not, can it be reframed or split?

**Check Value:**
- Does this deliver something users care about?
- Can we articulate the "so that" benefit clearly?

**Verify Size:**
- Is this 1-5 days of work?
- If larger, how can it be split?

**Add Testability:**
- What are the acceptance criteria?
- How will we verify this works?

### Step 5: Add Acceptance Criteria

For each story, define clear acceptance criteria:

**Format:**

Given [context],
When [action],
Then [expected outcome].

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

**Sequencing:**
- Which stories must come first (dependencies)?
- What's the logical build-up of functionality?

**Prioritization:**
- Which stories deliver most value?
- Which are riskiest (do early for learning)?
- Use MoSCoW framework (prioritization skill)

### Step 7: Create Story Issues in GitHub Projects

For each story, create a GitHub issue:

**Issue Title:** "[Story summary in user voice]"

**Issue Description:** Full story with acceptance criteria using template

**Custom Fields:**
- Type: Story
- Priority: [Must Have / Should Have / Could Have]
- Status: Not Started

**Labels:**
- `type:story`
- `priority:[moscow-level]`

**Parent:** Link to Epic issue as parent

All tasks for this story will be created as child issues.

## Story Splitting Techniques

When stories are too large, use these techniques:

### Workflow Steps

Split by steps in a workflow:

**Large:**
"User can manage their subscription"

**Split:**
- "User can view subscription details"
- "User can upgrade subscription plan"
- "User can cancel subscription"

### Operations (CRUD)

Split by different operations:

**Large:**
"User can manage team members"

**Split:**
- "User can invite team members"
- "User can view team member list"
- "User can remove team members"
- "User can change team member roles"

### Business Rules

Split by different rules or variations:

**Large:**
"System applies discount codes"

**Split:**
- "System applies percentage discount codes"
- "System applies fixed-amount discount codes"
- "System applies buy-one-get-one promotions"

### Happy Path vs. Variations

Start with simple case, add complexity:

**Large:**
"User can upload files"

**Split:**
- "User can upload single image file (basic case)"
- "User can upload multiple files at once"
- "User can drag and drop files to upload"
- "System validates file types and shows errors"

### Data Variations

Split by different data types or sources:

**Large:**
"System imports contact data"

**Split:**
- "System imports contacts from CSV file"
- "System imports contacts from Google Contacts"
- "System imports contacts from Outlook"

### Platforms/Interfaces

Split by different interfaces:

**Large:**
"User receives notifications"

**Split:**
- "User receives in-app notifications"
- "User receives email notifications"
- "User receives SMS notifications"

## Best Practices

### Write from User Perspective

Focus on what users see and experience:

❌ "Implement database indexes for performance"
✅ "Campaign list loads in under 2 seconds"

### Keep Stories Testable

Always include acceptance criteria:

**Minimum:**
- 2-5 acceptance criteria per story
- Specific, observable outcomes
- Testable without looking at code

### Avoid Technical Tasks as Stories

Technical work should be tasks within user-facing stories:

❌ Story: "Set up CI/CD pipeline"
✅ Story: "User can see deployment status", Tasks include CI/CD setup

### One Story, One Goal

Each story should have singular focus:

❌ "User can edit profile and change password and upload avatar"
✅ Three separate stories

### Include Non-Functional Requirements

Don't forget quality attributes:

- Performance requirements
- Security constraints
- Accessibility standards
- Usability expectations

## Common Pitfalls to Avoid

### Stories Too Large

Watch for stories that take weeks, not days:
- Split using techniques above
- Aim for 1-5 days of work
- Smaller is better than larger

### Stories Too Small

Avoid stories that are trivial or just tasks:

❌ "Add Submit button to form" (this is a task)
✅ "User can submit contact form with validation"

### Missing Acceptance Criteria

Every story needs testability:
- How do we know when it's done?
- What are the specific behaviors?
- What should we test?

### Pure Technical Stories

Frame technical work in terms of user value:

❌ "Refactor payment module"
✅ "Payment processing completes in under 3 seconds" (enables user value)

## Quick Reference: Story Creation Flow

1. **Review Epic** → Understand scope, value, success criteria
2. **Identify Journeys** → Map user flows and scenarios
3. **Draft Stories** → Cover happy paths, then edge cases
4. **Apply INVEST** → Check and refine against criteria
5. **Add Acceptance Criteria** → Define testability for each story
6. **Prioritize** → Sequence and rank by value
7. **Create Issues** → Add to GitHub Projects as children of epic
8. **Proceed** → Move to task breakdown for each story

## Additional Resources

### Reference Files

For detailed story templates:
- **`references/story-template.md`** - Complete user story template with acceptance criteria formats

## Next Steps

After creating user stories:
1. Create story issues in GitHub Projects (as children of epic issue)
2. Prioritize stories using the prioritization skill
3. Select highest-priority story and proceed to task breakdown
4. Iterate through all stories, creating tasks for each

User stories are the bridge between epics and executable work—invest time to make them clear, valuable, and testable.
