---
name: re:status
description: Show comprehensive overview of requirements project status, progress, and health
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

Display comprehensive status:

```
# Requirements Project Status

**Project:** [Project Name]
**URL:** [Project URL]
**Last Updated:** [Current Date/Time]

---

## Overview

| Level | Total | Not Started | In Progress | Completed | % Complete |
|-------|-------|-------------|-------------|-----------|------------|
| Vision | [N] | [N] | [N] | [N] | [%]% |
| Epics | [N] | [N] | [N] | [N] | [%]% |
| Stories | [N] | [N] | [N] | [N] | [%]% |
| Tasks | [N] | [N] | [N] | [N] | [%]% |

**Overall Progress:** [Progress bar visualization]
████████░░░░░░░░░░░░ [%]%

---

## Priority Breakdown

**Must Have:**
- Epics: [N] | Stories: [N] | Tasks: [N]
- Status: [N] complete, [N] in progress, [N] not started

**Should Have:**
- Epics: [N] | Stories: [N] | Tasks: [N]
- Status: [N] complete, [N] in progress, [N] not started

**Could Have:**
- Epics: [N] | Stories: [N] | Tasks: [N]
- Status: [N] complete, [N] in progress, [N] not started

**Won't Have:**
- Epics: [N] | Stories: [N] | Tasks: [N]

---

## Current Focus

**Active Work (In Progress):**
- #[num] - [Epic/Story/Task title] (type: [type])
- #[num] - [Epic/Story/Task title] (type: [type])
[List all items with Status = "In Progress"]

**Next Up (Highest Priority Not Started):**
1. #[num] - [Epic/Story/Task title] (priority: Must Have)
2. #[num] - [Epic/Story/Task title] (priority: Must Have)
3. #[num] - [Epic/Story/Task title] (priority: Must Have)

---

## Epic Status Detail

[For each epic, show progress]

### Epic: [Epic Title] (#[num])
- **Priority:** [Must/Should/Could Have]
- **Status:** [Not Started/In Progress/Completed]
- **Stories:** [X] of [Total] complete ([%]%)
- **Tasks:** [X] of [Total] complete ([%]%)
- **Progress:** ████░░░░░░ [%]%

[Repeat for all epics]

---

## Validation Status

**Last Validation:** [Date or "Never"]

**Quick Health Check:**
- Vision exists: [Pass/Fail]
- All epics linked to vision: [Pass/Fail]
- All stories linked to epics: [Pass/Fail]
- All tasks linked to stories: [Pass/Fail]
- Priority distribution balanced: [Pass/Warning/Fail]
- No orphaned issues: [Pass/Fail]

**Issues Found:** [N critical, N warnings]

[If issues:] Run `/re:review` for detailed validation report.

---

## Velocity & Trends

**Recent Activity (Last 7 days):**
- Tasks completed: [N]
- Stories completed: [N]
- Epics completed: [N]
- New items created: [N]

**Last 10 Updated Items:**
1. #[num] - [Title] ([type]) - Updated [timeago]
2. #[num] - [Title] ([type]) - Updated [timeago]
[...]

---

## Coverage Analysis

**Vision → Epics:**
- Vision coverage: [All vision elements covered by epics? Yes/No]

**Epics → Stories:**
[For each epic]
- Epic #[num]: [Has stories? Yes/No] ([N] stories)

**Stories → Tasks:**
[Sample or summary]
- [N] stories have tasks
- [N] stories need task breakdown

---

## Recommendations

[Based on status, provide actionable suggestions]

**Immediate Actions:**
[If no vision:] Run `/re:discover-vision` to create vision
[If no epics:] Run `/re:identify-epics` to identify major capabilities
[If epics not prioritized:] Run `/re:prioritize` to rank epics
[If highest priority epic has no stories:] Run `/re:create-stories` to break down top epic
[If highest priority story has no tasks:] Run `/re:create-tasks` to create implementation tasks

**Health Issues:**
[If validation issues:] Run `/re:review` to identify and fix issues
[If too many In Progress:] Focus on completing work before starting new items
[If progress stalled:] Review blockers and dependencies

**Next Steps:**
[Contextual suggestions based on current state]

---

## Quick Links

- **GitHub Project:** [URL]
- **Vision Issue:** #[num]
- **All Epics:** [Filter URL]
- **All Stories:** [Filter URL]
- **All Tasks:** [Filter URL]
- **Must Haves:** [Filter URL]
- **In Progress:** [Filter URL]

---

## Suggested Actions

Based on current status:

1. [Most logical next action based on project state]
2. [Second priority action]
3. [Third priority action]

**Commands:**
- `/re:discover-vision` - [If no vision]
- `/re:identify-epics` - [If vision but no epics]
- `/re:create-stories` - [If epics but incomplete stories]
- `/re:create-tasks` - [If stories but incomplete tasks]
- `/re:prioritize` - [If items not prioritized]
- `/re:review` - [Regular validation]
```

### Step 4: Provide Context-Aware Guidance

Based on the status, provide specific next steps:

**If just starting (no vision):**
```
Getting Started

Your requirements project is newly initialized!

Next Steps:
1. Run `/re:discover-vision` to define your product vision
2. Then `/re:identify-epics` to identify major capabilities
3. Use `/re:prioritize` to rank epics
4. Start implementing highest-priority epics

Estimated time to complete vision + epics: 1-2 hours
```

**If vision exists but few epics:**
```
Vision Defined - Define Epics Next

You have a solid vision. Time to break it down!

Next Steps:
1. Run `/re:identify-epics` to identify 5-12 major capabilities
2. Prioritize epics with `/re:prioritize`
3. Create stories for top epic with `/re:create-stories`
```

**If epics exist but few stories:**
```
Epics Identified - Create Stories

You have [N] epics. Let's create user stories!

Focus: [Highest priority epic name]

Next Steps:
1. Run `/re:create-stories` for epic #[num]
2. Prioritize stories with `/re:prioritize`
3. Create tasks for top story with `/re:create-tasks`
```

**If well underway:**
```
In Full Swing - Keep the Momentum

Progress: [X]% complete

Current Focus: [In progress items]

Next Steps:
1. Complete in-progress items
2. Run `/re:status` regularly to track progress
3. Run `/re:review` weekly for quality checks
```

**If near complete:**
```
Almost There

You're [X]% complete - great progress!

Remaining Work:
- [N] epics to complete
- [N] stories to finish
- [N] tasks remaining

Keep going! Run `/re:status` to track final progress.
```

### Step 5: Export Option

Offer to export status report:

```
Would you like to export this status report?

I can save it as:
- Markdown file (status-report-[date].md)
- Add as comment to vision issue
- Both

[Use AskUserQuestion for choice]
```

If user wants export, create the file or add comment as requested.

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
