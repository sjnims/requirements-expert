# GitHub Copilot Instructions - Requirements Expert Plugin

## Project Overview

This is a **Claude Code plugin** for requirements management. The plugin guides users through the full requirements lifecycle (Vision → Epics → User Stories → Tasks) using GitHub Projects as the storage backend—no local files.

**Critical**: The plugin root is `plugins/requirements-expert/`, not the repository root. This repo uses a marketplace-at-root structure where the repository serves as both development workspace and marketplace.

## PR Review Checklist

When reviewing PRs, validate these critical aspects:

### Architecture Compliance
- [ ] **No local requirement files**: Changes must not create `.json`, `.yaml`, or `.md` files for storing requirements data
- [ ] **GitHub CLI only**: All GitHub operations use `gh` commands via Bash tool, never GitHub REST API or direct Git operations
- [ ] **Plugin root awareness**: All paths reference `plugins/requirements-expert/`, not repository root
- [ ] **Idempotency**: Commands check existing state before creating duplicates (use `gh project item-list`, `gh project field-list`)

### Component Integrity
- [ ] **Commands**: YAML frontmatter includes `name`, `description`, `allowed-tools`; body uses imperative form ("Do X")
- [ ] **Skills**: Description uses third-person with specific trigger phrases; SKILL.md ≤2000 words; no content duplication with `references/`
- [ ] **Agents**: Include 3-4 `<example>` blocks with `<commentary>` tags; tools list is minimal
- [ ] **Manifests sync**: Version numbers match in both `plugin.json` and `marketplace.json`

### GitHub Projects Data Model
- [ ] **Hierarchy preserved**: Vision → Epic → Story → Task parent/child links via GitHub's native issue hierarchy
- [ ] **Two-layer metadata**: Custom fields (Type/Priority/Status) AND labels (`type:*`, `priority:*`) are both set
- [ ] **Field validation**: Type field uses exactly: Vision, Epic, Story, Task; Priority uses: Must Have, Should Have, Could Have, Won't Have

### Code Quality Standards
- [ ] **Markdown linting**: ATX headers, dash lists, 2-space indentation, fenced code blocks (run `markdownlint`)
- [ ] **Error handling**: GitHub CLI failures have user-friendly messages with resolution steps
- [ ] **State validation**: Commands validate prerequisites before execution (e.g., vision exists before epics)
- [ ] **No second person**: Component instructions written FOR Claude, not TO user ("Execute" not "You should execute")

## Common PR Anti-Patterns to Flag

### ❌ Creating Local Storage
```diff
- Creating plugins/requirements-expert/data/requirements.json
- Adding vision.yaml to store vision data
- Implementing local cache for GitHub data
```
**Why it's wrong**: Everything must live in GitHub Projects; local files break the "single source of truth" principle.

### ❌ Breaking Idempotency
```diff
- gh project create (without checking if project exists)
- gh project field-create (without listing existing fields first)
```
**Why it's wrong**: Commands must check state before creating duplicates. Use `gh project list` and `gh project field-list` first.

### ❌ Hardcoding Repository Root Paths
```diff
- .claude-plugin/plugin.json
- commands/init.md
- skills/vision-discovery/SKILL.md
```
**Should be**: `plugins/requirements-expert/.claude-plugin/plugin.json` etc.

### ❌ Using Direct GitHub API
```diff
- curl https://api.github.com/repos/.../issues
- Using @octokit/rest package
- Raw HTTP requests to GitHub
```
**Why it's wrong**: Only GitHub CLI (`gh`) is allowed as external dependency.

### ❌ Violating INVEST Criteria
```diff
- User stories without acceptance criteria
- Stories estimating >5 days of work
- Stories that can't be tested
```
**Why it's wrong**: Requirements-validator agent enforces INVEST; stories must be Independent, Negotiable, Valuable, Estimable, Small, Testable.

## Architecture Essentials

### Three-Layer Component Model

1. **Commands** (`plugins/requirements-expert/commands/*.md`) - 8 slash commands (`/re:*`) that are user-facing entry points
2. **Skills** (`plugins/requirements-expert/skills/*/SKILL.md`) - 6 knowledge modules auto-loaded by context with progressive disclosure pattern
3. **Agents** (`plugins/requirements-expert/agents/*.md`) - 2 specialized agents for orchestration and validation

### Data Architecture: 100% GitHub Projects

**Zero local files**: All requirements are GitHub issues in GitHub Projects with parent/child hierarchy:

```
Vision Issue (#1, Type: Vision, labels: type:vision)
  └── Epic Issue (#2, Type: Epic, parent: #1, labels: type:epic, priority:must-have)
      └── Story Issue (#3, Type: Story, parent: #2, labels: type:story, priority:must-have)
          └── Task Issue (#4, Type: Task, parent: #3, labels: type:task)
```

**Two-layer metadata**:
- Custom fields (project-level via `gh project item-edit`): Type, Priority, Status
- Labels (issue-level via `gh issue create --label`): `type:*`, `priority:*`

Why both? Custom fields enable project views; labels enable cross-project queries.

## Critical Patterns

### 1. GitHub CLI is Everything

**Only external dependency**: GitHub CLI (`gh`). All operations use `gh` commands via Bash tool.

Before any GitHub operation:
- Check CLI exists: `which gh`
- Verify auth: `gh auth status` (requires `repo` and `project` scopes)
- Get repo context: `gh repo view --json nameWithOwner`

Key commands:
```bash
gh project item-list [project-number] --owner [owner] --format json  # Query state
gh issue create --repo [repo] --title "[title]" --body "[body]" --label "type:epic"
gh project item-add [project-number] --owner [owner] --url [issue-url]
gh project item-edit --id [item-id] --field-id [field-id] --value "[value]"
```

**PR Review**: Verify no `curl`, `@octokit`, or direct API calls. All GitHub operations must use `gh`.

### 2. State-First Validation

Always check GitHub Project state before suggesting actions. Never recommend `/re:identify-epics` if no vision exists. Commands must be idempotent.

**Example pattern**:
```bash
# Good: Check before creating
gh project list --owner [owner] --format json | jq '.projects[] | select(.title=="[name]")'
if [ -z "$existing" ]; then gh project create ...; fi

# Bad: Create without checking
gh project create ...  # May create duplicates
```

**PR Review**: Ensure commands query state (`gh project item-list`, `gh project field-list`) before mutations.

### 3. Command Chaining Pattern

Commands auto-chain to next phase:
```
/re:discover-vision completes → Ask: "Continue to identify epics?"
→ If yes: Execute /re:identify-epics → If no: Exit gracefully
```

**PR Review**: New commands should offer continuation; validate prerequisite checks exist.

### 4. Progressive Disclosure in Skills

- Core methodology in `SKILL.md` (1,500-2,000 words)
- Detailed docs in `references/` subdirectory (loaded as needed)
- Never duplicate content between them

**PR Review**: Flag if SKILL.md >2000 words or if content duplicated between SKILL.md and references/.

### 5. INVEST Criteria Enforcement

User stories MUST meet INVEST criteria (validated by requirements-validator agent):
- **I**ndependent, **N**egotiable, **V**aluable, **E**stimable, **S**mall (1-5 days), **T**estable
- Minimum 3-5 acceptance criteria per story/task

**PR Review**: Changes to story/task creation must preserve acceptance criteria requirements (3-5 minimum).

## Component File Structure

### Commands Format
```yaml
---
name: command-name
description: Brief description
allowed-tools: [Bash, AskUserQuestion, Read]
---
# Instructions FOR Claude (imperative form: "Do X", not "You should do X")
```

**PR Review**:
- Verify all three frontmatter fields exist
- Check body uses imperative ("Execute", "Run", "Create") not second person ("You should")
- Validate `allowed-tools` matches actual tool usage in body

### Skills Format
```yaml
---
name: Skill Name
description: This skill should be used when the user asks to "trigger phrase 1", "trigger phrase 2"...
version: 0.1.0
---
# Core methodology content (imperative form)
```

**Critical**: Skill descriptions use third-person with specific trigger phrases.

**PR Review**:
- Description must list concrete trigger phrases (not generic descriptions)
- SKILL.md body ≤2000 words (use `wc -w` to verify)
- No content duplication between SKILL.md and references/

### Agents Format
```yaml
---
name: agent-name
description: |
  Use this agent when [triggering conditions].
  <example>
  Context: [scenario]
  user: "[message]"
  assistant: "[response]"
  <commentary>[why this triggers]</commentary>
  </example>
model: inherit
color: blue
tools: [Bash, AskUserQuestion, SlashCommand]
---
```

Include 3-4 `<example>` blocks to train triggering behavior.

**PR Review**:
- Minimum 3 `<example>` blocks with `<commentary>` tags
- Each example shows realistic user message and expected assistant behavior
- Tools list is minimal (only what's actually needed)

## Development Workflow

### Testing Locally
```bash
# From repository root
cc --plugin-dir plugins/requirements-expert

# Test specific command
/re:init

# Verify prerequisites
gh auth status
gh project list --owner [owner]
```

### Full Lifecycle Test
1. `/re:init` - Create project with custom fields
2. `/re:discover-vision` - Create vision issue
3. `/re:identify-epics` - Create epic issues
4. `/re:create-stories` - Create story issues (select epic)
5. `/re:create-tasks` - Create task issues (select story)
6. `/re:prioritize` - Apply MoSCoW priorities
7. `/re:review` - Validate structure and quality
8. `/re:status` - View project summary

**PR Review**: Changes to commands should preserve this workflow sequence and chaining behavior.

### Linting
```bash
markdownlint '**/*.md' --ignore node_modules
markdownlint plugins/requirements-expert/**/*.md --fix
```

**Style rules** (see `.markdownlint.json`):
- ATX headers (`#` not underlines)
- Dash lists (`-` not `*` or `+`)
- 2-space indentation
- Fenced code blocks (not indented)
- Allow HTML: `<example>`, `<commentary>`, `<details>`, `<summary>`

## PR Review Quick Reference

### Files That Must Stay In Sync
- `plugins/requirements-expert/.claude-plugin/plugin.json` version
- `.claude-plugin/marketplace.json` plugins[0].version
- Both must match exactly on version bumps

### Markdown Style Validation
Run `markdownlint plugins/requirements-expert/**/*.md` to verify:
- ATX headers (`#` style)
- Dash lists (`-` not `*` or `+`)
- 2-space indentation
- Fenced code blocks (triple backticks)

### State Management Pattern
All commands should follow this pattern:
```bash
# 1. Check current state
gh project item-list [project-number] --format json

# 2. Validate prerequisites
# (e.g., vision exists before creating epics)

# 3. Conditional creation
if [ condition ]; then
  gh project create ...
fi
```

### Key Files Reference

- `CLAUDE.md` - Comprehensive development documentation (600+ lines)
- `README.md` - User-facing documentation
- `plugins/requirements-expert/.claude-plugin/plugin.json` - Plugin manifest
- `.claude-plugin/marketplace.json` - Marketplace manifest
- `plugins/requirements-expert/hooks/hooks.json` - UserPromptSubmit hook config

## Methodology Quick Reference

- **Vision**: Problem statement, target users, solution overview, success metrics, scope boundaries
- **Epics** (5-12 typical): Major capabilities too large for single iteration (e.g., "User Authentication")
- **User Stories** (5-15 per epic): Format "As a {user}, I want {goal}, so that {benefit}" - INVEST compliant
- **Tasks** (5-20 per story): 2-8 hours of work, organized by layer (frontend, backend, data, testing, docs)
- **MoSCoW Prioritization**: Must Have (<60%), Should Have (~20%), Could Have (~20%), Won't Have (explicit exclusions)
