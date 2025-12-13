# MoSCoW Prioritization Workflow

This reference provides structured workflow guidance for executing MoSCoW prioritization sessions. Load this when prioritizing epics, stories, or tasks.

For a complete worked example, see `examples/example-prioritization-session.md`.

---

## Phase 1: Gather Context

Before starting prioritization, collect essential context from the user via AskUserQuestion.

### Required Context to Collect

**Scope** - What are we prioritizing?

- Epics (which capabilities to build first)
- Stories (which stories within an epic)
- Tasks (which tasks within a story)

**Target** - What is the prioritization goal?

- MVP (minimum viable product)
- V1.0 (initial release)
- Next sprint or iteration
- Specific milestone or deadline

**Constraints** - What limits the work?

- Time (fixed deadline, sprint length)
- Budget (cost constraints)
- Resources (team size, skills available)
- Dependencies (external blockers, prerequisites)

**Decision Criteria** - What factors matter most?

- User value (impact on user experience)
- Business value (revenue, strategic importance)
- Technical risk (complexity, unknowns)
- Effort (time and resources required)

### Context Collection Process

1. Ask about scope using AskUserQuestion
2. Ask about target/goal using AskUserQuestion
3. Ask about constraints using AskUserQuestion
4. Confirm decision criteria weights (High/Medium/Low)

---

## Phase 2: Retrieve Items

Fetch items to prioritize from GitHub Projects.

### GitHub CLI Commands

**List project items:**

```bash
gh project item-list [project-number] --owner [owner] --format json
```

**Filter by Type:**

- For epics: Filter where Type = "Epic"
- For stories: Filter where Type = "Story" and parent = selected epic
- For tasks: Filter where Type = "Task" and parent = selected story

**Query existing priorities:**

```bash
gh project field-list [project-number] --owner [owner] --format json
```

### Validation Before Proceeding

- [ ] Items exist in GitHub Projects
- [ ] Items have Type field set correctly
- [ ] Item count is reasonable for session (10-20 items ideal)

If no items exist, suggest appropriate creation command:

- No epics? → `/re:identify-epics`
- No stories? → `/re:create-stories`
- No tasks? → `/re:create-tasks`

---

## Phase 3: Evaluate Each Item

For each item, assess against the decision criteria.

### Evaluation Criteria

| Criterion | Assessment Questions |
|-----------|---------------------|
| **User Value** | How much does this improve user experience? How many users benefit? How often will this be used? |
| **Business Value** | Revenue impact? Strategic importance? Competitive advantage? |
| **Technical Risk** | Complexity? Unknowns? Third-party dependencies? |
| **Effort** | Time required? Resources needed? Dependencies on other items? |

### Assessment Process

For each item:

1. Review the item's description and acceptance criteria
2. Rate user value: High / Medium / Low
3. Rate business value: High / Medium / Low
4. Rate technical risk: High / Medium / Low
5. Rate effort: High / Medium / Low
6. Note dependencies on other items

### Assessment Output

| Item | User Value | Business Value | Risk | Effort | Dependencies |
|------|------------|----------------|------|--------|--------------|
| Item 1 | High | High | Low | Medium | None |
| Item 2 | Medium | High | High | High | Item 1 |
| ... | ... | ... | ... | ... | ... |

---

## Phase 4: Apply MoSCoW Classification

Assign each item to a MoSCoW category based on assessment.

### Classification Logic

**Must Have** (Target: <60% of items)

- Non-negotiable for this release
- Product is not viable without this
- Legal, regulatory, or safety requirement
- Core functionality essential to vision

**Decision question:** "Can we ship without this?" If no → Must Have

**Should Have** (Target: ~20% of items)

- High impact but not mission-critical
- Significantly improves user experience
- Differentiates from competitors
- Can work around absence (though painful)

**Decision question:** "Important but deferrable?" If yes → Should Have

**Could Have** (Target: ~20% of items)

- Low impact on core value
- Enhancement or polish feature
- Convenience improvement
- Easy to cut if needed

**Decision question:** "Nice to have if time permits?" If yes → Could Have

**Won't Have** (This Time)

- Out of current scope
- Lower priority than other work
- Not aligned with current goals
- Explicitly deferred or rejected

**Decision question:** "Explicitly out of scope?" If yes → Won't Have

### Classification Process

1. Use AskUserQuestion to get priority for each item
2. Present MoSCoW options with clear descriptions
3. Collect all priorities before updating GitHub
4. Record brief rationale for Must Haves and Won't Haves

---

## Phase 5: Validate Distribution

Check the priority distribution against targets.

### Distribution Check

Calculate:

- Must Haves: Count / Total = percentage
- Should Haves: Count / Total = percentage
- Could Haves: Count / Total = percentage
- Won't Haves: Count documented

### Validation Rules

| Check | Target | Action if Failed |
|-------|--------|------------------|
| Must Haves | 60% | Challenge each: "Can we really not ship without this?" |
| No Won't Haves | At least 1 | Explicitly identify what's out of scope |
| Dependency conflict | None | High-priority items must not depend on low-priority items |

### MVP Viability Check

Verify the Must Haves alone deliver a viable product:

- [ ] Can the product ship with just Must Haves?
- [ ] Does it deliver core value to users?
- [ ] Would users pay for / use this?
- [ ] Are all critical user journeys covered?

### Dependency Validation

- [ ] All dependencies are respected in prioritization
- [ ] No high-priority items depend on low-priority items
- [ ] Prerequisite items are appropriately prioritized

If validation fails, use AskUserQuestion to adjust priorities.

---

## Phase 6: Sequence Within Categories

Establish execution order within each priority category.

### Sequencing Factors

Consider when ordering:

- **Dependencies** - Prerequisite items must come first
- **Risk** - High-uncertainty items early for learning
- **Value** - Higher-value items first within category
- **Effort** - Quick wins can build momentum

### Sequencing Output

For each category, produce ordered list:

1. Item name - Reason for this sequence position
2. Item name - Reason for this sequence position
3. ...continue for all items in category

---

## Phase 7: Update GitHub

Execute GitHub CLI commands to persist prioritization.

### Update Priority Custom Field

For each item:

```bash
gh project item-edit --id [item-id] \
  --field-id [priority-field-id] --value "[priority-value]"
```

Where `[priority-value]` must match the custom field option name exactly:
"Must Have", "Should Have", "Could Have", or "Won't Have".

### Apply Priority Labels

For each item:

```bash
gh issue edit [issue-number] --repo [owner/repo] \
  --add-label "priority:must-have"
```

Label values:

- `priority:must-have`
- `priority:should-have`
- `priority:could-have`
- `priority:wont-have`

### Add Rationale Comments

For Must Haves and Won't Haves:

```bash
gh issue comment [issue-number] --repo [owner/repo] \
  --body "Priority: [level]

Rationale: [user-provided explanation]"
```

---

## Phase 8: Generate Summary

Produce final prioritization output.

### Priority Distribution Summary

```text
Priority Distribution:
- Must Have: [X] items ([%]%)
- Should Have: [Y] items ([%]%)
- Could Have: [Z] items ([%]%)
- Won't Have: [W] items

Target Compliance:
- Must Haves under 60%: [Yes/No]
- Won't Haves documented: [Yes/No]
- Dependencies respected: [Yes/No]
```

### Execution Order

```text
Execution Order (Must Haves):
1. #[num] - [Item title] - [Sequence rationale]
2. #[num] - [Item title] - [Sequence rationale]
3. #[num] - [Item title] - [Sequence rationale]
```

### Next Steps

Based on what was prioritized, suggest:

- **Epics prioritized** → Start with first Must Have epic, run `/re:create-stories`
- **Stories prioritized** → Start with first Must Have story, run `/re:create-tasks`
- **Tasks prioritized** → Begin implementation with Must Have tasks

---

## Quick Reference

### MoSCoW at a Glance

| Category | Target % | Question to Ask |
|----------|----------|-----------------|
| Must Have | 60% | "Can we ship without this?" |
| Should Have | ~20% | "Important but not critical?" |
| Could Have | ~20% | "Nice to have if time permits?" |
| Won't Have | N/A | "Explicitly out of scope?" |

### Red Flags

Watch for these issues:

- **>60% Must Haves** - Challenge assumptions, apply stricter criteria
- **No Won't Haves** - Scope creep risk, explicitly exclude items
- **Dependency conflicts** - High-priority items depending on low-priority ones
- **No rationale** - Document why for Must Haves and Won't Haves

### GitHub CLI Quick Reference

| Operation | Command |
|-----------|---------|
| List items | `gh project item-list [number] --owner [owner] --format json` |
| Get fields | `gh project field-list [number] --owner [owner] --format json` |
| Set priority | `gh project item-edit --id [id] --field-id [fid] --value "[val]"` |
| Add label | `gh issue edit [num] --add-label "priority:must-have"` |
| Add comment | `gh issue comment [num] --body "[rationale]"` |
