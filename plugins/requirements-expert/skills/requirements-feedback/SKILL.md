---
name: Requirements Feedback
description: This skill should be used when the user asks about "feedback loops", "iterate on requirements", "continuous documentation", "refine requirements", "update requirements", "requirements changed", or when they need guidance on gathering feedback and continuously improving requirements throughout the product lifecycle.
version: 0.2.0
---

# Requirements Feedback & Continuous Documentation

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

## Feedback Loops at Each Stage

### Vision-Level Feedback

**When:** After creating or updating vision

**Who to Involve:**
- Key stakeholders (executives, product leaders)
- Representative users or customers
- Technical leads (feasibility check)
- Marketing/sales (market validation)

**Questions to Ask:**
- Does this vision resonate with target users?
- Is the problem statement accurate and compelling?
- Are success metrics realistic and measurable?
- Does this align with business strategy?
- Are scope boundaries clear and appropriate?

**Feedback Mechanisms:**
- Vision review meetings
- Customer interviews about the problem space
- Stakeholder alignment sessions
- Competitive analysis validation

**How to Incorporate Feedback:**
- Update vision issue in GitHub Projects
- Revise problem statement based on user insights
- Adjust success metrics based on stakeholder input
- Clarify scope based on feasibility feedback
- Document assumptions that were validated or invalidated

---

### Epic-Level Feedback

**When:** After identifying epics, before creating stories

**Who to Involve:**
- Product team (completeness check)
- Engineering leads (technical feasibility)
- UX/Design (user journey validation)
- Business stakeholders (strategic alignment)

**Questions to Ask:**
- Do these epics collectively deliver the full vision?
- Are there gaps in user journeys or capabilities?
- Is the scope of each epic appropriate?
- Are epics properly bounded and distinct?
- Are dependencies and sequence logical?

**Feedback Mechanisms:**
- Epic review sessions
- User journey mapping workshops
- Technical feasibility assessments
- Roadmap planning meetings

**How to Incorporate Feedback:**
- Add missing epics that were overlooked
- Split epics that are too large or cover multiple concerns
- Combine epics that overlap or are too granular
- Adjust epic scope based on technical constraints
- Re-prioritize based on new strategic insights
- Update epic issues in GitHub Projects

---

### Story-Level Feedback

**When:** After creating stories, during refinement, after user testing

**Who to Involve:**
- Development team (implementability)
- UX/Design (user experience)
- QA/Test (testability)
- Users (value validation)

**Questions to Ask:**
- Do stories follow INVEST criteria?
- Are acceptance criteria clear and testable?
- Are stories small enough for an iteration?
- Do stories deliver real user value?
- Are edge cases and error scenarios covered?

**Feedback Mechanisms:**
- Backlog refinement sessions
- Story review with development team
- User testing of prototypes or early implementations
- Acceptance criteria walkthrough

**How to Incorporate Feedback:**
- Split stories that are too large
- Add missing acceptance criteria
- Create new stories for overlooked scenarios
- Revise story descriptions for clarity
- Adjust priorities based on user feedback
- Update story issues in GitHub Projects

---

### Task-Level Feedback

**When:** During implementation, code review, testing

**Who to Involve:**
- Developers (during implementation)
- Code reviewers (during review)
- QA engineers (during testing)
- Product owner (during acceptance)

**Questions to Ask:**
- Are acceptance criteria accurate and complete?
- Did implementation reveal missing requirements?
- Are there technical challenges not anticipated?
- Do actual results match expected outcomes?
- Are there edge cases not covered?

**Feedback Mechanisms:**
- Daily standups
- Code reviews
- Test results and bug reports
- Sprint demos and retrospectives

**How to Incorporate Feedback:**
- Update task acceptance criteria if incomplete
- Create new tasks for discovered work
- Update story acceptance criteria if task feedback reveals gaps
- Document lessons learned for similar future work
- Update task status in GitHub Projects

---

## Continuous Documentation Practices

### Keep Requirements Up to Date

**Living Documents:**
- Requirements in GitHub issues (in GitHub Projects) are living documents, not static specs
- Update issues as understanding evolves
- Add clarifications when questions arise
- Document decisions made during implementation

**Version History:**
- GitHub automatically tracks issue edit history
- Use comments to explain significant changes
- Reference related issues or discussions

**When to Update:**
- When assumptions are proven wrong
- When user feedback reveals new insights
- When technical constraints require scope changes
- When priorities shift

### Document What You Learn

**Capture Insights:**
- Add comments to issues with findings from user research
- Link to test results or analytics that inform requirements
- Reference customer feedback or support tickets
- Note technical discoveries that impact requirements

**Make it Searchable:**
- Use consistent terminology across issues
- Tag issues with relevant labels
- Reference related issues via links
- Keep GitHub Projects metadata current

### Maintain Traceability

**Link Related Work:**
- Tasks link to parent stories
- Stories link to parent epics
- Epics link to parent vision
- Full chain of traceability maintained

**Cross-Reference:**
- Link to related issues (dependencies, related work)
- Reference GitHub PRs that implement requirements
- Link to supporting documents (design mocks, research findings)

---

## Feedback Collection Techniques

### User Research

**Methods:**
- User interviews about problems and needs
- Usability testing of prototypes or implementations
- Surveys about feature priorities
- Analytics on actual usage patterns

**When to Use:**
- Vision validation (does problem resonate?)
- Epic prioritization (what matters most?)
- Story refinement (does solution work for users?)
- Post-launch (are we delivering value?)

**Incorporating Results:**
- Update requirements based on validated learnings
- Adjust priorities based on actual user behavior
- Create new requirements for discovered needs
- Remove or deprioritize unused features

### Stakeholder Reviews

**Methods:**
- Regular review meetings with key stakeholders
- Async reviews via GitHub issue (in a GitHub Project) comments
- Roadmap planning sessions
- Business alignment check-ins

**When to Use:**
- Vision and epic level (strategic alignment)
- Major priority decisions
- Scope change requests
- Resource allocation decisions

**Incorporating Results:**
- Update strategic alignment notes in vision/epics
- Adjust priorities based on business needs
- Add or remove requirements based on strategic shifts

### Team Feedback

**Methods:**
- Backlog refinement sessions
- Sprint retrospectives
- Code review comments
- Technical spike findings

**When to Use:**
- Story and task creation
- Implementation challenges
- Technical feasibility questions
- Process improvements

**Incorporating Results:**
- Clarify ambiguous requirements
- Split overly complex requirements
- Add technical constraints or considerations
- Improve future requirements based on lessons learned

### Automated Feedback

**Methods:**
- Analytics and usage tracking
- Error logs and monitoring
- Performance metrics
- A/B test results

**When to Use:**
- Post-launch validation
- Feature usage analysis
- Performance requirements validation
- Hypothesis testing

**Incorporating Results:**
- Validate or invalidate assumptions
- Identify unused features to remove
- Discover high-value features to enhance
- Update success metrics based on reality

---

## Iteration Patterns

### The Build-Measure-Learn Loop

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

### Regular Review Cadences

**Weekly:** Story refinement and task feedback
- Review upcoming stories with team
- Incorporate feedback from current sprint
- Adjust task estimates and acceptance criteria

**Monthly:** Epic and priority review
- Review progress on epics
- Adjust epic priorities based on learnings
- Add/remove/modify epics as needed

**Quarterly:** Vision and strategy review
- Validate vision still accurate and relevant
- Update based on market changes
- Adjust success metrics based on progress
- Re-align with business strategy

### Trigger-Based Updates

Update requirements when:
- **Major user feedback:** Significant insights from research or support
- **Technical discovery:** Implementation reveals new constraints or opportunities
- **Market change:** Competitors, regulations, or user expectations shift
- **Strategic pivot:** Business priorities or direction changes

---

## Best Practices

### Create Safe Space for Feedback

**Encourage honesty:**
- Make it safe to say "this requirement doesn't make sense"
- Reward people who catch problems early
- Avoid blame when requirements change

**Ask open questions:**
- "What are we missing?"
- "What concerns do you have?"
- "What would make this clearer?"

### Act on Feedback Quickly

**Rapid incorporation:**
- Update requirements soon after feedback (while fresh)
- Communicate changes to those who provided feedback
- Show that feedback leads to action

**Close the loop:**
- Tell people how their feedback was used
- Explain decisions (even if feedback not incorporated)
- Thank contributors

### Balance Stability and Flexibility

**Don't change constantly:**
- Batch small changes
- Major changes require broader review
- Communicate changes clearly

**But don't resist change:**
- New information should lead to updates
- Better to change requirements than build wrong thing
- Adaptability is a strength, not weakness

### Document the "Why" Behind Changes

**Change rationale:**
- Why was this requirement updated?
- What new information prompted the change?
- Who requested or approved the change?

**Use GitHub issue (in a GitHub Project) comments:**
- Add comment explaining significant updates
- Reference supporting evidence (user quotes, data, etc.)
- Tag relevant people

### Validate with Real Users

**Not just internal feedback:**
- Get outside perspective regularly
- Test assumptions with actual users
- Observe real usage, not just opinions

**Early and often:**
- Don't wait for "finished" to get feedback
- Prototypes, mockups, beta releases
- Small tests beat big reveals

---

## Common Pitfalls to Avoid

### Treating Requirements as Contracts

Requirements are communication tools, not legal contracts:
- They should evolve as understanding grows
- Resist "frozen" requirements that can't change
- Collaboration over specification

### Ignoring Implementation Feedback

Developers discover important details during implementation:
- Listen when they say "this is harder than expected"
- Investigate when estimates are way off
- Respect technical insights

### Feedback Without Action

Collecting feedback but not using it:
- If you ask for feedback, act on it (or explain why not)
- Update requirements based on learnings
- Close the feedback loop

### Changing Too Frequently

Constant churn creates confusion:
- Batch minor updates
- Communicate major changes clearly
- Stabilize before critical milestones

### Only Internal Feedback

Echo chamber risk:
- Involve real users regularly
- Seek outside perspectives
- Challenge assumptions with data

---

## Quick Reference: Feedback Integration Flow

1. **Collect Feedback** → Gather insights from users, stakeholders, team
2. **Analyze** → Identify patterns, validate assumptions, extract learnings
3. **Decide** → Determine what changes to make to requirements
4. **Update** → Modify GitHub issues (vision, epics, stories, tasks) - issues in GitHub Projects
5. **Communicate** → Inform stakeholders and team of changes
6. **Validate** → Verify changes address feedback and improve requirements
7. **Repeat** → Continuous cycle throughout product lifecycle

## GitHub Projects Integration

### Tracking Feedback

**Use issue comments:**
- Add feedback as comments on relevant issues
- Tag people who provided feedback
- Link to supporting evidence (research findings, analytics)

**Use labels:**
- `needs-validation` - Requires user feedback
- `feedback-received` - Feedback available, needs incorporation
- `updated-from-feedback` - Changed based on feedback

**Use custom fields:**
- Last Updated date
- Validation Status (Not Validated / In Progress / Validated)

### Documenting Changes

**Issue edit history:**
- GitHub tracks all changes to issues
- View history to see how requirements evolved

**Comments for rationale:**
- Add comment when making significant updates
- Explain what changed and why
- Reference feedback sources

**Linking:**
- Link to user research issues
- Link to test results
- Link to related PRs or discussions

---

## Additional Resources

### Reference Files

Load references as needed:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **feedback-checklist.md** | Conducting feedback reviews or validating requirements at any level | `references/feedback-checklist.md` |

---

## Integration with Requirements Lifecycle

Feedback loops operate throughout the entire lifecycle:

> Vision → Epics → Stories → Tasks

At each transition:
1. Gather feedback on current level
2. Incorporate learnings
3. Use refined requirements to inform next level
4. Repeat

**Post-Implementation:**
- Gather usage data and user feedback
- Update requirements based on learnings
- Inform future work and iterations

---

Requirements feedback is not a phase—it's an ongoing practice that keeps requirements aligned with reality and ensures continuous improvement throughout the product lifecycle.
