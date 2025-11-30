---
name: requirements-feedback
description: This skill should be used when the user asks about "feedback loops", "iterate on requirements", "continuous documentation", "refine requirements", "update requirements", "requirements changed", "stakeholder review", "validate requirements", "incorporate feedback", "gather feedback", "requirements review meeting", "backlog refinement feedback", "user research findings", "sprint retrospective feedback", or when they need guidance on collecting and incorporating feedback throughout the requirements lifecycle.
version: 0.2.0
---

# Requirements Feedback & Continuous Documentation

## When This Skill Loads

First, identify which requirement level the user is working with (Vision, Epic, Story, or Task).

Then determine their current need:

1. **Collecting feedback** (user asks about methods, sources, techniques) - Load `references/feedback-techniques.md`
2. **Stage-specific guidance** (user asks about feedback for a specific level) - Load `references/stage-feedback-guide.md`
3. **Running a review** (user wants to validate or check requirements) - Load `references/feedback-checklist.md`
4. **Incorporating feedback** (user has feedback to act on) - Follow the 7-step Quick Reference workflow below

Guide users through the feedback workflow:

1. Identify appropriate feedback sources for their requirement level
2. Collect feedback using proper methods (from references)
3. Document feedback in GitHub issue comments
4. Update requirements based on validated learnings
5. Communicate changes to stakeholders

Adapt based on where the user is in the process.

## Overview

Requirements are not static—they evolve as teams learn more about users, technology, and the market. This skill guides the practice of gathering feedback at each stage of the requirements lifecycle and using that feedback to continuously refine and improve requirements. Establishing effective feedback loops ensures requirements remain accurate, valuable, and aligned with user needs.

## Purpose

Continuous requirements feedback:

- Validates assumptions early and often
- Catches misunderstandings before they become expensive
- Adapts to new information and changing conditions
- Keeps requirements aligned with user needs
- Improves quality through iteration
- Builds shared understanding across team and stakeholders

## Feedback at Each Stage

Each level of the requirements hierarchy has distinct feedback needs. For detailed guidance on who to involve, what questions to ask, and how to incorporate feedback at each level, see `references/stage-feedback-guide.md`.

| Level | When to Gather Feedback | Key Focus |
|-------|------------------------|-----------|
| **Vision** | After creating/updating vision | Problem validation, strategic alignment |
| **Epic** | After identifying epics, before stories | Completeness, feasibility, dependencies |
| **Story** | During refinement, after user testing | INVEST criteria, acceptance criteria clarity |
| **Task** | During implementation, code review | Accuracy, discovered work, blockers |

## The Build-Measure-Learn Loop

**Build:** Implement requirements (epic → stories → tasks)

**Measure:** Collect data and feedback

- User testing and interviews
- Usage analytics
- Business metrics
- Team retrospectives

**Learn:** Extract insights and refine requirements

- What worked? (do more)
- What didn't? (change or remove)
- What's missing? (add)
- What changed? (adapt)

**Repeat:** Update requirements and iterate

## Continuous Documentation Practices

### Keep Requirements Up to Date

- Requirements in GitHub issues (in GitHub Projects) are living documents, not static specs
- Update issues as understanding evolves
- Add clarifications when questions arise
- Document decisions made during implementation

### Document Learnings

- Add comments to issues with findings from user research
- Link to test results or analytics that inform requirements
- Reference customer feedback or support tickets
- Note technical discoveries that impact requirements

### Maintain Traceability

- Tasks link to parent stories
- Stories link to parent epics
- Epics link to parent vision
- Full chain of traceability maintained
- Link to supporting documents (design mocks, research findings)

## Best Practices

### Create Safe Space for Feedback

- Make it safe to say "this requirement doesn't make sense"
- Reward people who catch problems early
- Avoid blame when requirements change
- Ask open questions: "What is missing?"

### Act on Feedback Quickly

- Update requirements soon after feedback (while fresh)
- Communicate changes to those who provided feedback
- Tell people how their feedback was used
- Explain decisions (even if feedback not incorporated)

### Balance Stability and Flexibility

- Batch small changes; major changes require broader review
- New information should lead to updates
- Better to change requirements than build wrong thing
- Adaptability is a strength, not weakness

### Document the "Why" Behind Changes

- Add comment explaining significant updates
- Reference supporting evidence (user quotes, data)
- Tag relevant people
- GitHub tracks all changes to issues via edit history

### Validate with Real Users

- Get outside perspective regularly
- Test assumptions with actual users
- Observe real usage, not just opinions
- Gather feedback early, before reaching completion

## Common Pitfalls to Avoid

| Pitfall | Problem | Solution |
|---------|---------|----------|
| **Treating requirements as contracts** | Resistance to change | Collaborate; requirements should evolve |
| **Ignoring implementation feedback** | Missing important technical details | Listen when developers raise concerns |
| **Feedback without action** | Disengages contributors | Act on feedback or explain why not |
| **Changing too frequently** | Confusion and churn | Batch minor updates; communicate major changes |
| **Only internal feedback** | Echo chamber risk | Involve real users regularly |

## Quick Reference: Feedback Integration Flow

1. **Collect Feedback** → Gather insights from users, stakeholders, team
2. **Analyze** → Identify patterns, validate assumptions, extract learnings
3. **Decide** → Determine what changes to make to requirements
4. **Update** → Modify GitHub issues (vision, epics, stories, tasks)
5. **Communicate** → Inform stakeholders and team of changes
6. **Validate** → Verify changes address feedback and improve requirements
7. **Repeat** → Continuous cycle throughout product lifecycle

## GitHub Projects Integration

### Tracking Feedback

- Add feedback as comments on relevant issues
- Tag people who provided feedback
- Link to supporting evidence (research findings, analytics)

**Useful labels:**

- `needs-validation` - Requires user feedback
- `feedback-received` - Feedback available, needs incorporation
- `updated-from-feedback` - Changed based on feedback

### Documenting Changes

- GitHub tracks all changes to issues via edit history
- Add comment when making significant updates explaining what changed and why
- Reference feedback sources and link to related issues, test results, or PRs

## Reference Files

Load references as needed:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **stage-feedback-guide.md** | Detailed guidance for feedback at each requirements level (Vision, Epic, Story, Task) | `references/stage-feedback-guide.md` |
| **feedback-techniques.md** | Methods for user research, stakeholder reviews, team feedback, and automated feedback | `references/feedback-techniques.md` |
| **feedback-checklist.md** | Conducting feedback reviews or validating requirements at any level | `references/feedback-checklist.md` |

## Integration with Requirements Lifecycle

Feedback loops operate throughout the entire lifecycle:

> Vision → Epics → Stories → Tasks

At each transition:

1. Gather feedback on current level
2. Incorporate learnings
3. Use refined requirements to inform next level
4. Repeat

**Post-Implementation:** Gather usage data and user feedback, update requirements based on learnings, and inform future work.

---

Requirements feedback is not a phase—it's an ongoing practice that keeps requirements aligned with reality and ensures continuous improvement throughout the product lifecycle.

## Related Skills

| Skill | Relationship |
|-------|-------------|
| **vision-discovery** | Gather feedback to validate and refine vision |
| **epic-identification** | Gather feedback to validate epic completeness and scope |
| **user-story-creation** | Gather feedback to validate story value and acceptance criteria |
| **task-breakdown** | Gather implementation feedback to refine tasks |
| **prioritization** | Use feedback insights to adjust priorities |
