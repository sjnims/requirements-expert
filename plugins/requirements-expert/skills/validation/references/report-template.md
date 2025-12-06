# Validation Report Template

Standard format for requirements validation reports.

## Report Structure

Use this template when generating validation reports:

```markdown
# Requirements Validation Report

**Project**: [Project Name]
**Date**: [YYYY-MM-DD]
**Validated By**: Claude Code (requirements-expert plugin)

---

## Executive Summary

| Dimension | Status | Score |
|-----------|--------|-------|
| Completeness | [Pass/Warning/Fail] | [N]% |
| Consistency | [Pass/Warning/Fail] | [N]% |
| Quality (INVEST) | [Pass/Warning/Fail] | [N]% |
| Traceability | [Pass/Warning/Fail] | [N]% |
| **Overall** | [Pass/Warning/Fail] | [N]% |

**Verdict**: [PASS / WARNING / FAIL]

---

## Requirements Inventory

| Level | Count | Complete | Issues |
|-------|-------|----------|--------|
| Vision | [N] | [Y/N] | [N] |
| Epics | [N] | [N/N] | [N] |
| Stories | [N] | [N/N] | [N] |
| Tasks | [N] | [N/N] | [N] |
| **Total** | [N] | [N/N] | [N] |

---

## Critical Issues (Must Fix)

[List blocking issues that prevent requirements from being actionable]

### Issue 1: [Title]

- **Impact**: [Why this is critical]
- **Location**: Issue #[N] - [Title]
- **Fix**: [Specific action to resolve]

### Issue 2: [Title]

- **Impact**: [Why this is critical]
- **Location**: Issue #[N] - [Title]
- **Fix**: [Specific action to resolve]

[Continue for all critical issues...]

---

## Warnings (Should Address)

[List quality issues that should be fixed but don't block progress]

### Warning 1: [Title]

- **Impact**: [Potential problems]
- **Location**: Issue #[N] - [Title]
- **Recommendation**: [Suggested improvement]

### Warning 2: [Title]

- **Impact**: [Potential problems]
- **Location**: Issue #[N] - [Title]
- **Recommendation**: [Suggested improvement]

[Continue for all warnings...]

---

## INVEST Compliance (Stories)

- **Stories Evaluated**: [N]
- **Fully Compliant**: [N] ([N]%)
- **Partial Compliance**: [N] ([N]%)
- **Non-Compliant**: [N] ([N]%)

### Common Issues

| Issue | Stories Affected |
|-------|------------------|
| [Issue description] | #[N], #[N], #[N] |
| [Issue description] | #[N], #[N] |

### Stories Needing Attention

| Story | Issues | Recommendation |
|-------|--------|----------------|
| #[N] - [Title] | [Not Small, Not Testable] | [Split story, add criteria] |
| #[N] - [Title] | [Dependent] | [Combine with #X] |

---

## Coverage Analysis

### Vision to Epics

**Status**: [Complete / Gaps / Major Gaps]

[Details about how well epics cover vision elements]

- Vision elements covered: [N/N]
- Epics aligned with vision: [N/N]

### Epics to Stories

**Status**: [Complete / Gaps / Major Gaps]

| Epic | Stories | Coverage |
|------|---------|----------|
| #[N] - [Title] | [N] | [Complete/Partial/None] |
| #[N] - [Title] | [N] | [Complete/Partial/None] |

### Stories to Tasks

**Status**: [Complete / Gaps / Major Gaps]

- Stories with tasks: [N/N]
- Stories needing tasks: [List]

---

## Recommendations

### High Priority

1. **[Recommendation title]**
   - Action: [Specific steps]
   - Affects: Issue #[N], #[N]

2. **[Recommendation title]**
   - Action: [Specific steps]
   - Affects: Issue #[N]

### Medium Priority

1. **[Recommendation title]**
   - Action: [Specific steps]
   - Affects: Issue #[N]

### Low Priority (Nice to Have)

1. **[Recommendation title]**
   - Action: [Specific steps]

---

## Next Steps

[Based on validation results, provide specific guidance]

**If Critical Issues Found:**

1. Fix critical issues before implementation
2. Re-run validation after fixes
3. Address warnings before sprint planning

**If Only Warnings:**

1. Proceed with caution
2. Address warnings incrementally
3. Re-validate weekly

**If All Pass:**

Requirements are solid! Ready for implementation.

---

## Appendix: Validation Details

### Vision Validation

- **Issue**: #[N] - [Title]
- **Status**: [Complete/Incomplete]
- **Issues Found**: [List or "None"]

### Epic Validation

| Epic | Status | Issues |
|------|--------|--------|
| #[N] - [Title] | [Complete] | None |
| #[N] - [Title] | [Incomplete] | Missing scope |

### Story Validation

| Story | INVEST | Criteria | Issues |
|-------|--------|----------|--------|
| #[N] | [6/6] | [5] | None |
| #[N] | [4/6] | [2] | Not Small, Few criteria |

### Task Validation

| Task | Status | Issues |
|------|--------|--------|
| #[N] - [Title] | [Complete] | None |
| #[N] - [Title] | [Incomplete] | No acceptance criteria |
```

## Report Sections Explained

### Executive Summary

Quick overview for stakeholders:

- One-glance status per dimension
- Overall verdict (Pass/Warning/Fail)
- Sets expectations for rest of report

### Requirements Inventory

Quantitative overview:

- Counts at each level
- Completion status
- Issue counts

### Critical Issues

Blocking problems requiring immediate attention:

- Must be fixed before implementation
- Include specific issue numbers
- Provide concrete fix actions

### Warnings

Non-blocking quality issues:

- Should be addressed but don't block
- Prioritized for incremental improvement
- Include recommendations

### INVEST Compliance

Story-specific quality assessment:

- Compliance percentages
- Common patterns in issues
- Specific stories needing work

### Coverage Analysis

Hierarchy completeness:

- Gaps in coverage
- Orphaned items
- Missing relationships

### Recommendations

Prioritized action items:

- High/Medium/Low priority
- Specific and actionable
- Linked to affected issues

### Next Steps

Context-appropriate guidance:

- Different paths based on verdict
- Clear action sequence
- Timeline suggestions

## Customization Guidelines

**Shorten for quick checks:**

- Include only Executive Summary and Critical Issues
- Skip Appendix for informal reviews

**Expand for formal reviews:**

- Include full Appendix with per-item details
- Add stakeholder-specific sections
- Include historical comparison if available

**Adjust tone for audience:**

- Technical: Include implementation details
- Executive: Focus on business impact
- Team: Emphasize actionable items
