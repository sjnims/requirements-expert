---
name: re:prioritize
description: Prioritize requirements with MoSCoW
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Prioritize Requirements

Prioritize requirements at any level (epics, stories, or tasks) using the MoSCoW framework. Updates GitHub Project issues with priority labels and custom fields.

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

For each item, update GitHub:

1. **Update Priority Custom Field:**
   - Use `gh project item-edit` to set Priority field to selected MoSCoW category

2. **Add Priority Label:**
   - Use `gh issue edit [issue-number] --add-label "priority:[moscow-level]"`
   - Labels: `priority:must-have`, `priority:should-have`, `priority:could-have`, `priority:wont-have`

3. **Add Comment with Rationale:**
   - Ask user for brief rationale for each Must Have and Won't Have
   - Add comment to issue: "Priority: [level] - Rationale: [user-provided text]"

### Step 7: Sequence Within Categories

After prioritization, determine execution order:

**For Must Haves:**
Ask about sequencing factors:
- Dependencies (what must come first?)
- Risk (tackle unknowns early?)
- Value (highest value first?)

Present suggested sequence and ask for confirmation.

### Step 8: Success Message & Summary

Display a success summary that includes:

- Confirmation that prioritization is complete
- Summary showing count of items in each priority category (Must Have, Should Have, Could Have, Won't Have)
- Execution order listing Must Have items with their issue numbers and titles
- Context-appropriate next steps based on what was prioritized:
  - If epics: start with first Must Have epic, run `/re:create-stories` for that epic, focus on completing Must Haves before Should Haves
  - If stories: start with first Must Have story, run `/re:create-tasks` for that story, complete stories in priority order
  - If tasks: begin implementation with Must Have tasks, follow dependency order within priority level, update task status in GitHub Projects as you progress

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

## Notes

- Use prioritization skill for MoSCoW framework details
- Must Haves should be <60% of total items
- "Won't Have" is important - makes exclusions explicit
- Re-prioritize as you learn (monthly/quarterly)
- Dependencies should influence sequencing
- Document rationale for priorities (especially Must Have and Won't Have)
- Update priorities in both custom fields AND labels for visibility
