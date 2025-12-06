# Fix Patterns

Common fixes for common validation issues.

## Overview

After validation identifies issues, apply these fix patterns to resolve them efficiently.

## Completeness Fixes

### Missing Acceptance Criteria

**Issue**: Story or task has fewer than 3 acceptance criteria.

**Fix approach**:

1. Review the story/task goal
2. Identify success scenarios
3. Identify failure scenarios
4. Add edge cases

**Fix command**:

```bash
gh issue edit [number] --body "[updated body with acceptance criteria]"
```

**Template for adding criteria**:

```markdown
## Acceptance Criteria

- [ ] [Success scenario 1]
- [ ] [Success scenario 2]
- [ ] [Error handling scenario]
- [ ] [Edge case scenario]
- [ ] [Performance requirement if applicable]
```

### Missing Parent Link

**Issue**: Epic, story, or task doesn't reference its parent.

**Fix approach**:

1. Identify correct parent issue
2. Add parent reference to body
3. Verify hierarchy is correct

**Fix command**:

```bash
# Add parent reference
gh issue edit [number] --body "[updated body with parent reference]"
```

**Parent reference format**:

```markdown
**Parent**: #[parent-issue-number]
```

### Missing Scope Boundaries

**Issue**: Vision or epic lacks clear in/out scope definition.

**Fix approach**:

1. Review current content
2. List included functionality
3. Explicitly list excluded functionality

**Template**:

```markdown
## Scope

### In Scope

- [Feature/capability 1]
- [Feature/capability 2]
- [Feature/capability 3]

### Out of Scope

- [Excluded item 1]
- [Excluded item 2]
- [Future consideration]
```

### Missing Success Metrics

**Issue**: Vision lacks measurable success criteria.

**Fix approach**:

1. Identify key outcomes
2. Define measurable targets
3. Specify measurement timeframe

**Template**:

```markdown
## Success Metrics

| Metric | Target | Timeframe |
|--------|--------|-----------|
| [Metric 1] | [Target value] | [When to measure] |
| [Metric 2] | [Target value] | [When to measure] |
```

## Consistency Fixes

### Orphaned Item

**Issue**: Item has no parent link or parent doesn't exist.

**Fix approach**:

1. Identify which parent this should belong to
2. If no appropriate parent exists, create one
3. Add parent reference

**Decision tree**:

```text
Orphaned epic? → Link to vision
Orphaned story? → Link to appropriate epic (or create epic)
Orphaned task? → Link to appropriate story (or create story)
```

### Priority Mismatch

**Issue**: Child priority exceeds parent priority.

**Fix approach**:

1. Evaluate if child priority is correct
2. Either lower child priority or raise parent priority
3. Update both custom field and label

**Fix commands**:

```bash
# Update priority label
gh issue edit [number] --remove-label "priority:must-have" --add-label "priority:should-have"

# Update project custom field (requires item ID and field ID)
gh project item-edit --id [item-id] --field-id [field-id] --single-select-option-id [option-id]
```

### Duplicate Scope

**Issue**: Two items describe the same functionality.

**Fix approach**:

1. Determine which item should own the scope
2. Merge content into primary item
3. Close duplicate with reference to primary

**Fix command**:

```bash
# Close duplicate
gh issue close [duplicate-number] --comment "Duplicate of #[primary-number]. Content merged."
```

### Inconsistent Labels

**Issue**: Labels don't match custom field values or are missing.

**Fix approach**:

1. Determine correct values from custom fields
2. Update labels to match

**Fix commands**:

```bash
# Fix type label
gh issue edit [number] --remove-label "type:story" --add-label "type:epic"

# Fix priority label
gh issue edit [number] --add-label "priority:must-have"
```

## Quality Fixes (INVEST)

### Story Too Large (Not Small)

**Issue**: Story estimated at more than 5 days.

**Fix approach**:

1. Identify natural split points
2. Apply splitting technique
3. Create new stories for split portions
4. Update original story scope

**Splitting techniques**:

| Technique | When to Use |
|-----------|-------------|
| Workflow steps | Multi-step process |
| CRUD operations | Managing entities |
| Happy path first | Complex with many edge cases |
| Data variations | Multiple data types/formats |
| User roles | Different user types |

**See**: `user-story-creation` skill, `references/splitting-techniques.md`

### Story Not Independent

**Issue**: Story depends on another story.

**Fix approach**:

1. Identify the dependency
2. Options:
   - Combine stories into one
   - Include dependency in story scope
   - Create vertical slice through layers

### Story Not Testable

**Issue**: Acceptance criteria are vague or missing.

**Fix approach**:

1. Rewrite criteria to be specific
2. Use Given-When-Then format
3. Include measurable outcomes

**Template**:

```markdown
## Acceptance Criteria

- [ ] Given [context], when [action], then [observable outcome]
- [ ] [Specific, measurable criterion]
- [ ] Error case: [What happens when X goes wrong]
```

### Story Not Valuable

**Issue**: No clear user benefit articulated.

**Fix approach**:

1. Identify who benefits
2. Articulate the benefit
3. Rewrite "so that" clause

**If no user value**: Consider if this is a task, not a story.

## Traceability Fixes

### Broken Chain

**Issue**: Item's parent reference points to non-existent issue.

**Fix approach**:

1. Find correct parent issue
2. Update parent reference
3. If parent was deleted, determine if item is still needed

### Missing Hierarchy Level

**Issue**: Gap in hierarchy (e.g., tasks linked directly to vision).

**Fix approach**:

1. Create missing intermediate items
2. Update child references to new parent
3. Ensure complete chain exists

## Bulk Fix Patterns

### Adding Labels to Multiple Items

```bash
# Add type label to all items matching criteria
gh issue list --label "some-label" --json number | \
  jq -r '.[].number' | \
  xargs -I {} gh issue edit {} --add-label "type:story"
```

### Updating Multiple Issue Bodies

For significant changes across many issues, consider:

1. Export issues to JSON
2. Transform programmatically
3. Update via API

**Or handle individually with guided fix flow.**

## Guided Fix Flow

When offering guided fixes to users:

1. **Present issue**: "[Issue type]: [Description] in #[number]"
2. **Explain impact**: Why this matters
3. **Suggest fix**: Specific action to take
4. **Offer options**:
   - Fix now (apply suggested fix)
   - Skip (leave for manual review)
   - Dismiss (mark as intentional)
5. **Confirm result**: Show what was changed
6. **Move to next**: Continue through issues

## Auto-Fix Limitations

Some issues cannot be auto-fixed and require human judgment:

| Issue | Why Manual | Guidance |
|-------|------------|----------|
| Missing acceptance criteria | Requires domain knowledge | Suggest criteria structure, user fills in |
| Scope conflicts | Requires decision on ownership | Present options, user decides |
| Priority determination | Business decision | Explain trade-offs, user chooses |
| Story splitting | Creative decomposition | Suggest techniques, user implements |

## Post-Fix Validation

After applying fixes:

1. Re-run validation to confirm improvement
2. Check that fixes didn't introduce new issues
3. Verify hierarchy is still intact
4. Confirm overall scores improved
