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

**8 Commands**: re:init, re:discover-vision, re:identify-epics, re:create-stories, re:create-tasks, re:prioritize, re:review, re:status

**6 Skills**: vision-discovery, epic-identification, user-story-creation, task-breakdown, prioritization, requirements-feedback

**2 Agents**: requirements-assistant (orchestration), requirements-validator (quality checks)

**GitHub CLI is critical**: All operations use `gh` commands via Bash tool. Verify with `gh auth status`.

## Architecture

### Repository Structure

This repository uses a **marketplace-at-root** structure where the repository acts as both a development workspace and a marketplace for distribution:

```
/                                    # Repository root (marketplace)
├── .claude-plugin/
│   └── marketplace.json             # Marketplace manifest (v0.1.0)
├── plugins/
│   └── requirements-expert/         # PLUGIN ROOT (publishable unit)
│       ├── .claude-plugin/
│       │   └── plugin.json          # Plugin manifest (v0.1.0)
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

### 1. Command Chaining Pattern

Commands offer to auto-chain to the next phase:

```
/re:discover-vision completes
  → Ask: "Continue to identify epics?"
  → If yes: Execute /re:identify-epics
  → If no: Exit gracefully
```

Implemented in commands using:
- AskUserQuestion for continuation prompt
- SlashCommand tool (in agents) or direct command execution
- State validation before chaining (ensure prerequisites exist)

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
gh project item-list [project-id] --format json

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

## Working with Components

### Adding a New Command

1. Create `plugins/requirements-expert/commands/new-command.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   name: new-command
   description: Brief description of what this command does
   allowed-tools: [Bash, AskUserQuestion, Read]
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
- Allow HTML elements: `<example>`, `<commentary>`, `<details>`, `<summary>`, `<br>`

**VS Code integration**: Markdown validation is enabled (see `.vscode/settings.json`)

### Testing Locally

```bash
# Load plugin locally (from repository root)
cd /Users/stevenims/Projects/requirements-expert
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

## GitHub CLI Integration

All commands use `gh` CLI for GitHub operations via the Bash tool. This is the plugin's **only external dependency**.

### Critical Commands

**Project Operations**:
```bash
gh project create --owner [owner] --title "[name]"         # Create project
gh project list --owner [owner] --format json              # List projects
gh project item-list [project-id] --format json            # List items
gh project item-add [project-id] --owner [owner] --url [issue-url]  # Add issue
gh project item-edit --id [item-id] --field-id [field-id] --value "[value]"  # Set field
gh project field-create [project-id] --owner [owner] --data-type SINGLE_SELECT --name "Type"  # Create field
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
allowed-tools: [Bash, AskUserQuestion, Read]
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
4. **Don't hardcode paths** - Use `${CLAUDE_PLUGIN_ROOT}` if needed (though not used in this plugin)
5. **Don't duplicate content** - Between SKILL.md and references/, between README and CLAUDE.md
6. **Don't make up GitHub issue numbers** - Always query actual state
7. **Don't suggest commands without prerequisites** - Check vision exists before suggesting epics

## Publishing & Version Management

### Version Release Checklist

When releasing a new version (e.g., v0.2.0):

1. **Update version in both manifests** (must match):
   - `plugins/requirements-expert/.claude-plugin/plugin.json`
   - `.claude-plugin/marketplace.json` (in plugins array)

2. **Update documentation**:
   - README.md changelog section
   - Any breaking changes or new features

3. **Tag the release**:
   ```bash
   git tag v0.2.0
   git push origin v0.2.0
   ```

4. **Test the plugin**:
   ```bash
   cc --plugin-dir plugins/requirements-expert
   # Run through full lifecycle test
   ```

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
