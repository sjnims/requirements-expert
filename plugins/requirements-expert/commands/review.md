---
name: re:review
description: Validate requirements quality and traceability
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Review & Validate Requirements

Comprehensive validation of requirements at all levels (vision, epics, stories, tasks) checking for completeness, consistency, quality, and traceability.

## Instructions

Load the **requirements-validator** agent OR implement validation logic directly.

### Step 1: Scan Requirements

1. **Retrieve All Requirements:**
   - Use `gh project item-list [project-number] --format json`
   - Categorize by Type: Vision, Epic, Story, Task
   - Count items at each level

2. **Check Hierarchy:**
   - Verify vision exists (exactly 1)
   - Verify epics link to vision
   - Verify stories link to epics
   - Verify tasks link to stories

### Step 2: Completeness Check

**Vision Level:**

Verify:
- Problem statement exists and is clear
- Target users are defined
- Solution overview exists
- Success metrics are defined
- Scope boundaries are set

**Epic Level:**

Verify:
- Each epic has clear description
- User value is articulated
- Scope (included/excluded) is defined
- Success criteria exist
- All vision elements are covered by epics

**Story Level:**

Verify:
- Each story follows "As a... I want... So that..." format
- Acceptance criteria are present (minimum 3-5)
- Stories are small enough (1-5 days estimate)
- All epic scope is covered by stories

**Task Level:**

Verify:
- Each task has clear, action-oriented title
- Acceptance criteria are specific and testable (minimum 3-5)
- Tasks are right-sized (2-8 hours)
- All story acceptance criteria are covered by tasks

### Step 3: Consistency Check

**Traceability:**

Verify:
- Every epic links to vision
- Every story links to an epic
- Every task links to a story
- No orphaned issues (items without parents)

**Naming & IDs:**

Verify:
- Consistent terminology across levels
- No duplicate or conflicting requirements
- Labels are applied consistently

**Priority Alignment:**

Verify:
- Child priorities don't exceed parent priorities
- Dependencies respect priority order

### Step 4: Quality Check (INVEST for Stories)

For each user story, verify INVEST criteria:

- **Independent**: Can be completed without depending on others
- **Negotiable**: Details open for discussion
- **Valuable**: Delivers clear user value
- **Estimable**: Team can estimate size
- **Small**: Fits in single iteration
- **Testable**: Clear acceptance criteria

### Step 5: Validation Report

Generate a comprehensive validation report with these sections:

**Header:**

- Generation timestamp and project name

**Summary:**

- Table showing counts by level (Vision, Epic, Story, Task)
- Completion status and issue count per level
- Overall status: Pass / Warning / Fail

**Critical Issues (Must Fix):**

List any critical issues found, such as:

- Missing vision (no vision issue exists)
- Broken traceability (orphaned epics, stories, or tasks without parents)
- Incomplete requirements (missing scope definitions, acceptance criteria)

Reference specific issue numbers for each issue found.

**Warnings (Should Address):**

List any warnings found, such as:

- Quality issues (oversized stories, vague tasks, overlapping epics)
- INVEST violations (not independent, not valuable, not testable)
- Priority imbalances (>60% Must Have, missing Won't Have, child priority > parent)

Reference specific issue numbers for each warning.

**Recommendations:**

- Actionable fixes grouped by type (add content, split items, clarify, fix traceability)
- Reference specific issue numbers with suggested actions

**Next Steps:**

- Context-appropriate actions based on validation results
- Different guidance for critical issues, warnings only, or all pass

**Validation Details:**

- Per-level breakdown (Vision, Epic, Story, Task)
- Status and specific issues for each level

### Step 6: Offer to Fix Issues

After presenting the validation report:

- If no issues or warnings were found: Proceed directly to Step 7
- If issues or warnings were found: Use AskUserQuestion below

Use AskUserQuestion:

- Question: "Would you like help fixing these issues?"
- Header: "Fix Issues"
- Options:
  - "Auto-fix" (description: "Automatically fix issues where possible via GitHub CLI")
  - "Guided fix" (description: "Walk through each issue with suggestions")
  - "Skip" (description: "Review the report without making changes")
- multiSelect: false

**If "Auto-fix" selected:**

1. For missing acceptance criteria: Add placeholder acceptance criteria to issues via `gh issue edit`
2. For broken traceability links: Update issue bodies to add missing parent references
3. For missing content: Add section headers and placeholder text
4. After all fixes, re-run validation (Steps 1-5) to confirm fixes

**If "Guided fix" selected:**

For each issue found, use AskUserQuestion:

- Question: "How would you like to address: [brief issue description]?"
- Header: "Action"
- Options:
  - "Fix now" (description: "Apply the suggested fix")
  - "Skip" (description: "Leave for manual review")
  - "Dismiss" (description: "Mark as intentional/acceptable")
- multiSelect: false

If "Fix now": Apply the fix via `gh issue edit` and confirm success.
If "Skip" or "Dismiss": Move to next issue.

After processing all issues, re-run validation to show updated status.

**If "Skip" selected:**

Proceed directly to Step 7 without making changes.

### Step 7: Success Message

Display summary with:

- Overall status and issue counts
- If issues found: guidance to address critical issues first
- If no issues: confirmation that requirements are ready
- Recommendations for ongoing maintenance (periodic reviews, iterative refinement)
- Context-appropriate next steps

## Error Handling

- If no requirements exist: Guide to appropriate creation commands
- If project doesn't exist: Suggest `/re:init`
- If validation fails: Provide clear, actionable guidance

## Notes

- Validation checks all levels: vision, epics, stories, tasks
- Focus on actionable findings
- Distinguish critical issues from warnings
- Provide specific guidance for each issue type
- Offer to help fix issues automatically where possible
- Can be run at any time - recommended weekly/monthly
- Use as quality gate before sprint planning or releases
