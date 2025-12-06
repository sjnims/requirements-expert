---
name: shared-patterns
description: This skill should be used when the user asks to "implement recovery flow", "add error handling to command", "handle gh operation failures", "implement idempotency check", "prevent duplicate issues", "check before creating", "implement batch tracking", "track created and failed items", "implement two-layer metadata", "update custom fields and labels", "standardize command patterns", or when developing or modifying /re:* commands that need consistent error handling, duplicate detection, batch operation tracking, or GitHub Projects metadata updates.
version: 0.4.0
---

# Shared Command Patterns

## Quick Reference

| Pattern | Purpose | Section |
|---------|---------|---------|
| [Recovery Flow](#standard-recovery-flow) | Handle `gh` operation failures | Interactive error recovery |
| [Idempotency Check](#idempotency-check) | Prevent duplicate issue creation | Query-before-create |
| [Batch Tracking](#batch-tracking) | Track multi-item operation results | Summary reporting |
| [Two-Layer Metadata](#two-layer-metadata-update) | Update custom fields AND labels | GitHub Projects metadata |

## Command Integration

Commands reference these patterns by name rather than reimplementing. When developing or modifying `/re:*` commands, apply the relevant patterns to ensure consistent behavior across the plugin.

**Pattern application:**

- Load this skill when implementing command error handling or batch operations
- Reference pattern names in command instructions (e.g., "Apply Standard Recovery Flow")
- Use the AskUserQuestion structures defined here for consistent user interactions
- Follow the Batch Tracking summary format for operation reporting

For full implementation details, see `references/implementation-details.md`.

## Overview

These four patterns provide consistent, reusable behavior across all `/re:*` commands:

1. **Recovery Flow** - Graceful error handling with user choice
2. **Idempotency Check** - Safe re-runs without duplicates
3. **Batch Tracking** - Clear operation summaries
4. **Two-Layer Metadata** - Complete GitHub Projects integration

Each pattern is designed for AI consumption—terse core definitions with detailed implementations in references/.

---

## Standard Recovery Flow

**When:** Any `gh` CLI operation fails (network, auth, permissions, rate limit).

**Options:** Present via `AskUserQuestion`:

| Option | Action |
|--------|--------|
| Retry | Re-attempt the failed operation |
| Skip | Add to `failed[]`, continue to next item |
| Check permissions | Run `gh auth status`, display result, re-ask |
| Stop | Exit immediately with summary of completed work |

**AskUserQuestion Structure:**

```yaml
header: "Operation Failed"
question: "[Operation] failed: [error message]. How would you like to proceed?"
options:
  - label: "Retry"
    description: "Attempt the operation again"
  - label: "Skip"
    description: "Skip this item and continue with the next"
  - label: "Check permissions"
    description: "Verify GitHub CLI authentication status"
  - label: "Stop"
    description: "Stop processing and show summary"
```

**Variations:**

- `re:init`: 3-option (no Skip) - single operation, nothing to skip
- `re:discover-vision`: Adds "Save draft" - preserve work on failure

---

## Idempotency Check

**When:** Before creating any GitHub issue (vision, epic, story, task).

**Flow:**

1. Query existing: `gh issue list --repo [repo] --label "type:[type]" --json number,title`
2. Match: case-insensitive, trimmed title comparison
3. If match found → present options via `AskUserQuestion`

**AskUserQuestion Structure:**

```yaml
header: "Duplicate Found"
question: "An issue titled '[title]' already exists (#[number]). How would you like to proceed?"
options:
  - label: "Skip"
    description: "Keep existing issue, don't create duplicate"
  - label: "Update"
    description: "Update the existing issue with new content"
  - label: "Create anyway"
    description: "Create new issue despite duplicate"
```

**Tracking integration:**

- Skip → add to `skipped[]` with existing issue number
- Update → add to `updated[]` after successful edit
- Create anyway → proceed to create, add to `created[]`

---

## Batch Tracking

**When:** Processing multiple items (epics, stories, tasks, priority updates).

**Lists:** Initialize at command start:

- `created[]` – New items successfully created
- `skipped[]` – Items skipped (duplicates or user choice)
- `updated[]` – Existing items modified
- `failed[]` – Operations that failed (with error reason)

**Summary Output Template:**

```markdown
## Summary

**Created:** [N] new [item-type]
- #[number] - [Title]
- #[number] - [Title]

**Updated:** [N] existing [item-type]
- #[number] - [Title] (updated [fields])

**Skipped:** [N] [item-type] (duplicates)
- [Title] (existing #[number])

**Failed:** [N] [item-type]
- [Title]: [error reason]
```

**Display rules:**

- Only show categories with count > 0
- Include issue numbers as `#[number]` links
- Show specific error reasons for failed items
- Order: Created → Updated → Skipped → Failed

**Variation:** `re:prioritize` adds `partial[]` for items where custom field updated but label failed.

---

## Two-Layer Metadata Update

**When:** Setting Type, Priority, or Status on GitHub Project items.

**Why two layers:**

| Layer | Command | Purpose |
|-------|---------|---------|
| Custom Field | `gh project item-edit --field-id [id] --value "[val]"` | Project views, boards, filtering |
| Label | `gh issue edit [number] --add-label "[label]"` | Cross-project queries, GitHub search |

**Operation order:** Always update custom field first, then label.

**Label mapping:**

| Field Value | Label |
|-------------|-------|
| Vision | `type:vision` |
| Epic | `type:epic` |
| Story | `type:story` |
| Task | `type:task` |
| Must Have | `priority:must-have` |
| Should Have | `priority:should-have` |
| Could Have | `priority:could-have` |
| Won't Have | `priority:wont-have` |

**Tracking integration:**

- Both succeed → add to `updated[]`
- Field succeeds, label fails → add to `partial[]` (non-blocking)
- Both fail → add to `failed[]`

---

## Pattern Integration

Patterns work together in command workflows:

```text
For each item to process:
  1. Idempotency Check → determines if create/update/skip
  2. Create or Update operation
     - On failure → Recovery Flow
     - On success → Two-Layer Metadata Update
  3. Track result in appropriate Batch Tracking list

After all items:
  4. Display Batch Tracking Summary
```

**Cross-pattern data flow:**

| From Pattern | To Pattern | Data |
|--------------|------------|------|
| Idempotency Check | Batch Tracking | `skipped[]`, `updated[]` |
| Recovery Flow (Skip) | Batch Tracking | `failed[]` |
| Two-Layer Metadata | Batch Tracking | `updated[]`, `partial[]`, `failed[]` |

---

## Pattern Usage by Command

| Command | Recovery | Idempotency | Batch | Two-Layer |
|---------|:--------:|:-----------:|:-----:|:---------:|
| re:init | ✓ | ✓ | – | – |
| re:discover-vision | ✓ | ✓ | – | ✓ |
| re:identify-epics | ✓ | ✓ | ✓ | ✓ |
| re:create-stories | ✓ | ✓ | ✓ | ✓ |
| re:create-tasks | ✓ | ✓ | ✓ | ✓ |
| re:prioritize | ✓ | – | ✓ | ✓ |
| re:review | – | – | – | – |
| re:status | – | – | – | – |

## Additional Resources

### Reference Files

For detailed implementation guidance:

- **`references/implementation-details.md`** - Full implementation flows with code examples

### Example Files

Working examples from actual commands:

- **`examples/pattern-usage.md`** - Pattern application in re:identify-epics
