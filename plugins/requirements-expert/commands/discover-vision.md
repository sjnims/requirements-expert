---
name: re:discover-vision
description: Guide user through interactive vision discovery and create vision issue in GitHub Projects
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

Note: Users can select "Other" to describe a different problem type.

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

Note: Users can select "Other" to describe different user types.

**Current State Question:**

Use AskUserQuestion:
- question: "How do users currently address this problem?"
- header: "Current State"
- multiSelect: false
- options:
  - label: "Manual workarounds", description: "Spreadsheets, documents, manual processes"
  - label: "Competitor products", description: "Existing commercial solutions"
  - label: "Internal tools", description: "Custom-built internal solutions"
  - label: "They don't", description: "Problem is currently unaddressed"

Note: Users can select "Other" to describe different current approaches.

**Solution Question:**

Use AskUserQuestion:
- question: "What category best describes your solution?"
- header: "Solution Type"
- multiSelect: false
- options:
  - label: "Automation tool", description: "Automates manual or repetitive tasks"
  - label: "Platform/service", description: "Provides a new platform or service"
  - label: "Integration", description: "Connects existing systems or data"
  - label: "Enhancement", description: "Improves an existing product or process"

Note: Users can select "Other" to describe a different solution category.

After the user selects a category, ask a follow-up to get the one-sentence solution description.

**Differentiator Question:**

Use AskUserQuestion:
- question: "What is your primary differentiator?"
- header: "Differentiator"
- multiSelect: false
- options:
  - label: "Speed/Performance", description: "Faster or more efficient than alternatives"
  - label: "Simplicity", description: "Easier to use or understand"
  - label: "Cost", description: "More affordable or better value"
  - label: "Features", description: "Unique capabilities not available elsewhere"

Note: Users can select "Other" to describe a different differentiator.

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

Note: Users can select "Other" to describe different success metrics.

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

1. Create issue in GitHub:
   - Use `gh issue create --repo [repo] --title "Product Vision: [Product Name]" --body "[vision document]" --label "type:vision"`
   - Capture issue number and URL

2. Add issue to project:
   - Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

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
