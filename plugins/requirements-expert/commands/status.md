---
name: re:status
description: Show requirements project status and health
allowed-tools: [AskUserQuestion, Bash(gh:*), Read, Write]
---

# Requirements Project Status

Display a comprehensive overview of the requirements project including counts, progress, priorities, validation status, and recent activity.

## Instructions

### Step 1: Gather Project Data

1. **Get Project Info:**
   - Use `gh project list --owner [owner] --format json`
   - Identify the requirements project
   - Get project URL and metadata

2. **Retrieve All Items:**
   - Use `gh project item-list [project-number] --format json`
   - Get full details including custom fields (Type, Priority, Status)

3. **Categorize by Type:**
   - Vision: Count and status
   - Epics: Count, priorities, status
   - Stories: Count, priorities, status, parent epic
   - Tasks: Count, priorities, status, parent story

4. **Get Recent Activity:**
   - Use `gh issue list --repo [repo] --label type:epic,type:story,type:task --limit 10 --json number,title,updatedAt,state`
   - Show last updated items

### Step 2: Calculate Metrics

**Counts by Type:**
- Total Vision issues (should be 1)
- Total Epics
- Total Stories
- Total Tasks

**Progress by Status:**
- Not Started: [Count] ([%]%)
- In Progress: [Count] ([%]%)
- Completed: [Count] ([%]%)

**Priority Distribution:**
- Must Have: [Count] ([%]%)
- Should Have: [Count] ([%]%)
- Could Have: [Count] ([%]%)
- Won't Have: [Count] ([%]%)

**Completion Metrics:**
- Epics: [X] of [Total] completed ([%]%)
- Stories: [X] of [Total] completed ([%]%)
- Tasks: [X] of [Total] completed ([%]%)

**Velocity (if applicable):**
- Tasks completed in last 7 days
- Stories completed in last 30 days

### Step 3: Generate Status Dashboard

Generate a comprehensive status dashboard with these sections:

**Header:**

- Project name, URL, and generation timestamp

**Overview:**

- Table showing counts by level (Vision, Epic, Story, Task) with status breakdown (Not Started, In Progress, Completed)
- Overall completion percentage with progress visualization

**Priority Breakdown:**

- Counts per priority level (Must Have, Should Have, Could Have, Won't Have)
- Status distribution within each priority level

**Current Focus:**

- Active work: all items currently In Progress
- Next up: highest priority Not Started items

**Epic Status Detail:**

- Per-epic progress: priority, status, story/task completion percentages

**Validation Status:**

- Quick health check: vision exists, traceability intact, priority balance
- Issue summary with pointer to `/re:review` if needed

**Velocity & Trends:**

- Recent activity: completions and creations in last 7 days
- Last 10 updated items

**Coverage Analysis:**

- Parent-child relationship coverage (Vision→Epics→Stories→Tasks)
- Identify gaps in breakdown

**Recommendations:**

- Context-appropriate immediate actions
- Health issue remediation
- Suggested next steps

**Quick Links:**

- Project URL and key filter links (by type, priority, status)

### Step 4: Provide Context-Aware Guidance

Based on project state, provide tailored guidance:

**Just starting (no vision):**

- Guide to `/re:discover-vision`
- Explain the full workflow ahead (vision → epics → stories → tasks)
- Set expectations for time investment

**Vision exists, few epics:**

- Guide to `/re:identify-epics` (aim for 5-12 major capabilities)
- Emphasize prioritization as next step
- Prepare to focus on highest priority epic for stories

**Epics exist, few stories:**

- Identify the highest priority epic to focus on
- Guide to `/re:create-stories` for that epic
- Note the progression: stories → prioritization → tasks

**Well underway:**

- Encourage completing in-progress items before starting new work
- Suggest running `/re:status` regularly to track progress
- Recommend `/re:review` weekly for quality checks

**Near complete:**

- Celebrate progress and acknowledge remaining work
- Show specific counts: remaining epics, stories, tasks
- Encourage finishing strong

### Step 5: Export Option

Offer to export the status report as:

- Markdown file (status-report-[date].md)
- Comment on vision issue
- Both

Use AskUserQuestion for the choice, then create file or add comment as requested.

## Error Handling

- If no project exists: Guide to `/re:init`
- If project empty: Guide to `/re:discover-vision`
- If GitHub API fails: Show cached/partial data with warning

## Notes

- Can be run anytime - no prerequisites
- Provides complete project snapshot
- Context-aware recommendations
- Shows trends and velocity
- Validates project health
- Suggests next logical actions
- Export-friendly format
- Run regularly (daily/weekly) to track progress
