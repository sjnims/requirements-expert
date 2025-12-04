# Pattern Usage Example: re:identify-epics

This example demonstrates how all four shared patterns work together in the `re:identify-epics` command, which creates multiple epic issues from a vision.

## Context

The `re:identify-epics` command:

- Reads the vision issue to understand product scope
- Helps user identify 5-12 epics
- Creates GitHub issues for each epic
- Sets metadata (Type: Epic) on each issue
- Reports summary of operations

This command uses **all four patterns**: Recovery Flow, Idempotency Check, Batch Tracking, and Two-Layer Metadata.

## Pattern Application Flow

```text
Command Start
    │
    ▼
Initialize Batch Tracking lists
    │
    ▼
Cache field IDs for Two-Layer Metadata
    │
    ▼
For each epic to create:
    │
    ├─► Idempotency Check ─┬─► Skip → skipped[]
    │                      ├─► Update → updated[]
    │                      └─► Create/Continue
    │                              │
    │                              ▼
    │                      Create Issue
    │                              │
    │                      On failure ─► Recovery Flow
    │                              │         │
    │                              │    ┌────┴────┐
    │                              │    │ Retry   │──► Retry create
    │                              │    │ Skip    │──► failed[]
    │                              │    │ Check   │──► gh auth status
    │                              │    │ Stop    │──► Summary
    │                              │    └─────────┘
    │                              │
    │                      On success
    │                              │
    │                              ▼
    │                      Two-Layer Metadata
    │                              │
    │                      ┌───────┴───────┐
    │                      │               │
    │                 Field Update    Label Update
    │                      │               │
    │                 On fail ──► Recovery │
    │                      │               │
    │                      ▼               ▼
    │               Track result in Batch Tracking
    │
    ▼
Display Batch Tracking Summary
```

## Example Execution

### Step 1: Initialize Batch Tracking

```text
created = []
skipped = []
updated = []
failed = []
```

### Step 2: Cache Field IDs

```bash
gh project field-list 4 --owner sjnims --format json
```

Extract and cache:

```text
type_field_id = "PVTSSF_lAHOAAUfK84BI2KNzgfNxYQ"
```

### Step 3: Process Epic "User Authentication"

**Idempotency Check:**

```bash
gh issue list --repo sjnims/my-project --label "type:epic" --json number,title
```

Response: `[]` (no existing epics)

No match found → proceed to create.

**Create Issue:**

```bash
gh issue create --repo sjnims/my-project \
  --title "User Authentication" \
  --body "## Epic: User Authentication\n\n..." \
  --label "type:epic"
```

Response: `#12` created successfully.

**Two-Layer Metadata - Custom Field:**

```bash
gh project item-add 4 --owner sjnims --url "https://github.com/sjnims/my-project/issues/12"
# Returns item ID: PVTI_lAHOAAUfK84BI2KNzgS3bQ

gh project item-edit \
  --id "PVTI_lAHOAAUfK84BI2KNzgS3bQ" \
  --field-id "PVTSSF_lAHOAAUfK84BI2KNzgfNxYQ" \
  --project-id "PVT_kwHOAAUfK84BI2KN" \
  --single-select-option-id "epic-option-id"
```

Success → label already added during create.

**Track Result:**

```text
created.push({
  number: 12,
  title: "User Authentication",
  url: "https://github.com/sjnims/my-project/issues/12"
})
```

### Step 4: Process Epic "Data Import" (Duplicate Found)

**Idempotency Check:**

```bash
gh issue list --repo sjnims/my-project --label "type:epic" --json number,title
```

Response:

```json
[{"number": 10, "title": "Data Import"}]
```

Match found for "Data Import" → present options.

**AskUserQuestion:**

```text
header: "Duplicate Found"
question: "An issue titled 'Data Import' already exists as #10. How would you like to proceed?"
options: [Skip, Update, Create anyway]
```

User selects: **Skip**

**Track Result:**

```text
skipped.push({
  title: "Data Import",
  existing_number: 10,
  reason: "duplicate"
})
```

### Step 5: Process Epic "Reporting Dashboard" (Create Fails)

**Idempotency Check:** No match found → proceed to create.

**Create Issue:**

```bash
gh issue create --repo sjnims/my-project \
  --title "Reporting Dashboard" \
  --body "..."
```

**Failure:** `HTTP 403: Resource not accessible by integration`

**Recovery Flow - AskUserQuestion:**

```text
header: "Operation Failed"
question: "Creating issue 'Reporting Dashboard' failed: Permission denied. How would you like to proceed?"
options: [Retry, Skip, Check permissions, Stop]
```

User selects: **Check permissions**

**Check Permissions:**

```bash
gh auth status
```

Output:

```text
github.com
  ✓ Logged in to github.com account sjnims
  - Token scopes: 'repo', 'project'
```

Re-present options. User selects: **Retry**

**Retry Create:** Success → `#14` created.

**Two-Layer Metadata:** Success.

**Track Result:**

```text
created.push({
  number: 14,
  title: "Reporting Dashboard",
  url: "https://github.com/sjnims/my-project/issues/14"
})
```

### Step 6: Process Epic "Mobile App" (Metadata Partial Failure)

**Idempotency Check:** No match → create.

**Create Issue:** Success → `#15` created.

**Two-Layer Metadata - Custom Field:** Success.

**Two-Layer Metadata - Label:** Already applied during create (success).

Actually, let's show a partial failure case:

**Two-Layer Metadata - Custom Field:**

```bash
gh project item-edit ...
```

**Failure:** `HTTP 422: Field value invalid`

**Recovery Flow:** User selects **Skip**

**Track Result:**

```text
failed.push({
  title: "Mobile App",
  error: "Failed to set Type field: Field value invalid"
})
```

### Step 7: Display Batch Tracking Summary

After all epics processed:

```markdown
## Summary

**Created:** 2 new epics
- #12 - User Authentication
- #14 - Reporting Dashboard

**Skipped:** 1 epic (duplicate)
- Data Import (existing #10)

**Failed:** 1 epic
- Mobile App: Failed to set Type field - Field value invalid
```

## Key Takeaways

### Pattern Interactions

1. **Idempotency Check feeds Batch Tracking** - Skip/Update decisions directly populate tracking lists
2. **Recovery Flow feeds Batch Tracking** - Skip action adds to `failed[]`
3. **Two-Layer Metadata feeds Batch Tracking** - Success/partial/failure tracked appropriately

### Error Recovery Strategy

- **Transient errors** (network, rate limit): Retry is usually successful
- **Permission errors**: Check permissions helps diagnose
- **Validation errors**: Skip and investigate later
- **Critical blockers**: Stop preserves completed work

### Summary Visibility

The Batch Tracking summary provides:

- Clear count of what was accomplished
- Actionable information about failures
- Reference to existing items (for duplicates)
- Audit trail for the operation

## Adapting to Other Commands

### re:create-stories

Same pattern flow, but:

- Query filter: `--label "type:story"`
- Additional context: Parent epic
- Metadata: Type = Story

### re:create-tasks

Same pattern flow, but:

- Query filter: `--label "type:task"`
- Additional context: Parent story, technical area
- Metadata: Type = Task, plus area labels

### re:prioritize

Modified flow:

- No Idempotency Check (updating existing items)
- Two-Layer Metadata updates Priority field + priority label
- Adds `partial[]` tracking for field-only updates
