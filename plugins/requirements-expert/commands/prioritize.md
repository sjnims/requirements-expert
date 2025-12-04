---
name: re:prioritize
description: Prioritize requirements with MoSCoW
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Prioritize Requirements

Prioritize requirements at any level (epics, stories, or tasks) using the MoSCoW framework. Updates GitHub Project issues with priority labels and custom fields. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Instructions

Load the **prioritization** skill to access MoSCoW framework methodology.

### Step 1: Determine What to Prioritize

Use AskUserQuestion:
- Question: "What would you like to prioritize?"
- Header: "Level"
- Options:
  - "Epics" (description: "Prioritize all epics - determine which capabilities to build first")
  - "Stories for an epic" (description: "Prioritize user stories within a specific epic")
  - "Tasks for a story" (description: "Prioritize implementation tasks within a story")
- multiSelect: false

### Step 2: Retrieve Items to Prioritize

Based on selection:

**If Epics:**
- Use `gh project item-list [project-number] --format json`
- Filter for Type = "Epic"
- If no epics: Suggest running `/re:identify-epics`, exit

**If Stories:**
- First ask which epic (use AskUserQuestion with epic options)
- Then retrieve stories for that epic
- Filter for Type = "Story" and parent = selected epic

**If Tasks:**
- First ask which story (use AskUserQuestion with story options)
- Then retrieve tasks for that story
- Filter for Type = "Task" and parent = selected story

### Step 3: Present Items for Prioritization

Present the items to be prioritized with:

- Introduction stating how many items will be prioritized and what type (epics/stories/tasks)
- Explanation of the MoSCoW framework categories: Must Have (critical for success), Should Have (important but deferrable), Could Have (nice to have), Won't Have (explicitly out of scope)
- Numbered list of all items to prioritize with their titles
- Note that each item will be assigned a priority interactively

### Step 4: Interactive Prioritization

For each item, use AskUserQuestion:

**For each item:**

- Question: "[Item title] - What priority should this be?"
- Header: "Priority"
- Options:
  - "Must Have" (description: "Critical - cannot ship without this")
  - "Should Have" (description: "Important - defer only if Must Haves at risk")
  - "Could Have" (description: "Nice to have - include if time permits")
  - "Won't Have" (description: "Explicitly out of scope for now")
- multiSelect: false
- **Collect all priorities before updating GitHub**

### Step 5: Validate Distribution

After collecting all priorities, display the priority distribution showing:

- Count and percentage for each category (Must Have, Should Have, Could Have, Won't Have)

Check against recommendations from prioritization skill:

- Must Haves should be <60% of total
- If more than 60% are Must Have: Warn user and ask to review

If distribution is problematic, display a warning that includes:

- The percentage of items marked as Must Have
- Recommendation to aim for <60% Must Haves to maintain focus and flexibility
- Question asking if they would like to review and adjust priorities

Use AskUserQuestion with Yes/No options. If Yes, restart Step 4.

### Step 6: Update GitHub Issues in GitHub Project

Initialize batch tracking lists:

- `updated`: Items with priority successfully set (with issue numbers and priority level)
- `partial`: Items where custom field OR label updated but not both (with details)
- `failed`: Items that failed completely (with error reasons)
- `skipped`: Items user chose to skip

For each item, update GitHub:

#### 6a. Update Priority Custom Field

Use `gh project item-edit` to set Priority field to selected MoSCoW category.

**If Custom Field Update Fails:**

Capture error output from gh CLI.

Display: "Failed to update priority field for '#[issue-number] - [item-title]': [error message]"

Use AskUserQuestion for recovery:

- question: "Priority field update failed. How would you like to proceed?"
- header: "Recovery"
- multiSelect: false
- options:
  - label: "Retry"
    description: "Try updating this item again"
  - label: "Skip"
    description: "Skip this item, continue with remaining"
  - label: "Check permissions"
    description: "Show diagnostic commands"
  - label: "Stop"
    description: "Stop and show summary of progress"

**Handle response:**

- **Retry**: Re-attempt update. If fails again, present recovery options again.
- **Skip**: Add to `failed` list with error reason, continue to next item.
- **Check permissions**:
  - Run: `gh auth status`
  - Display the output
  - Explain: "Project field updates require 'project' scope."
  - Suggest: `gh auth refresh -s project` if scope is missing
  - After showing diagnostics, present the same recovery options again
- **Stop**: Exit loop and proceed to Step 8 (show summary with progress so far)

**Track custom field result** (success or failure) before proceeding to label update.

#### 6b. Add Priority Label

Use `gh issue edit [issue-number] --add-label "priority:[moscow-level]"`

Labels: `priority:must-have`, `priority:should-have`, `priority:could-have`, `priority:wont-have`

**If Label Update Fails (but custom field succeeded):**

Display: "Priority field updated but label failed for #[issue-number]: [error message]"

Continue to next item without blocking (this is a partial success).

Add to `partial` list with details: "Field OK, label failed: [error]"

**If Label Update Fails (and custom field also failed):**

Item is already in `failed` list from step 6a. Continue to next item.

**If Both Succeed:**

Add to `updated` list with issue number and priority level.

#### 6c. Add Comment with Rationale (Optional)

For Must Have and Won't Have items only:

- Ask user for brief rationale
- Use `gh issue comment [issue-number] --body "Priority: [level] - Rationale: [user-provided text]"`

**If Comment Fails:**

Note the failure but do not block. Display: "Note: Rationale comment failed for #[issue-number]"

Continue to next item. This does not affect the item's status in tracking lists.

### Step 7: Sequence Within Categories

After prioritization, determine execution order:

**For Must Haves:**
Ask about sequencing factors:
- Dependencies (what must come first?)
- Risk (tackle unknowns early?)
- Value (highest value first?)

Present suggested sequence and ask for confirmation.

### Step 8: Success Message & Summary

After processing all items, display a batch summary:

**Prioritization complete!**

**Updated:** [N] items

- #[num] - [Item title] → Must Have
- #[num] - [Item title] → Should Have
- #[num] - [Item title] → Could Have
- #[num] - [Item title] → Won't Have

**Partial updates:** [N] items (only if > 0)

- #[num] - [Item title]: Field OK, label failed
- #[num] - [Item title]: Label OK, field failed

**Failed:** [N] items (only if > 0)

- #[num] - [Item title]: [error reason]

**Skipped:** [N] items (only if > 0)

- #[num] - [Item title]: User skipped

**Priority Distribution:**

- Must Have: [X] items ([%])
- Should Have: [Y] items ([%])
- Could Have: [Z] items ([%])
- Won't Have: [W] items ([%])

**Execution order:**

1. #[num] - [Must Have item 1]
2. #[num] - [Must Have item 2]
3. ...

**Next steps (context-appropriate):**

- If epics: Start with first Must Have epic, run `/re:create-stories` for that epic, focus on completing Must Haves before Should Haves
- If stories: Start with first Must Have story, run `/re:create-tasks` for that story, complete stories in priority order
- If tasks: Begin implementation with Must Have tasks, follow dependency order within priority level, update task status in GitHub Projects as you progress

**If any items failed or had partial updates:**

Note: [N] items had issues. Run `/re:prioritize` again to retry failed items. Partial updates can be fixed manually with `gh issue edit --add-label` or `gh project item-edit`.

### Step 9: Offer Next Action

Use AskUserQuestion:
- Question: "What would you like to do next?"
- Header: "Next Step"
- Options:
  - "Prioritize another level" (description: "Prioritize epics/stories/tasks")
  - "Show status" (description: "See overall progress")
  - "Start top priority" (description: "Create stories/tasks for top priority item")
  - "Exit" (description: "Stop here")
- multiSelect: false
- **Handle response appropriately**

## Error Handling

- If no items to prioritize: Guide to appropriate creation command
- If all items are Must Have: Provide guidance on right-sizing
- If no items are Must Have: Confirm this is intentional
- If priorities conflict with dependencies: Highlight and suggest resolution
- If custom field update fails: Use interactive recovery (Retry/Skip/Check permissions/Stop)
- If label update fails: Note partial success, continue without blocking
- If rationale comment fails: Note failure, continue without blocking
- If batch partially completes: Show summary with updated/partial/failed counts

## Notes

- This command is idempotent: safe to run multiple times
- Use prioritization skill for MoSCoW framework details
- Must Haves should be <60% of total items
- "Won't Have" is important - makes exclusions explicit
- Re-prioritize as you learn (monthly/quarterly)
- Dependencies should influence sequencing
- Document rationale for priorities (especially Must Have and Won't Have)
- Update priorities in both custom fields AND labels for visibility
- Two-layer metadata (fields + labels) provides both project views and cross-project queries
- Partial failures are tracked separately from complete failures
