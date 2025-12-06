---
name: re:status
description: Show requirements project status and health
allowed-tools: [AskUserQuestion, Bash(gh:*), Read, Write]
---

# Requirements Project Status

Display a comprehensive overview of the requirements project including counts, progress, priorities, validation status, and recent activity.

## Instructions

### Step 1: Gather Project Data

Query the project and retrieve all items:

```bash
gh project list --owner [owner] --format json
gh project item-list [project-number] --format json --limit 500
gh issue list --repo [repo] --label type:epic,type:story,type:task --limit 10 --json number,title,updatedAt,state
```

Categorize items by Type custom field (Vision, Epic, Story, Task) and extract Status and Priority fields.

### Step 2: Calculate Metrics

Calculate for display:

- Counts by type (Vision, Epic, Story, Task)
- Progress by status (Not Started, In Progress, Completed) with percentages
- Priority distribution (Must Have, Should Have, Could Have, Won't Have) with percentages
- Completion rates per level (Epics, Stories, Tasks)
- Recent activity (items completed/created in last 7 days)

### Step 3: Generate Status Dashboard

Generate a dashboard with these sections:

- **Header**: Project name, URL, timestamp
- **Overview**: Counts by level with status breakdown, overall completion percentage
- **Priority Breakdown**: Counts and status per priority level
- **Current Focus**: In-progress items and next highest-priority items
- **Epic Status**: Per-epic progress with story/task completion
- **Validation Status**: Quick health check (vision exists, traceability, priority balance), pointer to `/re:review` if issues found
- **Velocity**: Recent completions, last 10 updated items
- **Coverage**: Parent-child relationship gaps
- **Recommendations**: Context-appropriate next actions
- **Quick Links**: Project URL and filter links

### Step 4: Provide Context-Aware Guidance

Based on project state, provide tailored next steps:

| State | Guidance |
|-------|----------|
| No vision | Guide to `/re:discover-vision`, explain full workflow |
| Vision only | Guide to `/re:identify-epics` (aim for 5-12 epics) |
| Few stories | Focus highest-priority epic, guide to `/re:create-stories` |
| Well underway | Complete in-progress items, suggest `/re:review` for quality |
| Near complete | Celebrate progress, show remaining counts |

### Step 5: Export Option

Ask Export: "Would you like to export this report?" (options: Markdown file, Vision comment, Both, Skip)

Handle: Markdown file saves as `status-report-[date].md`, Vision comment uses `gh issue comment`.

## Error Handling

- No project exists: Guide to `/re:init`
- Project empty: Guide to `/re:discover-vision`
- API failure: Show partial data with warning

## Notes

- No prerequisites - can be run anytime
- Provides complete project snapshot with context-aware recommendations
- Run regularly (daily/weekly) to track progress
