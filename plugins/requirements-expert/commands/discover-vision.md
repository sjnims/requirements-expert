---
name: re:discover-vision
description: Discover product vision and create issue
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Discover Product Vision

Guide the user through an interactive vision discovery session using the vision-discovery skill methodology. Create a vision issue in GitHub Projects with the discovered vision.

## Instructions

Load the **vision-discovery** skill to access methodology and question templates.

### Step 1: Verify GitHub Project Exists

1. Check if a GitHub Project exists for this repository:
   - Use `gh project list --owner [owner] --format json`
   - If no projects found: Suggest running `/re:init` first, then exit
   - If multiple projects: Use AskUserQuestion to ask which project to use
   - Store project number for later use

### Step 2: Check for Existing Vision

1. Search for existing vision issues:
   - Use `gh project item-list [project-number] --format json`
   - Filter for items with Type = "Vision"
   - If vision exists: Ask user if they want to update it or create new one

### Step 3: Interactive Vision Discovery

Use AskUserQuestion to guide through vision discovery. Ask questions from the vision-discovery skill:

**Problem Space Questions (First Question):**

Use AskUserQuestion:
- question: "What type of problem are you solving?"
- header: "Problem Type"
- multiSelect: false
- options:
  - label: "Efficiency problem", description: "Users spend too much time or effort on a task"
  - label: "Quality problem", description: "Current solutions produce poor or inconsistent results"
  - label: "Access problem", description: "Users cannot easily access something they need"
  - label: "Cost problem", description: "Current solutions are too expensive"

If user selects "Other", use their custom description as the problem type.

After the user selects a problem type, ask a follow-up to get specifics about the problem.

**Target Users Question:**

Use AskUserQuestion:
- question: "Who primarily experiences this problem?"
- header: "Target Users"
- multiSelect: false
- options:
  - label: "Technical users", description: "Developers, engineers, system administrators"
  - label: "Business users", description: "Product managers, analysts, executives"
  - label: "End consumers", description: "General public, customers"
  - label: "Internal team", description: "Employees within the organization"

If user selects "Other", use their custom description as the target user type.

**Current State Question:**

Use AskUserQuestion:
- question: "How do users currently address this problem?"
- header: "Current"
- multiSelect: false
- options:
  - label: "Manual workarounds", description: "Spreadsheets, documents, manual processes"
  - label: "Competitor products", description: "Existing commercial solutions"
  - label: "Internal tools", description: "Custom-built internal solutions"
  - label: "They don't", description: "Problem is currently unaddressed"

If user selects "Other", use their custom description as the current approach.

**Solution Question:**

Use AskUserQuestion:
- question: "What category best describes your solution?"
- header: "Solution"
- multiSelect: false
- options:
  - label: "Automation tool", description: "Automates manual or repetitive tasks"
  - label: "Platform/service", description: "Provides a new platform or service"
  - label: "Integration", description: "Connects existing systems or data"
  - label: "Enhancement", description: "Improves an existing product or process"

If user selects "Other", use their custom description as the solution category.

After the user selects a category, ask a follow-up to get the one-sentence solution description.

**Differentiator Question:**

Use AskUserQuestion:
- question: "What is your primary differentiator?"
- header: "Advantage"
- multiSelect: false
- options:
  - label: "Speed/Performance", description: "Faster or more efficient than alternatives"
  - label: "Simplicity", description: "Easier to use or understand"
  - label: "Cost", description: "More affordable or better value"
  - label: "Features", description: "Unique capabilities not available elsewhere"

If user selects "Other", use their custom description as the differentiator.

**Success Metrics Question:**

Use AskUserQuestion:
- question: "How will you primarily measure success?"
- header: "Metrics"
- multiSelect: false
- options:
  - label: "User adoption", description: "Number of users, signups, active usage"
  - label: "Efficiency gains", description: "Time saved, tasks completed faster"
  - label: "Revenue/Cost", description: "Revenue generated or costs reduced"
  - label: "Quality metrics", description: "Error rates, satisfaction scores"

If user selects "Other", use their custom description as the success metric.

### Step 4: Compile Vision Document

Using the answers, create a vision document. First, read the comprehensive template using the Read tool:

```
plugins/requirements-expert/skills/vision-discovery/references/vision-template.md
```

Follow that template structure when creating the vision document.

Structure the vision as:
```markdown
# Product Vision: [Inferred from solution]

## Problem Statement
[User's problem description]

**Why it matters:** [Synthesized from answers]

**Current State:** [How users currently address it]

## Target Users
[User's description of target users]

## Solution Overview
[User's one-sentence solution]

**Unique Value Proposition:**
[What makes it different/better]

## Success Metrics
[User's 2-3 key metrics]

## Scope & Boundaries
[To be defined - suggest running /re:identify-epics to define scope via epics]
```

### Step 5: Create Vision Issue

#### 5a. Create Issue in GitHub

Use `gh issue create --repo [repo] --title "Product Vision: [Product Name]" --body "[vision document]" --label "type:vision"`

**If issue creation fails:**

Capture error output from gh CLI.

Display: "Failed to create vision issue: [error message]"

Use AskUserQuestion for recovery:

- question: "Vision issue creation failed. How would you like to proceed?"
- header: "Recovery"
- multiSelect: false
- options:
  - label: "Retry"
    description: "Try creating the vision issue again"
  - label: "Check permissions"
    description: "Show diagnostic commands"
  - label: "Save draft"
    description: "Output vision document for manual creation"
  - label: "Exit"
    description: "Stop without creating"

**Handle response:**

- **Retry**: Re-attempt `gh issue create` with same content. If fails again, present recovery options again.
- **Check permissions**:
  - Run: `gh auth status`
  - Display the output
  - Explain: "Issue creation requires 'repo' scope."
  - After showing diagnostics, present the same recovery options again
- **Save draft**: Display the complete vision markdown document (the compiled vision from Step 4) so user can copy/paste to manually create an issue. Exit gracefully with a message explaining how to create the issue manually.
- **Exit**: Exit gracefully with a message that includes:
  - Summary: vision issue creation failed
  - Troubleshooting steps
  - Command to retry: `/re:discover-vision`
  - Original error details

**If issue creation succeeds:**

- Capture issue number and URL
- Inform user: "Created vision issue #[number]: [title]"

#### 5b. Add Issue to Project

Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

**If adding to project fails:**

Display: "Vision issue created (#[number]) but failed to add to project: [error message]"

Use AskUserQuestion for recovery:

- question: "Would you like to retry adding to project?"
- header: "Add to Project"
- multiSelect: false
- options:
  - label: "Retry"
    description: "Try adding issue to project again"
  - label: "Skip"
    description: "Continue without adding (can add manually later)"
  - label: "Show command"
    description: "Display command for manual execution"

**Handle response:**

- **Retry**: Re-attempt `gh project item-add`. If fails again, present recovery options again.
- **Skip**: Continue to Step 6 (the issue exists, just not in project).
- **Show command**: Display the exact command for manual execution, then continue to Step 6.

**If adding succeeds:**

- Capture project item ID for field updates

#### 5c. Set Custom Fields

Set custom fields on the project item:

- Type: Vision
- Status: Active

Use `gh project item-edit` commands to set these fields.

**If setting fields fails:**

Display warning: "Note: Could not set custom fields. Vision issue created successfully."

Show manual commands for setting fields:

```bash
gh project item-edit --id [item-id] --field-id [type-field-id] --single-select-option-id [vision-option-id] --project-id [project-id]
gh project item-edit --id [item-id] --field-id [status-field-id] --single-select-option-id [active-option-id] --project-id [project-id]
```

Continue to Step 6 (fields can be set manually in the project UI).

**If setting fields succeeds:**

- Inform user: "Set Type to 'Vision' and Status to 'Active'"

### Step 6: Success Message & Next Steps

Display a success summary that includes:

- Confirmation that the vision was created successfully
- Issue number and title with URL link
- Confirmation that the vision has been documented and added to the project

**Next steps:**

- Review the vision issue and add details
- Share with stakeholders for feedback
- Run `/re:identify-epics` to identify major capabilities
- Use `/re:review` to validate the vision

## Error Handling

- If GitHub CLI not available: Provide installation instructions
- If not authenticated: Suggest `gh auth login`
- If project doesn't exist: Suggest `/re:init`
- If issue creation fails: Use interactive recovery (Retry/Check permissions/Save draft/Exit)
- If project add fails: Use interactive recovery (Retry/Skip/Show command)
- If field setting fails: Show warning and manual command, continue to success

## Notes

- Use vision-discovery skill for methodology
- Keep questions conversational but focused
- Synthesize user answers into coherent vision document
- Vision should be concise (500-1000 words)
- Encourage iteration and refinement
- Discovery answers are preserved across retry attempts
- "Save draft" option preserves user's work even if GitHub is inaccessible
