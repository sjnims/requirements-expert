---
name: shared-patterns
description: This skill should be used when the user asks about "error handling patterns", "recovery flow", "retry logic", "handle failures", "idempotency", "check for duplicates", "batch tracking", "track created items", "track failed items", "two-layer metadata", "update fields and labels", "command patterns", or when implementing consistent error handling, duplicate detection, batch operation tracking, or GitHub Projects metadata updates across commands.
version: 0.3.0
---

# Shared Command Patterns

## Quick Reference

| Pattern | Purpose |
|---------|---------|
| [Recovery Flow](#standard-recovery-flow) | Handle operation failures |
| [Idempotency Check](#idempotency-check) | Prevent duplicate creation |
| [Batch Tracking](#batch-tracking) | Track multi-item operations |
| [Two-Layer Metadata](#two-layer-metadata-update) | Update fields AND labels |

## Overview

Reusable patterns for consistent `/re:*` command behavior. Reference by name; don't reimplement.

---

## Standard Recovery Flow

**When:** Any `gh` operation fails.

**Options:** Present via `AskUserQuestion`:

| Option | Action |
|--------|--------|
| Retry | Re-attempt operation |
| Skip | Add to `failed[]`, continue |
| Check permissions | Run `gh auth status`, re-ask |
| Stop | Exit with summary |

**Variations:** `re:init` uses 3-option (no Skip). `re:discover-vision` adds "Save draft".

---

## Idempotency Check

**When:** Before creating any issue (vision, epic, story, task).

**Flow:**

1. Query: `gh issue list --label "type:[type]" --json number,title`
2. Match: case-insensitive, trimmed title comparison
3. If match → `AskUserQuestion`:

| Option | Action |
|--------|--------|
| Skip | Add to `skipped[]`, continue |
| Update | `gh issue edit`, add to `updated[]` |
| Create anyway | Proceed with duplicate |

---

## Batch Tracking

**When:** Processing multiple items.

**Lists:** Initialize at command start:

- `created[]` – New items created
- `skipped[]` – Duplicates skipped
- `updated[]` – Existing items modified
- `failed[]` – Operations that failed (with error)

**Summary:** Show counts per category, issue numbers as links, error reasons for failures.

**Variation:** `re:prioritize` adds `partial[]` for field-only updates.

---

## Two-Layer Metadata Update

**When:** Setting Type, Priority, or Status on project items.

**Layers:**

| Layer | Command | Purpose |
|-------|---------|---------|
| Custom Field | `gh project item-edit --field-id [id] --value "[val]"` | Project views/boards |
| Label | `gh issue edit --add-label "[label]"` | Cross-project queries |

**Labels:** `type:vision`, `type:epic`, `type:story`, `type:task`, `priority:must-have`, `priority:should-have`, `priority:could-have`, `priority:wont-have`

**Tracking:** Both succeed → `updated[]`. Field only → `partial[]`. Both fail → `failed[]`.

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
