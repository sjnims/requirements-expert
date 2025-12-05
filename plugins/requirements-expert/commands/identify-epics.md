---
name: re:identify-epics
description: Identify epics from vision, create issues
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---

# Identify Epics

Identify major capabilities (epics) from the product vision and create epic issues in GitHub Projects. This command is **idempotent**—safe to run multiple times without creating duplicates.

## Instructions

Load the **epic-identification** skill for methodology and templates. Load **shared-patterns** skill for error handling and idempotency patterns.

### Step 1: Verify Prerequisites

1. Query project items: `gh project item-list [project-number] --format json`
2. Filter for Type = "Vision"
3. If no vision found: Inform user to run `/re:discover-vision` first, then exit
4. Read vision issue: `gh issue view [vision-issue-number] --repo [repo] --json body`
5. Store vision issue number for parent linking

### Step 2: Suggest Epics

Apply discovery techniques from epic-identification skill (`references/discovery-techniques.md`):

- User Journey Mapping
- Capability Decomposition
- Stakeholder Needs Analysis
- Technical Enablers Identification

Analyze vision content. Suggest 5-10 epics categorized by type (User-Facing, Infrastructure, Integration, etc.). Present numbered list with brief descriptions.

### Step 3: Epic Selection

Use AskUserQuestion:

1. **Select epics** (multiSelect: true): Present suggested epics as options
2. **Add more?** (multiSelect: false): Options: "Add more", "Continue", "Review selection"

Handle "Add more" by prompting for additional epic details. Handle "Review selection" by displaying current selection before re-asking.

### Step 4: Validate Count

Check total epic count:

- < 5: Suggest more decomposition may be needed
- > 15: Suggest some could be combined
- Ideal: 5-12 epics

### Step 5: Create Epic Issues

Initialize batch tracking per shared-patterns skill: `created[]`, `skipped[]`, `updated[]`, `failed[]`

For each selected epic:

#### 5a. Idempotency Check

Apply shared-patterns Idempotency Check pattern:

1. Query: `gh issue list --repo [repo] --label "type:epic" --json number,title`
2. Compare titles (case-insensitive, trimmed)
3. If match found: Use AskUserQuestion (Skip/Update/Create anyway)
4. Track result in appropriate list

#### 5b. Create Issue

Read template: `plugins/requirements-expert/skills/epic-identification/references/epic-template.md`

Compile epic description following template structure. Create issue:

```bash
gh issue create --repo [repo] --title "[Epic Name]" --body "[description]" --label "type:epic"
```

On failure: Apply shared-patterns Recovery Flow (Retry/Skip/Check permissions/Stop).

#### 5c. Add to Project

```bash
gh project item-add [project-number] --owner [owner] --url [issue-url]
```

#### 5d. Set Custom Fields

Apply shared-patterns Two-Layer Metadata pattern:

- Type: Epic
- Status: Not Started

#### 5e. Link to Vision

Add comment: "Parent: #[vision-issue-number]"

### Step 6: Summary & Next Steps

Display batch summary per shared-patterns format:

```text
**Epic identification complete!**

**Created:** [N] new epics
- #[num] - [Epic name]

**Updated:** [N] existing epics (if > 0)
**Skipped:** [N] duplicates (if > 0)
**Failed:** [N] epics (if > 0)

All epics linked to Vision (#[vision-num])

**Next steps:**
- Run `/re:prioritize` to rank epics
- Run `/re:create-stories` to break down highest-priority epic
- Use `/re:status` for project overview
```

## Error Handling

- No vision exists: Guide to `/re:discover-vision`
- Vision incomplete: Suggest reviewing it first
- Duplicate detected: Use Idempotency Check pattern
- Creation fails: Use Recovery Flow pattern
- Too many/few epics: Provide right-sizing guidance
