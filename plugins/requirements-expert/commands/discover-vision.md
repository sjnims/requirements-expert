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

Check if a GitHub Project exists for this repository:

- Use `gh project list --owner [owner] --format json`
- If no projects found: Suggest running `/re:init` first, then exit
- If multiple projects: Ask Select Project: "Which project to use?" (options: one per project)
- Store project number for later use

### Step 2: Check for Existing Vision

Apply idempotency check from shared-patterns skill:

1. Search for existing vision issues:
   - Use `gh issue list --repo [repo] --label "type:vision" --json number,title`
   - If match found: Ask Existing Vision: "Found existing vision. How to proceed?" (options: Skip, Update, Create anyway)
   - Track decision in appropriate list (skipped/updated/created)

### Step 3: Interactive Vision Discovery

Ask each discovery topic from vision-discovery skill:

1. Ask Problem Type: "What type of problem are you solving?" (options: Efficiency, Quality, Access, Cost)
2. Ask Target Users: "Who experiences this problem?" (options: Technical, Business, Consumers, Internal)
3. Ask Current State: "How do users currently address it?" (options: Manual, Competitors, Internal, Don't)
4. Ask Solution Category: "What kind of solution?" (options: Automation, Platform, Integration, Enhancement)
5. Ask Differentiator: "Primary advantage?" (options: Speed, Simplicity, Cost, Features)
6. Ask Success Metrics: "How to measure success?" (options: Adoption, Efficiency, Revenue, Quality)

For each: capture "Other" as custom input. Ask follow-up for specifics on Problem (1) and Solution (4).

### Step 4: Compile Vision Document

Read the template structure from:

```
plugins/requirements-expert/skills/vision-discovery/references/vision-template.md
```

Follow that template to create the vision document using the discovery answers.

### Step 5: Create Vision Issue

#### 5a. Create Issue in GitHub

Use `gh issue create --repo [repo] --title "Product Vision: [Product Name]" --body "[vision document]" --label "type:vision"`

On failure: Apply standard recovery flow from shared-patterns skill (Retry/Check permissions/Save draft/Exit).

On success: Capture issue number and URL. Inform user: "Created vision issue #[number]: [title]"

#### 5b. Add Issue to Project

Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

On failure: Apply standard recovery flow from shared-patterns skill (Retry/Skip/Show command).

On success: Capture project item ID for field updates.

#### 5c. Set Custom Fields

Apply two-layer metadata update from shared-patterns skill:

- Custom field: Type = "Vision", Status = "Active"
- Label: Already set in 5a (`type:vision`)

Use `gh project item-edit` to set custom fields.

On failure: Show warning and manual commands, continue to Step 6 (fields can be set manually in project UI).

On success: Inform user: "Set Type to 'Vision' and Status to 'Active'"

### Step 6: Success Message & Next Steps

Display success summary:

- Confirmation: vision created successfully
- Issue: #[number] - [title] ([URL])
- Status: Vision documented and added to project

**Next steps:**

- Review the vision issue and add details
- Share with stakeholders for feedback
- Run `/re:identify-epics` to identify major capabilities
- Use `/re:review` to validate the vision
