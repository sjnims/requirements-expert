---
name: validation
description: This skill should be used when the user asks to "validate requirements", "review requirements quality", "check requirements completeness", "verify traceability", "check INVEST compliance", "validate user stories", "requirements health check", "quality gate check", or when assessing requirements for completeness, consistency, quality, and traceability.
version: 0.3.0
---

# Validation

## Quick Actions & Routing

| User Intent | Action | Resource |
|-------------|--------|----------|
| Run full validation | Execute /re:review command | Command handles orchestration |
| Check completeness | Verify all required elements | `references/completeness-checks.md` |
| Check consistency | Verify traceability and alignment | `references/consistency-checks.md` |
| Validate stories (INVEST) | Apply INVEST criteria | `references/invest-criteria.md` |
| Understand thresholds | Review pass/warning/fail levels | `references/quality-thresholds.md` |
| Generate report | Use standard format | `references/report-template.md` |
| Fix common issues | Apply fix patterns | `references/fix-patterns.md` |

## Command Integration

The `/re:review` command orchestrates requirements validation in GitHub Projects. This skill provides the methodology for what to validate and how—including the four-dimensional validation framework, quality thresholds, and fix patterns. Load this skill for deeper understanding of validation concepts or when you need guidance beyond what the command provides.

## Overview

Requirements validation ensures that requirements at all levels (vision, epics, stories, tasks) are complete, consistent, high-quality, and traceable. Validation identifies issues early, reducing rework and improving implementation success. This skill provides the framework for systematic validation.

## Purpose

Validation serves as the quality gate for requirements:

- **Catches issues early**: Before implementation begins
- **Ensures traceability**: Vision → Epics → Stories → Tasks chain is complete
- **Verifies quality**: INVEST criteria for stories, clear acceptance criteria
- **Identifies gaps**: Missing elements, broken links, incomplete coverage

## Four-Dimensional Validation Framework

Perform validation across four dimensions:

| Dimension | Question | Focus |
|-----------|----------|-------|
| **Completeness** | Are all required elements present? | Structure and content |
| **Consistency** | Do requirements align and link properly? | Relationships and terminology |
| **Quality** | Do requirements meet best practice standards? | INVEST, acceptance criteria |
| **Traceability** | Can we trace from vision to tasks? | Parent/child hierarchy |

## Validation Process Overview

### Step 1: Gather Requirements

Retrieve all items from GitHub Project:

```bash
gh project item-list [project-number] --format json
```

Categorize by Type: Vision, Epic, Story, Task. For each item, read full content:

```bash
gh issue view [issue-number] --repo [repo] --json body,title,labels
```

### Step 2: Apply Completeness Checks

Verify required elements exist at each level. See `references/completeness-checks.md` for detailed checklists.

**Quick summary by level:**

| Level | Key Elements |
|-------|--------------|
| Vision | Problem, users, solution, metrics, scope |
| Epic | Overview, value, scope, success criteria, parent link |
| Story | Story format, acceptance criteria (3-5), parent link, size (1-5 days) |
| Task | Action title, description, acceptance criteria (3-5), parent link, size (2-8 hrs) |

### Step 3: Apply Consistency Checks

Verify alignment and traceability. See `references/consistency-checks.md` for detailed checks.

**Key checks:**

- Every epic links to vision
- Every story links to an epic
- Every task links to a story
- No orphaned issues
- Consistent terminology and labels
- Child priorities don't exceed parent priorities

### Step 4: Apply Quality Checks

Validate requirements meet quality standards. See `references/invest-criteria.md` for INVEST details.

**INVEST criteria for stories:**

| Letter | Criterion | Quick Check |
|--------|-----------|-------------|
| **I** | Independent | Can complete without other stories? |
| **N** | Negotiable | Implementation details open? |
| **V** | Valuable | Clear user/business value? |
| **E** | Estimable | Team can estimate effort? |
| **S** | Small | Fits in 1-5 days? |
| **T** | Testable | Specific acceptance criteria? |

**Acceptance criteria quality:**

- Specific and unambiguous
- Testable and verifiable
- Observable outcomes
- Minimum 3-5 per story/task

### Step 5: Generate Validation Report

Format findings using the standard report template. See `references/report-template.md`.

**Report sections:**

1. Executive Summary (dimensions + overall status)
2. Requirements Inventory (counts by level)
3. Critical Issues (must fix)
4. Warnings (should address)
5. INVEST Compliance (for stories)
6. Coverage Analysis
7. Recommendations (prioritized)
8. Next Steps

### Step 6: Offer to Fix Issues

After presenting report, offer assistance:

- **Auto-fix**: Automatically fix where possible
- **Guided fix**: Walk through each issue
- **Skip**: Review only, no changes

See `references/fix-patterns.md` for common fix approaches.

## Quality Thresholds

Use these thresholds for pass/warning/fail assessment. See `references/quality-thresholds.md` for details.

| Metric | Pass | Warning | Fail |
|--------|------|---------|------|
| Completeness | >90% | 70-90% | <70% |
| Consistency | 100% | 95-99% | <95% |
| INVEST Compliance | >80% | 60-80% | <60% |
| Traceability | 100% | 95-99% | <95% |
| Acceptance Criteria | >=3 per item | 2 per item | <2 per item |

## Issue Severity Classification

### Critical Issues (Must Fix)

Block progress and must be resolved:

- Missing vision (no vision issue exists)
- Broken traceability (orphaned items without parents)
- Missing acceptance criteria (cannot verify completion)
- Incomplete scope definitions

### Warnings (Should Address)

Quality issues that should be fixed but don't block:

- Oversized stories (>5 days)
- INVEST violations
- Priority imbalances (>60% Must Have)
- Vague task descriptions

## Best Practices

### Be Thorough but Pragmatic

- Focus on actionable findings
- Distinguish critical from nice-to-have
- Don't be pedantic about minor style issues

### Provide Actionable Guidance

- Every issue should have a clear fix
- Reference specific issue numbers
- Group recommendations by priority

### Validate Iteratively

- Re-run validation after fixes
- Use as quality gate before sprint planning
- Recommend periodic reviews (weekly/monthly)

## Reference Files

Load references as needed:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **completeness-checks.md** | Detailed per-level checklists | `references/completeness-checks.md` |
| **consistency-checks.md** | Traceability and alignment checks | `references/consistency-checks.md` |
| **invest-criteria.md** | INVEST criteria deep-dive | `references/invest-criteria.md` |
| **quality-thresholds.md** | Pass/warning/fail thresholds | `references/quality-thresholds.md` |
| **report-template.md** | Validation report format | `references/report-template.md` |
| **fix-patterns.md** | Common fixes for common issues | `references/fix-patterns.md` |

## Related Skills

Load these skills when validation reveals needs beyond this skill's scope:

| Validation Finding | Load Skill | Routing Trigger |
|--------------------|------------|-----------------|
| Vision is missing or incomplete | `vision-discovery` | Need to create or improve vision |
| Epics are missing or poorly defined | `epic-identification` | Need to identify or refine epics |
| Stories fail INVEST criteria | `user-story-creation` | Need to rewrite or split stories |
| Tasks are missing or oversized | `task-breakdown` | Need to create or break down tasks |
| Priorities are imbalanced | `prioritization` | Need to apply MoSCoW framework |
