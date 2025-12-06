---
name: re:review
description: Validate requirements quality and traceability
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Review & Validate Requirements

Validate requirements at all levels (vision, epics, stories, tasks) for completeness, consistency, quality, and traceability.

Load the **validation** skill for methodology details.

## Instructions

### Step 1: Gather Requirements

1. Get repository context: `gh repo view --json nameWithOwner`
2. List projects: `gh project list --owner [owner] --format json`
3. Get all items: `gh project item-list [project-number] --format json`
4. Categorize by Type: Vision, Epic, Story, Task
5. For each item, read full content: `gh issue view [number] --repo [repo] --json body,title,labels`

### Step 2: Apply Validation Checks

Apply four-dimensional validation per skill methodology:

1. **Completeness** - All required elements present (see `references/completeness-checks.md`)
2. **Consistency** - Proper linking and alignment (see `references/consistency-checks.md`)
3. **Quality** - INVEST criteria for stories (see `references/invest-criteria.md`)
4. **Traceability** - Complete parent/child chain

Use thresholds from `references/quality-thresholds.md`.

### Step 3: Generate Report

Format findings per `references/report-template.md`:

- Executive Summary (dimensions + overall verdict)
- Requirements Inventory (counts by level)
- Critical Issues (must fix)
- Warnings (should address)
- INVEST Compliance (stories)
- Recommendations (prioritized)
- Next Steps

### Step 4: Present Results

Display the validation report. Highlight:

- Overall verdict: Pass / Warning / Fail
- Critical issue count
- Warning count
- Key recommendations

### Step 5: Offer Fixes

If issues or warnings found, use AskUserQuestion:

- Question: "Would you like help fixing these issues?"
- Header: "Fix Issues"
- Options:
  - "Auto-fix" (description: "Automatically fix issues where possible")
  - "Guided fix" (description: "Walk through each issue with suggestions")
  - "Skip" (description: "Review the report without making changes")
- multiSelect: false

**If "Auto-fix"**: Apply fixes per `references/fix-patterns.md`, then re-run validation.

**If "Guided fix"**: For each issue, present options (Fix now / Skip / Dismiss), apply fixes, then re-run validation.

**If "Skip"**: Proceed to Step 6.

### Step 6: Success Message

Display:

- Overall status and issue counts
- If issues found: Guidance to address critical issues first
- If no issues: Confirmation that requirements are ready
- Context-appropriate next steps

## Error Handling

- No project exists: Suggest `/re:init`
- No requirements exist: Guide to appropriate creation commands
- GitHub CLI errors: Check authentication with `gh auth status`
