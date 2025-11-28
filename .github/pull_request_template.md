## Description

<!-- Provide a clear and concise description of your changes -->

## Type of Change

<!-- Mark the relevant option with an "x" -->

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update (improvements to README, CLAUDE.md, or component docs)
- [ ] Refactoring (code change that neither fixes a bug nor adds a feature)
- [ ] Configuration change (changes to .markdownlint.json, plugin.json, etc.)

## Component(s) Affected

<!-- Mark all that apply -->

- [ ] Commands (`/re:*`)
- [ ] Skills (methodology and best practices)
- [ ] Agents (requirements-assistant, requirements-validator)
- [ ] Hooks (UserPromptSubmit)
- [ ] Documentation (README.md, CLAUDE.md, SECURITY.md)
- [ ] Configuration (.markdownlint.json, plugin.json, marketplace.json)
- [ ] Issue/PR templates
- [ ] Other (please specify):

## Motivation and Context

<!-- Why is this change required? What problem does it solve? -->
<!-- If it fixes an open issue, please link to the issue here -->

Fixes # (issue)

## How Has This Been Tested?

<!-- Describe the tests you ran to verify your changes -->

**Test Configuration**:
- Claude Code version:
- GitHub CLI version: `gh --version`
- OS:
- Testing repository: <!-- public repo you tested with, if applicable -->

**Test Steps**:
1. <!-- e.g., Load plugin with `cc --plugin-dir plugins/requirements-expert` -->
2. <!-- e.g., Run command `/re:init` -->
3. <!-- e.g., Verify project created successfully -->
4. <!-- etc. -->

## Checklist

### General

- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas (if applicable)
- [ ] My changes generate no new warnings or errors

### Documentation

- [ ] I have updated the documentation accordingly (README.md, CLAUDE.md, or component docs)
- [ ] I have updated YAML frontmatter (if applicable)
- [ ] I have verified all links work correctly

### Markdown

- [ ] I have run `markdownlint` and fixed all issues
- [ ] My markdown follows the repository style (ATX headers, dash lists, fenced code blocks)
- [ ] I have verified special HTML elements are properly closed (`<example>`, `<commentary>`, etc.)

### Component-Specific Checks

<!-- Only relevant if you modified commands, skills, or agents -->

#### Commands (if applicable)

- [ ] Command uses imperative form ("Do X", not "You should do X")
- [ ] Error handling is included for common failure modes
- [ ] GitHub CLI commands are properly formatted
- [ ] Success/failure messages are clear and helpful

#### Skills (if applicable)

- [ ] Description uses third-person with specific trigger phrases
- [ ] SKILL.md is under 2,000 words (progressive disclosure)
- [ ] Detailed content is in `references/` subdirectory
- [ ] Templates follow the established format

#### Agents (if applicable)

- [ ] Agent includes 3-4 `<example>` blocks
- [ ] Examples demonstrate triggering conditions clearly
- [ ] System prompt is clear and focused
- [ ] Tool list is minimal and appropriate

### Testing

- [ ] I have tested the plugin locally with `cc --plugin-dir plugins/requirements-expert`
- [ ] I have tested the full workflow (if applicable)
- [ ] I have verified GitHub CLI integration works (if applicable)
- [ ] I have tested in a clean repository (not my development repo)

### Version Management (if applicable)

- [ ] I have updated version numbers in both `plugin.json` and `marketplace.json` (if this is a release)
- [ ] I have updated version numbers in all 6 skills (if this is a release):
  - [ ] `plugins/requirements-expert/skills/epic-identification/SKILL.md`
  - [ ] `plugins/requirements-expert/skills/prioritization/SKILL.md`
  - [ ] `plugins/requirements-expert/skills/requirements-feedback/SKILL.md`
  - [ ] `plugins/requirements-expert/skills/task-breakdown/SKILL.md`
  - [ ] `plugins/requirements-expert/skills/user-story-creation/SKILL.md`
  - [ ] `plugins/requirements-expert/skills/vision-discovery/SKILL.md`
- [ ] I have updated CHANGELOG.md with relevant changes

## Screenshots (if applicable)

<!-- Add screenshots to help explain your changes -->

## Additional Notes

<!-- Add any other context about the pull request here -->

## Reviewer Notes

<!-- Information specifically for the reviewer -->

**Areas that need special attention**:
<!-- List any specific areas you'd like reviewers to focus on -->

**Known limitations or trade-offs**:
<!-- Describe any known issues or compromises made -->

---

## Pre-Merge Checklist (for maintainers)

- [ ] All CI checks pass
- [ ] Documentation is accurate and complete
- [ ] Changes align with project architecture and design patterns
- [ ] No security vulnerabilities introduced
- [ ] Breaking changes are clearly documented
- [ ] Version numbers are updated (if applicable)
