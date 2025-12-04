---
name: re:create-stories
description: Break epic into INVEST-compliant stories
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Create User Stories

Break down a selected epic into user stories following INVEST criteria and create story issues in GitHub Projects as children of the epic issue. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Instructions

Load the **user-story-creation** skill to access methodology, INVEST criteria, and templates.

### Step 1: Select Epic to Break Down

1. **List Available Epics:**
   - Use `gh project item-list [project-number] --format json`
   - Filter for Type = "Epic"
   - If no epics: Suggest running `/re:identify-epics` first, exit

2. **Present Epic Menu:**
   Use AskUserQuestion:
   - Question: "Which epic would you like to break down into user stories?"
   - Header: "Select Epic"
   - Options: One option per epic (label = epic name, description = brief desc from issue)
   - multiSelect: false

3. **Read Epic Issue:**
   - Use `gh issue view [epic-issue-number] --repo [repo] --json body,title`
   - Extract epic content for story creation

4. **Query Existing Stories Under Epic:**
   - From the project items fetched in step 1, filter for Type = "Story"
   - For each story, check if it references this epic as parent (look for "Parent: #[epic-number]" in body)
   - Store this list of existing stories for duplicate checking in Step 6

### Step 2: Story Discovery & Drafting

Using user-story-creation skill methodology:

**Analyze Epic for User Journeys:**

- What tasks do users need to complete?
- What scenarios or use cases exist?
- Do different user types need different stories?

**Draft Initial Stories:**
Suggest 5-15 user stories for the epic using standard format:

```text
As a [user type],
I want [goal],
So that [benefit].
```

Present the suggested user stories organized by category (Core Functionality, Supporting Features, Edge Cases & Enhancements):

- List each story in the standard "As a [user], I want [goal], so that [benefit]" format
- Number the stories for easy reference
- Include a note that these cover the main user journeys and ask if the user would like to add, remove, or modify any

### Step 3: Story Refinement

Use AskUserQuestion:

- Question: "Which stories should we include?"
- Header: "Stories"
- Options: One per suggested story (label = short title, description = full story)
- multiSelect: true

Then ask:

Use AskUserQuestion:

- question: "Would you like to add any additional stories?"
- header: "Add Stories"
- multiSelect: false
- options:
  - label: "Add more", description: "I have additional user stories to include"
  - label: "Continue", description: "Proceed with the selected stories"
  - label: "Review selection", description: "Review the list before deciding"

If user selects "Other", use their custom description for additional stories.

If user selects "Add more", prompt for story details. If "Review selection", display the current selection and ask again.

### Step 4: INVEST Criteria Check

For each selected story, verify INVEST criteria:

- **Independent**: Can be completed separately
- **Negotiable**: Details open for discussion
- **Valuable**: Delivers user value
- **Estimable**: Team can estimate size
- **Small**: Fits in 1-5 days
- **Testable**: Has clear acceptance criteria

If story fails INVEST, suggest refinements:

- Too large? Suggest splitting
- Not valuable? Suggest reframing or removing
- Not testable? Suggest adding acceptance criteria

### Step 5: Add Acceptance Criteria

For each story, define acceptance criteria. Use format from user-story-creation skill:

**Given-When-Then format:**

```text
- Given [context]
  When [action]
  Then [outcome]
```

**Or checklist format:**

```text
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3
```

For each story, present suggested acceptance criteria and ask user to confirm/refine.

### Step 6: Create Story Issues

Initialize batch tracking lists:

- `created`: Stories successfully created (with issue numbers)
- `skipped`: Stories skipped due to duplicates (with existing issue numbers)
- `updated`: Existing stories that were updated (with issue numbers)
- `failed`: Stories that failed to create (with error reasons)

For each finalized story:

#### 6a. Check for Existing Story (Idempotency)

Before creating, check if story already exists under this epic:

1. **Check for Title Match:**
   - Compare new story title against existing story titles (from Step 1.4)
   - Trim leading/trailing whitespace before comparison
   - Use case-insensitive comparison

2. **If Match Found:**

   Use AskUserQuestion:

   - question: "Story '[story-title]' appears to already exist as #[existing-issue-number]. What would you like to do?"
   - header: "Duplicate"
   - multiSelect: false
   - options:
     - label: "Skip"
       description: "Don't create this story, continue with next"
     - label: "Update"
       description: "Update existing story with new acceptance criteria"
     - label: "Create anyway"
       description: "Create as new story (will be duplicate)"

   **Handle response:**

   - **Skip**: Add to `skipped` list with existing issue number, continue to next story
   - **Update**: Use `gh issue edit [existing-issue-number] --repo [repo] --body "[updated-description]"` to replace with new content including acceptance criteria, add to `updated` list, continue to next story
   - **Create anyway**: Proceed with creation (user acknowledged duplicate)

3. **If No Match:**
   - Proceed with creation

#### 6b. Compile Story Description

Read the comprehensive template using the Read tool:

```text
plugins/requirements-expert/skills/user-story-creation/references/story-template.md
```

Follow that template structure:

```markdown
## User Story: [Short title]

### Story
As a [user type],
I want [goal],
So that [benefit].

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Notes
[Any assumptions or constraints]

**Parent:** [Link to Epic Issue #]
```

#### 6c. Create Issue

Use `gh issue create --repo [repo] --title "[Story short title]" --body "[story description]" --label "type:story"`

**If Creation Fails:**

Capture error output from gh CLI.

Display: "Failed to create story '[story-title]': [error message]"

Use AskUserQuestion for recovery:

- question: "Story creation failed. How would you like to proceed?"
- header: "Recovery"
- multiSelect: false
- options:
  - label: "Retry"
    description: "Try creating this story again"
  - label: "Skip"
    description: "Skip this story, continue with remaining"
  - label: "Check permissions"
    description: "Show diagnostic commands"
  - label: "Stop"
    description: "Stop and show summary of progress"

**Handle response:**

- **Retry**: Re-attempt creation. If fails again, present recovery options again.
- **Skip**: Add to `failed` list with error reason, continue to next story.
- **Check permissions**:
  - Run: `gh auth status`
  - Display the output
  - Explain: "Issue creation requires 'repo' scope."
  - After showing diagnostics, present the same recovery options again
- **Stop**: Exit loop and proceed to Step 9 (show summary with progress so far)

**If Creation Succeeds:**

- Capture issue number and URL
- Add to `created` list

#### 6d. Add to Project

Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

#### 6e. Set Custom Fields

- Type: Story
- Status: Not Started
- Priority: (Inherit from epic or set during prioritization)

#### 6f. Link to Epic (Parent)

- Add comment to story: "Parent: #[epic-issue-number]"

### Step 7: Story Count Validation

Check total number of stories:

- If < 3: Might be too few, epic might be too small
- If > 20: Might be too many, epic might be too large
- Ideal range: 5-15 stories per epic

### Step 8: Continue or Done

After creating all stories for current epic, ask:

Use AskUserQuestion:

- Question: "Create stories for another epic?"
- Header: "Continue"
- Options:
  - "Select another epic" (description: "Create stories for a different epic")
  - "Done" (description: "Finish story creation")
- multiSelect: false

**Handle response:**

- "Select another epic": Restart from Step 1
- "Done": Show success message

### Step 9: Success Message

After processing all stories, display a batch summary:

**Story creation complete for Epic #[epic-num]!**

**Created:** [N] new stories

- #[num] - [Story 1 title]
- #[num] - [Story 2 title]

**Updated:** [N] existing stories (only if > 0)

- #[num] - [Story title]

**Skipped (duplicates):** [N] stories (only if > 0)

- [Story title] (existing #[num])

**Failed:** [N] stories (only if > 0)

- [Story title]: [error reason]

All stories linked to Epic (#[epic-num])

**Next steps:**

- Run `/re:prioritize` to rank stories by importance
- Run `/re:create-tasks` to break down highest-priority story into tasks
- Review stories and refine acceptance criteria
- Use `/re:status` to see project progress

## Error Handling

- If no epics exist: Guide to `/re:identify-epics`
- If epic has no content: Suggest updating epic issue first
- If duplicate story detected: Use interactive prompt (Skip/Update/Create anyway)
- If story creation fails: Use interactive recovery (Retry/Skip/Check permissions/Stop)
- If story violates INVEST: Provide refinement suggestions
- If too many/few stories: Guidance on right-sizing

## Notes

- This command is idempotent: safe to run multiple times
- Use user-story-creation skill for INVEST criteria and methodology
- Each story follows standard "As a... I want... So that..." format
- Minimum 3-5 acceptance criteria per story
- Stories should be 1-5 days of work
- Split large stories using techniques from skill
- Ensure every story delivers user value
