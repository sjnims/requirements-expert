---
name: re:init
description: Initialize GitHub Project with custom fields
allowed-tools: [Bash(gh:*), AskUserQuestion]
---

# Initialize Requirements Project

Initialize a GitHub Project for requirements management. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Prerequisites Validation

1. **Check GitHub CLI:**
   - Verify `gh` command exists: `command -v gh`
   - If not found: "GitHub CLI (gh) is not installed. Install it:"
     - macOS: `brew install gh`
     - Other: <https://cli.github.com/>

2. **Check Authentication:**
   - Run: `gh auth status`
   - If command fails: "Not authenticated with GitHub. Run: `gh auth login`"
   - Check output for required scopes: `repo` and `project`
   - If missing `project` scope: "Refresh authentication with: `gh auth refresh -s project`"

3. **Detect Repository:**
   - Get repository info: `gh repo view --json nameWithOwner`
   - If fails: "Not in a git repository with GitHub remote. Navigate to your project repository."
   - Parse JSON to extract nameWithOwner (format: `{"nameWithOwner":"owner/repo"}`)
   - Split nameWithOwner on "/" to get the owner (before the "/")
   - Example: "sjnims/requirements-expert" → owner="sjnims"

## Project Setup

4. **Get Project Name:**
   - Use AskUserQuestion:
     - question: "What should we name the GitHub Project for requirements tracking?"
     - header: "Project Name"
     - multiSelect: false
     - options:
       - label: "[Repository Name] Requirements"
         description: "Standard naming convention following best practices (recommended)"
       - label: "[Repository Name] Backlog"
         description: "Alternative naming for backlog-style requirements tracking"
       - label: "[Repository Name] Roadmap"
         description: "Emphasizes long-term planning and feature roadmap view"
   - If user selects "Other", use their custom input as the project name
   - Replace [Repository Name] placeholder with the repository name (the part after the "/" in `nameWithOwner` from step 3). For example, if `nameWithOwner` is "sjnims/requirements-expert", use "requirements-expert"
   - Store the user's choice for project creation

5. **Check for Existing Project (Idempotency):**
   - List existing projects: `gh project list --owner [owner] --format json`
   - Parse JSON response: `{"projects":[{"id":"...","number":4,"title":"...","url":"..."}]}`
   - Search the `projects` array for a project where `title` matches the chosen name
   - If found:
     - Inform user: "Found existing project '[title]' at [url]"
     - Extract the `number` field (the sequential integer visible in the project URL, e.g., 1, 2, 3), not the `id` field
     - Skip to step 7 (field creation)
   - If not found:
     - Proceed to create project

6. **Create GitHub Project:**
   - Create project: `gh project create --owner [owner] --title "[name]" --format json`
   - Parse JSON response to extract `number` and `url`
   - If creation fails:
     - Display the actual error message from gh CLI
     - Use AskUserQuestion for interactive recovery:
       - question: "Project creation failed. How would you like to proceed?"
       - header: "Recovery"
       - multiSelect: false
       - options:
         - label: "Retry"
           description: "Try creating the project again"
         - label: "Check permissions"
           description: "Show commands to verify and fix GitHub CLI permissions"
         - label: "Exit"
           description: "Stop and let me fix the issue manually"
     - Handle user choice:
       - If "Retry": Re-execute the project creation command (line 64). If creation fails again, present the recovery options again (allowing user to continue trying, check permissions, or exit)
       - If "Check permissions":
         - Run: `gh auth status`
         - Display the output
         - Show refresh command: `gh auth refresh -s project`
         - Explain: "Projects require 'repo' and 'project' scopes. Projects are owner-scoped (user/org), not repository-scoped."
         - After showing diagnostics, present the same recovery options again (Retry, Check permissions, or Exit)
       - If "Exit": Exit gracefully with a message that includes:
         - Summary: project creation failed
         - Troubleshooting steps: check authentication, verify scopes include 'repo' and 'project', refresh token if needed, verify permission to create projects for the owner
         - Command to retry: `/re:init`
         - Original error details from the failed command
   - If creation succeeds:
     - Inform user: "Created project: [name] at [url]"
     - Capture project `number` for subsequent commands

## Custom Fields Setup

7. **Check Existing Fields:**
   - List all existing fields once: `gh project field-list [project-number] --owner [owner] --format json`
   - If command fails:
     - Log warning: "Could not retrieve existing fields, will attempt to create all fields"
     - Set field names list to empty (this ensures subsequent steps will attempt creation)
     - Continue to step 8
   - If command succeeds:
     - Parse JSON response to extract field names
     - Store the list of existing field names for use in subsequent steps
     - Example: If response contains fields with names "Title", "Status", "Assignees", store these names
   - This single query replaces multiple redundant field-list calls

8. **Create Type Field (If Missing):**
    - Check if "Type" exists in the stored field names list from step 7
    - If exists:
      - Inform user: "Type field already exists, skipping creation"
    - If not exists:
      - Create field with all options in one command:
        ```
        gh project field-create [project-number] --owner [owner] \
          --name "Type" \
          --data-type SINGLE_SELECT \
          --single-select-options "Vision,Epic,Story,Task" \
          --format json
        ```
      - If command fails: Note the failure but continue (user can add field manually)
      - Inform user: "Created Type field with options: Vision, Epic, Story, Task"

9. **Create Priority Field (If Missing):**
    - Check if "Priority" exists in the stored field names list from step 7
    - If exists:
      - Inform user: "Priority field already exists, skipping creation"
    - If not exists:
      - Create field with all options:
        ```
        gh project field-create [project-number] --owner [owner] \
          --name "Priority" \
          --data-type SINGLE_SELECT \
          --single-select-options "Must Have,Should Have,Could Have,Won't Have" \
          --format json
        ```
      - If command fails: Note the failure but continue
      - Inform user: "Created Priority field with MoSCoW options"

10. **Create Status Field (If Missing):**
    - Check if "Status" exists in the stored field names list from step 7
    - If exists:
      - Inform user: "Status field already exists, skipping creation"
    - If not exists:
      - Create field with all options:
        ```
        gh project field-create [project-number] --owner [owner] \
          --name "Status" \
          --data-type SINGLE_SELECT \
          --single-select-options "Not Started,In Progress,Completed" \
          --format json
        ```
      - If command fails: Note the failure but continue
      - Inform user: "Created Status field with workflow states"

## Views Setup (Manual Configuration Required)

11. **Views Setup - Manual Instructions:**
    - GitHub CLI does not support view creation. Provide manual setup instructions.
    - Inform user: "Project views require manual setup in the GitHub web interface"
    - Display project URL: [project-url]

    **Manual Setup Instructions:**

    1. **Access the project**:
       - Open the project in your browser: [project-url]
       - Or navigate to: Repository → Projects → [Project Name]

    2. **Create recommended views**:

       **View 1: "By Type" (Board View)**
       - Click "+ New view" → Board
       - Name: "By Type"
       - Layout: Board
       - Group by: Type
       - Shows: All items grouped by Vision/Epic/Story/Task

       **View 2: "By Priority" (Board View)**
       - Click "+ New view" → Board
       - Name: "By Priority"
       - Layout: Board
       - Group by: Priority
       - Shows: All items grouped by Must Have/Should Have/Could Have/Won't Have

       **View 3: "Active Work" (Table View)**
       - Click "+ New view" → Table
       - Name: "Active Work"
       - Layout: Table
       - Filter: Status = "In Progress"
       - Shows: Only items currently being worked on

       **View 4: "Backlog" (Table View)**
       - Click "+ New view" → Table
       - Name: "Backlog"
       - Layout: Table
       - Filter: Status = "Not Started"
       - Shows: Work ready to be started

    3. **Set default view** (optional):
       - Click "..." menu on preferred view
       - Select "Set as default"

## Success Reporting

12. **Display Success Message:**

Display a success summary that includes:

- Confirmation that the GitHub Project was initialized successfully
- Project name and URL
- List of custom fields created (Type, Priority, Status) with their available options
- Next steps: run `/re:discover-vision` to create the product vision, then `/re:identify-epics` to identify major capabilities, and use `/re:status` anytime to see project overview

## Error Handling

- Exit gracefully on any validation failure (steps 1-3)
- Display clear, actionable error messages
- If project creation fails: Show gh error output and suggest remedies
- If field creation fails: Note which fields failed but continue
- Views require manual setup: Provide comprehensive manual instructions
