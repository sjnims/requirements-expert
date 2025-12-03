---
name: re:create-tasks
description: Break story into implementation tasks
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Create Tasks

Break down a selected user story into concrete implementation tasks with clear acceptance criteria. Tasks are created as GitHub issues in a GitHub Project and automatically linked to the parent story.

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

For each selected task, define specific acceptance criteria:

#### Use checklist format

```
- [ ] Specific, testable outcome 1
- [ ] Specific, testable outcome 2
- [ ] Specific, testable outcome 3
```

#### Minimum 3-5 criteria per task

Present suggested criteria for each task and confirm with user.

### Step 5: Task Size Validation

Check each task:
- Should be 2-8 hours (up to 1-2 days max)
- If larger: Suggest splitting
- If too small: Consider merging or if it's really a subtask

### Step 6: Create Task Issues in GitHub

For each task:

1. **Compile Task Description:**
   First, read the comprehensive template using the Read tool:

   ```
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

2. **Create GitHub Issue in GitHub Project:**
   - Use `gh issue create --repo [repo] --title "[Task title]" --body "[task description]" --label "type:task,[technical-area]"`
   - Add technical area labels: frontend, backend, database, testing, docs
   - Capture issue number and URL

3. **Add to Project:**
   - Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

4. **Set Custom Fields:**
   - Type: Task
   - Status: Not Started
   - Priority: (Inherit from story)

5. **Link to Story (Parent):**
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

### Step 8: Success Message & Assignment

Display a success summary that includes:

- Confirmation of how many tasks were created and for which story
- List of all created tasks with their issue numbers, titles, and technical area labels
- Summary of what was done: issues created in GitHub Project, added to project, linked to parent story, labeled by technical area
- Next steps: review tasks in GitHub Projects, assign tasks to team members (if working with a team), start with Phase 1 tasks (no dependencies), update task status as you progress, when all tasks complete the story is complete

### Step 9: Continue or Stop

Use AskUserQuestion:
- Question: "What would you like to do next?"
- Header: "Next Step"
- Options:
  - "Select another story" (description: "Select a different story")
  - "Show status" (description: "See overall progress")
  - "Exit" (description: "Stop here")
- multiSelect: false

**Handle response:**
- "Select another story": Restart from Step 1
- "Show status": Use the SlashCommand tool to invoke `/re:status`
- "Exit": Exit

## Error Handling

- If no stories exist: Guide to `/re:create-stories`
- If story has no acceptance criteria: Suggest updating story first
- If tasks too large: Provide splitting guidance
- If no technical tasks identified: Might be story is too vague

## Notes

- Use task-breakdown skill for methodology and patterns
- Task titles should be action-oriented (start with verbs)
- Each task: 2-8 hours of work
- Minimum 3-5 acceptance criteria per task
- Label tasks by technical area (frontend, backend, database, testing, docs)
- Tasks are created as GitHub issues in a GitHub Project (not local files)
- Full traceability: Vision → Epic → Story → Task
