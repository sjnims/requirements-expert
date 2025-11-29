---
name: Task Breakdown
description: This skill should be used when the user asks to "create tasks", "break down story into tasks", "define tasks", "what tasks are needed", "write acceptance criteria", "implementation tasks", "task list", "create work items", "technical tasks", "work breakdown", "decompose story", "story to tasks", or when decomposing user stories into specific, executable tasks with clear acceptance criteria for GitHub Projects.
version: 0.2.0
---

# Task Breakdown

## Overview

Task breakdown transforms user stories into concrete, executable work items that can be assigned, tracked, and completed. Tasks represent the actual implementation steps needed to deliver a user story, each with clear acceptance criteria. This skill guides the process of decomposing stories into well-defined tasks suitable for GitHub issue tracking.

## Purpose

Tasks are the execution layer in the requirements hierarchy:
- **Above**: User Stories (user-facing functionality)
- **Tasks**: Specific implementation steps
- **Below**: (Nothing—tasks are the lowest level)

Well-defined tasks:
- Represent discrete units of work (hours to 1-2 days max)
- Have clear, testable acceptance criteria
- Can be assigned to individuals
- Track progress toward story completion
- Enable accurate status reporting

## When to Use This Skill

Use task breakdown when:
- A user story exists and needs to be implemented
- User asks for specific work items or tasks
- Planning a sprint and need granular work breakdown
- Creating GitHub issues in a GitHub Project for tracking work
- Defining clear acceptance criteria for work items

**Prerequisite:** User story must exist before creating tasks. If no story exists, use user-story-creation skill first.

## Task Characteristics

### What Makes a Good Task

**Specific and Concrete:**
- Clear, unambiguous description
- Obvious what needs to be done
- No interpretation needed

**Right-sized:**
- 2-8 hours of work (up to 1-2 days maximum)
- Small enough to complete in a single sitting when possible
- Large enough to deliver meaningful progress

**Testable:**
- Has clear acceptance criteria
- Can verify when complete
- Observable outcome

**Assignable:**
- One person can own and complete it
- Doesn't require coordinating multiple people

**Valuable:**
- Contributes toward completing the story
- Represents real progress

## Task Breakdown Process

### Step 1: Review the User Story

Understand the story being implemented:

**Key Actions:**
- Read story issue in GitHub Projects
- Understand the user goal and value
- Review acceptance criteria
- Note any constraints or assumptions

### Step 2: Identify Implementation Layers

Break down work by typical software layers:

**Frontend/UI Tasks:**
- Component creation
- UI layout and styling
- User interactions and events
- Client-side validation
- State management

**Backend/API Tasks:**
- API endpoint implementation
- Business logic
- Data validation
- Error handling
- Integration with services

**Data/Database Tasks:**
- Schema changes
- Migrations
- Data access layer
- Queries and optimization

**Testing Tasks:**
- Unit tests
- Integration tests
- E2E tests
- Manual test scenarios

**Documentation Tasks:**
- API documentation
- User-facing documentation
- Code comments
- README updates

**DevOps/Infrastructure Tasks:**
- Configuration changes
- Deployment scripts
- Environment setup
- Monitoring/logging

### Step 3: Apply Common Task Patterns

Use these patterns as starting points:

**CRUD Operations:**
- Implement Create functionality
- Implement Read/List functionality
- Implement Update functionality
- Implement Delete functionality
- Add validation for each operation

**Feature Implementation:**
- Design and create UI components
- Implement backend API
- Connect frontend to backend
- Add error handling
- Write tests
- Update documentation

**Integration:**
- Research third-party API/service
- Implement authentication/connection
- Implement data mapping/transformation
- Handle errors and edge cases
- Test integration end-to-end

### Step 4: Define Acceptance Criteria

For each task, specify clear success conditions:

**Format:**

Use specific, testable statements:
- "Component renders correctly with props X, Y, Z"
- "API endpoint returns 200 status with correct data structure"
- "Database migration runs without errors and creates table T"
- "Unit tests achieve >80% code coverage for module M"

**Key Elements:**
- What should exist/work when task is complete
- How to verify it works
- Any performance or quality standards

### Step 5: Sequence and Dependencies

Order tasks logically:

**Dependency Analysis:**
- Which tasks must come first?
- What's the critical path?
- Can any tasks be done in parallel?

**Typical Sequence:**
1. Data/schema changes (if needed)
2. Backend implementation
3. Frontend implementation
4. Integration and testing
5. Documentation

**Mark Dependencies:**
- Note which tasks block others
- Identify tasks that can start immediately
- Plan for parallel work when possible

### Step 6: Create Task Issues in GitHub Projects

For each task, create a GitHub issue in the relevant GitHub Project:

**Issue Title:** "[Clear, action-oriented task description]"

**Issue Description:** Task details and acceptance criteria using template

**Custom Fields:**
- Type: Task
- Priority: (inherited from story)
- Status: Not Started

**Labels:**
- `type:task`
- Technical labels (frontend, backend, database, testing, docs)

**Parent:** Link to Story issue as parent

**Estimate:** (optional) Hour or story point estimate

## Task Templates and Examples

For detailed task templates and examples by type (Frontend, Backend, Database, Testing, Documentation, Research/Spike), see `references/task-template.md`.

## Best Practices

### Keep Tasks Focused

One clear objective per task:

❌ "Implement campaign filtering and sorting and export"
✅ "Implement campaign date filtering"
✅ "Implement campaign sorting by name"
✅ "Implement campaign CSV export"

### Use Action-Oriented Titles

Start with verbs:

**Good:**
- "Create campaign filter component"
- "Implement date validation logic"
- "Add database index for performance"
- "Write unit tests for filter module"

**Poor:**
- "Campaign filtering" (vague)
- "Database" (what about it?)
- "Tests" (what kind? for what?)

### Include Technical Context

Help the implementer:
- Reference existing code patterns to follow
- Note relevant files or modules
- Mention design system components to use
- Link to related tasks or documentation

### Balance Granularity

Not too big, not too small:

**Too big:**
"Implement entire campaign management system" (this is a story or epic)

**Too small:**
"Import React" (this is a substep, not a task)

**Just right:**
"Create CampaignList component with sorting and filtering props"

### Always Include Acceptance Criteria

Never create a task without clear success conditions:
- Minimum 3-5 criteria per task
- Make them specific and testable
- Include both functional and quality criteria

## Task Types

### Implementation Tasks

Primary work to build functionality:
- Create UI components
- Implement API endpoints
- Write business logic
- Build data access layer

### Testing Tasks

Verify quality and correctness:
- Write unit tests
- Create integration tests
- Perform manual testing
- User acceptance testing

### Documentation Tasks

Communicate how it works:
- API documentation
- User guides
- Code comments
- README updates

### Infrastructure Tasks

Enable functionality:
- Database migrations
- Configuration changes
- Deployment scripts
- Environment setup

### Research/Spike Tasks

Investigate unknowns:
- Evaluate libraries/tools
- Prototype approaches
- Performance testing
- Feasibility studies

## Common Pitfalls to Avoid

### Tasks Without Acceptance Criteria

Every task needs testable success conditions:

❌ "Work on campaign filtering"
✅ "Implement date filter UI" + 5 specific acceptance criteria

### Tasks Too Large

Watch for multi-day or multi-person tasks:
- Split tasks larger than 2 days
- Each task should be completable by one person
- If coordination needed, it's probably too big

### Mixing Concerns

One task, one focus area:

❌ "Implement filter UI and backend API and database schema"
✅ Three separate tasks for UI, API, and database

### Vague Descriptions

Be specific about what needs to be done:

❌ "Fix bugs"
✅ "Fix date validation bug where end date before start date is allowed"

### Missing Dependencies

Note what must be done first:
- Database schema before backend code
- Backend API before frontend integration
- Core functionality before tests (usually)

## Integration with GitHub Issues (GitHub Projects)

### Task Issue Format

**Title:** Clear, action-oriented description

**Labels:**
- `type:task`
- Technical area (frontend, backend, database, etc.)
- Priority (inherited from story)

**Assignment:** Person responsible

**Estimate:** Optional hours or points

**Parent Link:** User story issue

**Acceptance Criteria:** In issue description

### Tracking Progress

Tasks enable granular progress tracking:
- Story progress = % of tasks complete
- Epic progress = % of stories complete (via tasks)
- Vision progress = % of epics complete (via stories → tasks)

Full traceability: Vision → Epic → Story → Task

## Quick Reference: Task Breakdown Flow

1. **Review Story** → Understand user goal, value, acceptance criteria
2. **Identify Layers** → Frontend, backend, database, testing, docs, infrastructure
3. **Apply Patterns** → Use common task patterns as starting points
4. **Define Acceptance Criteria** → Specify testable success conditions for each task
5. **Sequence** → Order tasks, note dependencies
6. **Create Issues** → Add to GitHub Projects as children of story
7. **Assign** → (Optional) Assign tasks to team members
8. **Execute** → Begin work, update task status as progress is made

## Reference Files

Load references as needed:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **task-template.md** | Creating task issue content or defining acceptance criteria | `references/task-template.md` |

## Examples

Working examples that can be copied and adapted:

| Example | Use Case | Path |
|---------|----------|------|
| **example-task-issue.md** | Creating a single task with full detail | `examples/example-task-issue.md` |
| **example-task-set.md** | Viewing related tasks for a story | `examples/example-task-set.md` |

## Next Steps

After creating tasks:
1. Create task issues in GitHub Projects (as children of story issue)
2. Assign tasks to team members (if applicable)
3. Begin execution—implement, test, document
4. Update task status as work progresses
5. When all tasks complete, story is complete

Tasks are where vision becomes reality—invest time to make them clear, testable, and actionable.
