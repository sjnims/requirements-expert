# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2025-11-26

### Added

- **GitHub Discussion templates** for Q&A, feature requests, announcements, and show-and-tell (#75)
- **Claude Code GitHub Action workflows** for automated PR review and issue triage (#53)
- **CODEOWNERS file** for automatic PR reviewer assignment (#54)
- **Interactive error recovery** to `/re:init` Step 6 with retry, diagnostic, and exit options (#34)
- **Release Drafter** for automated release notes generation from merged PRs (#62)
- **PR auto-labeler** based on changed files (#61)
- **Automated label sync** workflow from `.github/labels.yml` (#60)
- **Dependabot auto-merge** for non-breaking dependency updates (#64)
- **Concurrency controls** to all GitHub Actions workflows (#59)
- Missing labels for workflow automation and versioning (#51)

### Changed

- Consolidated to Claude-only PR review setup, removing redundant reviewers (#55)
- Optimized `/re:init` field listing to reduce API calls (#35)
- Improved `/re:init` Step 4 AskUserQuestion structure (#33)
- Enhanced init command with comprehensive documentation improvements (#26)

### Fixed

- Shell quoting issue in `claude_args` by removing inner quotes (#74)
- Discussion template slug mismatch and removed unsupported name/description fields
- Bot workflow cancellation by including actor in concurrency group
- Claude workflow self-triggering by excluding `claude[bot]` from triggers
- `validate-workflows.yml` performance using pre-built actionlint action (#71)
- Claude Code Action native commenting instead of `gh pr comment` (#69)
- Contents write permission for Claude to push branches
- Non-existent `gh project view-create` commands in Step 11 (#39)
- `[project-id]` references replaced with `[project-number]` throughout (#27)
- GitHub Actions version comments (#70)

### Security

- **Pinned all GitHub Actions to full SHA** for supply chain security (#58)

### Performance

- Added caching to link checker workflow for faster runs (#72)

### Documentation

- Fixed documentation inaccuracies in CLAUDE.md and README.md
- Improved CLAUDE.md portability and quick reference section
- Improved Mermaid diagram color contrast in README for accessibility (#57)
- Fixed CHANGELOG date and added Acknowledgments section to README (#56)
- Documented "GitHub as source of truth" design decision (#38)
- Added comprehensive testing strategies to CLAUDE.md (#37)
- Added verified GitHub CLI patterns and CI/CD documentation

## [0.1.0] - 2025-11-22

### Added

- **Initial release** of requirements-expert Claude Code plugin
- **Full requirements lifecycle support** (Vision → Epics → User Stories → Tasks)

#### Core Features

- **8 slash commands** for complete workflow coverage:
  - `/re:init` - Initialize GitHub Project with custom fields
  - `/re:discover-vision` - Interactive vision discovery session
  - `/re:identify-epics` - Identify and create major capabilities
  - `/re:create-stories` - Break epics into user stories (INVEST criteria)
  - `/re:create-tasks` - Break stories into implementation tasks
  - `/re:prioritize` - Apply MoSCoW prioritization framework
  - `/re:review` - Validate requirements quality and completeness
  - `/re:status` - View comprehensive project overview

- **6 methodology skills** with progressive disclosure:
  - `vision-discovery` - Product vision discovery methodology and templates
  - `epic-identification` - Epic identification from vision
  - `user-story-creation` - INVEST criteria for effective user stories
  - `task-breakdown` - Task decomposition with acceptance criteria
  - `prioritization` - MoSCoW prioritization framework and worksheets
  - `requirements-feedback` - Continuous feedback and iteration practices

- **2 specialized agents** for autonomous assistance:
  - `requirements-assistant` - Workflow orchestration and proactive guidance
  - `requirements-validator` - Quality validation and INVEST compliance checking

#### Integration & Data

- **GitHub Projects integration** with full parent/child issue hierarchy
- **Two-layer metadata system**:
  - Custom project fields (Type, Priority, Status)
  - Issue labels for cross-project queries
- **Command chaining** for seamless workflow progression
- **State-first validation** to prevent invalid operations

#### Quality & Best Practices

- **MoSCoW prioritization** framework built into workflows
- **INVEST criteria enforcement** for user stories
- **Automated quality checks** via requirements-validator agent
- **3-5 acceptance criteria minimum** for stories and tasks

#### Documentation

- **Comprehensive user documentation**:
  - `README.md` - Complete user guide with examples
  - `CONTRIBUTING.md` - Contributor guidelines and development setup
  - `SECURITY.md` - Security policy and vulnerability reporting
  - `CODE_OF_CONDUCT.md` - Community standards and expectations
  - `CHANGELOG.md` - Version history and release notes

- **Developer documentation**:
  - `CLAUDE.md` - Architecture, patterns, and development guide
  - Inline documentation in all components
  - Template files for all requirement types

#### Repository Infrastructure

- **Issue templates** (4 types):
  - Bug report with reproduction steps
  - Feature request with use cases
  - Documentation improvements
  - Questions and discussions

- **Pull request template** with component-specific checklists:
  - Commands, Skills, Agents validation
  - Markdown quality checks
  - Testing requirements

- **GitHub Actions workflows** (5 workflows):
  - `markdownlint.yml` - Markdown style enforcement
  - `links.yml` - Link validation with lychee
  - `greet.yml` - Welcome new contributors
  - `stale.yml` - Stale issue/PR management
  - `validate-workflows.yml` - Workflow validation

- **Comprehensive label system**:
  - Component labels (agent, command, skill, hook, docs)
  - Priority labels (critical, high, medium, low)
  - Status labels (blocked, in-progress, needs-review)
  - Effort labels (small, medium, large)
  - Dependency labels (dependencies, github-actions)
  - Special labels (experiment, pinned, security)
  - Version-controlled in `.github/labels.yml`
  - Sync script for label management

- **Dependabot configuration** for automated GitHub Actions updates

- **Code quality tools**:
  - Markdownlint configuration (`.markdownlint.json`)
  - Markdown ignore patterns (`.markdownlintignore`)

#### Plugin Architecture

- **UserPromptSubmit hook** for proactive plugin suggestions
- **Marketplace-at-root structure** for distribution
- **Progressive disclosure pattern** in skills (lean SKILL.md + detailed references/)
- **Three-layer architecture** (Commands → Skills → Agents)
- **MIT License** for open-source distribution
- **Semantic versioning** from initial release

#### Manifests

- `plugin.json` - Plugin metadata and configuration (v0.1.0)
- `marketplace.json` - Marketplace distribution metadata (v0.1.0)

[Unreleased]: https://github.com/sjnims/requirements-expert/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/sjnims/requirements-expert/releases/tag/v0.2.0
[0.1.0]: https://github.com/sjnims/requirements-expert/releases/tag/v0.1.0
