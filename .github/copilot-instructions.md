# Copilot Instructions for Requirements Expert Plugin

**Purpose**: This file helps GitHub Copilot perform effective automated code reviews for PRs in this repository.

## Repository Overview

This is a **Claude Code plugin** for requirements management that guides users through the full requirements lifecycle: Vision → Epics → User Stories → Tasks. All requirements are stored as GitHub issues in GitHub Projects with full parent/child hierarchy.

**Key Characteristics:**
- **Type**: Claude Code plugin (pure markdown-based, NOT traditional code)
- **Size**: ~770KB, 30 markdown files
- **Language**: Markdown (100%)
- **No compilation/tests**: No build process, no runtime, no test suite
- **Only dependency**: GitHub CLI (`gh`) for GitHub Projects integration
- **Architecture**: Three-layer design (Commands → Skills → Agents)

## Critical Information for PR Reviews

### This is NOT a Traditional Code Repository

**When reviewing PRs, DO NOT:**
- Look for package.json, build scripts, or test files (they don't exist)
- Expect unit tests or integration tests (not applicable to markdown plugins)
- Comment about missing compilation steps or test coverage
- Suggest adding build processes or CI/CD beyond markdown validation
- Flag missing runtime dependencies or package installations

**Instead, focus on:**
- Markdown style compliance (see validation rules below)
- Content structure and clarity
- Consistency with existing patterns
- Documentation completeness

### Plugin Root Location

**Critical for reviewing file paths**: The plugin root is `plugins/requirements-expert/`, NOT the repository root.

Repository structure:
- Repository root = marketplace
- `plugins/requirements-expert/` = publishable plugin unit

When reviewing PRs that modify plugin files, verify paths include `plugins/requirements-expert/` prefix.

## PR Review Focus Areas

### 1. Markdown Style Compliance (PRIMARY CHECK)

**This is the most important validation**. The CI will fail if markdown doesn't pass linting.

**When reviewing PRs, check for these common violations:**

❌ **Wrong list style** (CI will fail):
```markdown
* List item
+ Another item
```
✅ **Correct - use dashes**:
```markdown
- List item
- Another item
```

❌ **Wrong header style** (CI will fail):
```markdown
Header Text
===========
```
✅ **Correct - use ATX style**:
```markdown
# Header Text
```

❌ **Wrong list indentation** (CI will fail):
```markdown
- Item
    - Sub-item (4 spaces)
```
✅ **Correct - 2 space indentation**:
```markdown
- Item
  - Sub-item (2 spaces)
```

❌ **Indented code blocks** (CI will fail):
```markdown
    code here
```
✅ **Correct - use fenced blocks**:
````markdown
```bash
code here
```
````

**Important style rules** (from `.markdownlint.json`):
- ATX-style headers (`#`, `##`, `###`) - NOT setext (underlines)
- Dash-style lists (`-`) - NOT asterisk (`*`) or plus (`+`)
- 2-space list indentation (not 4 spaces)
- Fenced code blocks - NOT indented blocks
- No line length limits (MD013 disabled, so don't flag long lines)
- Allowed HTML: `<example>`, `<commentary>`, `<details>`, `<summary>`, `<br>` (don't flag these)

**CI Workflow**: `markdownlint.yml` runs on every PR with markdown changes (takes ~30-40 seconds)

### 2. Link Validity (SECONDARY CHECK)

Links are validated in CI via lychee (`links.yml` workflow, runs ~1-2 minutes).

**When reviewing PRs with new links:**
- Check that URLs are properly formatted
- Internal links use relative paths, not absolute URLs
- Note: Some domains (claude.ai/code) block automated checks but work in browsers - these are in `.lycheeignore`
- Don't flag links that are in `.lycheeignore`

### 3. GitHub Actions Workflow Syntax (IF MODIFIED)

Only relevant if PR modifies `.github/workflows/*.yml` files.

**Check for:**
- Valid YAML syntax
- Proper GitHub Actions syntax
- Uses of deprecated actions

**CI Workflow**: `validate-workflows.yml` runs actionlint (~20-30 seconds)

## Plugin Component Review Guidelines

### Commands (`plugins/requirements-expert/commands/*.md`)

8 slash commands: `/re:init`, `/re:discover-vision`, `/re:identify-epics`, `/re:create-stories`, `/re:create-tasks`, `/re:prioritize`, `/re:review`, `/re:status`

**When reviewing command PRs, verify:**

✅ **Correct YAML frontmatter**:
```yaml
---
name: command-name
description: Brief description
allowed-tools: [Bash, AskUserQuestion, Read]
---
```

✅ **Imperative form** (instructions FOR Claude, not TO user):
- Good: "Do X", "Run Y", "Create Z"
- Bad: "You should do X", "Please run Y"

✅ **Error handling** for common failures:
- GitHub CLI not found
- Not authenticated
- Not in git repository
- Insufficient permissions

✅ **GitHub CLI usage**: Commands use `gh` CLI via Bash tool

### Skills (`plugins/requirements-expert/skills/*/SKILL.md`)

6 knowledge modules: vision-discovery, epic-identification, user-story-creation, task-breakdown, prioritization, requirements-feedback

**When reviewing skill PRs, verify:**

✅ **Correct YAML frontmatter with trigger phrases**:
```yaml
---
name: Skill Name
description: This skill should be used when the user asks to "trigger phrase"...
version: 0.1.0
---
```

✅ **Progressive disclosure**:
- Core content in SKILL.md (<2,000 words)
- Detailed content in `references/` subdirectory
- NO duplication between SKILL.md and references/

✅ **Third-person description** with specific trigger phrases:
- Good: `This skill should be used when the user asks to "create user stories"`
- Bad: `Use this skill to help users`

✅ **Templates** stored in `references/` subdirectory

### Agents (`plugins/requirements-expert/agents/*.md`)

2 agents: requirements-assistant, requirements-validator

**When reviewing agent PRs, verify:**

✅ **Complete YAML frontmatter**:
```yaml
---
name: agent-name
description: Use this agent when...
model: inherit
color: blue
tools: [Bash, AskUserQuestion]
---
```

✅ **3-4 `<example>` blocks** showing triggering behavior

✅ **Minimal tool list** (only tools actually needed)

✅ **Clear system prompt** defining role and responsibilities

### Hooks (`plugins/requirements-expert/hooks/hooks.json`)

Single `UserPromptSubmit` hook for detecting requirements queries.

**When reviewing hook PRs, verify:**
- Valid JSON syntax
- Reasonable timeout values
- Clear matcher patterns

## File Organization

```
/                                    # Repository root (marketplace)
├── .github/
│   ├── workflows/                   # CI and automation workflows
│   │   ├── markdownlint.yml        # Markdown linting (runs on every PR)
│   │   ├── links.yml               # Link checking (weekly + PRs)
│   │   └── validate-workflows.yml  # Workflow validation
│   ├── ISSUE_TEMPLATE/             # Issue templates
│   ├── pull_request_template.md    # PR template
│   └── labels.yml                  # Label definitions
├── .claude-plugin/
│   └── marketplace.json             # Marketplace manifest (v0.1.0)
├── plugins/
│   └── requirements-expert/         # PLUGIN ROOT
│       ├── .claude-plugin/
│       │   └── plugin.json         # Plugin manifest (v0.1.0)
│       ├── commands/               # 8 slash commands
│       ├── skills/                 # 6 knowledge modules
│       ├── agents/                 # 2 specialized agents
│       └── hooks/
│           └── hooks.json          # UserPromptSubmit hook
├── .markdownlint.json              # Markdown linting rules
├── .markdownlintignore             # Files to ignore in linting
├── .lycheeignore                   # Links to ignore in link checking
├── .gitignore                      # Git ignore patterns
├── README.md                       # User documentation
├── CLAUDE.md                       # Development/architecture docs
├── CONTRIBUTING.md                 # Contribution guidelines
├── CHANGELOG.md                    # Version history
├── CODE_OF_CONDUCT.md             # Code of conduct
├── SECURITY.md                     # Security policy
└── LICENSE.txt                     # MIT license
```

## GitHub Workflows (CI/CD)

### Markdown Lint (`markdownlint.yml`)

**Triggers**: Every PR with markdown changes, every push to main
**Duration**: 30-40 seconds
**Action**: Runs markdownlint on all markdown files
**Pass Criteria**: Zero linting errors

**If this fails:**
1. Run locally: `markdownlint '**/*.md' --ignore node_modules --fix`
2. Manually fix any remaining issues
3. Commit and push

### Link Checker (`links.yml`)

**Triggers**: PRs with markdown changes, weekly schedule, manual dispatch
**Duration**: 1-2 minutes
**Action**: Checks all links in markdown files using lychee
**Pass Criteria**: No broken links (excluding those in `.lycheeignore`)

**If this fails:**
- Fix broken links or add false positives to `.lycheeignore`
- Note: Some domains (claude.ai/code) block automated checks but work in browsers

### Validate Workflows (`validate-workflows.yml`)

**Triggers**: Every PR, every push to main
**Duration**: 20-30 seconds
**Action**: Validates GitHub Actions workflow syntax using actionlint
**Pass Criteria**: Valid YAML and workflow syntax

## Documentation Review Guidelines

### README.md (User-Facing Documentation)

**When reviewing README.md changes, verify:**
- Clear, user-friendly language
- Accurate command examples
- Up-to-date installation instructions
- Working links to external resources
- Consistent with actual plugin behavior

### CLAUDE.md (Development/Architecture Documentation)

**When reviewing CLAUDE.md changes, verify:**
- Accurate architectural descriptions
- Development commands are correct
- Consistent with actual plugin structure
- Clear examples and code snippets
- Version information is current

### CONTRIBUTING.md (Contribution Guidelines)

**When reviewing CONTRIBUTING.md changes, verify:**
- Clear step-by-step instructions
- Accurate workflow descriptions
- Up-to-date prerequisite information
- Consistent with actual development process

### Plugin Manifests

**When reviewing manifest changes:**
- `plugins/requirements-expert/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

**Verify:**
- Versions match in BOTH files (critical)
- Valid JSON syntax
- Accurate descriptions
- Correct repository URLs

## Common Issues to Flag in PR Reviews

### 1. Markdown Style Violations (WILL BREAK CI)

**Flag these - CI will fail:**

❌ Using `*` or `+` for lists:
```markdown
* Item
+ Item
```

❌ Using setext headers:
```markdown
Header
======
```

❌ Wrong list indentation (4 spaces):
```markdown
- Item
    - Sub-item
```

❌ Indented code blocks:
```markdown
    code
```

**Suggest using:**
- Dash lists (`-`)
- ATX headers (`#`)
- 2-space indentation
- Fenced code blocks

### 2. Wrong Plugin Root References

❌ **Flag this** - referencing repository root as plugin:
```markdown
See `commands/init.md` for details
```

✅ **Should be**:
```markdown
See `plugins/requirements-expert/commands/init.md` for details
```

### 3. Inconsistent Component Structure

**Commands without proper frontmatter**:
- Missing `name`, `description`, or `allowed-tools`
- Using second person instead of imperative form

**Skills without trigger phrases**:
- Description missing specific "when the user asks to" phrases
- Content exceeds 2,000 words without using references/

**Agents without examples**:
- Missing `<example>` blocks for triggering behavior
- Including unnecessary tools

### 4. Documentation Inconsistencies

❌ **Flag these**:
- README.md examples that don't match actual commands
- CLAUDE.md architecture descriptions that contradict actual structure
- Version numbers that don't match between manifests
- Broken internal links (relative paths)

### 5. Missing Error Handling in Commands

**Commands should handle common errors**:
- GitHub CLI not installed
- Not authenticated
- Not in a git repository
- Missing permissions (repo, project scopes)

If a PR adds/modifies a command, verify error handling is present.

### 6. Content Duplication

❌ **Flag this** - duplicating content between files:
- Same content in SKILL.md and references/
- Repeating README.md content in CLAUDE.md
- Copy-pasting between similar commands instead of referencing

### 7. Scope Violations

**Flag PRs that try to add**:
- Build processes (not applicable to markdown plugins)
- Test frameworks (not used for markdown plugins)
- Package managers (only dependency is GitHub CLI)
- Compilation steps (markdown doesn't compile)

**These are out of scope** for this repository type.

## What to Look For in Different PR Types

### PRs Modifying Commands

**Key review points:**
1. YAML frontmatter complete and valid
2. Imperative form (not second person)
3. Error handling for common failures
4. Markdown style compliance
5. GitHub CLI usage patterns correct

**Ask:**
- Does this follow patterns in existing commands?
- Is error handling comprehensive?
- Are instructions clear and actionable?

### PRs Modifying Skills

**Key review points:**
1. YAML frontmatter includes trigger phrases
2. Core content under 2,000 words
3. Detailed content in references/ subdirectory
4. No duplication between SKILL.md and references/
5. Third-person description style

**Ask:**
- Will Claude Code auto-activate this skill appropriately?
- Is progressive disclosure used correctly?
- Are trigger phrases specific enough?

### PRs Modifying Documentation

**Key review points:**
1. Markdown style compliance
2. Accurate information (matches actual behavior)
3. Clear and concise language
4. Working links
5. Appropriate file modified (README vs CLAUDE.md)

**Ask:**
- Is this user-facing (README) or developer-facing (CLAUDE)?
- Are examples accurate and working?
- Is version information current?

### PRs Adding New Features

**Key review points:**
1. Follows existing architectural patterns
2. Consistent with three-layer design (Commands → Skills → Agents)
3. Documentation updated appropriately
4. No external dependencies added (except GitHub CLI)
5. Markdown style compliant

**Ask:**
- Does this fit the plugin's purpose and scope?
- Is it consistent with existing patterns?
- Is documentation complete?

### PRs Fixing Bugs

**Key review points:**
1. Fix addresses root cause (not just symptom)
2. Doesn't break existing functionality
3. Error handling improved if applicable
4. Documentation updated if behavior changed

**Ask:**
- Does this actually fix the reported issue?
- Are there similar issues elsewhere that also need fixing?
- Should error messages be improved?

## Review Checklist for PRs

Use this checklist when reviewing any PR:

### All PRs

- [ ] Markdown style compliant (will CI pass?)
- [ ] No broken links introduced
- [ ] Files modified are in appropriate directories
- [ ] Changes are consistent with repository architecture
- [ ] No attempt to add build/test infrastructure (not applicable)

### PRs Modifying Plugin Components

- [ ] YAML frontmatter complete and valid
- [ ] Follows established patterns for that component type
- [ ] Plugin root paths correct (`plugins/requirements-expert/`)
- [ ] Error handling present (if applicable)

### PRs Modifying Documentation

- [ ] Information is accurate
- [ ] Examples work as documented
- [ ] Appropriate documentation file(s) updated
- [ ] Version numbers consistent (if applicable)

### PRs from External Contributors

- [ ] Follows CONTRIBUTING.md guidelines
- [ ] Includes clear description of changes
- [ ] No inappropriate scope expansion
- [ ] Respects existing architecture

## Version Management (For Release PRs)

**Current Version**: 0.1.0

**Critical: Both manifests must match**:
- `plugins/requirements-expert/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

When reviewing version bump PRs:
- [ ] Version matches in both manifests
- [ ] CHANGELOG.md updated
- [ ] README.md updated (if needed)
- [ ] Follows release procedure described in CLAUDE.md

## Quick Reference for Reviews

### CI Workflows (Will These Pass?)

1. **Markdown Lint** (~30-40 sec) - Check for style violations listed above
2. **Link Check** (~1-2 min) - Check for broken links (except .lycheeignore)
3. **Workflow Validation** (~20-30 sec) - Only if .github/workflows/ modified

### Essential Files to Reference

- `.markdownlint.json` - Markdown style rules (understand these!)
- `CLAUDE.md` - Architecture and development guide
- `CONTRIBUTING.md` - Contribution guidelines
- `README.md` - User-facing documentation

### Directory Structure

- Plugin root: `plugins/requirements-expert/` (NOT repository root)
- Commands: `plugins/requirements-expert/commands/` (8 files)
- Skills: `plugins/requirements-expert/skills/` (6 directories)
- Agents: `plugins/requirements-expert/agents/` (2 files)
- Workflows: `.github/workflows/` (5 files)

## Key Architecture Principles to Enforce

When reviewing PRs, ensure these principles are maintained:

1. **Pure Markdown Plugin**: No compilation, no runtime, no external packages (except GitHub CLI)
2. **Three-Layer Architecture**: Commands → Skills → Agents (don't mix layers)
3. **100% GitHub Projects**: Requirements stored as GitHub issues (never local files)
4. **Progressive Disclosure**: Core content in main files, details in references/
5. **Imperative Instructions**: Commands written FOR Claude (not TO users)
6. **No Duplication**: Content should appear in one place only

## Final Notes for Reviewers

**This is a unique repository type**: It's a pure markdown-based Claude Code plugin, not traditional software. The usual code review concerns (test coverage, build processes, runtime dependencies) don't apply here.

**Focus your review on**:
- Markdown style compliance (this is what breaks CI)
- Content accuracy and clarity
- Consistency with existing patterns
- Plugin architecture adherence

**Don't waste time on**:
- Suggesting test frameworks
- Asking for build scripts
- Requesting dependency updates
- Traditional code quality metrics

**Trust the documentation**: This repository is well-documented. README.md and CLAUDE.md contain comprehensive information about architecture, patterns, and development workflows.
