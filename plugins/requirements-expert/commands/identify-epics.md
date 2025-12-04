---
name: re:identify-epics
description: Identify epics from vision, create issues
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Identify Epics

Identify major capabilities (epics) from the product vision and create epic issues in GitHub Projects as children of the vision issue. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Instructions

Load the **epic-identification** skill to access methodology and templates.

### Step 1: Verify Prerequisites

1. **Check for Vision:**
   - Use `gh project item-list [project-number] --format json` to list items
   - Filter for Type = "Vision"
   - If no vision found: Inform user they need to run `/re:discover-vision` first, then exit
   - Store vision issue number/URL for parent linking

2. **Read Vision Issue:**
   - Use `gh issue view [vision-issue-number] --repo [repo] --json body`
   - Extract vision content to use for epic identification

### Step 2: Automated Epic Suggestion

Analyze the vision and suggest potential epics using epic-identification skill methodology:

**Use these discovery techniques:**
- User Journey Mapping: What end-to-end journeys do users take?
- Capability Decomposition: What major capabilities are needed?
- Stakeholder Needs: What do different user types need?
- Technical Enablers: What infrastructure is required?

**Suggest 5-10 potential epics based on the vision:**
- Present as a numbered list
- Brief description (1-2 sentences) for each
- Categorize (User-Facing, Infrastructure, Integration, etc.)

Present the suggested epics organized by category (User-Facing Capabilities, Infrastructure, Integration, etc.):

- List each epic with a brief 1-2 sentence description
- Number the epics for easy reference
- Include a note that these are suggestions and can be accepted, modified, or supplemented with user's own ideas

### Step 3: Epic Selection & Refinement

Use AskUserQuestion to refine the epic list:

**Question 1:**
- Question: "Which of these suggested epics should we include? (Select all that apply)"
- Header: "Epics"
- multiSelect: true
- Options: One option per suggested epic (label = epic name, description = brief desc)

**Question 2:**

Use AskUserQuestion:
- question: "Would you like to add any additional epics?"
- header: "Add Epics"
- multiSelect: false
- options:
  - label: "Add more", description: "I have additional epics to include"
  - label: "Continue", description: "Proceed with the selected epics"
  - label: "Review selection", description: "Review the list before deciding"

If user selects "Other", use their custom description for additional epics.

If user selects "Add more", prompt for epic details. If "Review selection", display the current selection and ask again.

### Step 4: Validate Epic Count

Check the total number of epics:
- If < 5: Suggest this might be too few, ask if more decomposition needed
- If > 15: Suggest this might be too many, ask if some can be combined
- Ideal range: 5-12 epics

### Step 5: Create Epic Issues

Initialize batch tracking lists:

- `created`: Epics successfully created (with issue numbers)
- `skipped`: Epics skipped due to duplicates (with existing issue numbers)
- `updated`: Existing epics that were updated (with issue numbers)
- `failed`: Epics that failed to create (with error reasons)

For each selected/added epic:

#### 5a. Check for Existing Epic (Idempotency)

Before creating, check if epic already exists:

1. **Query Existing Epics:**
   - Use the project items already fetched in Step 1
   - Filter for Type = "Epic"

2. **Check for Title Match:**
   - Compare new epic title against existing epic titles
   - Trim leading/trailing whitespace before comparison
   - Use case-insensitive comparison (e.g., "User Authentication" matches "user authentication")

3. **If Match Found:**

   Use AskUserQuestion:

   - question: "Epic '[epic-name]' appears to already exist as #[existing-issue-number]. What would you like to do?"
   - header: "Duplicate"
   - multiSelect: false
   - options:
     - label: "Skip"
       description: "Don't create this epic, continue with next"
     - label: "Update"
       description: "Update existing epic with new content"
     - label: "Create anyway"
       description: "Create as new epic (will be duplicate)"

   **Handle response:**

   - **Skip**: Add to `skipped` list with existing issue number, continue to next epic
   - **Update**: Use `gh issue edit [existing-issue-number] --repo [repo] --body "[new-description]"`, add to `updated` list, continue to next epic
   - **Create anyway**: Proceed with creation (user acknowledged duplicate)

4. **If No Match:**
   - Proceed with creation

#### 5b. Compile Epic Description

Read the comprehensive template using the Read tool:

```
plugins/requirements-expert/skills/epic-identification/references/epic-template.md
```

Follow that template structure:

```markdown
## Epic: [Epic Name]

### Overview
[Brief description of what this epic delivers]

### User Value
[Who benefits and how]

### Scope
**Included:**
- [Capability 1]
- [Capability 2]

**Excluded:**
- [Not included 1]

### Success Criteria
- [Criterion 1]
- [Criterion 2]

### Dependencies
[None identified yet - will be defined during story creation]

**Parent:** [Link to Vision Issue #]
```

#### 5c. Create Issue

Use `gh issue create --repo [repo] --title "[Epic Name]" --body "[epic description]" --label "type:epic"`

**If Creation Fails:**

Capture error output from gh CLI.

Display: "Failed to create epic '[epic-name]': [error message]"

Use AskUserQuestion for recovery:

- question: "Epic creation failed. How would you like to proceed?"
- header: "Recovery"
- multiSelect: false
- options:
  - label: "Retry"
    description: "Try creating this epic again"
  - label: "Skip"
    description: "Skip this epic, continue with remaining"
  - label: "Check permissions"
    description: "Show diagnostic commands"
  - label: "Stop"
    description: "Stop and show summary of progress"

**Handle response:**

- **Retry**: Re-attempt creation. If fails again, present recovery options again.
- **Skip**: Add to `failed` list with error reason, continue to next epic.
- **Check permissions**:
  - Run: `gh auth status`
  - Display the output
  - Explain: "Issue creation requires 'repo' scope."
  - After showing diagnostics, present the same recovery options again
- **Stop**: Exit loop and proceed to Step 7 (show summary with progress so far)

**If Creation Succeeds:**

- Capture issue number and URL
- Add to `created` list

#### 5d. Add to Project

Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

#### 5e. Set Custom Fields

- Type: Epic
- Status: Not Started
- Priority: (Will be set in prioritization step)

#### 5f. Link to Vision (Parent)

- Add comment to epic issue: "Parent: #[vision-issue-number]"
- Use GitHub's task list syntax in vision issue to track epics

### Step 6: Initial Prioritization Prompt

After processing all epics, display a batch summary:

**Epic identification complete!**

**Created:** [N] new epics

- #[num] - [Epic 1 name]
- #[num] - [Epic 2 name]

**Updated:** [N] existing epics (only if > 0)

- #[num] - [Epic name]

**Skipped (duplicates):** [N] epics (only if > 0)

- [Epic name] (existing #[num])

**Failed:** [N] epics (only if > 0)

- [Epic name]: [error reason]

All epics linked to Vision (#[vision-num])

Then ask about prioritization:

Use AskUserQuestion:

- Question: "Prioritize epics now?"
- Header: "Prioritize"
- Options:
  - "Prioritize now" (description: "Use MoSCoW framework to prioritize")
  - "Skip" (description: "Skip prioritization for now")
- multiSelect: false

If "Prioritize now": Use the SlashCommand tool to invoke `/re:prioritize`

If "Skip": Show next steps

### Step 7: Success Message & Next Steps

Display a success summary that includes:

- Confirmation that epic identification is complete
- Total epics processed with breakdown: [N] created, [N] skipped, [N] updated, [N] failed
- Reference to the parent vision issue
- Next steps: run `/re:prioritize` to rank epics by importance, review epic issues and add details as needed, run `/re:create-stories` to break down highest-priority epic, use `/re:status` to see project overview

## Error Handling

- If no vision exists: Guide to `/re:discover-vision`
- If vision is incomplete: Suggest reviewing and updating it first
- If duplicate epic detected: Use interactive prompt (Skip/Update/Create anyway)
- If issue creation fails: Use interactive recovery (Retry/Skip/Check permissions/Stop)
- If too many/few epics: Provide guidance on right-sizing

## Notes

- This command is idempotent: safe to run multiple times
- Use epic-identification skill for methodology
- Aim for 5-12 epics (sweet spot)
- Each epic is a separate GitHub issue
- Each epic links to vision as parent
- Epics should be distinct and non-overlapping
- Use common epic patterns (User-Facing, Infrastructure, Integration, Data)
