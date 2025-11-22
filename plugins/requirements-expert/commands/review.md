---
name: re:review
description: Validate requirements for completeness, consistency, quality, and traceability
allowed-tools: [Bash, Read]
---

# Review & Validate Requirements

Comprehensive validation of requirements at all levels (vision, epics, stories, tasks) checking for completeness, consistency, quality, and traceability.

## Instructions

Load the **requirements-validator** agent OR implement validation logic directly.

### Step 1: Scan Requirements

1. **Retrieve All Requirements:**
   - Use `gh project item-list [project-id] --format json`
   - Categorize by Type: Vision, Epic, Story, Task
   - Count items at each level

2. **Check Hierarchy:**
   - Verify vision exists (exactly 1)
   - Verify epics link to vision
   - Verify stories link to epics
   - Verify tasks link to stories

### Step 2: Completeness Check

**Vision Level:**
- [ ] Problem statement exists and is clear
- [ ] Target users are defined
- [ ] Solution overview exists
- [ ] Success metrics are defined
- [ ] Scope boundaries are set

**Epic Level:**
- [ ] Each epic has clear description
- [ ] User value is articulated
- [ ] Scope (included/excluded) is defined
- [ ] Success criteria exist
- [ ] All vision elements are covered by epics

**Story Level:**
- [ ] Each story follows "As a... I want... So that..." format
- [ ] Acceptance criteria are present (minimum 3-5)
- [ ] Stories are small enough (1-5 days estimate)
- [ ] All epic scope is covered by stories

**Task Level:**
- [ ] Each task has clear, action-oriented title
- [ ] Acceptance criteria are specific and testable (minimum 3-5)
- [ ] Tasks are right-sized (2-8 hours)
- [ ] All story acceptance criteria are covered by tasks

### Step 3: Consistency Check

**Traceability:**
- [ ] Every epic links to vision
- [ ] Every story links to an epic
- [ ] Every task links to a story
- [ ] No orphaned issues (items without parents)

**Naming & IDs:**
- [ ] Consistent terminology across levels
- [ ] No duplicate or conflicting requirements
- [ ] Labels are applied consistently

**Priority Alignment:**
- [ ] Child priorities don't exceed parent priorities
- [ ] Dependencies respect priority order

### Step 4: Quality Check (INVEST for Stories)

For each user story, verify INVEST criteria:
- [ ] **Independent**: Can be completed without depending on others
- [ ] **Negotiable**: Details open for discussion
- [ ] **Valuable**: Delivers clear user value
- [ ] **Estimable**: Team can estimate size
- [ ] **Small**: Fits in single iteration
- [ ] **Testable**: Clear acceptance criteria

### Step 5: Validation Report

Generate comprehensive report:

```
# Requirements Validation Report

**Generated:** [Date/Time]
**Project:** [Project Name]

## Summary

| Level | Count | Complete | Issues |
|-------|-------|----------|--------|
| Vision | [N] | [✓/✗] | [N] |
| Epics | [N] | [✓/✗] | [N] |
| Stories | [N] | [✓/✗] | [N] |
| Tasks | [N] | [✓/✗] | [N] |

**Overall Status:** [✓ Pass / ⚠️ Warning / ✗ Fail]

---

## Critical Issues (Must Fix)

[List any critical issues that prevent requirements from being actionable]

### Missing Vision
- [ ] No vision issue found - run `/re:discover-vision`

### Broken Traceability
- [ ] Epic #[num] has no parent vision
- [ ] Story #[num] has no parent epic
- [ ] Task #[num] has no parent story

### Incomplete Requirements
- [ ] Epic #[num] missing scope definition
- [ ] Story #[num] has no acceptance criteria
- [ ] Task #[num] missing acceptance criteria

---

## Warnings (Should Address)

[List issues that should be fixed but don't block progress]

### Quality Issues
- [ ] Story #[num] too large (>5 days) - consider splitting
- [ ] Task #[num] too vague - needs clearer description
- [ ] Epic #[num] overlaps with Epic #[num2]

### INVEST Violations
- [ ] Story #[num] not independent (depends on #[num2])
- [ ] Story #[num] not valuable (too technical, no user benefit)
- [ ] Story #[num] not testable (vague acceptance criteria)

### Priority Issues
- [ ] Must Have items exceed 60% - review priorities
- [ ] No Won't Haves defined - consider scope boundaries
- [ ] Child priority higher than parent

---

## Recommendations

[Actionable suggestions for improvement]

1. **Add Missing Content:**
   - Update Epic #[num] with success criteria
   - Add acceptance criteria to Story #[num]

2. **Split Large Items:**
   - Story #[num] - suggest splitting into [X] stories

3. **Clarify Vague Items:**
   - Task #[num] - add specific technical notes

4. **Fix Traceability:**
   - Link Story #[num] to Epic #[num2]

---

## Next Steps

Based on validation results:

**If Critical Issues Found:**
1. Fix critical issues before proceeding
2. Re-run `/re:review` after fixes

**If Only Warnings:**
1. Address high-priority warnings
2. Proceed with implementation
3. Refine as you learn

**If All Pass:**
✅ Requirements are solid! Ready for implementation.

---

## Validation Details

### Vision Validation
[Detailed findings for vision]
- Status: [✓ Pass / ⚠️ Warning / ✗ Fail]
- Issues: [List]

### Epic Validation
[Detailed findings for epics]
- Epics validated: [N]
- Pass: [N], Warnings: [N], Fail: [N]
- Issues: [List]

### Story Validation
[Detailed findings for stories]
- Stories validated: [N]
- INVEST compliance: [%]%
- Issues: [List]

### Task Validation
[Detailed findings for tasks]
- Tasks validated: [N]
- Avg acceptance criteria per task: [N]
- Issues: [List]
```

### Step 6: Offer to Fix Issues

After presenting report, offer to help fix issues:

```
Would you like help fixing any of these issues?

I can:
- Update issues with missing content
- Split large stories/tasks
- Add missing acceptance criteria
- Fix broken traceability links

Which would you like to address first?
```

**If user wants help:**
- For each issue, provide specific guidance or make updates
- Update GitHub issues in GitHub Project as needed
- Re-run validation after fixes

### Step 7: Success Message

Display:
```
✅ Requirements review complete!

**Status:** [Overall status]
**Critical Issues:** [N]
**Warnings:** [N]

[If issues found:]
Address critical issues before proceeding with implementation.
Use the validation report above to guide fixes.

[If no issues:]
Requirements look good! You're ready to start implementation.

**Recommendations:**
- Re-run `/re:review` periodically (weekly/monthly)
- Update requirements as you learn during implementation
- Use feedback from testing to refine acceptance criteria

**Next Steps:**
[Based on validation status, suggest appropriate next actions]
```

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
