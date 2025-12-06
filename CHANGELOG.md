# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.0] - 2025-12-06

### Added

- **New skills**:
  - `shared-patterns` skill for common command flows including error handling, idempotency, batch tracking, and metadata patterns (#346)
  - `validation` skill extracted from review command for reusable validation methodology (#356)
- **Idempotency and recovery handling** added to 5 commands: discover-vision, identify-epics, create-stories, create-tasks, prioritize (#322, #325, #326, #327, #329)
- **6 new CI/CD workflows**:
  - Automated PR review with Claude (#307)
  - Plugin component validation (#308)
  - Version consistency check (#309)
  - Semantic PR labeling (#310)
  - CI failure analysis (#311)
  - Weekly maintenance report (#312)
- **Commit signing** for Claude Code Action (#333)
- **AskUserQuestion specifications** to review and status commands (#315, #316)

### Changed

- **Commands now leverage associated skills** - discover-vision, identify-epics, create-stories, create-tasks, prioritize, and review commands load their corresponding skills for methodology (#348, #349, #350, #351, #352, #360)
- **Standardized command format** for AI consumption:
  - Removed redundant Notes and Error Handling sections (#365)
  - Standardized AskUserQuestion format across all commands (#364)
  - Simplified status.md metric specifications (#363)
  - Standardized step heading format (#321)
  - Separated output formatting from instructions (#320)
  - Converted Note: sections to imperative instructions (#319)
  - Replaced user-facing option labels with imperative alternatives (#318)
  - Removed user-facing language and emojis (#279, #280)
  - Condensed verbose templates to structural guidance (#281)
- **Improved skills for progressive disclosure** - reduced verbosity and improved quality across all skills (#361, #362)
- **Reduced init.md verbosity** from 288 to 135 lines (#347)
- **Removed requirements-validator agent** - functionality consolidated into validation skill and review command (#356)

### Fixed

- **CI workflow fixes**:
  - Install markdownlint-cli for Claude PR review (#359)
  - Exclude deleted files from component validation (#357)
  - Scope component validation to changed files only (#353)
  - Correct allowedTools flag format (#331)
  - Correct claude_args escaping for PR review workflow (#330)
- **Command fixes**:
  - Remove SlashCommand references and command chaining (#324)
  - Shorten AskUserQuestion headers to ≤12 characters (#314)
  - Correct AskUserQuestion usage patterns (#277)
  - Use explicit Read tool for template references (#276)
  - Add missing tool permissions to review and status commands (#274)
- **Documentation fixes**:
  - Update skill count from 6 to 8 across all documentation
  - Fix README skill count (was "seven", now "eight")

### Security

- **Restricted Bash tool to `Bash(gh:*)`** in all commands for least privilege security (#275)

### Documentation

- **Added TESTING.md** with comprehensive testing strategies (#332)
- **Streamlined CLAUDE.md** with improved organization
- **Documented `${CLAUDE_PLUGIN_ROOT}` limitation** for command files (#317)
- **Added semantic labeler documentation** to LABELS.md
- **Removed Release Drafter** - replaced with manual release process

### CI/CD

- **Updated GitHub Actions** to latest versions (#354)
- **Improved validation skill description triggers** (#358)

## [0.3.0] - 2025-11-30

### Added

- **Quick Actions & Routing section** to 5 skills for intelligent skill-to-skill navigation (#244)
- **Command Integration section** to 5 skills documenting slash command relationships (#245)
- **Explicit routing triggers** in Related Skills tables across all skills (#233, #246)
- **Examples directories** to prioritization, requirements-feedback, user-story-creation, task-breakdown, and vision-discovery skills (#147, #156, #170, #202, #124)
- **Reference files** for progressive disclosure in vision-discovery and task-breakdown skills (#262, #263)
- **MoSCoW classification decision tree** to prioritization skill (#188)
- **Field ID retrieval guidance** to prioritization Step 6 (#187)
- **Cross-references between related skills** for better navigation (#161)
- **Intelligent PR review workflow** with dynamic model selection (#107)

### Changed

- **Standardized section ordering** across all 6 skills for consistency (#248)
- **Restructured skills for progressive disclosure** - moved detailed content to references/ directories (#138, #178, #198, #243)
- **Converted all skills to imperative form** for better AI consumption (#81, #105, #108, #141, #200, #261)
- **Expanded trigger phrases** in skill descriptions for improved activation (#84, #128, #139, #159, #169, #201, #211)
- **Removed redundant sections** from skills to reduce duplication (#94, #95, #140, #155, #225, #231, #242)
- **Standardized Examples table format** in prioritization skill (#247)
- **Reframed skill content for AI consumption** with bullet points and clear directives (#180, #203, #209)

### Fixed

- **Skill name frontmatter** now uses kebab-case consistently (#190)
- **Removed duplicated templates** from feedback workflow example (#223)
- **Second-person language violations** in vision-discovery and prioritization skills (#119, #182)
- **Release Drafter duplicate entries** and malformed headers (#162)
- **Shell-quote parsing** in allowed-tools CI configuration (#144)

### Documentation

- **Added explicit Quick Reference labels** to skill content (#264)
- **Expanded Best Practices sections** in requirements-feedback skill (#256)
- **Added Purpose and Overview sections** to requirements-feedback skill (#253, #254)
- **Added Feedback Collection Process** documentation (#255)
- **Improved template structure** by removing redundant sections (#142, #146)
- **Standardized relative paths** in skill references (#118, #157)
- **Clarified optional vision sections** usage (#129)
- **Added version consistency check commands** to CLAUDE.md

### CI/CD

- **Removed Claude Code Review workflow** in favor of native GitHub integration (#181)

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

[Unreleased]: https://github.com/sjnims/requirements-expert/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/sjnims/requirements-expert/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/sjnims/requirements-expert/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/sjnims/requirements-expert/releases/tag/v0.2.0
[0.1.0]: https://github.com/sjnims/requirements-expert/releases/tag/v0.1.0
