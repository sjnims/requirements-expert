---
name: re:create-stories
description: Break down an epic into user stories following INVEST criteria and create story issues in GitHub Projects
allowed-tools: [AskUserQuestion, Bash, Read]
---

# Create User Stories

Break down a selected epic into user stories following INVEST criteria and create story issues in GitHub Projects as children of the epic issue.

## Instructions

Load the **user-story-creation** skill to access methodology, INVEST criteria, and templates.

### Step 1: Select Epic to Break Down

1. **List Available Epics:**
   - Use `gh project item-list [project-id] --format json`
   - Filter for Type = "Epic"
   - If no epics: Suggest running `/re:identify-epics` first, exit

2. **Present Epic Menu:**
   Use AskUserQuestion:
   - Question: "Which epic would you like to break down into user stories?"
   - Header: "Select Epic"
   - Options: One option per epic (label = epic name, description = brief desc from issue)
   - multiSelect: false

3. **Read Epic Issue:**
   - Use `gh issue view [epic-issue-number] --repo [repo] --json body,title`
   - Extract epic content for story creation

### Step 2: Story Discovery & Drafting

Using user-story-creation skill methodology:

**Analyze Epic for User Journeys:**
- What tasks do users need to complete?
- What scenarios or use cases exist?
- Do different user types need different stories?

**Draft Initial Stories:**
Suggest 5-15 user stories for the epic using standard format:
```
As a [user type],
I want [goal],
So that [benefit].
```

Present suggestions:
```
Based on the epic "[Epic Name]", here are suggested user stories:

**Core Functionality:**
1. As a [user], I want [goal], so that [benefit]
2. As a [user], I want [goal], so that [benefit]

**Supporting Features:**
3. As a [user], I want [goal], so that [benefit]

**Edge Cases & Enhancements:**
4. As a [user], I want [goal], so that [benefit]

These cover the main user journeys - would you like to add, remove, or modify any?
```

### Step 3: Story Refinement

Use AskUserQuestion:
- Question: "Which stories should we include?"
- Header: "Story Selection"
- Options: One per suggested story (label = short title, description = full story)
- multiSelect: true

Then ask:
- Question: "Any additional stories to add?"
- Header: "Add Stories"
- Options: Custom text input

### Step 4: INVEST Criteria Check

For each selected story, verify INVEST criteria:
- **Independent**: Can be completed separately
- **Negotiable**: Details open for discussion
- **Valuable**: Delivers user value
- **Estimable**: Team can estimate size
- **Small**: Fits in 1-5 days
- **Testable**: Has clear acceptance criteria

If story fails INVEST, suggest refinements:
- Too large? Suggest splitting
- Not valuable? Suggest reframing or removing
- Not testable? Suggest adding acceptance criteria

### Step 5: Add Acceptance Criteria

For each story, define acceptance criteria. Use format from user-story-creation skill:

**Given-When-Then format:**
```
- Given [context]
  When [action]
  Then [outcome]
```

**Or checklist format:**
```
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3
```

For each story, present suggested acceptance criteria and ask user to confirm/refine.

### Step 6: Create Story Issues

For each finalized story:

1. **Compile Story Description:**
   Use template from user-story-creation skill's references: `${CLAUDE_PLUGIN_ROOT}/skills/user-story-creation/references/story-template.md`:
   ```markdown
   ## User Story: [Short title]

   ### Story
   As a [user type],
   I want [goal],
   So that [benefit].

   ### Acceptance Criteria
   - [ ] Criterion 1
   - [ ] Criterion 2
   - [ ] Criterion 3

   ### Notes
   [Any assumptions or constraints]

   **Parent:** [Link to Epic Issue #]
   ```

2. **Create Issue:**
   - Use `gh issue create --repo [repo] --title "[Story short title]" --body "[story description]" --label "type:story"`
   - Capture issue number and URL

3. **Add to Project:**
   - Use `gh project item-add [project-id] --owner [owner] --url [issue-url]`

4. **Set Custom Fields:**
   - Type: Story
   - Status: Not Started
   - Priority: (Inherit from epic or set during prioritization)

5. **Link to Epic (Parent):**
   - Add comment to story: "Parent: #[epic-issue-number]"

### Step 7: Story Count Validation

Check total number of stories:
- If < 3: Might be too few, epic might be too small
- If > 20: Might be too many, epic might be too large
- Ideal range: 5-15 stories per epic

### Step 8: Next Story or Next Phase

After creating all stories for current epic, ask:

Use AskUserQuestion:
- Question: "What would you like to do next?"
- Header: "Next Step"
- Options:
  - "Create stories for another epic" (description: "Select a different epic and create stories")
  - "Prioritize stories" (description: "Use MoSCoW to prioritize these stories")
  - "Create tasks for a story" (description: "Break down a story into tasks")
  - "Done for now" (description: "Stop here")
- multiSelect: false

**Handle response:**
- "Create stories for another epic": Restart from Step 1
- "Prioritize stories": Execute `/re:prioritize`
- "Create tasks for a story": Execute `/re:create-tasks`
- "Done for now": Show success message

### Step 9: Success Message

Display:
```
✅ Created [N] user stories for epic #[epic-num]!

Stories:
- #[num] - [Story 1 title]
- #[num] - [Story 2 title]
...

Next Steps:
1. Run `/re:prioritize` to rank stories
2. Run `/re:create-tasks` to break down highest-priority story
3. Review stories and refine acceptance criteria
4. Use `/re:status` to see progress

Pro tip: Tackle stories one at a time - implement, test, ship, repeat!
```

## Error Handling

- If no epics exist: Guide to `/re:identify-epics`
- If epic has no content: Suggest updating epic issue first
- If story violates INVEST: Provide refinement suggestions
- If too many/few stories: Guidance on right-sizing

## Notes

- Use user-story-creation skill for INVEST criteria and methodology
- Each story follows standard "As a... I want... So that..." format
- Minimum 3-5 acceptance criteria per story
- Stories should be 1-5 days of work
- Split large stories using techniques from skill
- Ensure every story delivers user value
