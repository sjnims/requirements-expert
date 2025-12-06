# Example Validation Report

This example demonstrates a complete validation report for a sample project with realistic issues. Use this as a reference when generating validation reports.

---

## Requirements Validation Report

**Project**: CampaignTracker Marketing Analytics Platform
**Date**: 2024-01-15
**Validated By**: Claude Code (requirements-expert plugin)

---

## Executive Summary

| Dimension | Status | Score |
|-----------|--------|-------|
| Completeness | Warning | 85% |
| Consistency | Pass | 100% |
| Quality (INVEST) | Warning | 75% |
| Traceability | Pass | 100% |
| **Overall** | Warning | 90% |

**Verdict**: WARNING - Requirements are mostly solid but have quality issues that should be addressed before sprint planning.

---

## Requirements Inventory

| Level | Count | Complete | Issues |
|-------|-------|----------|--------|
| Vision | 1 | 1/1 | 0 |
| Epics | 6 | 6/6 | 1 |
| Stories | 24 | 22/24 | 4 |
| Tasks | 48 | 45/48 | 3 |
| **Total** | 79 | 74/79 | 8 |

---

## Critical Issues (Must Fix)

No critical issues found. All requirements have proper structure and traceability.

---

## Warnings (Should Address)

### Warning 1: Story Too Large

- **Impact**: Story may take longer than one sprint to complete, reducing predictability
- **Location**: Issue #15 - "As a marketing manager, I want to import campaign data from multiple sources so that I can see unified analytics"
- **Recommendation**: Split into multiple stories: CSV import, API integration, manual entry

### Warning 2: Missing Acceptance Criteria

- **Impact**: Cannot verify when story is complete; may lead to scope disagreement
- **Location**: Issue #18 - "As an analyst, I want to export reports so that I can share insights with stakeholders"
- **Recommendation**: Add 3-5 specific acceptance criteria defining export formats, permissions, and output locations

### Warning 3: Vague Task Description

- **Impact**: Developer may implement incorrectly or require excessive clarification
- **Location**: Issue #42 - "Set up database"
- **Recommendation**: Specify database type, schema requirements, migration strategy, and success criteria

### Warning 4: Priority Imbalance

- **Impact**: 67% of stories marked Must Have exceeds 60% threshold
- **Location**: Epic #3 - "Campaign Performance Dashboard"
- **Recommendation**: Review priorities; demote 2-3 items to Should Have

---

## INVEST Compliance (Stories)

- **Stories Evaluated**: 24
- **Fully Compliant**: 18 (75%)
- **Partial Compliance**: 4 (17%)
- **Non-Compliant**: 2 (8%)

### Common Issues

| Issue | Stories Affected |
|-------|------------------|
| Not Small (>5 days estimated) | #15, #21 |
| Missing acceptance criteria | #18 |
| Dependent on other stories | #22, #23 |

### Stories Needing Attention

| Story | Issues | Recommendation |
|-------|--------|----------------|
| #15 - Multi-source import | Not Small | Split into 3 stories by data source |
| #18 - Export reports | Not Testable | Add 5 acceptance criteria |
| #21 - Real-time updates | Not Small, Dependent | Split; address #20 dependency |
| #22 - Advanced filtering | Dependent | Ensure #19 completes first |
| #23 - Custom dashboards | Dependent | Ensure #22 completes first |

---

## Coverage Analysis

### Vision to Epics

**Status**: Complete

Vision elements are fully covered by the 6 epics:

- Vision elements covered: 6/6
- Epics aligned with vision: 6/6

All core capabilities mentioned in vision have corresponding epics:
1. User Authentication (#2)
2. Campaign Data Import (#3)
3. Performance Dashboard (#4)
4. Reporting & Export (#5)
5. Team Collaboration (#6)
6. Notifications & Alerts (#7)

### Epics to Stories

**Status**: Complete

| Epic | Stories | Coverage |
|------|---------|----------|
| #2 - User Authentication | 3 | Complete |
| #3 - Campaign Data Import | 5 | Complete |
| #4 - Performance Dashboard | 6 | Complete |
| #5 - Reporting & Export | 4 | Complete |
| #6 - Team Collaboration | 3 | Complete |
| #7 - Notifications & Alerts | 3 | Complete |

### Stories to Tasks

**Status**: Minor Gaps

- Stories with tasks: 22/24 (92%)
- Stories needing tasks: #23, #24

---

## Recommendations

### High Priority

1. **Split oversized stories**
   - Action: Break #15 into CSV Import, API Integration, and Manual Entry stories
   - Affects: Issue #15

2. **Add acceptance criteria to #18**
   - Action: Define export formats (PDF, CSV, Excel), permissions, and download locations
   - Affects: Issue #18

### Medium Priority

1. **Rebalance priorities in Epic #3**
   - Action: Move "Custom date range comparison" and "Export to PowerPoint" to Should Have
   - Affects: Stories #16, #17

2. **Improve task descriptions**
   - Action: Add specific acceptance criteria and technical context to vague tasks
   - Affects: Issues #42, #47, #48

### Low Priority (Nice to Have)

1. **Add tasks to remaining stories**
   - Action: Break down #23 and #24 into implementation tasks
   - Affects: Issues #23, #24

---

## Next Steps

**Since Only Warnings Were Found:**

1. Address High Priority recommendations before sprint planning
2. Split oversized stories (#15, #21) into properly sized increments
3. Add acceptance criteria to #18 and improve task descriptions
4. Re-run validation after fixes to confirm resolution
5. Address Medium Priority items during first sprint

**Recommended Timeline:**

- Day 1: Split stories and add acceptance criteria
- Day 2: Rebalance priorities with stakeholders
- Day 3: Re-validate and proceed to sprint planning

---

## Appendix: Validation Details

### Vision Validation

- **Issue**: #1 - "Product Vision: CampaignTracker"
- **Status**: Complete
- **Issues Found**: None

All required sections present:
- [x] Problem statement
- [x] Target users defined
- [x] Solution overview
- [x] Success metrics (SMART)
- [x] Scope boundaries

### Epic Validation

| Epic | Status | Issues |
|------|--------|--------|
| #2 - User Authentication | Complete | None |
| #3 - Campaign Data Import | Complete | None |
| #4 - Performance Dashboard | Warning | Priority imbalance |
| #5 - Reporting & Export | Complete | None |
| #6 - Team Collaboration | Complete | None |
| #7 - Notifications & Alerts | Complete | None |

### Story Validation (Sample)

| Story | INVEST | Criteria | Issues |
|-------|--------|----------|--------|
| #8 - User login | 6/6 | 5 | None |
| #9 - Password reset | 6/6 | 4 | None |
| #15 - Multi-source import | 4/6 | 5 | Not Small, Not Independent |
| #18 - Export reports | 5/6 | 1 | Not Testable |
| #21 - Real-time updates | 4/6 | 4 | Not Small, Dependent |

### Task Validation (Sample)

| Task | Status | Issues |
|------|--------|--------|
| #30 - Create login form component | Complete | None |
| #31 - Implement JWT authentication | Complete | None |
| #42 - Set up database | Incomplete | Vague description, no acceptance criteria |
| #47 - "Do API stuff" | Incomplete | Vague description |
| #48 - "Testing" | Incomplete | No specific test criteria |

---

Report generated by requirements-expert plugin v0.3.0
