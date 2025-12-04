# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin Overview

The requirements-expert plugin is a **Claude Code plugin** that guides users through the full requirements lifecycle: **Vision → Epics → User Stories → Tasks**. All requirements are stored as GitHub issues in GitHub Projects with full parent/child hierarchy—no local files.

**No external dependencies**: This is a pure Claude Code plugin with no npm packages, Python/Ruby runtimes, or databases. The only external dependency is GitHub CLI (`gh`).

## Quick Reference

**Plugin Root**: `plugins/requirements-expert/` (not repository root)

**Test Locally**:
```bash
cc --plugin-dir plugins/requirements-expert
/re:init  # Test a command
```

**Lint Markdown**:
```bash
markdownlint '**/*.md' --ignore node_modules
markdownlint '**/*.md' --ignore node_modules --fix  # Auto-fix
```

**8 Commands**: re:init, re:discover-vision, re:identify-epics, re:create-stories, re:create-tasks, re:prioritize, re:review, re:status

**6 Skills**: vision-discovery, epic-identification, user-story-creation, task-breakdown, prioritization, requirements-feedback

**2 Agents**: requirements-assistant (orchestration), requirements-validator (quality checks)

**GitHub CLI is critical**: All operations use `gh` commands via Bash tool. Verify with `gh auth status`.

**Version Files** (must match on release):
- `plugins/requirements-expert/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`
- All 6 `plugins/requirements-expert/skills/*/SKILL.md` frontmatter

**Check Version Consistency**:
```bash
rg '"version"' plugins/requirements-expert/.claude-plugin/plugin.json .claude-plugin/marketplace.json
rg '^version:' plugins/requirements-expert/skills/*/SKILL.md
```

## Architecture

### Repository Structure

This repository uses a **marketplace-at-root** structure where the repository acts as both a development workspace and a marketplace for distribution:

```
/                                    # Repository root (marketplace)
├── .claude-plugin/
│   └── marketplace.json             # Marketplace manifest (v0.3.0)
├── plugins/
│   └── requirements-expert/         # PLUGIN ROOT (publishable unit)
│       ├── .claude-plugin/
│       │   └── plugin.json          # Plugin manifest (v0.3.0)
│       ├── commands/                # 8 slash commands (*.md)
│       ├── skills/                  # 6 knowledge modules (*/SKILL.md)
│       ├── agents/                  # 2 specialized agents (*.md)
│       └── hooks/
│           └── hooks.json           # UserPromptSubmit hook
├── README.md                        # User-facing documentation
└── CLAUDE.md                        # This file (development docs)
```

**Critical**: The plugin root is `plugins/requirements-expert/`, not the repository root. All component paths must include this prefix.

### Three-Layer Architecture

1. **Commands Layer** (`/re:*` commands)
   - User-facing entry points
   - Interactive workflows using `AskUserQuestion` tool
   - Execute GitHub CLI commands via `Bash` tool
   - Each command orchestrates a specific phase of the lifecycle

2. **Skills Layer** (methodology knowledge)
   - Automatically loaded when relevant context is detected
   - Provide best practices, templates, and frameworks
   - Use progressive disclosure (lean SKILL.md + detailed references/)
   - Written in imperative form for Claude consumption

3. **Agents Layer** (autonomous assistance)
   - `requirements-assistant`: Workflow orchestration, proactive guidance
   - `requirements-validator`: Quality validation, compliance checking
   - Triggered by specific contexts or explicit commands

### Data Architecture: 100% GitHub Projects

**Critical Design Decision**: No local files for requirements. Everything is GitHub issues in GitHub Projects.

**Why No Local State?**

This plugin intentionally does NOT persist local state (e.g., project numbers in `.local.md` files). Design rationale:

1. **Single source of truth**: GitHub Projects is authoritative - commands always query GitHub directly
2. **Always accurate**: Direct queries reflect real-time state, never stale cached data
3. **Multi-machine**: Works identically across developer machines without synchronization
4. **No sync conflicts**: Eliminates local state synchronization issues and merge conflicts
5. **Idempotency**: Commands safely re-run without risk of local state corruption
6. **Team collaboration**: All team members see identical data without manual sync

Other `/re:*` commands discover projects dynamically by querying GitHub rather than relying on cached references.

**Hierarchy Structure** (parent/child relationships):
```
Vision Issue (#1, Type: Vision, labels: type:vision)
  └── Epic Issue (#2, Type: Epic, parent: #1, labels: type:epic, priority:must-have)
      └── Story Issue (#3, Type: Story, parent: #2, labels: type:story, priority:must-have)
          └── Task Issue (#4, Type: Task, parent: #3, labels: type:task)
```

**Two-Layer Metadata System**:

1. **Custom Fields** (Project-level, set via `gh project item-edit`):
   - `Type`: Vision | Epic | Story | Task
   - `Priority`: Must Have | Should Have | Could Have | Won't Have
   - `Status`: Not Started | In Progress | Completed

2. **Labels** (Issue-level, set via `gh issue create --label`):
   - Type: `type:vision`, `type:epic`, `type:story`, `type:task`
   - Priority: `priority:must-have`, `priority:should-have`, `priority:could-have`, `priority:wont-have`

**Why both?**: Custom fields enable Project views/filtering. Labels enable cross-project queries and GitHub API filtering.

**Data Flow**:
1. Create GitHub issue in GitHub Projects → Returns issue URL and number
2. Add issue to project → Returns project item ID
3. Set custom field on project item → Type, Priority, Status visible in project
4. Parent/child links created via GitHub's native issue hierarchy

## Key Design Patterns

### 1. Command Completion Pattern

Commands complete their task, report results, and inform about next steps:

```
/re:discover-vision completes
  → Display success message with created issue
  → List next steps (including /re:identify-epics)
  → Exit
```

**Key principle**: Commands have single responsibility. They do NOT chain to other commands.

**Implementation**:

- Commands display success messages with next steps listed
- Some commands offer to loop (e.g., "Create stories for another epic?")
- All commands exit after completing their task
- Users (or agents) decide which command to run next

**Why no chaining?**

- **Single responsibility**: Each command does one thing well
- **Debuggability**: Clear boundaries make it obvious which command caused an issue
- **Loose coupling**: Refactoring one command doesn't break others
- **Testability**: Each command can be tested in isolation
- **User agency**: Users explicitly control workflow progression

**Agent orchestration**: The `requirements-assistant` agent uses `SlashCommand` to invoke commands when orchestrating workflows. Commands themselves never use `SlashCommand`.

### 2. Progressive Disclosure in Skills

Skills follow the pattern:
- `SKILL.md`: Core methodology (1,500-2,000 words)
- `references/`: Detailed documentation (loaded as needed)
- `examples/`: (optional) Working examples

**Never duplicate content** between SKILL.md and references—use references for deep-dive content.

### 3. State-First Validation

All commands and agents check GitHub Project state before acting:

```bash
# Check what exists
gh project item-list [project-number] --format json

# Filter by Type custom field
# Count Vision (should be exactly 1)
# Count Epics, Stories, Tasks
# Verify parent/child links
```

**Never suggest a command** if its prerequisites don't exist.

### 4. INVEST Criteria Enforcement

User stories MUST meet INVEST criteria (validated by requirements-validator agent):
- **I**ndependent
- **N**egotiable
- **V**aluable
- **E**stimable
- **S**mall (1-5 days)
- **T**estable

**Minimum Acceptance Criteria**: 3-5 per story/task (enforced in commands and validation)

### 5. MoSCoW Prioritization Framework

Only four priority levels (no custom priorities):
- **Must Have**: <60% of items (critical threshold)
- **Should Have**: ~20% of items
- **Could Have**: ~20% of items
- **Won't Have**: Explicitly documented exclusions

### 6. Template File Path Pattern

Commands reference template files using repository-relative paths:

```markdown
plugins/requirements-expert/skills/vision-discovery/references/vision-template.md
```

**Why not `${CLAUDE_PLUGIN_ROOT}`?**

The `${CLAUDE_PLUGIN_ROOT}` variable only works in JSON configuration files (hooks.json, MCP servers). It does **not** expand in command markdown files due to a known limitation ([anthropics/claude-code#9354](https://github.com/anthropics/claude-code/issues/9354)).

**Current approach:**

- Commands use repository-relative paths starting with `plugins/requirements-expert/`
- Paths are resolved by the Read tool from the working directory
- Works correctly for local development and testing

**Affected commands:**

| Command | Template Path |
|---------|---------------|
| `re:discover-vision` | `skills/vision-discovery/references/vision-template.md` |
| `re:identify-epics` | `skills/epic-identification/references/epic-template.md` |
| `re:create-stories` | `skills/user-story-creation/references/story-template.md` |
| `re:create-tasks` | `skills/task-breakdown/references/task-template.md` |

**If the limitation is fixed:** Commands could migrate to `${CLAUDE_PLUGIN_ROOT}/skills/.../references/*.md` for true portability across installation contexts.

## Working with Components

### Adding a New Command

1. Create `plugins/requirements-expert/commands/new-command.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   name: new-command
   description: Brief description of what this command does
   allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
   ---
   ```
3. Write instructions **FOR Claude** (not TO the user)
4. Use imperative form: "Do X", not "You should do X"
5. Include error handling for common failure modes
6. Follow markdown style guide (ATX headers, dash lists, fenced code blocks)
7. Test with: `cc --plugin-dir plugins/requirements-expert` then `/re:new-command`
8. Lint before committing: `markdownlint plugins/requirements-expert/commands/new-command.md`

### Adding a New Skill

1. Create directory: `plugins/requirements-expert/skills/new-skill/`
2. Create `plugins/requirements-expert/skills/new-skill/SKILL.md` with frontmatter:
   ```yaml
   ---
   name: New Skill Name
   description: This skill should be used when the user asks to "trigger phrase 1", "trigger phrase 2"...
   version: 0.1.0
   ---
   ```
3. **Critical**: Description must use third-person with specific trigger phrases
4. Keep SKILL.md body lean (<2,000 words)
5. Move detailed content to `references/` subdirectory
6. Add templates to `references/` (e.g., `references/template.md`)
7. Follow markdown style guide (ATX headers, dash lists, fenced code blocks)
8. Use skill-reviewer agent to validate quality
9. Lint before committing: `markdownlint plugins/requirements-expert/skills/new-skill/**/*.md`

### Modifying Agents

Agents are defined in `plugins/requirements-expert/agents/*.md` with frontmatter:
```yaml
---
name: agent-name
description: |
  Use this agent when [triggering conditions].

  <example>
  Context: [Scenario description]
  user: "[User message]"
  assistant: "[How Claude should respond]"
  <commentary>[Why this triggers the agent]</commentary>
  </example>

model: inherit
color: blue  # or yellow, green, etc.
tools:
  - Bash
  - AskUserQuestion
---
```

**Include 3-4 `<example>` blocks** to train triggering behavior.

## Development Commands

### Linting Markdown Files

This repository uses markdownlint to enforce consistent markdown formatting:

```bash
# Install markdownlint-cli if not already installed
npm install -g markdownlint-cli

# Lint all markdown files
markdownlint '**/*.md' --ignore node_modules

# Lint specific directories
markdownlint plugins/requirements-expert/commands/*.md
markdownlint plugins/requirements-expert/skills/**/*.md
markdownlint README.md CLAUDE.md

# Fix auto-fixable issues
markdownlint '**/*.md' --ignore node_modules --fix
```

**Markdown style rules** (see `.markdownlint.json`):
- ATX-style headers (`#` not underlines)
- Dash-style lists (`-` not `*` or `+`)
- 2-space list indentation
- No line length limits (MD013 disabled)
- Fenced code blocks (not indented)
- Underscores for emphasis (`_italic_`), asterisks for bold (`**bold**`)
- Allow HTML elements: `<example>`, `<commentary>`, `<details>`, `<summary>`, `<br>`, `<invoke>`, `<parameter>`

**VS Code integration**: Markdown validation is enabled (see `.vscode/settings.json`)

### Testing Locally

```bash
# Load plugin locally (from repository root)
cc --plugin-dir plugins/requirements-expert

# Test specific command
/re:init

# Verify GitHub CLI setup
gh auth status                    # Check authentication
gh project list --owner [owner]   # List existing projects
```

### Validating Components

```bash
# After modifying a skill
/plugin-dev:skill-reviewer        # Review skill quality

# After creating/modifying plugin structure
/plugin-dev:plugin-validator      # Validate plugin structure

# Check command syntax
# Commands use YAML frontmatter + markdown instructions
```

### Validating GitHub Actions Locally

```bash
# Install actionlint if not already installed
brew install actionlint

# Validate all workflow files
actionlint

# Validate a specific workflow
actionlint .github/workflows/markdownlint.yml
```

### CI/CD Workflows

The repository includes 14 GitHub Actions workflows:

**Primary CI** (runs on every PR):
1. **markdownlint.yml** (~30-40s) - Enforces markdown style (ATX headers, dash lists, 2-space indentation)
2. **links.yml** (~1-2min) - Validates all links (excluding `.lycheeignore`)
3. **validate-workflows.yml** (~20-30s) - Validates workflow YAML syntax using actionlint

**Claude Code Workflows**:
4. **claude.yml** - Interactive Claude Code for `@claude` mentions (manual trigger)
5. **claude-pr-review.yml** - Automated PR review on all non-draft PRs (automatic trigger)
6. **component-validation.yml** - Deep validation of plugin components on PR changes (path-filtered)
7. **version-check.yml** (~30-60s) - Validates version consistency across plugin files (path-filtered)
8. **ci-failure-analysis.yml** - Analyzes failed CI runs and comments with fix suggestions (workflow_run trigger)

**Automation Workflows**:
9. **semantic-labeler.yml** - Claude-powered semantic labeling for issues and PRs
10. **sync-labels.yml** - Syncs labels from labels.yml to repository
11. **weekly-maintenance.yml** - Weekly repository health audit creating maintenance report issues (scheduled Monday 9:00 UTC)

**Dependency Management Workflows**:
12. **dependabot-auto-merge.yml** - Auto-merges non-breaking Dependabot PRs

**Utility Workflows**:
13. **greet.yml** - Welcomes first-time contributors
14. **stale.yml** - Marks inactive issues/PRs as stale

**If markdownlint fails**:
```bash
markdownlint '**/*.md' --ignore node_modules --fix  # Auto-fix issues
markdownlint plugins/requirements-expert/commands/*.md  # Check specific files
```

### Testing Workflow

**Prerequisites**:
- Git repository with GitHub remote
- GitHub CLI (`gh`) authenticated: `gh auth login`
- GitHub Projects enabled on repository

**Full Lifecycle Test**:
1. `/re:init` - Create project with custom fields
2. `/re:discover-vision` - Create vision issue
3. `/re:identify-epics` - Create epic issues
4. `/re:create-stories` - Create story issues (select epic)
5. `/re:create-tasks` - Create task issues (select story)
6. `/re:prioritize` - Apply MoSCoW priorities
7. `/re:review` - Validate structure and quality
8. `/re:status` - View project summary

**Test Scenarios**:
- **New project**: Start with `/re:init`, follow full workflow
- **Resume work**: Agent checks GitHub state, suggests next appropriate command
- **Add to existing**: Commands detect existing items and offer to add more
- **Validation**: Run `/re:review` to check for issues

### Comprehensive Testing Strategies

This section provides detailed testing strategies for contributors who are creating or modifying commands before deployment and distribution.

#### Testing `/re:init` Command

**1. Happy Path Testing**:
- [ ] Load plugin: `cc --plugin-dir plugins/requirements-expert`
- [ ] Navigate to a test git repository with GitHub remote
- [ ] Run `/re:init`
- [ ] Verify project created with user-selected name
- [ ] Verify all three custom fields exist: Type, Priority, Status
- [ ] Verify field options are correct:
  - Type: Vision, Epic, Story, Task
  - Priority: Must Have, Should Have, Could Have, Won't Have
  - Status: Not Started, In Progress, Completed
- [ ] Verify success message displays with project URL and next steps

**2. Idempotency Testing**:
- [ ] Run `/re:init` again in the same repository
- [ ] Verify no duplicate project created (reuses existing)
- [ ] Verify no duplicate fields created (skips existing)
- [ ] Verify appropriate "already exists" messages displayed
- [ ] Verify command completes successfully

**3. Error Cases - Prerequisites Validation**:
- [ ] Test without `gh` CLI installed:
  - Expected: Clear error message suggesting installation
  - Verify: `brew install gh` or link to <https://cli.github.com/>
- [ ] Test without GitHub authentication:
  - Expected: Error message suggesting `gh auth login`
  - Verify: Command exits gracefully
- [ ] Test without project scope:
  - Expected: Error message suggesting `gh auth refresh -s project`
  - Verify: Clear explanation of required scopes
- [ ] Test outside git repository:
  - Expected: Error message about not being in git repo
  - Verify: Suggests navigating to project repository

**4. Interactive Recovery Testing (Step 6)**:
- [ ] Simulate project creation failure (invalid permissions, network issue)
- [ ] Verify AskUserQuestion presents 3 recovery options:
  - Retry: Try creating the project again
  - Check permissions: Show diagnostic commands
  - Exit: Graceful exit with manual steps
- [ ] Test "Retry" option:
  - Verify command re-attempts project creation
  - If fails again, recovery options presented again
- [ ] Test "Check permissions" option:
  - Verify `gh auth status` output displayed
  - Verify `gh auth refresh -s project` command shown
  - Verify explanation of required scopes
  - Verify recovery options presented again after diagnostics
- [ ] Test "Exit" option:
  - Verify graceful exit message with manual troubleshooting steps
  - Verify original error details included

**5. Field Creation Optimization Testing**:
- [ ] Verify single field-list query executed (not 3 separate calls):
  - Step 7 queries field list once
  - Steps 8-10 check stored list (no additional queries)
- [ ] Test when all fields already exist:
  - Verify "already exists, skipping creation" for all three fields
  - Verify no field creation commands executed
- [ ] Test when some fields exist:
  - Verify existing fields skipped with message
  - Verify only missing fields created
- [ ] Test field-list query failure:
  - Verify graceful degradation (empty list assumption)
  - Verify warning message displayed
  - Verify all fields attempted to be created

**6. AskUserQuestion Structure Validation**:
- [ ] Step 4 (Project Name):
  - Verify proper structure: question, header, multiSelect, options
  - Verify header within 12 character limit ("Project Name" = 12)
  - Verify 3 options with labels and descriptions
  - Verify "Other" option available for custom input
  - Verify repository name placeholder substitution

**7. Edge Cases**:
- [ ] Test with special characters in repository name
- [ ] Test with very long repository name
- [ ] Test in organization vs personal account
- [ ] Test with existing project using exact same name
- [ ] Test with rate limiting (many API calls in succession)

#### Testing Other Commands

**General Testing Pattern**:
1. Prerequisites validation (gh CLI, auth, repo context)
2. Happy path execution
3. Idempotency (safe to re-run)
4. Error handling (graceful failures)
5. User interaction (AskUserQuestion where applicable)
6. GitHub API integration (correct commands, error handling)

**Validation Checklist**:
- [ ] YAML frontmatter syntax correct
- [ ] Allowed-tools list matches actual tool usage
- [ ] Commands use proper GitHub CLI patterns (see "Critical GitHub CLI Patterns")
- [ ] Error messages are clear and actionable
- [ ] Success messages include next steps
- [ ] Markdown formatting passes linting

## GitHub CLI Integration

All commands use `gh` CLI for GitHub operations via the Bash tool. This is the plugin's **only external dependency**.

### Critical GitHub CLI Patterns (VERIFIED)

**IMPORTANT**: These patterns were verified against `gh` CLI v2.x. Commands that deviate from these patterns will fail.

**Project Operations**:
```bash
# Projects are OWNER-SCOPED (not repository-scoped)
gh project create --owner [owner] --title "[name]"                    # ✅ CORRECT
gh project list --owner [owner] --format json                         # ✅ CORRECT
gh project field-list [project-number] --owner [owner] --format json  # ✅ CORRECT

# WRONG - these flags DO NOT EXIST
gh project create --repo owner/repo  # ❌ WRONG - --repo flag not supported
gh project list --repo owner/repo    # ❌ WRONG - use --owner instead
```

**Use Project Number, NOT GraphQL ID**:
```bash
# Project number: sequential integer (1, 2, 3...) visible in URL
# GraphQL ID: long string like "PVT_kwHOAAUfK84BI2KN"
# Commands expect PROJECT NUMBER, not GraphQL ID

gh project field-list 4 --owner sjnims              # ✅ CORRECT (number 4)
gh project field-list PVT_kwHOAAUfK84BI2KN          # ❌ WRONG (GraphQL ID)
```

**Field Creation - Use Single Command**:
```bash
# Create field with ALL options in one command (efficient)
gh project field-create [project-number] --owner [owner] \
  --name "Type" \
  --data-type SINGLE_SELECT \
  --single-select-options "Vision,Epic,Story,Task" \
  --format json

# WRONG - Don't create field then add options separately (slow)
# gh project field-create ... --name "Type"           # ❌ WRONG
# gh project field-create ... --single-select-option "Vision"  # ❌ WRONG (separate calls)
```

**Other Operations**:
```bash
gh project item-list [project-number] --owner [owner] --format json             # List items
gh project item-add [project-number] --owner [owner] --url [issue-url]          # Add issue
gh project item-edit --id [item-id] --field-id [field-id] --value "[value]"     # Set field
```

**Issue Operations**:
```bash
gh issue create --repo [repo] --title "[title]" --body "[body]" --label "type:epic"  # Create
gh issue view [number] --repo [repo] --json body,title    # Read
gh issue list --repo [repo] --label "type:epic" --format json  # List by label
```

**Repository Detection**:
```bash
gh repo view --json nameWithOwner  # Get current repo info
```

### Error Handling Checklist

Before any GitHub operation:
1. Check `gh` CLI exists: `which gh`
2. Verify authentication: `gh auth status`
3. Confirm repository context: `gh repo view --json nameWithOwner`
4. Check required permissions: "repo" and "project" scopes

**Common Error Responses**:
- CLI not found → "Install GitHub CLI: `brew install gh`"
- Not authenticated → "Run: `gh auth login`"
- Insufficient permissions → "Run: `gh auth refresh -s project`"
- Not in git repo → "Navigate to a git repository with GitHub remote"

## Hook Behavior

The `UserPromptSubmit` hook detects requirements-related queries:

**Triggers on**:
- Building/planning/designing applications
- Mentions of: vision, epics, user stories, tasks, acceptance criteria
- Requirements gathering, discovery, documentation
- Prioritization of features
- Breaking down work

**Does NOT trigger on**:
- General coding questions
- Debugging existing code
- Simple feature requests
- "How does X work?" questions

**Hook response**:
```
It looks like you're working on requirements. Would you like to use the
requirements-expert plugin to help structure this work?
```

## Methodology Summary

### Vision Elements

- Problem statement (what problem, why it matters)
- Target users (who, characteristics)
- Solution overview (what it does)
- Success metrics (measurable outcomes)
- Scope boundaries (included/excluded)

### Epics (5-12 typical)

- Major capabilities or feature themes
- Too large for single iteration
- Linked to vision as parent
- Examples: "User Authentication", "Data Management", "Reporting Dashboard"

### User Stories (5-15 per epic)

- Format: "As a {user}, I want {goal}, so that {benefit}"
- INVEST criteria compliance required
- 3-5 acceptance criteria minimum
- Linked to epic as parent

### Tasks (5-20 per story)

- Implementation-specific work items
- 2-8 hours of work (right-sized)
- 3-5 acceptance criteria minimum
- Organized by layer: frontend, backend, data, testing, docs
- Linked to story as parent

## Component File Structure

### Commands (`plugins/requirements-expert/commands/*.md`)

Each command is a markdown file with YAML frontmatter:
```yaml
---
name: command-name
description: Brief description
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
---
```

Body contains **instructions FOR Claude** (imperative form), not instructions TO the user.

**Available commands**: re:init, re:discover-vision, re:identify-epics, re:create-stories, re:create-tasks, re:prioritize, re:review, re:status

### Skills (`plugins/requirements-expert/skills/*/SKILL.md`)

Progressive disclosure pattern:
- `SKILL.md`: Core methodology (1,500-2,000 words) with YAML frontmatter
- `references/*.md`: Detailed documentation, templates, worksheets
- Trigger description uses third-person with specific phrases

**Available skills**: vision-discovery, epic-identification, user-story-creation, task-breakdown, prioritization, requirements-feedback

### Agents (`plugins/requirements-expert/agents/*.md`)

System prompts with YAML frontmatter and `<example>` blocks for triggering:
- `requirements-assistant`: Workflow orchestration, proactive guidance
- `requirements-validator`: Quality validation, INVEST compliance

### Hooks (`plugins/requirements-expert/hooks/hooks.json`)

Single `UserPromptSubmit` hook that detects requirements-related queries and suggests the plugin.

## File Organization Best Practices

When modifying this plugin:

1. **Commands**: Keep instructions clear and sequential. Use numbered steps. Include error handling.

2. **Skills**: Follow progressive disclosure. Core concepts in SKILL.md, details in references/.

3. **Agents**: Strong trigger examples. Clear system prompt. Minimal tool set.

4. **Templates**: Store in skill references/ directories, not in commands.

5. **Documentation**: Keep README comprehensive. This CLAUDE.md focuses on architecture/development.

## Common Pitfalls to Avoid

1. **Don't create local requirement files** - Everything goes in GitHub issues in GitHub Projects
2. **Don't skip state validation** - Always check what exists before suggesting next action
3. **Don't use second person in skills** - Use imperative form ("Do X" not "You should do X")
4. **Don't expect `${CLAUDE_PLUGIN_ROOT}` in commands** - It only works in JSON configs (hooks, MCP), not markdown files (see Pattern 6)
5. **Don't duplicate content** - Between SKILL.md and references/, between README and CLAUDE.md
6. **Don't make up GitHub issue numbers** - Always query actual state
7. **Don't suggest commands without prerequisites** - Check vision exists before suggesting epics
8. **Don't use `--repo` flag for project commands** - Projects use `--owner` (owner-scoped, not repo-scoped)
9. **Don't use GraphQL IDs in commands** - Use project number (sequential integer from URL)
10. **Don't create fields with multiple commands** - Use `--single-select-options` with comma-separated list
11. **Don't leave draft files in production directories** - Remove `*-SUGGESTED.md`, `*-BACKUP.md` before merging to main

## Publishing & Version Management

### Version Release Procedure

When releasing a new version (e.g., v0.x.x), follow this procedure:

#### 1. Create Release Branch

```bash
# Ensure main is up to date
git checkout main
git pull origin main

# Create release branch
git checkout -b release/v0.x.x
```

#### 2. Update Version Numbers

Update version in **all version files** (must match):
- `plugins/requirements-expert/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json` (in plugins array and metadata)
- All skill SKILL.md files (6 files in `plugins/requirements-expert/skills/*/SKILL.md`)

```bash
# Find all files with version to update
grep -r "0\.x\.0" plugins/requirements-expert --include="*.json" --include="SKILL.md"
```

#### 3. Update Documentation

- `CHANGELOG.md` - Add release notes following Keep a Changelog format:
  1. Review commits since last release: `git log v0.x.x..HEAD --oneline`
  2. Organize into sections: Added, Changed, Fixed, Security, Performance, Documentation
  3. Group related changes and reference PR numbers
  4. Add version comparison links at bottom of file
- `README.md` - Update version references if applicable
- Any other relevant documentation

#### 4. Test the Plugin

```bash
# Load plugin locally and test
cc --plugin-dir plugins/requirements-expert

# Run through full lifecycle test:
# /re:init → /re:discover-vision → /re:identify-epics →
# /re:create-stories → /re:create-tasks → /re:prioritize →
# /re:review → /re:status
```

#### 5. Commit and Create PR

```bash
# Commit version bump and documentation updates
git add .
git commit -m "Bump version to v0.x.x"

# Push release branch
git push origin release/v0.x.x

# Create pull request
gh pr create --title "Release v0.x.x" \
  --body "Version bump to v0.x.x

## Changes
- [List major changes]
- [List bug fixes]
- [List documentation updates]

## Checklist
- [x] Version updated in manifests (plugin.json, marketplace.json)
- [x] Version updated in all skill SKILL.md files
- [x] CHANGELOG.md updated
- [x] README.md updated (if applicable)
- [x] Plugin tested locally
"
```

#### 6. Merge and Tag

After PR review and approval:

```bash
# Merge PR via GitHub UI or:
gh pr merge --squash  # or --merge or --rebase based on preference

# Switch to main and pull the merged changes
git checkout main
git pull origin main

# Tag the release (on the merge commit)
git tag v0.x.x

# Push the tag
git push origin v0.x.x
```

#### 7. Create GitHub Release

```bash
# Create GitHub Release with notes from CHANGELOG
gh release create v0.x.x --title "v0.x.x" --notes-file - <<'EOF'
## Summary

Brief description of the release focus.

## What's Changed

[Copy relevant sections from CHANGELOG.md]

**Full Changelog**: https://github.com/sjnims/requirements-expert/compare/v0.x-1.x...v0.x.x
EOF
```

**Note**: Main branch is protected and requires PRs. All version bumps must go through the release branch workflow.

**Publishing**: The entire repository acts as a marketplace. The `plugins/requirements-expert/` directory is the distributable plugin unit.

## Plugin Development Workflow

When developing new features for this plugin:

1. **Design First**: Determine which layer (command/skill/agent)
2. **Check Patterns**: Follow existing patterns in similar components
3. **Progressive Build**: Start with minimal version, expand incrementally
4. **Test Locally**: Use `cc --plugin-dir plugins/requirements-expert` for each change
5. **Validate**: Use plugin-validator agent if available
6. **Document**: Update README if user-facing, update this file if architectural

## Dependencies & Requirements

**Required**:
- Claude Code (claude.ai/code)
- GitHub CLI (`gh`) v2.0+
- Git repository with GitHub remote
- GitHub Projects (beta) enabled on repository

**Permissions Required**:
- `repo`: Create and manage issues
- `project`: Create and manage GitHub Projects

**Not Required**:
- Any npm packages (pure Claude Code plugin)
- Python/Ruby/other runtimes
- Docker or containers
- Database (GitHub is the database)

## Critical PR Review Patterns

Key patterns to follow when reviewing PRs or writing code:

### Command Tool Permissions (CRITICAL)

All commands should follow the principle of least privilege:

**Bash tool restrictions**:
- ✅ Use: `Bash(gh:*)` - commands only use GitHub CLI
- ❌ Never: Unrestricted `Bash` - violates least privilege principle

**Standard allowed-tools pattern**:
```yaml
allowed-tools: [AskUserQuestion, Bash(gh:*), Read]
```

**Why `Bash(gh:*)`?**
- All plugin commands only execute `gh` CLI operations
- Reduces attack surface if command files are compromised
- Makes permission requirements explicit and auditable
- Follows Claude Code best practice: "Limit scope"

### GitHub CLI Usage Patterns (CRITICAL)

When reviewing or writing commands that interact with GitHub Projects:

**Owner-scoped projects**:
- ✅ Use: `gh project list --owner owner`
- ❌ Never: `gh project list --repo owner/repo` (flag doesn't exist)

**Project number vs ID**:
- ✅ Use: Project number (1, 2, 3...) from URL
- ❌ Never: GraphQL ID (PVT_xxx) in `gh` commands

**Efficient field creation**:
- ✅ Use: `--single-select-options "opt1,opt2,opt3"` (one command)
- ❌ Never: Multiple calls to add each option separately

### Draft Files Policy

**Production directories** (`commands/`, `skills/`, `agents/`, `hooks/`):
- Only production-ready components
- No `*-SUGGESTED.md`, `*-BACKUP.md`, `*-OLD.md` files

**Development branches**:
- Draft files are acceptable during feature development
- Must be removed before merging to main
- Alternative: Move drafts outside plugin root (e.g., `drafts/` directory)

### Markdown Style Compliance (CI Critical)

The CI will fail if markdown doesn't comply:
- ✅ ATX headers (`#`), not setext (underlines)
- ✅ Dash lists (`-`), not asterisk (`*`) or plus (`+`)
- ✅ 2-space indentation for nested lists
- ✅ Fenced code blocks, not indented blocks
- ✅ No line length limits (MD013 disabled)

**Allowed HTML tags**: `<example>`, `<commentary>`, `<details>`, `<summary>`, `<br>`, `<invoke>`, `<parameter>`

### State-First Validation Pattern

All commands must validate state before acting:

```bash
# Check existing project
existing=$(gh project list --owner "${owner}" --format json | \
  jq ".projects[] | select(.title==\"${project_name}\")")

if [ -n "$existing" ]; then
  # Reuse existing project
  project_number=$(echo "$existing" | jq -r '.number')
else
  # Create new project
  gh project create --owner "${owner}" --title "${project_name}"
fi
```

This ensures:
- Idempotency (safe to re-run commands)
- No duplicate projects/fields/issues
- Accurate state representation

### Two-Layer Metadata System

Every requirement issue must have BOTH:

1. **Custom Fields** (Project-level):
   - Set via `gh project item-edit --field-id [id] --value "[value]"`
   - Enables Project views/filtering
   - Fields: Type, Priority, Status

2. **Labels** (Issue-level):
   - Set via `gh issue create --label "type:epic,priority:must-have"`
   - Enables cross-project queries
   - Labels: `type:*`, `priority:*`

**Why both?** Custom fields are project-specific; labels are portable across GitHub.
