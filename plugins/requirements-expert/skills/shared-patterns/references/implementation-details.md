# Pattern Implementation Details

This reference provides complete implementation flows for each shared pattern, including exact `gh` CLI commands, error handling sequences, and integration points.

## Standard Recovery Flow Implementation

### Complete Flow

```text
1. Execute gh command
2. If success → continue normal flow
3. If failure → capture error message
4. Present AskUserQuestion:
   - header: "Operation Failed"
   - question: "[Operation] failed: [error]. How would you like to proceed?"
   - options: [Retry, Skip, Check permissions, Stop]
5. Handle response:
   - Retry → goto step 1
   - Skip → failed.push({item, error}), continue to next item
   - Check permissions → execute `gh auth status`, display output, goto step 4
   - Stop → goto summary display
```

### AskUserQuestion Tool Call

```text
Use AskUserQuestion with:
  questions: [{
    header: "Operation Failed",
    question: "[Operation description] failed: [error message]. How would you like to proceed?",
    multiSelect: false,
    options: [
      { label: "Retry", description: "Attempt the operation again" },
      { label: "Skip", description: "Skip this item and continue with the next" },
      { label: "Check permissions", description: "Verify GitHub CLI authentication status" },
      { label: "Stop", description: "Stop processing and show summary" }
    ]
  }]
```

### Error Categories and Messages

| Error Type | Example Message | Recommended Action |
|------------|-----------------|-------------------|
| Authentication | "authentication required" | Check permissions first |
| Permission denied | "Resource not accessible" | Check permissions first |
| Not found | "Could not resolve" | Verify repository/project exists |
| Rate limit | "API rate limit exceeded" | Wait and retry |
| Network | "Could not connect" | Retry |

### Variation: 3-Option Flow (re:init)

For single-operation commands where Skip doesn't apply:

```text
options: [
  { label: "Retry", description: "Attempt the operation again" },
  { label: "Check permissions", description: "Verify GitHub CLI authentication status" },
  { label: "Exit", description: "Exit without completing setup" }
]
```

### Variation: Save Draft (re:discover-vision)

For issue creation where preserving work matters:

```text
options: [
  { label: "Retry", description: "Attempt to create the issue again" },
  { label: "Save draft", description: "Save vision content locally for later" },
  { label: "Check permissions", description: "Verify GitHub CLI authentication status" },
  { label: "Exit", description: "Exit without creating vision issue" }
]
```

On "Save draft": Display the issue body content so user can copy it.

---

## Idempotency Check Implementation

### Complete Flow

```text
1. Determine item type (vision, epic, story, task)
2. Query existing issues:
   gh issue list --repo [owner/repo] --label "type:[type]" --json number,title --limit 100
3. Parse response as JSON array
4. For proposed title, check each existing issue:
   - Normalize both: lowercase, trim whitespace
   - Compare: existing.title.toLowerCase().trim() === proposed.toLowerCase().trim()
5. If match found:
   a. Present AskUserQuestion with Skip/Update/Create anyway
   b. Handle response per option
6. If no match: proceed to create
```

### Query Commands by Type

```bash
# Vision (usually only 1)
gh issue list --repo [owner/repo] --label "type:vision" --json number,title

# Epics
gh issue list --repo [owner/repo] --label "type:epic" --json number,title --limit 100

# Stories (filter by parent epic if known)
gh issue list --repo [owner/repo] --label "type:story" --json number,title,body --limit 200

# Tasks (filter by parent story if known)
gh issue list --repo [owner/repo] --label "type:task" --json number,title,body --limit 500
```

### Title Matching Logic

```text
function titleMatches(existing, proposed):
  existingNormalized = existing.toLowerCase().trim()
  proposedNormalized = proposed.toLowerCase().trim()
  return existingNormalized === proposedNormalized
```

**Match criteria:**

- Case-insensitive comparison
- Leading/trailing whitespace ignored
- Exact match required (no fuzzy matching)

### AskUserQuestion for Duplicates

```text
Use AskUserQuestion with:
  questions: [{
    header: "Duplicate Found",
    question: "An issue titled '[proposed title]' already exists as #[number]. How would you like to proceed?",
    multiSelect: false,
    options: [
      { label: "Skip", description: "Keep the existing issue, don't create a duplicate" },
      { label: "Update", description: "Update the existing issue with the new content" },
      { label: "Create anyway", description: "Create a new issue despite the duplicate" }
    ]
  }]
```

### Handling Each Option

**Skip:**

```text
skipped.push({
  title: proposed_title,
  existing_number: matched_issue.number,
  reason: "duplicate"
})
// Continue to next item without creating
```

**Update:**

```text
gh issue edit [matched_number] --repo [owner/repo] --body "[new_body]"
// If success:
updated.push({
  number: matched_issue.number,
  title: proposed_title,
  changes: "body updated"
})
// If failure: trigger Recovery Flow
```

**Create anyway:**

```text
// Proceed with normal creation flow
// User acknowledged duplicate, continue as if no match found
```

---

## Batch Tracking Implementation

### Initialization

At command start, initialize four tracking lists:

```text
created = []   // {number, title, url}
skipped = []   // {title, existing_number, reason}
updated = []   // {number, title, changes}
failed = []    // {title, error}
```

For `re:prioritize`, add:

```text
partial = []   // {number, title, field_updated, label_failed}
```

### Adding Items to Lists

**On successful create:**

```text
created.push({
  number: response.number,
  title: item.title,
  url: response.url
})
```

**On duplicate skip:**

```text
skipped.push({
  title: item.title,
  existing_number: matched.number,
  reason: "duplicate"
})
```

**On successful update:**

```text
updated.push({
  number: existing.number,
  title: item.title,
  changes: "body updated" // or specific fields
})
```

**On failure:**

```text
failed.push({
  title: item.title,
  error: error_message
})
```

**On partial success (re:prioritize):**

```text
partial.push({
  number: item.number,
  title: item.title,
  field_updated: true,
  label_failed: error_message
})
```

### Summary Output Generation

Generate summary after all items processed:

```text
## Summary

// Only show sections with count > 0

if created.length > 0:
  **Created:** [created.length] new [item-type]
  for item in created:
    - #[item.number] - [item.title]

if updated.length > 0:
  **Updated:** [updated.length] existing [item-type]
  for item in updated:
    - #[item.number] - [item.title] ([item.changes])

if skipped.length > 0:
  **Skipped:** [skipped.length] [item-type] (duplicates)
  for item in skipped:
    - [item.title] (existing #[item.existing_number])

if partial.length > 0:  // re:prioritize only
  **Partial:** [partial.length] [item-type] (field updated, label failed)
  for item in partial:
    - #[item.number] - [item.title]: [item.label_failed]

if failed.length > 0:
  **Failed:** [failed.length] [item-type]
  for item in failed:
    - [item.title]: [item.error]
```

### Example Output

```markdown
## Summary

**Created:** 3 new epics
- #12 - User Authentication
- #13 - Data Import/Export
- #14 - Reporting Dashboard

**Updated:** 1 existing epic
- #11 - Core Infrastructure (body updated)

**Skipped:** 1 epic (duplicate)
- API Integration (existing #10)

**Failed:** 1 epic
- Mobile App: Permission denied - check repository access
```

---

## Two-Layer Metadata Implementation

### Complete Flow

```text
1. Cache field IDs at command start (if not already cached)
2. For each item requiring metadata:
   a. Update custom field first
   b. If field update fails → Recovery Flow
   c. If field update succeeds → update label
   d. Track result based on outcomes
```

### Field ID Caching

Retrieve field IDs once at command start:

```bash
gh project field-list [project-number] --owner [owner] --format json
```

Parse response to extract:

```text
type_field_id = fields.find(f => f.name === "Type").id
priority_field_id = fields.find(f => f.name === "Priority").id
status_field_id = fields.find(f => f.name === "Status").id
```

### Custom Field Update

```bash
gh project item-edit \
  --id [project-item-id] \
  --field-id [field-id] \
  --project-id [project-id] \
  --single-select-option-id [option-id]
```

**For single-select fields (Type, Priority, Status):**

First get option IDs from field-list response, then use `--single-select-option-id`.

**Alternative with value:**

```bash
gh project item-edit \
  --id [project-item-id] \
  --field-id [field-id] \
  --project-id [project-id] \
  --text "[value]"
```

### Label Update

```bash
gh issue edit [issue-number] --repo [owner/repo] --add-label "[label]"
```

**Label values:**

| Metadata | Field Value | Label to Add |
|----------|-------------|--------------|
| Type | Vision | `type:vision` |
| Type | Epic | `type:epic` |
| Type | Story | `type:story` |
| Type | Task | `type:task` |
| Priority | Must Have | `priority:must-have` |
| Priority | Should Have | `priority:should-have` |
| Priority | Could Have | `priority:could-have` |
| Priority | Won't Have | `priority:wont-have` |

### Tracking Logic

```text
field_success = false
label_success = false

// Step 1: Update custom field
try:
  gh project item-edit ...
  field_success = true
catch error:
  // Trigger Recovery Flow
  // If user chooses Skip: field_success = false
  // If user chooses Retry and succeeds: field_success = true

// Step 2: Update label (only if field succeeded or user wants to continue)
if field_success or user_chose_continue:
  try:
    gh issue edit ... --add-label ...
    label_success = true
  catch error:
    label_success = false
    // Non-blocking - just log the error

// Step 3: Track result
if field_success and label_success:
  updated.push({number, title, changes: "field and label"})
else if field_success and not label_success:
  partial.push({number, title, field_updated: true, label_failed: error})
else:
  failed.push({title, error})
```

### Removing Old Labels (Priority Updates)

When updating priority, remove old priority label first:

```bash
# Remove any existing priority labels
gh issue edit [number] --repo [owner/repo] \
  --remove-label "priority:must-have" \
  --remove-label "priority:should-have" \
  --remove-label "priority:could-have" \
  --remove-label "priority:wont-have"

# Add new priority label
gh issue edit [number] --repo [owner/repo] --add-label "priority:[new-priority]"
```

---

## Error Handling Best Practices

### Always Capture Full Error

```text
try:
  result = execute_gh_command(...)
catch error:
  error_message = extract_meaningful_message(error)
  // Use error_message in Recovery Flow question
  // Store error_message in failed[] list
```

### Meaningful Error Messages

Transform raw errors into user-friendly messages:

| Raw Error | User-Friendly Message |
|-----------|----------------------|
| `exit status 1` | "Command failed - check GitHub CLI output" |
| `HTTP 401` | "Authentication failed - run `gh auth login`" |
| `HTTP 403` | "Permission denied - check repository access" |
| `HTTP 404` | "Not found - verify project/issue exists" |
| `HTTP 422` | "Invalid request - check field values" |

### Graceful Degradation

When non-critical operations fail:

```text
// Label update is non-critical
try:
  gh issue edit ... --add-label ...
catch:
  // Log warning but don't block
  partial.push({...})
  // Continue processing
```

When critical operations fail:

```text
// Issue creation is critical
try:
  gh issue create ...
catch:
  // Trigger full Recovery Flow
  // User decides: Retry, Skip, Check permissions, Stop
```
