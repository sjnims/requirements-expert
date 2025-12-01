---
name: re:identify-epics
description: Identify major capabilities (epics) from vision and create epic issues in GitHub Projects
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Identify Epics

Identify major capabilities (epics) from the product vision and create epic issues in GitHub Projects as children of the vision issue.

## Instructions

Load the **epic-identification** skill to access methodology and templates.

### Step 1: Verify Prerequisites

1. **Check for Vision:**
   - Use `gh project item-list [project-number] --format json` to list items
   - Filter for Type = "Vision"
   - If no vision found: Inform user they need to run `/re:discover-vision` first, then exit
   - Store vision issue number/URL for parent linking

2. **Read Vision Issue:**
   - Use `gh issue view [vision-issue-number] --repo [repo] --json body`
   - Extract vision content to use for epic identification

### Step 2: Automated Epic Suggestion

Analyze the vision and suggest potential epics using epic-identification skill methodology:

**Use these discovery techniques:**
- User Journey Mapping: What end-to-end journeys do users take?
- Capability Decomposition: What major capabilities are needed?
- Stakeholder Needs: What do different user types need?
- Technical Enablers: What infrastructure is required?

**Suggest 5-10 potential epics based on the vision:**
- Present as a numbered list
- Brief description (1-2 sentences) for each
- Categorize (User-Facing, Infrastructure, Integration, etc.)

Display:
```
Based on your vision, I've identified these potential epics:

**User-Facing Capabilities:**
1. [Epic name] - [Brief description]
2. [Epic name] - [Brief description]

**Infrastructure:**
3. [Epic name] - [Brief description]

**Integration:**
4. [Epic name] - [Brief description]

These are suggestions - you can accept, modify, or add your own.
```

### Step 3: Epic Selection & Refinement

Use AskUserQuestion to refine the epic list:

**Question 1:**
- Question: "Which of these suggested epics should we include? (Select all that apply)"
- Header: "Epic Selection"
- multiSelect: true
- Options: One option per suggested epic (label = epic name, description = brief desc)

**Question 2:**

Use AskUserQuestion:
- question: "Would you like to add any additional epics?"
- header: "Add Epics"
- multiSelect: false
- options:
  - label: "Yes, add more", description: "I have additional epics to include"
  - label: "No, continue", description: "Proceed with the selected epics"
  - label: "Let me think", description: "Review the list before deciding"

Note: Users can select "Other" to directly describe additional epics.

If user selects "Yes, add more", prompt for epic details. If "Let me think", display the current selection and ask again.

### Step 4: Validate Epic Count

Check the total number of epics:
- If < 5: Suggest this might be too few, ask if more decomposition needed
- If > 15: Suggest this might be too many, ask if some can be combined
- Ideal range: 5-12 epics

### Step 5: Create Epic Issues

For each selected/added epic:

1. **Compile Epic Description:**
   First, read the comprehensive template using the Read tool:

   ```
   plugins/requirements-expert/skills/epic-identification/references/epic-template.md
   ```

   Follow that template structure:
   ```markdown
   ## Epic: [Epic Name]

   ### Overview
   [Brief description of what this epic delivers]

   ### User Value
   [Who benefits and how]

   ### Scope
   **Included:**
   - [Capability 1]
   - [Capability 2]

   **Excluded:**
   - [Not included 1]

   ### Success Criteria
   - [Criterion 1]
   - [Criterion 2]

   ### Dependencies
   [None identified yet - will be defined during story creation]

   **Parent:** [Link to Vision Issue #]
   ```

2. **Create Issue:**
   - Use `gh issue create --repo [repo] --title "[Epic Name]" --body "[epic description]" --label "type:epic"`
   - Capture issue number and URL

3. **Add to Project:**
   - Use `gh project item-add [project-number] --owner [owner] --url [issue-url]`

4. **Set Custom Fields:**
   - Type: Epic
   - Status: Not Started
   - Priority: (Will be set in prioritization step)

5. **Link to Vision (Parent):**
   - Add comment to epic issue: "Parent: #[vision-issue-number]"
   - Use GitHub's task list syntax in vision issue to track epics

### Step 6: Initial Prioritization Prompt

After creating all epics, ask:
```
✅ Created [N] epics successfully!

Epics:
- #[num] - [Epic 1 name]
- #[num] - [Epic 2 name]
...

Would you like to prioritize these epics now using MoSCoW framework?
```

Use AskUserQuestion:
- Question: "Prioritize epics now?"
- Header: "Prioritize"
- Options:
  - "Yes, prioritize now" (description: "Use MoSCoW framework to prioritize")
  - "No, I'll prioritize later" (description: "Skip prioritization for now")
- multiSelect: false

If "Yes": Use the SlashCommand tool to invoke `/re:prioritize`

If "No": Show next steps

### Step 7: Success Message & Next Steps

Display:
```
✅ Epic identification complete!

Created [N] epics linked to Vision (#[vision-num])

Next Steps:
1. Run `/re:prioritize` to rank epics by importance
2. Review epic issues and add details as needed
3. Run `/re:create-stories` to break down highest-priority epic
4. Use `/re:status` to see project overview
```

## Error Handling

- If no vision exists: Guide to `/re:discover-vision`
- If vision is incomplete: Suggest reviewing and updating it first
- If issue creation fails: Show error and permissions guidance
- If too many/few epics: Provide guidance on right-sizing

## Notes

- Use epic-identification skill for methodology
- Aim for 5-12 epics (sweet spot)
- One epic per file (separate issues)
- Each epic links to vision as parent
- Epics should be distinct and non-overlapping
- Use common epic patterns (User-Facing, Infrastructure, Integration, Data)
