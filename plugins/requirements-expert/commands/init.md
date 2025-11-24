---
name: re:init
description: Initialize a GitHub Project for requirements management with custom fields and views
allowed-tools: [Bash, AskUserQuestion]
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
   - Note: Output could show "Token scopes: 'gist', 'project', 'read:org', 'repo', 'workflow'" format

3. **Detect Repository:**
   - Get repository info: `gh repo view --json nameWithOwner`
   - If fails: "Not in a git repository with GitHub remote. Navigate to your project repository."
   - Parse JSON to extract nameWithOwner (format: `{"nameWithOwner":"owner/repo"}`)
   - Split nameWithOwner on "/" to get owner and repo separately
   - Example: "sjnims/requirements-expert" → owner="sjnims", repo="requirements-expert"

## Project Setup

4. **Get Project Name:**
   - Use AskUserQuestion to ask: "What should we name the GitHub Project for requirements tracking?"
   - Suggest default: "[Repository Name] Requirements"
   - Example: "requirements-expert Requirements"
   - Store the user's choice

5. **Check for Existing Project (Idempotency):**
   - List existing projects: `gh project list --owner [owner] --format json`
   - Parse JSON response: `{"projects":[{"id":"...","number":4,"title":"...","url":"..."}]}`
   - Search the `projects` array for a project where `title` matches the chosen name
   - If found:
     - Inform user: "Found existing project '[title]' at [url]"
     - Capture project `number` (not `id`) for subsequent commands
     - Note: Project number is the sequential number (1, 2, 3...) visible in the URL
     - Skip to step 7 (field creation)
   - If not found:
     - Proceed to create project

6. **Create GitHub Project:**
   - Create project: `gh project create --owner [owner] --title "[name]" --format json`
   - Parse JSON response to extract `number` and `url`
   - If creation fails:
     - Display error message
     - Suggest: "Verify token permissions include 'repo' and 'project' scopes"
     - Note: Projects are owner-scoped (user/org), not repository-scoped
   - Inform user: "Created project: [name] at [url]"
   - Capture project `number` for subsequent commands

## Custom Fields Setup

7. **Create Type Field (Idempotent):**
   - List existing fields: `gh project field-list [project-number] --owner [owner] --format json`
   - Parse JSON to check if a field with `name` = "Type" exists
   - If exists:
     - Inform user: "Type field already exists, skipping creation"
     - Continue to next field
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

8. **Create Priority Field (Idempotent):**
   - List existing fields: `gh project field-list [project-number] --owner [owner] --format json`
   - Check if "Priority" field exists
   - If not exists:
     - Create field with all options:
       ```
       gh project field-create [project-number] --owner [owner] \
         --name "Priority" \
         --data-type SINGLE_SELECT \
         --single-select-options "Must Have,Should Have,Could Have,Won't Have" \
         --format json
       ```
   - Inform user: "Created Priority field with MoSCoW options"

9. **Create Status Field (Idempotent):**
   - List existing fields: `gh project field-list [project-number] --owner [owner] --format json`
   - Check if "Status" field exists
   - If not exists:
     - Create field with all options:
       ```
       gh project field-create [project-number] --owner [owner] \
         --name "Status" \
         --data-type SINGLE_SELECT \
         --single-select-options "Not Started,In Progress,Completed" \
         --format json
       ```
   - Inform user: "Created Status field with workflow states"

## Views Setup (Best Effort)

10. **Create Project Views:**
    - Note: View creation with grouping/filtering is not well-supported by gh CLI
    - Attempt basic view creation (names only):
      - Try: `gh project view-create [project-number] --owner [owner] --name "By Type"`
      - Try: `gh project view-create [project-number] --owner [owner] --name "By Priority"`
      - Try: `gh project view-create [project-number] --owner [owner] --name "Active Work"`
    - If commands fail:
      - Inform user: "View creation requires manual setup in GitHub web interface"
      - Provide project URL for manual configuration
      - Suggest views to create manually:
        - "By Type" - group by Type field
        - "By Priority" - group by Priority field
        - "Active Work" - filter Status = "In Progress"
    - Note: Grouping and filtering must be configured via web interface after creation

## Success Reporting

11. **Display Success Message:**
    ```
    ✅ GitHub Project initialized successfully!

    Project: [Project Name]
    URL: [Project URL]

    Custom Fields Created:
    - Type (Vision, Epic, Story, Task)
    - Priority (Must Have, Should Have, Could Have, Won't Have)
    - Status (Not Started, In Progress, Completed)

    Next Steps:
    1. Run `/re:discover-vision` to create your product vision
    2. Then `/re:identify-epics` to identify major capabilities
    3. Use `/re:status` anytime to see project overview
    ```

## Error Handling

- Exit gracefully on any validation failure (steps 1-3)
- Display clear, actionable error messages
- If project creation fails: Show gh error output and suggest remedies
- If field creation fails: Note which fields failed but continue
- If view creation fails: Provide manual instructions

## Implementation Notes

**Key Architectural Points:**

- **Projects are owner-scoped, not repository-scoped**: Use `--owner [owner]` not `--repo`
- **Use project number, not project ID**: Commands expect the sequential number (1, 2, 3...) visible in URLs, not the GraphQL ID (PVT_xxx)
- **Field creation supports comma-separated options**: Use `--single-select-options "option1,option2,option3"` to create field and options in one command
- **Idempotency is critical**: Always check for existing resources before creating

**Command Execution:**

- All operations should be non-interactive (use `--format json` where available)
- Parse JSON output using `jq` or similar tools
- Use `--owner [owner]` for all project and field commands
- Project number is extracted from JSON response during creation or listing

**Error Handling:**

- Exit gracefully on validation failures (steps 1-3)
- Continue on non-critical failures (field/view creation)
- Provide clear, actionable error messages
- Include fallback manual instructions when CLI lacks functionality

**Testing Notes:**

- Verified with gh CLI version 2.x on macOS
- Commands tested: `gh project list`, `gh project create`, `gh project field-list`, `gh project field-create`
- View creation may not fully support grouping/filtering via CLI
