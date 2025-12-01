---
name: re:create-tasks
description: Break down a user story into implementation tasks with acceptance criteria and create GitHub issues in a GitHub Project.
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

Present suggested tasks:
```
Based on the story "[Story Title]", here are suggested implementation tasks:

**Frontend:**
1. Create [component] component
2. Implement [interaction] functionality

**Backend:**
3. Implement GET/POST [endpoint] API endpoint
4. Add validation for [data]

**Data:**
5. [If needed] Add database indexes for [performance]

**Testing:**
6. Write unit tests for [module]
7. Create integration tests for [feature]

**Documentation:**
8. Document [API/feature] in user guide

Estimated: [X] tasks total
```

### Step 3: Task Refinement

Use AskUserQuestion:
- Question: "Which tasks should we create?"
- Header: "Task Selection"
- Options: One per suggested task
- multiSelect: true

Then ask:

Use AskUserQuestion:
- question: "Would you like to add any additional tasks?"
- header: "Add Tasks"
- multiSelect: false
- options:
  - label: "Yes, add more", description: "I have additional tasks to include"
  - label: "No, continue", description: "Proceed with the selected tasks"
  - label: "Let me think", description: "Review the list before deciding"

Note: Users can select "Other" to directly describe additional tasks.

If user selects "Yes, add more", prompt for task details. If "Let me think", display the current selection and ask again.

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

Display task execution order:
```
📋 Task Sequence:

**Phase 1 (Can start immediately):**
- #[num] - [Task requiring no dependencies]
- #[num] - [Another independent task]

**Phase 2 (After Phase 1):**
- #[num] - [Task depending on Phase 1]

**Phase 3 (Integration & Testing):**
- #[num] - Integration tests
- #[num] - Documentation
```

### Step 8: Success Message & Assignment

Display:
```
✅ Created [N] tasks for story #[story-num]!

Tasks:
- #[num] - [Task 1] (frontend)
- #[num] - [Task 2] (backend)
- #[num] - [Task 3] (testing)
...

All tasks have been:
- Created as GitHub issues in a GitHub Project
- Added to the project
- Linked to parent story #[story-num]
- Labeled by technical area

Next Steps:
1. Review tasks in GitHub Projects
2. Assign tasks to team members (if working with a team)
3. Start with Phase 1 tasks (no dependencies)
4. Update task status as you progress
5. When all tasks complete, story is complete!
```

### Step 9: Continue or Stop

Use AskUserQuestion:
- Question: "What would you like to do next?"
- Header: "Next Step"
- Options:
  - "Create tasks for another story" (description: "Select a different story")
  - "Check project status" (description: "See overall progress")
  - "Done for now" (description: "Stop here")
- multiSelect: false

**Handle response:**
- "Create tasks for another story": Restart from Step 1
- "Check project status": Use the SlashCommand tool to invoke `/re:status`
- "Done for now": Exit

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
