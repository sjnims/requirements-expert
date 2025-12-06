# Consistency Checks

Detailed checks for verifying requirements align and link properly across all levels.

## Traceability Chain

### Epic to Vision

- [ ] Every epic links to vision (no orphaned epics)
- [ ] Epic scope aligns with vision goals
- [ ] Epic value proposition supports vision metrics

**Check command:**

```bash
# List all epics and verify parent links
gh issue list --repo [repo] --label "type:epic" --json number,title,body
# Each should reference vision issue in body
```

### Story to Epic

- [ ] Every story links to an epic (no orphaned stories)
- [ ] Story scope falls within epic boundaries
- [ ] Story acceptance criteria support epic success criteria

**Check command:**

```bash
# List all stories and verify parent links
gh issue list --repo [repo] --label "type:story" --json number,title,body
# Each should reference epic issue in body
```

### Task to Story

- [ ] Every task links to a story (no orphaned tasks)
- [ ] Task deliverables support story acceptance criteria
- [ ] Task scope is appropriate for story context

**Check command:**

```bash
# List all tasks and verify parent links
gh issue list --repo [repo] --label "type:task" --json number,title,body
# Each should reference story issue in body
```

### Orphan Detection

Count orphaned issues at each level:

| Level | Orphan Definition | Impact |
|-------|-------------------|--------|
| Epic | No link to vision | May not align with product goals |
| Story | No link to epic | May not fit in any capability |
| Task | No link to story | May not deliver user value |

**Orphaned items must be either:**

1. Linked to appropriate parent
2. Removed if not needed
3. Promoted to higher level if appropriate

## Terminology Consistency

### Naming Conventions

- [ ] Consistent terminology across hierarchy
  - Same concepts use same terms
  - No conflicting definitions
  - Glossary terms used consistently

- [ ] No duplicate or conflicting requirements
  - No two items describe same functionality
  - No contradictory requirements
  - Clear boundaries between items

- [ ] Labels applied consistently
  - `type:vision`, `type:epic`, `type:story`, `type:task`
  - Priority labels match custom field values
  - No missing or misapplied labels

### Terminology Issues to Flag

| Issue | Example | Fix |
|-------|---------|-----|
| Synonym confusion | "user" vs "customer" vs "member" | Standardize on one term |
| Duplicate scope | Two stories for same feature | Merge or clarify boundaries |
| Conflicting requirements | "Must be fast" vs "Must be thorough" | Resolve contradiction |

## Priority Alignment

### Priority Hierarchy Rules

- [ ] Child priorities don't exceed parent priorities
  - A "Should Have" epic cannot have "Must Have" stories
  - A "Could Have" story cannot have "Must Have" tasks

- [ ] Priority distribution is balanced
  - Must Have: <60% of items at each level
  - Should Have: ~20%
  - Could Have: ~20%
  - Won't Have: Explicitly documented

- [ ] Dependencies respect priority order
  - Higher priority items don't depend on lower priority
  - Critical path items are all "Must Have"

### Priority Alignment Matrix

| Parent Priority | Allowed Child Priorities |
|-----------------|-------------------------|
| Must Have | Must Have, Should Have, Could Have |
| Should Have | Should Have, Could Have |
| Could Have | Could Have |
| Won't Have | Won't Have (or remove children) |

### Priority Imbalance Detection

**Warning signs:**

- >60% of items are "Must Have" → Scope creep risk
- 0% "Won't Have" → Scope not properly bounded
- Child priority > Parent priority → Alignment issue

## Coverage Consistency

### Vision Coverage by Epics

- [ ] All vision elements are addressed by at least one epic
- [ ] No epics exist that don't support vision goals
- [ ] Epic coverage is balanced (no over/under-represented areas)

### Epic Coverage by Stories

For each epic:

- [ ] All epic scope elements have stories
- [ ] Stories collectively deliver epic success criteria
- [ ] No story scope exceeds epic boundaries

### Story Coverage by Tasks

For each story:

- [ ] All acceptance criteria are addressed by tasks
- [ ] Implementation layers are covered (frontend, backend, testing, docs)
- [ ] No task duplicates another task's scope

## Consistency Scoring

Calculate consistency percentage:

```text
Consistency % = (Consistent relationships / Total relationships) * 100
```

| Score | Rating | Action |
|-------|--------|--------|
| 100% | Pass | Fully consistent |
| 95-99% | Warning | Minor issues to address |
| <95% | Fail | Significant alignment problems |

## Common Consistency Issues

| Issue | Impact | Fix |
|-------|--------|-----|
| Orphaned items | Work may not deliver value | Link to appropriate parent |
| Priority mismatch | Execution order confusion | Align child to parent priority |
| Scope overlap | Duplicate work risk | Clarify boundaries |
| Missing coverage | Gaps in delivery | Add missing items |
| Terminology drift | Communication breakdown | Standardize terms |
