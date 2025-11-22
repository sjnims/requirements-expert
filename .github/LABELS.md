# Label Management

This directory contains the canonical label configuration for the repository.

## Files

- **labels.yml**: Source of truth for all repository labels
- **sync-labels.sh**: Script for syncing labels (helper/documentation)

## Label Categories

### Type Labels

Default GitHub labels for issue/PR classification:
- `bug`, `documentation`, `duplicate`, `enhancement`, `invalid`, `question`, `wontfix`

### Component Labels

Identify which part of the codebase:
- `component:agent`, `component:command`, `component:docs`, `component:hook`, `component:skill`

### Priority Labels

Urgency classification:
- `priority:critical`, `priority:high`, `priority:medium`, `priority:low`

### Status Labels

Current state of work:
- `status:blocked`, `status:in-progress`, `status:needs-repro`, `status:needs-review`

### Effort Labels

Time estimates:
- `effort:small` (< 1 hour), `effort:medium` (1-4 hours), `effort:large` (> 4 hours)

### Community, Dependency, and Special Labels

**Community**:
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed

**Dependency** (Dependabot):
- `dependencies` - Dependency file updates
- `github-actions` - GitHub Actions updates

**Special**:
- `experiment` - Testing/experimental changes
- `pinned` - Never mark as stale
- `security` - Security-related issues

## Managing Labels

### Adding a New Label

1. **Update labels.yml** (source of truth):
   ```yaml
   - name: "new-label"
     color: "ff6ec7"
     description: "Description here"
   ```

2. **Apply to GitHub**:
   ```bash
   gh label create "new-label" --color "ff6ec7" --description "Description here"
   ```

3. **Commit** labels.yml changes

### Updating a Label

1. **Update labels.yml** (source of truth):
   ```yaml
   - name: "label-name"
     color: "new-color"
     description: "new description"
   ```

2. **Apply to GitHub**:
   ```bash
   gh label edit "label-name" --color "new-color" --description "new description"
   ```

3. **Commit** labels.yml changes

### Deleting a Label

1. **Remove from labels.yml** (source of truth)

2. **Delete from GitHub**:
   ```bash
   gh label delete "label-name" --yes
   ```

3. **Commit** labels.yml changes

### Syncing All Labels

**Option 1**: Manual sync using gh CLI (see sync-labels.sh for guidance)

**Option 2**: Use a label sync GitHub Action (recommended for automation)

## Label Naming Convention

- **Custom labels**: Use hyphens (`-`) not underscores (`_`) for multi-word labels
- **Default GitHub labels**: Keep spaces as-is (`good first issue`, `help wanted`) for ecosystem compatibility
- Use lowercase
- Use colons (`:`) for category prefixes (`component:`, `priority:`, `status:`, `effort:`)
- Keep names concise and descriptive

## Best Practices

1. **labels.yml is the source of truth** - always update it when changing labels
2. **Use consistent colors** within categories (e.g., component labels use cool colors: blues, purples, and teals)
3. **Keep descriptions clear** - they appear in the label picker
4. **Don't create too many labels** - aim for 25-35 total
5. **Archive unused labels** rather than delete (consider dependencies)

## Label Count

The repository maintains a balanced set of labels - enough for good organization without overwhelming contributors. Check `labels.yml` for the current complete list.
