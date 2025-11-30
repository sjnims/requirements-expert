# Stage-by-Stage Feedback Guide

Detailed guidance for gathering and incorporating feedback at each level of the requirements hierarchy.

---

## Vision-Level Feedback

**When:** After creating or updating vision

### Who to Involve

- Key stakeholders (executives, product leaders)
- Representative users or customers
- Technical leads (feasibility check)
- Marketing/sales (market validation)

### Questions to Ask

- Does this vision resonate with target users?
- Is the problem statement accurate and compelling?
- Are success metrics realistic and measurable?
- Does this align with business strategy?
- Are scope boundaries clear and appropriate?

### Feedback Mechanisms

- Vision review meetings
- Customer interviews about the problem space
- Stakeholder alignment sessions
- Competitive analysis validation

### How to Incorporate Feedback

- Update vision issue in GitHub Projects
- Revise problem statement based on user insights
- Adjust success metrics based on stakeholder input
- Clarify scope based on feasibility feedback
- Document assumptions that were validated or invalidated

---

## Epic-Level Feedback

**When:** After identifying epics, before creating stories

### Who to Involve

- Product team (completeness check)
- Engineering leads (technical feasibility)
- UX/Design (user journey validation)
- Business stakeholders (strategic alignment)

### Questions to Ask

- Do these epics collectively deliver the full vision?
- Are there gaps in user journeys or capabilities?
- Is the scope of each epic appropriate?
- Are epics properly bounded and distinct?
- Are dependencies and sequence logical?

### Feedback Mechanisms

- Epic review sessions
- User journey mapping workshops
- Technical feasibility assessments
- Roadmap planning meetings

### How to Incorporate Feedback

- Add missing epics that were overlooked
- Split epics that are too large or cover multiple concerns
- Combine epics that overlap or are too granular
- Adjust epic scope based on technical constraints
- Re-prioritize based on new strategic insights
- Update epic issues in GitHub Projects

---

## Story-Level Feedback

**When:** After creating stories, during refinement, after user testing

### Who to Involve

- Development team (implementability)
- UX/Design (user experience)
- QA/Test (testability)
- Users (value validation)

### Questions to Ask

- Do stories follow INVEST criteria?
- Are acceptance criteria clear and testable?
- Are stories small enough for an iteration?
- Do stories deliver real user value?
- Are edge cases and error scenarios covered?

### Feedback Mechanisms

- Backlog refinement sessions
- Story review with development team
- User testing of prototypes or early implementations
- Acceptance criteria walkthrough

### How to Incorporate Feedback

- Split stories that are too large
- Add missing acceptance criteria
- Create new stories for overlooked scenarios
- Revise story descriptions for clarity
- Adjust priorities based on user feedback
- Update story issues in GitHub Projects

---

## Task-Level Feedback

**When:** During implementation, code review, testing

### Who to Involve

- Developers (during implementation)
- Code reviewers (during review)
- QA engineers (during testing)
- Product owner (during acceptance)

### Questions to Ask

- Are acceptance criteria accurate and complete?
- Did implementation reveal missing requirements?
- Are there technical challenges not anticipated?
- Do actual results match expected outcomes?
- Are there edge cases not covered?

### Feedback Mechanisms

- Daily standups
- Code reviews
- Test results and bug reports
- Sprint demos and retrospectives

### How to Incorporate Feedback

- Update task acceptance criteria if incomplete
- Create new tasks for discovered work
- Update story acceptance criteria if task feedback reveals gaps
- Document lessons learned for similar future work
- Update task status in GitHub Projects

---

## Iteration Patterns

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
