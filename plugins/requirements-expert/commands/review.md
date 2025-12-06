---
name: re:review
description: Validate requirements quality and traceability
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Review & Validate Requirements

Validate requirements at all levels (vision, epics, stories, tasks) for completeness, consistency, quality, and traceability. This command is **read-only**—it analyzes requirements without modifying them unless fixes are explicitly requested.

## Instructions

Load the **validation** skill for methodology, checklists, and thresholds. Load **shared-patterns** skill for error handling patterns if fixes are applied.

### Step 1: Gather Context and Requirements

#### 1a. Get Repository Context

```bash
gh repo view --json nameWithOwner
```

Extract owner and repo name for subsequent commands.

#### 1b. Find Requirements Project

Query projects:

```bash
gh project list --owner [owner] --format json
```

If multiple projects found: Ask Select Project: "Which project would you like to validate?" (options: one per project)

If no project found: Inform user to run `/re:init` first, then exit.

#### 1c. Retrieve All Requirements

Get all project items:

```bash
gh project item-list [project-number] --format json
```

For each item, read full content:

```bash
gh issue view [number] --repo [repo] --json body,title,labels
```

Categorize by Type custom field: Vision, Epic, Story, Task.

#### 1d. State Validation

Before proceeding, verify prerequisites:

- If no Vision exists: Inform user to run `/re:discover-vision` first, then exit
- If no items at all: Guide user to creation commands (`/re:discover-vision` → `/re:identify-epics` → `/re:create-stories` → `/re:create-tasks`), then exit

### Step 2: Apply Validation Checks

Read `plugins/requirements-expert/skills/validation/references/quality-thresholds.md` for pass/warning/fail thresholds.

#### 2a. Completeness Check

Read `plugins/requirements-expert/skills/validation/references/completeness-checks.md` for per-level checklists.

For each requirement level, verify required elements:

| Level | Required Elements |
|-------|-------------------|
| Vision | Problem statement, target users, solution overview, success metrics, scope boundaries |
| Epic | Overview, value proposition, scope, success criteria, parent link to vision |
| Story | Story format ("As a..."), 3-5 acceptance criteria, parent link to epic, size (1-5 days) |
| Task | Action title, description, 3-5 acceptance criteria, parent link to story, size (2-8 hrs) |

Calculate: `(elements present / elements required) × 100 = Completeness %`

#### 2b. Consistency Check

Read `plugins/requirements-expert/skills/validation/references/consistency-checks.md` for detailed checks.

Verify:

- Every epic links to vision (has "Parent: #[vision-number]")
- Every story links to an epic
- Every task links to a story
- No orphaned issues (items without expected parents)
- Consistent terminology across requirements
- Child priorities don't exceed parent priorities (e.g., no Must Have task under Could Have story)

Calculate: `(consistent items / total items) × 100 = Consistency %`

#### 2c. Quality Check (INVEST Compliance)

Read `plugins/requirements-expert/skills/validation/references/invest-criteria.md` for INVEST details.

For each story, evaluate against INVEST criteria:

| Criterion | Question |
|-----------|----------|
| **I**ndependent | Can complete without other stories? |
| **N**egotiable | Implementation details open? |
| **V**aluable | Clear user/business value stated? |
| **E**stimable | Team can estimate effort? |
| **S**mall | Fits in 1-5 days? |
| **T**estable | Has specific, testable acceptance criteria? |

Score each story 0-6 based on criteria met.

Calculate: `(stories scoring 5+ / total stories) × 100 = INVEST Compliance %`

#### 2d. Traceability Check

Verify complete parent/child chains exist:

- Vision → at least 1 Epic
- Each Epic → at least 1 Story (or documented as future work)
- Each Story → at least 1 Task (or documented as atomic/self-contained)

Identify orphaned items and broken links.

Calculate: `(complete chains / expected chains) × 100 = Traceability %`

### Step 3: Generate and Present Report

Read `plugins/requirements-expert/skills/validation/references/report-template.md` for full format.

Generate report with all 8 sections:

1. **Executive Summary** - Dimensions with Pass/Warning/Fail status and percentages
2. **Requirements Inventory** - Counts by level (Vision, Epics, Stories, Tasks)
3. **Critical Issues** - Blocking problems that must be fixed
4. **Warnings** - Quality issues that should be addressed
5. **INVEST Compliance** - Story-specific quality assessment
6. **Coverage Analysis** - Gaps in Vision→Epic→Story→Task chain
7. **Recommendations** - Prioritized action items (High/Medium/Low)
8. **Next Steps** - Context-appropriate guidance

Determine overall verdict:

- **PASS**: All dimensions meet pass thresholds
- **WARNING**: Any dimension in warning range, none failing
- **FAIL**: Any dimension below fail threshold

Display condensed summary first:

```text
## Validation Summary

**Verdict**: [PASS / WARNING / FAIL]

| Dimension | Status | Score |
|-----------|--------|-------|
| Completeness | [Pass/Warning/Fail] | [N]% |
| Consistency | [Pass/Warning/Fail] | [N]% |
| Quality (INVEST) | [Pass/Warning/Fail] | [N]% |
| Traceability | [Pass/Warning/Fail] | [N]% |

**Critical Issues**: [N]
**Warnings**: [N]
```

Then display full report with all 8 sections.

### Step 4: Offer Fixes

If validation passes with no issues or warnings:

- Display congratulations message: "Requirements are solid and ready for implementation!"
- Proceed directly to Step 5

If issues or warnings found: Ask Fix Issues: "Would you like help fixing these issues?" (options: Auto-fix, Guided fix, Skip)

**If "Auto-fix" selected:**

Initialize batch tracking per shared-patterns skill: `fixed[]`, `skipped[]`, `failed[]`

For each critical issue, then each warning:

1. Read fix approach from `plugins/requirements-expert/skills/validation/references/fix-patterns.md`
2. Apply fix via `gh issue edit` or `gh project item-edit`
3. On failure: Apply shared-patterns Recovery Flow (Retry/Skip/Check permissions/Stop)
4. Track result in appropriate list

Display batch summary per shared-patterns format:

```text
## Fix Summary

**Fixed**: [N] issues
- #[number] - [Issue description] (fixed: [what was fixed])

**Skipped**: [N] issues (if > 0)
- [Issue description] (reason: [why skipped])

**Failed**: [N] issues (if > 0)
- [Issue description] (error: [error message])
```

Return to Step 2 to re-validate after fixes.

**If "Guided fix" selected:**

Initialize batch tracking per shared-patterns skill: `fixed[]`, `skipped[]`, `failed[]`

For each issue (critical first, then warnings):

Ask Fix Issue: "Issue: [description]. How would you like to proceed?" (options: Fix now, Skip, Dismiss)

If "Fix now": Apply fix per `plugins/requirements-expert/skills/validation/references/fix-patterns.md`, track in `fixed[]`. On failure: Apply shared-patterns Recovery Flow.

If "Skip": Track in `skipped[]`, continue to next issue.

If "Dismiss": Track in `skipped[]` with reason "dismissed", continue to next issue.

Display batch summary after all issues processed. Return to Step 2 to re-validate.

**If "Skip" selected:**

Proceed to Step 5.

### Step 5: Success Message

Display completion message:

```text
## Validation Complete

**Status**: [PASS / WARNING / FAIL]
**Critical Issues**: [N] | **Warnings**: [N]
```

**If critical issues remain:**

```text
Address critical issues before implementation:
- Vision missing or incomplete → Run `/re:discover-vision`
- Epics need work → Run `/re:identify-epics`
- Stories fail INVEST → Run `/re:create-stories` to refine
- Tasks missing or oversized → Run `/re:create-tasks`
- Priorities imbalanced → Run `/re:prioritize`
```

**If only warnings:**

```text
Proceed with caution. Address warnings incrementally.
Consider re-running `/re:review` weekly during development.
```

**If all pass:**

```text
Requirements are solid and ready for implementation!
```

**Next steps (always show):**

```text
**Next steps:**
- Run `/re:prioritize` if priorities need adjustment
- Run `/re:status` for project overview
- Begin implementation with highest-priority Must Have stories
```

## Error Handling

- **No project exists**: Inform user to run `/re:init` to create requirements project, then exit
- **No vision exists**: Inform user to run `/re:discover-vision` to create product vision, then exit
- **No epics exist**: Suggest running `/re:identify-epics` after vision is complete
- **No stories exist**: Suggest running `/re:create-stories` after epics are defined
- **Empty issue content**: Flag as critical issue in validation report with recommendation to update issue body
- **GitHub CLI not authenticated**: Run `gh auth status`, display authentication instructions, suggest `gh auth login`
- **Network/API errors**: Retry operation once; if still failing, inform user to check network connection and try again
- **Rate limiting**: Inform user of rate limit, display reset time if available, suggest waiting before retry
