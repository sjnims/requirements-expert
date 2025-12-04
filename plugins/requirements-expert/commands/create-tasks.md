---
name: re:create-tasks
description: Break story into implementation tasks
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Create Tasks

Break down a selected user story into concrete implementation tasks with clear acceptance criteria. Tasks are created as GitHub issues in a GitHub Project and automatically linked to the parent story. This command is **idempotent** - safe to run multiple times without creating duplicates.

## Instructions

Load the **task-breakdown** skill to access methodology, patterns, and templates.

### Step 1: Select Story to Break Down

1. **List Available Stories:**
   - Use `gh project item-list [project-number] --format json`
   - Filter for Type = "Story"
   - If no stories: Suggest running `/re:create-stories` first, exit

2. **Present Story Menu:**
   Use AskUserQuestion:
   - Question: "Which user story would you like to break down into tasks?"
   - Header: "Select Story"
   - Options: One option per story (label = story title, description = user story text)
   - multiSelect: false

3. **Read Story Issue:**
   - Use `gh issue view [story-issue-number] --repo [repo] --json body,title`
   - Extract story content and acceptance criteria

4. **Query Existing Tasks Under Story:**
   - From the project items fetched in step 1, filter for Type = "Task"
   - For each task, check if it references this story as parent (look for "Parent: #[story-number]" in body)
   - Store this list of existing tasks for duplicate checking in Step 6

### Step 2: Task Identification by Layer

Using task-breakdown skill methodology, identify tasks across implementation layers:

**Suggest tasks organized by layer:**

**Frontend/UI Tasks:**

- Create UI components
- Implement user interactions
- Client-side validation
- State management

**Backend/API Tasks:**

- Implement API endpoints
- Business logic
- Data validation
- Error handling

**Data/Database Tasks:**

- Schema changes (if needed)
- Data access layer
- Queries and optimization

**Testing Tasks:**

- Unit tests
- Integration tests
- User acceptance testing

**Documentation Tasks:**

- API documentation
- User-facing docs
- Code comments

Present the suggested tasks organized by implementation layer (Frontend, Backend, Data, Testing, Documentation):

- List each task with a brief description of what needs to be done
- Number the tasks for easy reference
- Include a total count of suggested tasks
- Note which layers may not be applicable (e.g., "Data" tasks only if schema changes are needed)

### Step 3: Task Refinement

Use AskUserQuestion:

- Question: "Which tasks should we create?"
- Header: "Tasks"
- Options: One per suggested task
- multiSelect: true

Then ask:

Use AskUserQuestion:

- question: "Would you like to add any additional tasks?"
- header: "Add Tasks"
- multiSelect: false
- options:
  - label: "Add more", description: "I have additional tasks to include"
  - label: "Continue", description: "Proceed with the selected tasks"
  - label: "Review selection", description: "Review the list before deciding"

If user selects "Other", use their custom description for additional tasks.

If user selects "Add more", prompt for task details. If "Review selection", display the current selection and ask again.

### Step 4: Define Acceptance Criteria

For each selected task, define specific acceptance criteria.

**Use checklist format:**

```text
- [ ] Specific, testable outcome 1
- [ ] Specific, testable outcome 2
- [ ] Specific, testable outcome 3
```

**Minimum 3-5 criteria per task.**

Present suggested criteria for each task and confirm with user.

### Step 5: Task Size Validation

Check each task:

- Should be 2-8 hours (up to 1-2 days max)
- If larger: Suggest splitting
- If too small: Consider merging or if it's really a subtask

### Step 6: Create Task Issues in GitHub

Initialize batch tracking lists:

- `created`: Tasks successfully created (with issue numbers and technical area)
- `skipped`: Tasks skipped due to duplicates (with existing issue numbers)
- `updated`: Existing tasks that were updated (with issue numbers)
- `failed`: Tasks that failed to create (with error reasons)

For each task:

#### 6a. Check for Existing Task (Idempotency)

Before creating, check if task already exists under this story:

1. **Check for Title Match:**
   - Compare new task title against existing task titles (from Step 1.4)
   - Trim leading/trailing whitespace before comparison
   - Use case-insensitive comparison

2. **If Match Found:**

   Use AskUserQuestion:

   - question: "Task '[task-title]' appears to already exist as #[existing-issue-number]. What would you like to do?"
   - header: "Duplicate"
   - multiSelect: false
   - options:
     - label: "Skip"
       description: "Don't create this task, continue with next"
     - label: "Update"
       description: "Update existing task with new acceptance criteria"
     - label: "Create anyway"
       description: "Create as new task (will be duplicate)"

   **Handle response:**

   - **Skip**: Add to `skipped` list with existing issue number, continue to next task
   - **Update**: Use `gh issue edit [existing-issue-number] --repo [repo] --body "[updated-description]"` to replace with new content including acceptance criteria, add to `updated` list, continue to next task
   - **Create anyway**: Proceed with creation (user acknowledged duplicate)

3. **If No Match:**
   - Proceed with creation

#### 6b. Compile Task Description

First, read the comprehensive template using the Read tool:

```text
plugins/requirements-expert/skills/task-breakdown/references/task-template.md
```

Follow that template structure:

```markdown
## Task: [Action-oriented title]

### Description
[Clear description of what needs to be done]

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Technical Notes
**Files to Modify:**
- [File 1]
- [File 2]

**Patterns to Follow:**
- [Reference to existing code pattern]

**Parent:** [Link to Story Issue #]
```

#### 6c. Create Issue

Use `gh issue create --repo [repo] --title "[Task title]" --body "[task description]" --label "type:task,[technical-area]"`

Add technical area labels: frontend, backend, database, testing, docs

**If Creation Fails:**

Capture error output from gh CLI.

Display: "Failed to create task '[task-title]': [error message]"

Use AskUserQuestion for recovery:

- question: "Task creation failed. How would you like to proceed?"
- header: "Recovery"
- multiSelect: false
- options:
  - label: "Retry"
    description: "Try creating this task again"
  - label: "Skip"
    description: "Skip this task, continue with remaining"
  - label: "Check permissions"
    description: "Show diagnostic commands"
  - label: "Stop"
    description: "Stop and show summary of progress"

**Handle response:**

- **Retry**: Re-attempt creation. If fails again, present recovery options again.
- **Skip**: Add to `failed` list with error reason, continue to next task.
- **Check permissions**:
  - Run: `gh auth status`
  - Display the output
  - Explain: "Issue creation requires 'repo' scope."
  - After showing diagnostics, present the same recovery options again
- **Stop**: Exit loop and proceed to Step 8 (show summary with progress so far)

**If Creation Succeeds:**

- Capture issue number and URL
- Add to `created` list with technical area

#### 6d. Add to Project

Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

#### 6e. Set Custom Fields

- Type: Task
- Status: Not Started
- Priority: (Inherit from story)

#### 6f. Link to Story (Parent)

- Add comment to task: "Parent: #[story-issue-number]"

### Step 7: Task Sequencing

After creating all tasks, identify dependencies:

- Which tasks must come first?
- What's the critical path?
- Can any tasks be done in parallel?

Present the task execution order organized by phase:

- Phase 1: Tasks that can start immediately with no dependencies
- Phase 2: Tasks that depend on Phase 1 completion
- Phase 3: Integration, testing, and documentation tasks
- List tasks with their issue numbers in each phase

### Step 8: Success Message

After processing all tasks, display a batch summary:

**Task creation complete for Story #[story-num]!**

**Created:** [N] new tasks

**Frontend:**

- #[num] - [Task title]

**Backend:**

- #[num] - [Task title]

**Data:**

- #[num] - [Task title]

**Testing:**

- #[num] - [Task title]

**Documentation:**

- #[num] - [Task title]

**Updated:** [N] existing tasks (only if > 0)

- #[num] - [Task title]

**Skipped (duplicates):** [N] tasks (only if > 0)

- [Task title] (existing #[num])

**Failed:** [N] tasks (only if > 0)

- [Task title]: [error reason]

All tasks linked to Story #[story-num]

**Suggested execution order:**
Phase 1: #[num], #[num] (no dependencies)
Phase 2: #[num] (depends on Phase 1)
Phase 3: #[num] (testing and documentation)

**Next steps:**

- Review tasks in GitHub Projects
- Assign tasks to team members (if working with a team)
- Start with Phase 1 tasks (no dependencies)
- Update task status as you progress
- Run `/re:status` to see overall project progress
- When all tasks complete, the story is complete

### Step 9: Continue or Done

Use AskUserQuestion:

- Question: "Create tasks for another story?"
- Header: "Continue"
- Options:
  - "Select another story" (description: "Create tasks for a different story")
  - "Done" (description: "Finish task creation")
- multiSelect: false

**Handle response:**

- "Select another story": Restart from Step 1
- "Done": Exit

## Error Handling

- If no stories exist: Guide to `/re:create-stories`
- If story has no acceptance criteria: Suggest updating story first
- If duplicate task detected: Use interactive prompt (Skip/Update/Create anyway)
- If task creation fails: Use interactive recovery (Retry/Skip/Check permissions/Stop)
- If tasks too large: Provide splitting guidance
- If no technical tasks identified: Might be story is too vague

## Notes

- This command is idempotent: safe to run multiple times
- Use task-breakdown skill for methodology and patterns
- Task titles should be action-oriented (start with verbs)
- Each task: 2-8 hours of work
- Minimum 3-5 acceptance criteria per task
- Label tasks by technical area (frontend, backend, database, testing, docs)
- Tasks are created as GitHub issues in a GitHub Project (not local files)
- Full traceability: Vision -> Epic -> Story -> Task
