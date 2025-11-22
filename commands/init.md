---
name: init
description: Initialize a GitHub Project for requirements management with custom fields and views
allowed-tools: [Bash, AskUserQuestion]
---

# Initialize Requirements Project

Initialize a new GitHub Project for requirements management. This command creates the project structure, custom fields, and views needed for the full requirements lifecycle (Vision → Epics → Stories → Tasks).

## Instructions

1. **Detect Repository:**
   - Use `gh repo view --json nameWithOwner` to get the current repository
   - If not in a git repository, inform the user and exit gracefully
   - Extract owner and repo name from the result

2. **Get Project Name:**
   - Use AskUserQuestion to ask the user for a project name
   - Suggest default: "[Repository Name] Requirements"
   - Ask: "What should we name the GitHub Project for requirements tracking?"

3. **Create GitHub Project:**
   - Use `gh project create --owner [owner] --title "[Project Name]" --format json`
   - Capture the project ID and URL from the JSON response
   - Inform user: "Created project: [Project Name] at [URL]"

4. **Add Custom Fields:**
   Create the following custom fields using `gh project field-create`:

   **Type Field (Single Select):**
   - Name: "Type"
   - Options: "Vision", "Epic", "Story", "Task"
   - Command: `gh project field-create [project-id] --owner [owner] --data-type SINGLE_SELECT --name "Type"`
   - Then add options with `gh project field-create [project-id] --owner [owner] --single-select-option "[option]"`

   **Priority Field (Single Select):**
   - Name: "Priority"
   - Options: "Must Have", "Should Have", "Could Have", "Won't Have"

   **Status Field (Single Select):**
   - Name: "Status"
   - Options: "Not Started", "In Progress", "Completed"

5. **Create Project Views:**
   Use `gh project view-create` to create helpful views:

   - **By Type:** Group by Type field
   - **By Priority:** Group by Priority field
   - **Active Work:** Filter for Status = "In Progress"

6. **Success Message:**
   Display:
   ```
   ✅ GitHub Project initialized successfully!

   Project: [Project Name]
   URL: [Project URL]

   Custom Fields Created:
   - Type (Vision, Epic, Story, Task)
   - Priority (Must Have, Should Have, Could Have, Won't Have)
   - Status (Not Started, In Progress, Completed)

   Next Steps:
   1. Run `/requirements:discover-vision` to create your product vision
   2. Then `/requirements:identify-epics` to identify major capabilities
   3. Use `/requirements:status` anytime to see project overview
   ```

7. **Error Handling:**
   - If `gh` CLI not found: "GitHub CLI (gh) is not installed. Install it with: brew install gh"
   - If not authenticated: "Not authenticated with GitHub. Run: gh auth login"
   - If project creation fails: Show error and suggest checking permissions

## Notes

- Requires GitHub CLI (`gh`) installed and authenticated
- Requires repository with Projects enabled
- Requires `repo` and `project` permissions
- Project will be created at the repository level (not organization level)
