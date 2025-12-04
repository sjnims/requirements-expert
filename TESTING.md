# TESTING.md

This file provides comprehensive testing strategies for contributors creating or modifying plugin commands.

## Quick Test

```bash
# Load plugin locally (from repository root)
cc --plugin-dir plugins/requirements-expert

# Test a specific command
/re:init
```

## Prerequisites

- Git repository with GitHub remote
- GitHub CLI (`gh`) authenticated: `gh auth login`
- GitHub Projects enabled on repository

## Full Lifecycle Test

Run these commands in sequence to test the complete workflow:

1. `/re:init` - Create project with custom fields
2. `/re:discover-vision` - Create vision issue
3. `/re:identify-epics` - Create epic issues
4. `/re:create-stories` - Create story issues (select epic)
5. `/re:create-tasks` - Create task issues (select story)
6. `/re:prioritize` - Apply MoSCoW priorities
7. `/re:review` - Validate structure and quality
8. `/re:status` - View project summary

## Test Scenarios

- **New project**: Start with `/re:init`, follow full workflow
- **Resume work**: Agent checks GitHub state, suggests next appropriate command
- **Add to existing**: Commands detect existing items and offer to add more
- **Validation**: Run `/re:review` to check for issues

## Testing `/re:init` Command

### 1. Happy Path Testing

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

### 2. Idempotency Testing

- [ ] Run `/re:init` again in the same repository
- [ ] Verify no duplicate project created (reuses existing)
- [ ] Verify no duplicate fields created (skips existing)
- [ ] Verify appropriate "already exists" messages displayed
- [ ] Verify command completes successfully

### 3. Error Cases - Prerequisites Validation

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

### 4. Interactive Recovery Testing (Step 6)

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

### 5. Field Creation Optimization Testing

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

### 6. AskUserQuestion Structure Validation

- [ ] Step 4 (Project Name):
  - Verify proper structure: question, header, multiSelect, options
  - Verify header within 12 character limit ("Project Name" = 12)
  - Verify 3 options with labels and descriptions
  - Verify "Other" option available for custom input
  - Verify repository name placeholder substitution

### 7. Edge Cases

- [ ] Test with special characters in repository name
- [ ] Test with very long repository name
- [ ] Test in organization vs personal account
- [ ] Test with existing project using exact same name
- [ ] Test with rate limiting (many API calls in succession)

## Testing Other Commands

### General Testing Pattern

1. Prerequisites validation (gh CLI, auth, repo context)
2. Happy path execution
3. Idempotency (safe to re-run)
4. Error handling (graceful failures)
5. User interaction (AskUserQuestion where applicable)
6. GitHub API integration (correct commands, error handling)

### Validation Checklist

- [ ] YAML frontmatter syntax correct
- [ ] Allowed-tools list matches actual tool usage
- [ ] Commands use proper GitHub CLI patterns (see CLAUDE.md "Critical GitHub CLI Patterns")
- [ ] Error messages are clear and actionable
- [ ] Success messages include next steps
- [ ] Markdown formatting passes linting

## Linting Before Commit

```bash
# Lint all markdown files
markdownlint '**/*.md' --ignore node_modules

# Lint specific command
markdownlint plugins/requirements-expert/commands/new-command.md

# Auto-fix issues
markdownlint '**/*.md' --ignore node_modules --fix
```

## Validating Components

```bash
# After modifying a skill
/plugin-dev:skill-reviewer        # Review skill quality

# After creating/modifying plugin structure
/plugin-dev:plugin-validator      # Validate plugin structure
```

## Validating GitHub Actions Locally

```bash
# Install actionlint if not already installed
brew install actionlint

# Validate all workflow files
actionlint

# Validate a specific workflow
actionlint .github/workflows/markdownlint.yml
```
