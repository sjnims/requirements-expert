# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial release of requirements-expert Claude Code plugin
- Full requirements lifecycle support (Vision → Epics → User Stories → Tasks)
- 8 slash commands for all workflow phases:
  - `/requirements:init` - Initialize GitHub Project
  - `/requirements:discover-vision` - Interactive vision discovery
  - `/requirements:identify-epics` - Identify major capabilities
  - `/requirements:create-stories` - Break epics into user stories
  - `/requirements:create-tasks` - Break stories into tasks
  - `/requirements:prioritize` - Apply MoSCoW prioritization
  - `/requirements:review` - Validate requirements quality
  - `/requirements:status` - View project overview
- 6 methodology skills:
  - vision-discovery - Product vision discovery methodology
  - epic-identification - Epic identification from vision
  - user-story-creation - INVEST criteria for user stories
  - task-breakdown - Task decomposition with acceptance criteria
  - prioritization - MoSCoW prioritization framework
  - requirements-feedback - Continuous feedback and iteration
- 2 specialized agents:
  - requirements-assistant - Workflow orchestration and proactive guidance
  - requirements-validator - Quality validation and INVEST compliance
- GitHub Projects integration with full parent/child hierarchy
- MoSCoW prioritization framework
- INVEST criteria validation for user stories
- Automated quality checks via requirements-validator agent
- Comprehensive documentation:
  - README.md - User-facing guide
  - CLAUDE.md - Developer documentation
  - CONTRIBUTING.md - Contributor guidelines
  - SECURITY.md - Security policy
  - CODE_OF_CONDUCT.md - Community standards
- Issue templates (bug report, feature request, documentation, question)
- Pull request template with component-specific checklists
- MIT License
- Markdownlint configuration for code quality
- UserPromptSubmit hook for proactive plugin suggestions
- CI/CD workflows for automation
- Dependabot configuration for GitHub Actions updates
- Enhanced issue labels (dependencies, github-actions)
- Repository badges in README
