# Copilot Instructions for Requirements Expert Plugin

You are a development assistant for the Requirements Expert plugin, a Claude Code plugin for requirements management. Your role is to help maintain and improve this plugin while adhering to its unique architecture and conventions.

## Repository Overview

This is a **Claude Code plugin** that guides users through requirements management using GitHub Projects:

- **Plugin Type**: Pure Claude Code plugin (no npm, Python, or runtime dependencies)
- **Purpose**: Requirements lifecycle management (Vision → Epics → User Stories → Tasks)
- **Storage**: All requirements stored as GitHub issues in GitHub Projects
- **Only External Dependency**: GitHub CLI (`gh`)

## Repository Structure

```
/                                    # Repository root (marketplace)
├── .claude-plugin/
│   └── marketplace.json             # Marketplace manifest
├── .github/
│   ├── copilot-instructions.md      # This file
│   ├── workflows/                   # CI workflows
│   └── ISSUE_TEMPLATE/             # Issue templates
├── plugins/
│   └── requirements-expert/         # PLUGIN ROOT (publishable unit)
│       ├── .claude-plugin/
│       │   └── plugin.json          # Plugin manifest
│       ├── commands/                # 8 slash commands (*.md)
│       ├── skills/                  # 6 knowledge modules (*/SKILL.md)
│       ├── agents/                  # 2 specialized agents (*.md)
│       ├── hooks/
│       │   └── hooks.json           # UserPromptSubmit hook
│       └── .mcp.json                # GitHub CLI MCP server config
├── README.md                        # User-facing documentation
├── CLAUDE.md                        # Development documentation (READ THIS FIRST)
└── CONTRIBUTING.md                  # Contribution guidelines
```

**CRITICAL**: The plugin root is `plugins/requirements-expert/`, not the repository root.

## Key Technologies & Frameworks

- **Claude Code**: Plugin system, commands, skills, and agents
- **GitHub CLI (`gh`)**: Primary integration for GitHub Projects and issues
- **Markdown**: All plugin components are markdown files with YAML frontmatter
- **GitHub Projects API**: Used via `gh` CLI for all data operations
- **Bash**: Command execution tool for running `gh` commands

## Development Commands

### Linting

```bash
# Install markdownlint if needed
npm install -g markdownlint-cli

# Lint all markdown files
markdownlint '**/*.md' --ignore node_modules

# Lint specific directories
markdownlint plugins/requirements-expert/commands/*.md
markdownlint plugins/requirements-expert/skills/**/*.md

# Auto-fix issues
markdownlint '**/*.md' --ignore node_modules --fix
```

### Testing

```bash
# Test the plugin locally (from repository root)
cc --plugin-dir plugins/requirements-expert

# Test specific command in Claude Code
/requirements:init
/requirements:status

# Verify GitHub CLI setup
gh auth status
gh project list --owner <owner>
```

### No Build Step

This plugin requires **no build process**. All files are markdown and JSON, loaded directly by Claude Code.

## Code Style & Conventions

### Markdown Style

- **Headers**: ATX-style (`#` not underlines)
- **Lists**: Dash-style (`-` not `*` or `+`)
- **Indentation**: 2 spaces for lists
- **Code Blocks**: Fenced (not indented)
- **Line Length**: No limit (MD013 disabled)
- **HTML Elements**: Allowed: `<example>`, `<commentary>`, `<details>`, `<summary>`, `<br>`

Configuration: `.markdownlint.json`

### Component-Specific Guidelines

#### Commands (`plugins/requirements-expert/commands/*.md`)

Commands are markdown files with YAML frontmatter that define user-facing slash commands:

```yaml
---
name: command-name
description: Brief description
allowed-tools: [Bash, AskUserQuestion, Read]
---
```

**Instructions are FOR Claude** (imperative form), not TO the user:
- ✅ "Execute the following steps..."
- ✅ "Check if project exists..."
- ❌ "You should execute..."
- ❌ "The user needs to..."

**Key Patterns**:
- Always validate state before acting (check GitHub Projects)
- Use `gh` CLI commands via Bash tool
- Include error handling for common failures
- Chain to next command when appropriate
- Use `AskUserQuestion` for interactive workflows

#### Skills (`plugins/requirements-expert/skills/*/SKILL.md`)

Skills provide methodology knowledge using progressive disclosure:

```yaml
---
name: Skill Name
description: This skill should be used when the user asks to "trigger phrase 1", "trigger phrase 2"...
version: 0.1.0
---
```

**Critical**:
- Description must be third-person with specific trigger phrases
- Keep SKILL.md body lean (<2,000 words)
- Move detailed content to `references/` subdirectory
- Use imperative form in body text
- Never duplicate content between SKILL.md and references/

**Structure**:
- `SKILL.md`: Core methodology
- `references/`: Detailed documentation, templates
- `examples/`: (optional) Working examples

#### Agents (`plugins/requirements-expert/agents/*.md`)

Agents are specialized assistants with specific roles:

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
color: blue
tools:
  - Bash
  - AskUserQuestion
---
```

**Requirements**:
- Include 3-4 `<example>` blocks for trigger training
- Clear system prompt in body
- Minimal tool set

## GitHub Integration Patterns

### All Data Lives in GitHub Projects

**Critical Design Decision**: No local files for requirements. Everything is GitHub issues in GitHub Projects.

**Hierarchy Structure**:
```
Vision Issue (#1, Type: Vision)
  └── Epic Issue (#2, Type: Epic, parent: #1)
      └── Story Issue (#3, Type: Story, parent: #2)
          └── Task Issue (#4, Type: Task, parent: #3)
```

**Two-Layer Metadata**:
1. **Custom Fields** (Project-level): Type, Priority, Status
2. **Labels** (Issue-level): `type:vision`, `type:epic`, `priority:must-have`, etc.

### Common GitHub CLI Commands

```bash
# Project operations
gh project create --owner [owner] --title "[name]"
gh project list --owner [owner] --format json
gh project item-list [project-id] --format json
gh project item-add [project-id] --owner [owner] --url [issue-url]
gh project item-edit --id [item-id] --field-id [field-id] --value "[value]"

# Issue operations
gh issue create --repo [repo] --title "[title]" --body "[body]" --label "type:epic"
gh issue view [number] --repo [repo] --json body,title
gh issue list --repo [repo] --label "type:epic" --format json

# Repository detection
gh repo view --json nameWithOwner
```

### Error Handling Checklist

Before any GitHub operation:
1. Check `gh` CLI exists: `which gh`
2. Verify authentication: `gh auth status`
3. Confirm repository context: `gh repo view --json nameWithOwner`
4. Check required permissions: "repo" and "project" scopes

## Methodology & Patterns

### Requirements Lifecycle

Vision → Epics → User Stories → Tasks

- **Vision**: Problem statement, target users, solution overview, success metrics
- **Epics** (5-12): Major capabilities, too large for single iteration
- **User Stories** (5-15 per epic): INVEST criteria, 3-5 acceptance criteria
- **Tasks** (5-20 per story): Implementation work, 2-8 hours each

### INVEST Criteria (User Stories)

Stories MUST meet:
- **I**ndependent
- **N**egotiable
- **V**aluable
- **E**stimable
- **S**mall (1-5 days)
- **T**estable

### MoSCoW Prioritization

Only four priority levels:
- **Must Have**: <60% of items (critical threshold)
- **Should Have**: ~20% of items
- **Could Have**: ~20% of items
- **Won't Have**: Explicitly documented exclusions

### Command Chaining Pattern

Commands offer to auto-chain:
```
/requirements:discover-vision completes
  → Ask: "Continue to identify epics?"
  → If yes: Execute /requirements:identify-epics
  → If no: Exit gracefully
```

## What NOT to Modify

### Protected Files & Patterns

- **DO NOT** modify the plugin architecture (three-layer: commands/skills/agents)
- **DO NOT** add dependencies (npm, Python, etc.) - this is a pure plugin
- **DO NOT** create local data files - everything goes to GitHub Projects
- **DO NOT** change the hierarchy model (Vision → Epic → Story → Task)
- **DO NOT** modify YAML frontmatter structure without understanding impact
- **DO NOT** duplicate content between SKILL.md and references/
- **DO NOT** add custom priority levels beyond MoSCoW

### Areas Requiring Careful Changes

- `.claude-plugin/plugin.json` and `marketplace.json`: Version must match
- `hooks/hooks.json`: Trigger patterns affect user experience
- Agent trigger examples: These train Claude's behavior
- GitHub CLI command patterns: Must maintain error handling

## Development Workflow

### Adding a New Command

1. Create `plugins/requirements-expert/commands/new-command.md`
2. Add YAML frontmatter with name, description, allowed-tools
3. Write instructions FOR Claude (imperative form)
4. Include error handling
5. Test with: `cc --plugin-dir plugins/requirements-expert` then `/requirements:new-command`
6. Lint: `markdownlint plugins/requirements-expert/commands/new-command.md`

### Adding a New Skill

1. Create directory: `plugins/requirements-expert/skills/new-skill/`
2. Create `SKILL.md` with frontmatter (third-person triggers)
3. Keep body lean (<2,000 words)
4. Move detailed content to `references/`
5. Lint: `markdownlint plugins/requirements-expert/skills/new-skill/**/*.md`

### Modifying Agents

1. Update agent file in `plugins/requirements-expert/agents/`
2. Ensure 3-4 `<example>` blocks for trigger training
3. Test trigger behavior in Claude Code
4. Verify tool list is minimal

### Version Release Checklist

1. Update version in BOTH manifests (must match):
   - `plugins/requirements-expert/.claude-plugin/plugin.json`
   - `.claude-plugin/marketplace.json`
2. Update README.md changelog
3. Tag release: `git tag v0.x.0`
4. Test full lifecycle

## Common Pitfalls to Avoid

1. ❌ Creating local requirement files (use GitHub Projects)
2. ❌ Skipping state validation (always check what exists)
3. ❌ Using second person in skills ("you should" → "do")
4. ❌ Hardcoding paths (plugin root is `plugins/requirements-expert/`)
5. ❌ Duplicating content (between SKILL.md and references/)
6. ❌ Making up GitHub issue numbers (query actual state)
7. ❌ Suggesting commands without prerequisites (check dependencies)

## Testing Workflow

### Prerequisites

- Git repository with GitHub remote
- GitHub CLI authenticated: `gh auth login`
- GitHub Projects enabled on repository

### Full Lifecycle Test

```
/requirements:init              # Create project
/requirements:discover-vision   # Create vision
/requirements:identify-epics    # Create epics
/requirements:create-stories    # Create stories (select epic)
/requirements:create-tasks      # Create tasks (select story)
/requirements:prioritize        # Apply MoSCoW
/requirements:review            # Validate structure
/requirements:status            # View summary
```

## Documentation Files

- **README.md**: User-facing documentation (how to use the plugin)
- **CLAUDE.md**: Development documentation (architecture, patterns, internals)
- **CONTRIBUTING.md**: Contribution guidelines
- **SECURITY.md**: Security policy and vulnerability reporting

**ALWAYS read CLAUDE.md before making architectural changes.**

## Example Tasks You Might Work On

### Good Tasks for Copilot Agent

- Fix markdown linting errors
- Update documentation for clarity
- Add error handling to commands
- Create new command following existing patterns
- Add examples to skills
- Fix typos and grammar
- Update issue templates
- Improve command descriptions

### Tasks Requiring Human Oversight

- Architectural changes (three-layer system)
- Adding new dependencies
- Changing GitHub Projects data model
- Modifying plugin manifest versions
- Changing agent trigger patterns
- Altering methodology (INVEST, MoSCoW)

## Security Considerations

- Never commit GitHub tokens or credentials
- Use `gh` CLI for authentication (never store tokens)
- Validate all user input in commands
- Check permissions before GitHub operations
- Follow principle of least privilege

## Support & Resources

- **Issues**: https://github.com/sjnims/requirements-expert/issues
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Start with CLAUDE.md for architecture
- **GitHub CLI Docs**: https://cli.github.com/manual/

## Quick Reference Card

```bash
# Lint all markdown
markdownlint '**/*.md' --ignore node_modules --fix

# Test plugin locally
cc --plugin-dir plugins/requirements-expert

# Check GitHub CLI auth
gh auth status

# View GitHub Projects
gh project list --owner <owner>

# Plugin root (important!)
plugins/requirements-expert/
```

Remember: This is a pure Claude Code plugin. No build steps, no dependencies, just markdown and GitHub CLI. Keep it simple!
