# Requirements Expert Plugin for Claude Code

A comprehensive requirements management plugin that guides users through the full requirements lifecycle using GitHub Projects for complete traceability and collaboration.

## Overview

The Requirements Expert plugin helps you transform vague ideas into fully-structured, actionable requirements using a proven methodology:

**Vision → Epics → User Stories → Tasks**

Everything is managed in GitHub Projects with full parent/child hierarchy, making your entire product roadmap visible and trackable in one place.

## Features

- **Interactive Discovery**: Guided Q&A sessions for each phase using best practices
- **Full Lifecycle Support**: Vision → Epics → Stories → Tasks with feedback loops
- **GitHub Projects Integration**: All requirements stored as GitHub issues with true hierarchy
- **MoSCoW Prioritization**: Built-in prioritization framework at every level
- **Automated Validation**: Quality checks for completeness, consistency, and best practices
- **Workflow Orchestration**: Seamlessly move from one phase to the next with guided automation

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Access to a GitHub repository with Projects enabled
- GitHub permissions: `repo`, `project` (read/write)

## Installation

### Local Development

```bash
# Clone or create the plugin directory
cd /path/to/requirements-expert

# Test with Claude Code
cc --plugin-dir /path/to/requirements-expert
```

### From Marketplace

*(Publishing instructions will be added after initial development)*

## Quick Start

### 1. Initialize a New Project

```
/requirements:init
```

Creates a GitHub Project for your repository with custom fields (Type, Priority, Status) and configures project views.

### 2. Discover Your Vision

```
/requirements:discover-vision
```

Interactive Q&A session that helps you articulate:
- Problem statement
- Target users
- Success metrics
- Core value proposition

Creates a Vision issue in your GitHub Project.

### 3. Identify Epics

```
/requirements:identify-epics
```

Analyzes your vision and guides you through identifying major features/capabilities. Creates Epic issues as children of the Vision issue.

### 4. Create User Stories

```
/requirements:create-stories
```

Select an epic and break it down into user stories following INVEST criteria. Creates Story issues as children of the Epic.

### 5. Define Tasks

```
/requirements:create-tasks
```

Break a story into concrete tasks with acceptance criteria. Creates Task issues as children of the Story.

### 6. Prioritize

```
/requirements:prioritize
```

Use MoSCoW framework (Must/Should/Could/Won't) to prioritize at any level.

### 7. Review & Validate

```
/requirements:review
```

Runs automated validation checks:
- Completeness (all required sections present)
- Consistency (proper linking, no orphans)
- Quality (INVEST criteria for stories, clear acceptance criteria)
- Traceability (vision → epic → story → task chain)

### 8. Check Status

```
/requirements:status
```

View project overview:
- Counts by type (X epics, Y stories, Z tasks)
- Completion status
- Validation results
- Recent activity

## GitHub Projects Structure

All requirements are stored as GitHub issues in a project with this hierarchy:

```
📋 Vision (Issue, Type: Vision)
  ├── 🎯 Epic 1 (Child Issue, Type: Epic)
  │   ├── 📝 Story 1 (Child Issue, Type: Story)
  │   │   ├── ✅ Task 1 (Child Issue, Type: Task)
  │   │   └── ✅ Task 2 (Child Issue, Type: Task)
  │   └── 📝 Story 2 (Child Issue, Type: Story)
  │       └── ✅ Task 3 (Child Issue, Type: Task)
  └── 🎯 Epic 2 (Child Issue, Type: Epic)
      └── 📝 Story 3 (Child Issue, Type: Story)
          └── ✅ Task 4 (Child Issue, Type: Task)
```

### Custom Fields

- **Type**: Vision | Epic | Story | Task
- **Priority**: Must Have | Should Have | Could Have | Won't Have
- **Status**: Not Started | In Progress | Completed

### Labels

- `priority:must-have`, `priority:should-have`, `priority:could-have`, `priority:wont-have`
- `type:vision`, `type:epic`, `type:story`, `type:task`

## Usage Examples

### Example 1: Starting from Scratch

```
User: "I'd like to build a web app that showcases Google Gemini failures"

→ requirements-assistant agent detects this and suggests the plugin
→ User accepts, agent runs /requirements:init
→ Project created
→ Agent runs /requirements:discover-vision
→ Interactive Q&A creates Vision issue
→ Agent asks: "Continue to identify epics?"
→ User: "Yes"
→ Agent runs /requirements:identify-epics
→ ... continues through the lifecycle
```

### Example 2: Continuing from a Specific Phase

```
User: "I have a vision defined, need help identifying epics"

→ requirements-assistant detects this
→ Agent runs /requirements:review to validate existing vision
→ If valid, runs /requirements:identify-epics
→ If issues found, suggests fixing them first
```

### Example 3: Iterating on Existing Work

```
User: "I need to add another epic to my project"

→ User runs /requirements:identify-epics
→ Command detects existing epics
→ Offers to add new epic or refine existing ones
→ Creates new epic as child of Vision issue
```

## Commands Reference

| Command | Description |
|---------|-------------|
| `/requirements:init` | Initialize GitHub Project with custom fields |
| `/requirements:discover-vision` | Interactive vision discovery session |
| `/requirements:identify-epics` | Identify and create epic issues |
| `/requirements:create-stories` | Break epic into user stories |
| `/requirements:create-tasks` | Break story into tasks with acceptance criteria |
| `/requirements:prioritize` | Prioritize requirements using MoSCoW |
| `/requirements:review` | Validate requirements for quality and completeness |
| `/requirements:status` | Show project overview and status |

## Skills

The plugin includes six specialized skills that provide methodology and best practices:

1. **vision-discovery** - How to discover and document product vision
2. **epic-identification** - How to identify and define epics from vision
3. **user-story-creation** - How to write effective user stories (INVEST criteria)
4. **task-breakdown** - How to decompose stories into tasks with acceptance criteria
5. **prioritization** - MoSCoW prioritization framework
6. **requirements-feedback** - Continuous feedback and iteration practices

Skills are automatically activated when relevant to the current work.

## Agents

### requirements-assistant

Proactively detects when you're working on requirements and offers help. Orchestrates the workflow by:
- Detecting requirements-related queries in your messages
- Suggesting appropriate commands based on context
- Automatically chaining phases (vision → epics → stories → tasks)
- Validating each phase before proceeding

### requirements-validator

Validates requirements documents for:
- **Completeness**: All required sections present
- **Consistency**: Proper linking between levels
- **Quality**: INVEST criteria for stories, clear acceptance criteria
- **Traceability**: Complete chain from vision to tasks

## Methodology

This plugin follows an Agile-inspired requirements methodology:

### Vision
The high-level product vision answering:
- What problem are we solving?
- Who are we solving it for?
- What does success look like?

### Epics
Major capabilities or features that:
- Deliver significant value
- Are too large for a single iteration
- Align with the vision

### User Stories
Specific user-facing functionality following INVEST criteria:
- **I**ndependent: Can be developed separately
- **N**egotiable: Details can be discussed
- **V**aluable: Delivers user value
- **E**stimable: Size can be estimated
- **S**mall: Fits in an iteration
- **T**estable: Can be verified

Format: "As a [user], I want [goal] so that [benefit]"

### Tasks
Concrete implementation steps with:
- Clear, actionable description
- Acceptance criteria (testable conditions)
- Effort estimate
- Dependencies

## Configuration

The plugin auto-detects configuration from your environment:

### GitHub Repository
Auto-detected from `git remote` in current directory.

### GitHub Authentication
Uses GitHub CLI (`gh`) authentication. Ensure you're logged in:

```bash
gh auth status
```

### Project Name
Auto-generated from repository name, or you can specify during init.

## Troubleshooting

### "GitHub CLI not found"

Ensure `gh` is installed and in your PATH:

```bash
brew install gh  # macOS
gh auth login
```

### "Insufficient permissions"

The plugin requires these GitHub permissions:
- `repo` - To create and manage issues
- `project` - To create and manage projects

Check with:
```bash
gh auth status
```

Re-authenticate if needed:
```bash
gh auth refresh -s project
```

### "Project not found"

Run `/requirements:init` to create the project, or ensure the project exists in your repository.

### "Cannot create child issues"

GitHub Projects (beta) is required for parent/child relationships. Ensure:
1. You're using GitHub Projects (beta), not classic projects
2. Your repository has Projects enabled
3. You have write access to the project

## Best Practices

1. **Start with Vision**: Always begin with `/requirements:discover-vision` to establish clear direction
2. **One Epic at a Time**: Fully flesh out one epic before moving to the next
3. **Keep Stories Small**: User stories should fit in 1-2 weeks of work
4. **Clear Acceptance Criteria**: Every task needs testable acceptance criteria
5. **Regular Review**: Run `/requirements:review` frequently to catch issues early
6. **Prioritize Often**: Use `/requirements:prioritize` at each phase to focus on high-value work
7. **Iterate**: Use the feedback loops to refine requirements as you learn

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

## License

MIT License - see LICENSE file for details

## Support

- **Issues**: [GitHub Issues](https://github.com/sjnims/requirements-expert/issues)
- **Discussions**: [GitHub Discussions](https://github.com/sjnims/requirements-expert/discussions)

## Changelog

### v0.1.0 (Initial Release)
- Full requirements lifecycle support
- GitHub Projects integration
- 8 commands for all phases
- 6 methodology skills
- 2 specialized agents
- MoSCoW prioritization
- Automated validation
