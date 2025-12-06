---
name: re:create-stories
description: Break epic into INVEST-compliant stories
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Create User Stories

Break down a selected epic into user stories following INVEST criteria and create story issues in GitHub Projects as children of the epic issue. This command is **idempotent**—safe to run multiple times without creating duplicates.

## Instructions

Load the **user-story-creation** skill for methodology and templates. Load **shared-patterns** skill for error handling and idempotency patterns.

### Step 1: Select Epic to Break Down

1. Query project items: `gh project item-list [project-number] --format json`
2. Filter for Type = "Epic"
3. If no epics found: Inform user to run `/re:identify-epics` first, then exit

Ask Select Epic: "Which epic would you like to break down into user stories?" (options: one per epic)

Read selected epic: `gh issue view [epic-issue-number] --repo [repo] --json body,title`

Query existing stories under this epic (Type = "Story" with "Parent: #[epic-number]" in body) for duplicate checking.

### Step 2: Story Discovery & Drafting

Apply story discovery from user-story-creation skill:

- Analyze epic for user journeys (task analysis, scenario mapping, user types)
- Suggest 5-15 stories using standard format:

```text
As a [user type], I want [goal], so that [benefit].
```

Present suggested stories organized by category (Core Functionality, Supporting Features, Edge Cases). Number stories for easy reference.

### Step 3: Story Refinement

1. Ask Select Stories: "Which stories should we create?" (options: one per suggested story, multiSelect: true)
2. Ask Add More: "Add more stories?" (options: Add more, Continue, Review selection)

Handle "Add more" by prompting for story details. Handle "Review selection" by displaying current selection before re-asking.

### Step 4: INVEST Validation

Validate each story against INVEST criteria from user-story-creation skill (`references/invest-criteria.md`):

- Independent, Negotiable, Valuable, Estimable, Small (1-5 days), Testable

If violations found, suggest refinements per skill guidance (splitting, reframing, adding acceptance criteria).

### Step 5: Add Acceptance Criteria

For each story, define acceptance criteria using Given-When-Then or checklist format from user-story-creation skill. Present suggested criteria and confirm with user.

### Step 6: Create Story Issues

Initialize batch tracking per shared-patterns skill: `created[]`, `skipped[]`, `updated[]`, `failed[]`

For each finalized story:

#### 6a. Idempotency Check

Apply shared-patterns Idempotency Check pattern:

1. Query: `gh issue list --repo [repo] --label "type:story" --json number,title`
2. Compare titles (case-insensitive, trimmed)
3. If match found: Ask Duplicate: "Story already exists. How to proceed?" (options: Skip, Update, Create anyway)
4. Track result in appropriate list

#### 6b. Create Issue

Read template: `plugins/requirements-expert/skills/user-story-creation/references/story-template.md`

Compile story description following template structure. Create issue:

```bash
gh issue create --repo [repo] --title "[Story title]" --body "[description]" --label "type:story"
```

On failure: Apply shared-patterns Recovery Flow (Retry/Skip/Check permissions/Stop).

#### 6c. Add to Project

```bash
gh project item-add [project-number] --owner [owner] --url [issue-url]
```

#### 6d. Set Custom Fields

Apply shared-patterns Two-Layer Metadata pattern:

- Type: Story
- Status: Not Started
- Priority: Inherit from epic or set during prioritization

#### 6e. Link to Epic

Add comment: "Parent: #[epic-issue-number]"

### Step 7: Story Count Validation

Check total stories for epic:

- < 3: May be too few, epic might be too small
- > 20: May be too many, epic might be too large
- Ideal: 5-15 stories per epic

### Step 8: Continue or Done

Ask Continue: "Create stories for another epic?" (options: Select another epic, Done)

Handle "Select another epic" by restarting from Step 1. Handle "Done" by showing summary.

### Step 9: Summary & Next Steps

Display batch summary per shared-patterns format:

```text
**Story creation complete for Epic #[epic-num]!**

**Created:** [N] new stories
- #[num] - [Story title]

**Updated:** [N] existing stories (if > 0)
**Skipped:** [N] duplicates (if > 0)
**Failed:** [N] stories (if > 0)

All stories linked to Epic (#[epic-num])

**Next steps:**
- Run `/re:prioritize` to rank stories by importance
- Run `/re:create-tasks` to break down highest-priority story
- Use `/re:status` for project overview
```

## Error Handling

- No epics exist: Guide to `/re:identify-epics`
- Epic has no content: Suggest updating epic issue first
- Duplicate detected: Use Idempotency Check pattern
- Creation fails: Use Recovery Flow pattern
- Story violates INVEST: Provide refinement per skill guidance
- Too many/few stories: Provide right-sizing guidance
