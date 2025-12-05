---
name: re:init
description: Initialize GitHub Project with custom fields
allowed-tools: [Bash(gh:*), AskUserQuestion]
---

# Initialize Requirements Project

Initialize a GitHub Project for requirements management. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Instructions

### Step 1: Check GitHub CLI

Verify `gh` command exists: `command -v gh`

If not found: "GitHub CLI (gh) is not installed. Install it: `brew install gh` (macOS) or <https://cli.github.com/>"

### Step 2: Check Authentication

Run: `gh auth status`

If command fails: "Not authenticated with GitHub. Run: `gh auth login`"

Check output for required scopes: `repo` and `project`

If missing `project` scope: "Refresh authentication with: `gh auth refresh -s project`"

### Step 3: Detect Repository

Run `gh repo view --json nameWithOwner`. Extract owner from nameWithOwner. If fails: exit with guidance to navigate to git repo.

### Step 4: Get Project Name

Use AskUserQuestion with header "Project Name", question "What should we name the GitHub Project for requirements tracking?", options:

- "[Repository Name] Requirements" (recommended)
- "[Repository Name] Backlog" (alternative)
- "[Repository Name] Roadmap" (emphasizes planning)

Replace [Repository Name] with actual repository name from nameWithOwner. Store user's choice.

### Step 5: Check for Existing Project

Run `gh project list --owner [owner] --format json`. Search for project with matching title.

If found: inform user "Found existing project '[title]' at [url]", extract `number` field, skip to step 7.

If not found: proceed to create project.

### Step 6: Create GitHub Project

Run `gh project create --owner [owner] --title "[name]" --format json`. Extract `number` and `url`.

If creation fails: Apply Standard Recovery Flow from shared-patterns skill with 3 options (Retry, Check permissions, Exit). For "Check permissions" option, run `gh auth status` and show refresh command: `gh auth refresh -s project`.

If succeeds: inform user "Created project: [name] at [url]".

### Step 7: Check Existing Fields

Run `gh project field-list [project-number] --owner [owner] --format json` once. Extract and store existing field names.

If command fails: log warning "Could not retrieve existing fields, will attempt to create all fields" and set field names list to empty.

### Step 8: Create Custom Fields

For each field (Type, Priority, Status):

Check if field name exists in stored field names from step 7.

If exists: inform user "[Field] field already exists, skipping creation".

If not exists: create field with single command:

**Type field:**

```bash
gh project field-create [project-number] --owner [owner] \
  --name "Type" \
  --data-type SINGLE_SELECT \
  --single-select-options "Vision,Epic,Story,Task" \
  --format json
```

**Priority field:**

```bash
gh project field-create [project-number] --owner [owner] \
  --name "Priority" \
  --data-type SINGLE_SELECT \
  --single-select-options "Must Have,Should Have,Could Have,Won't Have" \
  --format json
```

**Status field:**

```bash
gh project field-create [project-number] --owner [owner] \
  --name "Status" \
  --data-type SINGLE_SELECT \
  --single-select-options "Not Started,In Progress,Completed" \
  --format json
```

If creation fails: note failure but continue (user can add manually).

### Step 9: Provide Views Setup Instructions

Inform user: "Project views require manual setup in the GitHub web interface at [project-url]. See GitHub's [project views documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects/customizing-views-in-your-project) for instructions."

Recommend creating views: "By Type" (board), "By Priority" (board), "Active Work" (table, Status=In Progress), "Backlog" (table, Status=Not Started).

### Step 10: Display Success Message

Display summary:

- Confirmation: GitHub Project initialized successfully
- Project name and URL
- Custom fields created: Type (Vision/Epic/Story/Task), Priority (MoSCoW), Status (Not Started/In Progress/Completed)
- Next steps: run `/re:discover-vision` to create product vision, then `/re:identify-epics` to identify major capabilities, use `/re:status` anytime for project overview

## Error Handling

- Exit gracefully on validation failures (steps 1-3)
- Display clear, actionable error messages
- If project creation fails: apply Standard Recovery Flow
- If field creation fails: note which fields failed but continue
- Views require manual setup: provide link to documentation

## Notes

- This command is idempotent: safe to run multiple times
- Projects are owner-scoped, not repository-scoped
- Custom fields use SINGLE_SELECT type for consistent categorization
- Views must be created manually in the GitHub web interface
