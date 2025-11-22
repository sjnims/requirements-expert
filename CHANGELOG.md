# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-01-22

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

[0.1.0]: https://github.com/sjnims/requirements-expert/releases/tag/v0.1.0
