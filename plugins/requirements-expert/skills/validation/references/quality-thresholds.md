# Quality Thresholds

Pass, warning, and fail thresholds for requirements validation.

## Threshold Summary

| Metric | Pass | Warning | Fail |
|--------|------|---------|------|
| Completeness | >90% | 70-90% | <70% |
| Consistency | 100% | 95-99% | <95% |
| INVEST Compliance | >80% | 60-80% | <60% |
| Traceability | 100% | 95-99% | <95% |
| Acceptance Criteria Count | >=3 per item | 2 per item | <2 per item |

## Completeness Thresholds

**What it measures:** Percentage of items with all required elements present.

| Threshold | Percentage | Meaning | Action |
|-----------|------------|---------|--------|
| Pass | >90% | Nearly all items complete | Proceed with confidence |
| Warning | 70-90% | Some items missing elements | Address gaps before implementation |
| Fail | <70% | Many items incomplete | Fix critical gaps immediately |

**Calculation:**

```text
Completeness = (Complete items / Total items) * 100

Item is complete if ALL required elements exist:
- Vision: problem, users, solution, metrics, scope
- Epic: overview, value, scope, criteria, parent link
- Story: format, 3+ acceptance criteria, parent link
- Task: title, description, 3+ criteria, parent link
```

## Consistency Thresholds

**What it measures:** Percentage of items with correct relationships and alignment.

| Threshold | Percentage | Meaning | Action |
|-----------|------------|---------|--------|
| Pass | 100% | All relationships correct | Fully traceable |
| Warning | 95-99% | Minor inconsistencies | Address soon |
| Fail | <95% | Significant misalignment | Fix before proceeding |

**Calculation:**

```text
Consistency = (Consistent items / Total items) * 100

Item is consistent if:
- Has valid parent link (except vision)
- Priority doesn't exceed parent priority
- Terminology matches project glossary
- No duplicate scope with other items
```

## INVEST Compliance Thresholds

**What it measures:** Percentage of user stories meeting all INVEST criteria.

| Threshold | Percentage | Meaning | Action |
|-----------|------------|---------|--------|
| Pass | >80% | Most stories are high quality | Ready for implementation |
| Warning | 60-80% | Some stories need improvement | Refine before sprint |
| Fail | <60% | Many stories poorly defined | Significant rework needed |

**Calculation:**

```text
INVEST Compliance = (Fully compliant stories / Total stories) * 100

Story is fully compliant if it passes all 6 INVEST criteria:
- Independent
- Negotiable
- Valuable
- Estimable
- Small
- Testable
```

## Traceability Thresholds

**What it measures:** Percentage of items with complete parent/child chains.

| Threshold | Percentage | Meaning | Action |
|-----------|------------|---------|--------|
| Pass | 100% | All items traceable to vision | Full hierarchy intact |
| Warning | 95-99% | Few orphaned items | Link orphans to parents |
| Fail | <95% | Many broken links | Rebuild hierarchy |

**Calculation:**

```text
Traceability = (Traceable items / Total items) * 100

Item is traceable if:
- Vision: Always traceable (root)
- Epic: Links to vision
- Story: Links to epic that links to vision
- Task: Links to story that links to epic that links to vision
```

## Acceptance Criteria Count Thresholds

**What it measures:** Number of acceptance criteria per story/task.

| Threshold | Count | Meaning | Action |
|-----------|-------|---------|--------|
| Pass | >=3 | Sufficient testability | Ready for implementation |
| Warning | 2 | Minimal testability | Add more criteria |
| Fail | <2 | Cannot verify completion | Must add criteria |

**Guidance:**

- **Minimum**: 3 acceptance criteria per story/task
- **Recommended**: 3-5 acceptance criteria
- **Maximum**: 7-10 (more suggests story is too large)

## Priority Distribution Thresholds

**What it measures:** Balance of MoSCoW priorities.

| Priority | Target | Warning If |
|----------|--------|------------|
| Must Have | <60% | >60% (scope creep risk) |
| Should Have | ~20% | <10% or >30% |
| Could Have | ~20% | <10% or >30% |
| Won't Have | >0% | =0% (scope not bounded) |

## Overall Verdict

Combine dimension scores for overall assessment:

| Verdict | Criteria | Meaning |
|---------|----------|---------|
| **PASS** | All dimensions Pass | Requirements are solid, ready for implementation |
| **WARNING** | Any dimension Warning, none Fail | Proceed with caution, address issues incrementally |
| **FAIL** | Any dimension Fail | Fix critical issues before proceeding |

## Threshold Adjustment Guidelines

These thresholds are starting points. Adjust based on:

**Increase strictness when:**

- High-risk or safety-critical project
- Regulated industry (healthcare, finance)
- Distributed team with less communication
- External stakeholders require documentation

**Decrease strictness when:**

- Early prototype or MVP phase
- Small, co-located team
- Rapid iteration environment
- Technical spike or research project

## Using Thresholds in Validation

1. **Calculate scores** for each dimension
2. **Apply thresholds** to determine Pass/Warning/Fail
3. **Prioritize fixes** based on severity:
   - Fix all Fail items first
   - Then address Warning items
   - Pass items need no action
4. **Re-validate** after fixes to confirm improvement
