# Label Management

This directory contains the canonical label configuration for the repository.

## Files

- **labels.yml**: Source of truth for all repository labels (30 labels total)
- **sync-labels.sh**: Script for syncing labels (helper/documentation)

## Label Categories

### Type Labels (7)

Default GitHub labels for issue/PR classification:
- `bug`, `documentation`, `duplicate`, `enhancement`, `invalid`, `question`, `wontfix`

### Component Labels (5)

Identify which part of the codebase:
- `component:agent`, `component:command`, `component:docs`, `component:hook`, `component:skill`

### Priority Labels (4)

Urgency classification:
- `priority:critical`, `priority:high`, `priority:medium`, `priority:low`

### Status Labels (4)

Current state of work:
- `status:blocked`, `status:in-progress`, `status:needs-repro`, `status:needs-review`

### Effort Labels (3)

Time estimates:
- `effort:small` (< 1 hour), `effort:medium` (1-4 hours), `effort:large` (> 4 hours)

### Special Labels (7)

- `good first issue`, `help wanted` - Community
- `dependencies`, `github-actions` - Dependabot
- `experiment` - Testing/experimental changes
- `pinned` - Never mark as stale
- `security` - Security-related issues

## Managing Labels

### Adding a New Label

1. Add to `labels.yml`:
   ```yaml
   - name: "new-label"
     color: "ff6ec7"
     description: "Description here"
   ```

2. Create on GitHub:
   ```bash
   gh label create "new-label" --color "ff6ec7" --description "Description here"
   ```

3. Commit labels.yml changes

### Updating a Label

```bash
gh label edit "label-name" --color "new-color" --description "new description"
```

Then update labels.yml to match.

### Deleting a Label

```bash
gh label delete "label-name" --yes
```

Then remove from labels.yml.

### Syncing All Labels

**Option 1**: Manual sync using gh CLI (see sync-labels.sh for guidance)

**Option 2**: Use a label sync GitHub Action (recommended for automation)

## Label Naming Convention

- Use **hyphens** (`-`) not underscores (`_`) for consistency
- Use lowercase
- Use colons (`:`) for category prefixes (`component:`, `priority:`, `status:`, `effort:`)
- Keep names concise and descriptive

## Best Practices

1. **labels.yml is the source of truth** - always update it when changing labels
2. **Use consistent colors** within categories (e.g., all component labels use shades of blue)
3. **Keep descriptions clear** - they appear in the label picker
4. **Don't create too many labels** - aim for 25-35 total
5. **Archive unused labels** rather than delete (consider dependencies)

## Current Label Count: 30

This is a healthy number - enough for good organization without overwhelming contributors.
