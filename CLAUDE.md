# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin Overview

The requirements-expert plugin is a **Claude Code plugin** that guides users through the full requirements lifecycle: **Vision → Epics → User Stories → Tasks**. All requirements are stored as GitHub issues in GitHub Projects with full parent/child hierarchy—no local files.

## Architecture

### Component Structure

This is a **pure Claude Code plugin** following the standard plugin architecture:

```
.claude-plugin/plugin.json  # Plugin manifest (required)
commands/                   # 8 slash commands (user-initiated actions)
skills/                     # 6 knowledge modules (auto-loaded methodology)
agents/                     # 2 specialized agents (autonomous assistance)
hooks/hooks.json           # UserPromptSubmit hook (proactive detection)
.mcp.json                  # GitHub CLI MCP server configuration
```

### Three-Layer Architecture

1. **Commands Layer** (`/requirements:*` commands)
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

**Critical Design Decision**: No local files for requirements. Everything is GitHub issues.

**Hierarchy Structure**:
```
Vision Issue (Type: Vision)
  └── Epic Issue (Type: Epic, parent: Vision)
      └── Story Issue (Type: Story, parent: Epic)
          └── Task Issue (Type: Task, parent: Story)
```

**Custom Fields** (set via `gh project field-create`):
- `Type`: Vision | Epic | Story | Task
- `Priority`: Must Have | Should Have | Could Have | Won't Have
- `Status`: Not Started | In Progress | Completed

**Labels** (applied to issues):
- `type:vision`, `type:epic`, `type:story`, `type:task`
- `priority:must-have`, `priority:should-have`, `priority:could-have`, `priority:wont-have`

## Key Design Patterns

### 1. Command Chaining Pattern

Commands offer to auto-chain to the next phase:

```
/requirements:discover-vision completes
  → Ask: "Continue to identify epics?"
  → If yes: Execute /requirements:identify-epics
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

1. Create `commands/new-command.md`
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
6. Test with: `cc --plugin-dir .` then `/requirements:new-command`

### Adding a New Skill

1. Create directory: `skills/new-skill/`
2. Create `skills/new-skill/SKILL.md` with frontmatter:
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
7. Use skill-reviewer agent to validate quality

### Modifying Agents

Agents are defined in `agents/*.md` with frontmatter:
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

## Testing Commands

### Local Testing
```bash
# Load plugin locally
cc --plugin-dir /Users/stevenims/Projects/requirements-expert

# Test specific command
/requirements:init

# Debug: Check if GitHub CLI is authenticated
gh auth status

# Debug: Verify project exists
gh project list --owner [owner]
```

### Testing Workflow
1. Start in a git repository with GitHub remote
2. Ensure `gh` CLI is authenticated (`gh auth login`)
3. Run `/requirements:init` first (creates project)
4. Test command sequence: init → vision → epics → stories → tasks
5. Validate with `/requirements:review`
6. Check status with `/requirements:status`

### Common Test Scenarios

**New Project from Scratch**:
```
User: "I want to build a task management app"
→ Hook detects requirements work
→ requirements-assistant suggests /requirements:init
→ Follow full workflow
```

**Resume Existing Work**:
```
User: "I have a vision and 3 epics, need to create stories"
→ Agent checks GitHub Project state
→ Suggests /requirements:create-stories
→ Selects epic to break down
```

**Validation Check**:
```
User: "Are my requirements ready for development?"
→ Run /requirements:review
→ requirements-validator generates report
→ Fix any critical issues found
```

## GitHub CLI Integration

All commands use `gh` CLI for GitHub operations:

### Project Operations
```bash
# Create project
gh project create --owner [owner] --title "[name]"

# List projects
gh project list --owner [owner] --format json

# Add item to project
gh project item-add [project-id] --owner [owner] --url [issue-url]

# Set custom fields
gh project item-edit --id [item-id] --field-id [field-id] --value "[value]"
```

### Issue Operations
```bash
# Create issue
gh issue create --repo [repo] --title "[title]" --body "[body]" --label "type:epic"

# Read issue
gh issue view [number] --repo [repo] --json body,title

# List issues
gh issue list --repo [repo] --label "type:epic" --format json
```

### Error Handling

**Always check**:
- `gh` CLI availability: `which gh`
- Authentication: `gh auth status`
- Permissions: Look for "repo" and "project" scopes
- Repository context: `gh repo view --json nameWithOwner`

**Common errors**:
- "GitHub CLI not found" → `brew install gh`
- "Not authenticated" → `gh auth login`
- "Insufficient permissions" → `gh auth refresh -s project`

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
- Format: "As a [user], I want [goal], so that [benefit]"
- INVEST criteria compliance required
- 3-5 acceptance criteria minimum
- Linked to epic as parent

### Tasks (5-20 per story)
- Implementation-specific work items
- 2-8 hours of work (right-sized)
- 3-5 acceptance criteria minimum
- Organized by layer: frontend, backend, data, testing, docs
- Linked to story as parent

## File Organization Best Practices

When modifying this plugin:

1. **Commands**: Keep instructions clear and sequential. Use numbered steps. Include error handling.

2. **Skills**: Follow progressive disclosure. Core concepts in SKILL.md, details in references/.

3. **Agents**: Strong trigger examples. Clear system prompt. Minimal tool set.

4. **Templates**: Store in skill references/ directories, not in commands.

5. **Documentation**: Keep README comprehensive. This CLAUDE.md focuses on architecture/development.

## Common Pitfalls to Avoid

1. **Don't create local requirement files** - Everything goes in GitHub issues
2. **Don't skip state validation** - Always check what exists before suggesting next action
3. **Don't use second person in skills** - Use imperative form ("Do X" not "You should do X")
4. **Don't hardcode paths** - Use `${CLAUDE_PLUGIN_ROOT}` if needed (though not used in this plugin)
5. **Don't duplicate content** - Between SKILL.md and references/, between README and CLAUDE.md
6. **Don't make up GitHub issue numbers** - Always query actual state
7. **Don't suggest commands without prerequisites** - Check vision exists before suggesting epics

## Plugin Development Workflow

When developing new features for this plugin:

1. **Design First**: Determine which layer (command/skill/agent)
2. **Check Patterns**: Follow existing patterns in similar components
3. **Progressive Build**: Start with minimal version, expand incrementally
4. **Test Locally**: Use `cc --plugin-dir .` for each change
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
