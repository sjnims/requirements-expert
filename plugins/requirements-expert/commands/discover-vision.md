---
name: re:discover-vision
description: Guide user through interactive vision discovery and create vision issue in GitHub Projects
allowed-tools: [AskUserQuestion, Bash]
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
   - Store project ID for later use

### Step 2: Check for Existing Vision

1. Search for existing vision issues:
   - Use `gh project item-list [project-id] --format json`
   - Filter for items with Type = "Vision"
   - If vision exists: Ask user if they want to update it or create new one

### Step 3: Interactive Vision Discovery

Use AskUserQuestion to guide through vision discovery. Ask questions from the vision-discovery skill:

**Problem Space Questions (First Question):**
- Question: "What problem are you trying to solve?"
- Header: "Problem"
- Options: Let user provide custom text (multiSelect: false)

**After receiving problem answer, ask:**
- Question: "Who experiences this problem? Describe your target users."
- Header: "Users"
- Options: Custom text input

**Then ask:**
- Question: "How do they currently address this problem? What workarounds or competitors exist?"
- Header: "Current State"
- Options: Custom text input

**Then ask:**
- Question: "In one sentence, what does your solution do?"
- Header: "Solution"
- Options: Custom text input

**Then ask:**
- Question: "What makes your solution different or better than alternatives?"
- Header: "Differentiator"
- Options: Custom text input

**Finally ask:**
- Question: "How will you measure success? What are 2-3 key metrics?"
- Header: "Success Metrics"
- Options: Custom text input

### Step 4: Compile Vision Document

Using the answers, create a vision document following the template from vision-discovery skill's `${CLAUDE_PLUGIN_ROOT}/skills/vision-discovery/references/vision-template.md`.

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

1. Create issue in GitHub:
   - Use `gh issue create --repo [repo] --title "Product Vision: [Product Name]" --body "[vision document]" --label "type:vision"`
   - Capture issue number and URL

2. Add issue to project:
   - Use `gh project item-add [project-id] --owner [owner] --url [issue-url]`

3. Set custom fields:
   - Type: Vision
   - Status: Active
   - Use `gh project item-edit` commands to set these fields

### Step 6: Success Message & Next Steps

Display:
```
✅ Vision created successfully!

Issue: #[number] - Product Vision: [Product Name]
URL: [issue-url]

Your vision has been documented and added to the project.

Next Steps:
1. Review the vision issue and add any additional details
2. Share with stakeholders for feedback
3. Run `/re:identify-epics` to identify major capabilities
4. Use `/re:review` to validate the vision

Pro tip: The vision is a living document - update it as you learn more!
```

### Step 7: Offer to Continue

Use AskUserQuestion:
- Question: "Would you like to continue to identify epics now?"
- Header: "Continue"
- Options:
  - "Yes, identify epics" (description: "Continue to epic identification")
  - "No, I'll do it later" (description: "Stop here for now")
- multiSelect: false

If user selects "Yes":
- Execute `/re:identify-epics` command

## Error Handling

- If GitHub CLI not available: Provide installation instructions
- If not authenticated: Suggest `gh auth login`
- If project doesn't exist: Suggest `/re:init`
- If issue creation fails: Show error and suggest checking permissions

## Notes

- Use vision-discovery skill for methodology
- Keep questions conversational but focused
- Synthesize user answers into coherent vision document
- Vision should be concise (500-1000 words)
- Encourage iteration and refinement
