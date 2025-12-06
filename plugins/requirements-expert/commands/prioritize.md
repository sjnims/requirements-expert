---
name: re:prioritize
description: Prioritize requirements with MoSCoW
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Prioritize Requirements

Prioritize requirements at any level (epics, stories, or tasks) using the MoSCoW framework. Updates GitHub Project issues with priority labels and custom fields. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Instructions

Load the **prioritization** skill for MoSCoW framework methodology and the **shared-patterns** skill for batch tracking and metadata patterns.

### Step 1: Determine What to Prioritize

Ask Level: "What would you like to prioritize?" (options: Epics, Stories for an epic, Tasks for a story)

### Step 2: Retrieve Items to Prioritize

Based on selection:

- **Epics:** Query `gh project item-list` filtered for Type = "Epic". If none, suggest `/re:identify-epics` and exit.
- **Stories:** Ask Select Epic: "Which epic's stories to prioritize?" (options: one per epic), then retrieve stories.
- **Tasks:** Ask Select Story: "Which story's tasks to prioritize?" (options: one per story), then retrieve tasks.

### Step 3: Present Items

Present items with:

- Count and type being prioritized
- Brief MoSCoW overview from prioritization skill (Must Have, Should Have, Could Have, Won't Have)
- Numbered list of item titles

### Step 4: Prioritize Items

For each item: Ask Priority: "[Item title]" (options: Must Have, Should Have, Could Have, Won't Have). **Collect all priorities before updating GitHub.**

### Step 5: Validate Distribution

Display priority distribution (count and percentage per category). Validate per prioritization skill recommendations:

- Must Haves <60%? If exceeded, warn and offer to review.
- Ask Adjust: "Would you like to adjust priorities?" (options: Yes, No). If Yes, restart Step 4.

### Step 6: Update GitHub

Initialize batch tracking per shared-patterns Batch Tracking pattern (created, updated, partial, failed, skipped).

For each prioritized item:

1. **Update custom field** using `gh project item-edit`
2. **Add label** using `gh issue edit --add-label "priority:[level]"`
3. **Add rationale comment** (Must Have and Won't Have only) - ask user for brief rationale

Apply shared-patterns Two-Layer Metadata Update pattern. On failure, apply shared-patterns Standard Recovery Flow.

Track results:

- Both succeed → `updated[]`
- Field OK, label fails → `partial[]` (non-blocking)
- Both fail → `failed[]`

### Step 7: Sequence Within Categories

For Must Haves, ask about sequencing factors from prioritization skill (dependencies, risk, value). Present suggested sequence and confirm.

### Step 8: Summary

Display batch tracking summary per shared-patterns format:

- Updated count with issue numbers and assigned priorities
- Partial updates (if any)
- Failed items with reasons (if any)
- Priority distribution breakdown
- Execution order for Must Haves
- Context-appropriate next steps

If any items failed or had partial updates, note that `/re:prioritize` can be re-run to retry.

### Step 9: Offer Next Action

Ask Next Step: "What would you like to do next?" (options: Prioritize another level, Show status, Start top priority, Exit)

Handle response appropriately.

## Error Handling

- No items to prioritize → Guide to appropriate creation command
- All Must Have → Guidance on right-sizing per prioritization skill
- No Must Have → Confirm intentional
- Priority/dependency conflicts → Highlight and suggest resolution
- Operation failures → Apply shared-patterns Standard Recovery Flow
