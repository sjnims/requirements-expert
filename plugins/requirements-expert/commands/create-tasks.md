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

Ask Select Story: "Which user story would you like to break down into tasks?" (options: one per story)

Read selected story: `gh issue view [story-issue-number] --repo [repo] --json body,title`

Query existing tasks under this story (Type = "Task" with "Parent: #[story-number]" in body) for duplicate checking.

### Step 2: Task Identification by Layer

Apply task-breakdown skill layer methodology (`references/task-layers.md`):

- Analyze story for implementation needs across layers: Frontend, Backend, Data, Testing, Documentation
- Suggest tasks organized by layer with brief descriptions
- Number tasks for easy reference
- Note which layers may not apply (e.g., Data only if schema changes needed)

### Step 3: Task Refinement

1. Ask Select Tasks: "Which tasks should we create?" (options: one per suggested task, multiSelect: true)
2. Ask Add More: "Add more tasks?" (options: Add more, Continue, Review selection)

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
3. If match found: Ask Duplicate: "Task already exists. How to proceed?" (options: Skip, Update, Create anyway)
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

Ask Continue: "Create tasks for another story?" (options: Select another story, Done)

Handle "Select another story" by restarting from Step 1. Handle "Done" by showing summary.

### Step 9: Summary & Next Steps

Display batch summary per shared-patterns Batch Tracking format with task-specific additions:

- Group created tasks by layer (Frontend, Backend, Data, Testing, Documentation)
- Show suggested execution order by phase (from Step 7)
- Include parent story link
- Next steps: Review in GitHub Projects, assign tasks, start Phase 1, run `/re:status`
