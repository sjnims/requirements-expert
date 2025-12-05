---
name: re:create-tasks
description: Break story into implementation tasks
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Create Tasks

Break down a selected user story into implementation tasks with clear acceptance criteria. Tasks are created as GitHub issues in a GitHub Project and linked to the parent story. This command is **idempotent**—safe to run multiple times without creating duplicates.

## Instructions

Load the **task-breakdown** skill for methodology and templates. Load **shared-patterns** skill for error handling and idempotency patterns.

### Step 1: Select Story to Break Down

1. Query project items: `gh project item-list [project-number] --format json`
2. Filter for Type = "Story"
3. If no stories found: Inform user to run `/re:create-stories` first, then exit

Use AskUserQuestion:

- Question: "Which user story would you like to break down into tasks?"
- Header: "Select Story"
- Options: One per story (label = story title, description = user story text)
- multiSelect: false

Read selected story: `gh issue view [story-issue-number] --repo [repo] --json body,title`

Query existing tasks under this story (Type = "Task" with "Parent: #[story-number]" in body) for duplicate checking.

### Step 2: Task Identification by Layer

Apply task-breakdown skill layer methodology (`references/task-layers.md`):

- Analyze story for implementation needs across layers: Frontend, Backend, Data, Testing, Documentation
- Suggest tasks organized by layer with brief descriptions
- Number tasks for easy reference
- Note which layers may not apply (e.g., Data only if schema changes needed)

### Step 3: Task Refinement

Use AskUserQuestion:

1. **Select tasks** (multiSelect: true): Present suggested tasks as options
2. **Add more?** (multiSelect: false): Options: "Add more", "Continue", "Review selection"

Handle "Add more" by prompting for task details. Handle "Review selection" by displaying current selection before re-asking.

### Step 4: Define Acceptance Criteria

For each task, define acceptance criteria per task-breakdown skill:

- Use checklist format with specific, testable outcomes
- Minimum 3-5 criteria per task

Present suggested criteria and confirm with user.

### Step 5: Task Size Validation

Validate each task:

- Target: 2-8 hours (up to 1-2 days max)
- If larger: Suggest splitting
- If too small: Consider merging or treating as subtask

### Step 6: Create Task Issues

Initialize batch tracking per shared-patterns skill: `created[]`, `skipped[]`, `updated[]`, `failed[]`

For each task:

#### 6a. Idempotency Check

Apply shared-patterns Idempotency Check pattern:

1. Query: `gh issue list --repo [repo] --label "type:task" --json number,title`
2. Compare titles (case-insensitive, trimmed)
3. If match found: Use AskUserQuestion (Skip/Update/Create anyway)
4. Track result in appropriate list

#### 6b. Create Issue

Read template: `plugins/requirements-expert/skills/task-breakdown/references/task-template.md`

Compile task description following template structure. Create issue:

```bash
gh issue create --repo [repo] --title "[Task title]" --body "[description]" --label "type:task,[layer-label]"
```

Layer labels: frontend, backend, database, testing, docs

On failure: Apply shared-patterns Recovery Flow (Retry/Skip/Check permissions/Stop).

#### 6c. Add to Project

```bash
gh project item-add [project-number] --owner [owner] --url [issue-url]
```

#### 6d. Set Custom Fields

Apply shared-patterns Two-Layer Metadata pattern:

- Type: Task
- Status: Not Started
- Priority: Inherit from story

#### 6e. Link to Story

Add comment: "Parent: #[story-issue-number]"

### Step 7: Task Sequencing

Apply task-breakdown skill sequencing methodology (`Step 5: Sequence and Dependencies`):

- Identify dependencies and critical path
- Group tasks by execution phase
- Note tasks that can parallelize

### Step 8: Continue or Done

Use AskUserQuestion:

- Question: "Create tasks for another story?"
- Header: "Continue"
- Options: "Select another story", "Done"
- multiSelect: false

Handle "Select another story" by restarting from Step 1. Handle "Done" by showing summary.

### Step 9: Summary & Next Steps

Display batch summary per shared-patterns format:

```text
**Task creation complete for Story #[story-num]!**

**Created:** [N] new tasks
[Group by layer: Frontend, Backend, Data, Testing, Documentation]
- #[num] - [Task title]

**Updated:** [N] existing tasks (if > 0)
**Skipped:** [N] duplicates (if > 0)
**Failed:** [N] tasks (if > 0)

**Suggested execution order:**
Phase 1: #[num], #[num] (no dependencies)
Phase 2: #[num] (depends on Phase 1)
Phase 3: #[num] (testing and documentation)

All tasks linked to Story (#[story-num])

**Next steps:**
- Review tasks in GitHub Projects
- Assign tasks to team members
- Start with Phase 1 tasks
- Run `/re:status` for project overview
```

## Error Handling

- No stories exist: Guide to `/re:create-stories`
- Story has no acceptance criteria: Suggest updating story first
- Duplicate detected: Use Idempotency Check pattern
- Creation fails: Use Recovery Flow pattern
- Task too large: Provide splitting guidance per skill
- No tasks identified: Story may be too vague
