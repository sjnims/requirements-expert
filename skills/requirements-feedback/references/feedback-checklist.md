# Requirements Feedback Checklist

Use this checklist to ensure comprehensive feedback collection and incorporation at each level of the requirements hierarchy.

---

## Vision-Level Feedback Review

**Timing:** After creating/updating vision, quarterly reviews

### Preparation

- [ ] Vision issue is complete and current in GitHub Projects
- [ ] Key stakeholders identified and available
- [ ] Supporting research/data gathered (market analysis, user research)
- [ ] Review meeting scheduled with adequate time (60-90 minutes)

### Feedback Questions

**Problem Validation:**
- [ ] Do target users resonate with the problem statement?
- [ ] Is the problem significant enough to solve?
- [ ] Are there other more pressing problems to address first?

**User Validation:**
- [ ] Are target user descriptions accurate?
- [ ] Have we identified all key user types?
- [ ] Do we understand their context and constraints?

**Solution Validation:**
- [ ] Does the solution vision make sense to stakeholders?
- [ ] Is the value proposition compelling?
- [ ] Are there alternative approaches we should consider?

**Strategic Alignment:**
- [ ] Does this align with business goals and strategy?
- [ ] Is timing right for this initiative?
- [ ] Do we have resources and commitment?

**Success Metrics:**
- [ ] Are success metrics measurable and realistic?
- [ ] Do metrics align with business objectives?
- [ ] Can we actually track these metrics?

**Scope & Boundaries:**
- [ ] Are boundaries clear and appropriate?
- [ ] Is anything missing from scope?
- [ ] Is anything included that shouldn't be?

### Actions

- [ ] Document feedback received (in issue comments)
- [ ] Update vision based on validated learnings
- [ ] Communicate changes to stakeholders
- [ ] Schedule next vision review (quarterly or as needed)

---

## Epic-Level Feedback Review

**Timing:** After identifying epics, before story creation, monthly reviews

### Preparation

- [ ] All epic issues created in GitHub Projects
- [ ] Epics linked to vision as children
- [ ] Initial prioritization complete
- [ ] Product team and technical leads available

### Feedback Questions

**Completeness:**
- [ ] Do these epics collectively deliver the full vision?
- [ ] Are there gaps in user journeys?
- [ ] Are all target user types covered?
- [ ] Do epics address all success metrics?

**Scope & Boundaries:**
- [ ] Is each epic appropriately scoped (not too big/small)?
- [ ] Are epic boundaries clear and distinct?
- [ ] Is there overlap between epics that should be resolved?

**Technical Feasibility:**
- [ ] Are all epics technically feasible?
- [ ] Are there technical risks or unknowns to investigate?
- [ ] Are architectural foundations identified?

**Dependencies:**
- [ ] Have all inter-epic dependencies been identified?
- [ ] Is sequencing logical given dependencies?
- [ ] Are there external dependencies to consider?

**Prioritization:**
- [ ] Does priority order make sense?
- [ ] Are "Must Haves" truly essential?
- [ ] Are "Won't Haves" clearly documented?

### Actions

- [ ] Add missing epics discovered during review
- [ ] Split or combine epics as needed
- [ ] Update epic scope and descriptions
- [ ] Adjust priorities based on feedback
- [ ] Update dependency mapping
- [ ] Document changes in epic issue comments

---

## Story-Level Feedback Review

**Timing:** During backlog refinement, before sprint planning

### Preparation

- [ ] Stories created for epic being reviewed
- [ ] Stories linked to epic as children
- [ ] Development team, UX, and QA available
- [ ] User research findings available (if applicable)

### Feedback Questions

**INVEST Criteria:**
- [ ] Are stories independent enough?
- [ ] Are details negotiable (not over-specified)?
- [ ] Does each story deliver clear value?
- [ ] Can team estimate each story?
- [ ] Are stories small enough (1-5 days)?
- [ ] Are stories testable with clear acceptance criteria?

**Completeness:**
- [ ] Do stories cover all epic scope?
- [ ] Are edge cases and error scenarios covered?
- [ ] Are all user types' needs addressed?

**Clarity:**
- [ ] Is the user goal clear in each story?
- [ ] Are acceptance criteria specific and testable?
- [ ] Are assumptions and constraints documented?

**Value:**
- [ ] Does each story deliver user-facing value?
- [ ] Are priorities appropriate?
- [ ] Can we explain "why" for each story?

### Actions

- [ ] Split stories that are too large
- [ ] Combine stories that are too granular
- [ ] Add missing stories
- [ ] Clarify vague acceptance criteria
- [ ] Update story descriptions and estimates
- [ ] Adjust priorities based on team feedback

---

## Task-Level Feedback Review

**Timing:** During sprint, daily standups, code reviews

### Preparation

- [ ] Tasks created for story being implemented
- [ ] Tasks linked to story as children
- [ ] Implementers identified and assigned
- [ ] Story acceptance criteria reviewed

### Feedback Questions

**Clarity:**
- [ ] Is it clear what needs to be done?
- [ ] Are acceptance criteria specific enough?
- [ ] Are technical notes helpful?

**Completeness:**
- [ ] Are all necessary tasks identified?
- [ ] Are testing tasks included?
- [ ] Are documentation tasks included?

**Dependencies:**
- [ ] Is task sequencing correct?
- [ ] Have blockers been identified?
- [ ] Can tasks be parallelized?

**Implementation Feedback:**
- [ ] Are actual results matching expected outcomes?
- [ ] Have we discovered missing tasks?
- [ ] Are estimates accurate?
- [ ] Have we learned anything that should update the story?

### Actions

- [ ] Add tasks discovered during implementation
- [ ] Update task acceptance criteria if incomplete
- [ ] Update story acceptance criteria if tasks reveal gaps
- [ ] Document implementation learnings
- [ ] Adjust future task breakdown based on learnings

---

## Post-Implementation Feedback Review

**Timing:** After feature launch, ongoing

### Preparation

- [ ] Feature deployed and available to users
- [ ] Analytics/metrics collection in place
- [ ] User feedback channels established
- [ ] Stakeholders identified for review

### Feedback Questions

**Value Delivery:**
- [ ] Are users actually using this feature?
- [ ] Is it delivering expected value?
- [ ] Are success metrics being achieved?
- [ ] What's working well?

**Problems & Pain Points:**
- [ ] What issues are users encountering?
- [ ] What's confusing or difficult?
- [ ] What's missing that users need?
- [ ] What feedback are we getting from support?

**Opportunities:**
- [ ] What enhancements would increase value?
- [ ] What related needs have been discovered?
- [ ] What should we build next?

**Validation:**
- [ ] Were our assumptions correct?
- [ ] What did we get wrong?
- [ ] What did we learn?

### Actions

- [ ] Update requirements based on usage data
- [ ] Create new stories for enhancements
- [ ] Deprioritize or remove unused features
- [ ] Document lessons learned
- [ ] Update vision/epics if major insights emerged
- [ ] Plan iteration or follow-up work

---

## Feedback Collection Methods Checklist

### User Research Methods

- [ ] **User Interviews:** One-on-one conversations about needs and experiences
- [ ] **Surveys:** Structured questions to larger user groups
- [ ] **Usability Testing:** Observe users attempting tasks
- [ ] **Analytics Review:** Examine actual usage patterns and behaviors
- [ ] **Support Ticket Analysis:** Identify common issues and requests

### Stakeholder Feedback Methods

- [ ] **Review Meetings:** Formal reviews with stakeholders
- [ ] **Async Reviews:** GitHub issue comments and discussions
- [ ] **Roadmap Planning:** Strategic alignment sessions
- [ ] **Demos:** Show working software for feedback

### Team Feedback Methods

- [ ] **Backlog Refinement:** Regular story review with team
- [ ] **Daily Standups:** Quick updates and blockers
- [ ] **Retrospectives:** Reflect on what worked and what didn't
- [ ] **Code Reviews:** Technical feedback during implementation

### Automated Feedback Methods

- [ ] **Usage Analytics:** Track feature adoption and usage
- [ ] **Error Monitoring:** Identify bugs and issues
- [ ] **Performance Metrics:** Measure speed and reliability
- [ ] **A/B Testing:** Compare alternatives empirically

---

## Feedback Incorporation Workflow

### 1. Collect

- [ ] Gather feedback from various sources
- [ ] Document in GitHub issue comments
- [ ] Tag relevant people and issues
- [ ] Categorize by type and severity

### 2. Analyze

- [ ] Look for patterns across feedback sources
- [ ] Validate with data when possible
- [ ] Distinguish opinions from facts
- [ ] Prioritize based on impact and confidence

### 3. Decide

- [ ] Determine what changes to make
- [ ] Assess scope of changes (minor vs major)
- [ ] Get buy-in from stakeholders if needed
- [ ] Plan communication of changes

### 4. Update

- [ ] Modify GitHub issues (vision/epics/stories/tasks)
- [ ] Add comments explaining changes
- [ ] Update priority, scope, or acceptance criteria
- [ ] Link to feedback sources

### 5. Communicate

- [ ] Notify people who provided feedback
- [ ] Explain how feedback was used
- [ ] Update team on requirement changes
- [ ] Thank contributors

### 6. Validate

- [ ] Verify changes address the feedback
- [ ] Confirm with feedback providers if possible
- [ ] Test new requirements with users if significant
- [ ] Monitor impact of changes

### 7. Document Learnings

- [ ] What did we learn?
- [ ] How can we improve future requirements?
- [ ] What patterns are emerging?
- [ ] Update processes based on learnings

---

## Red Flags to Watch For

### Feedback That Suggests Problems

- [ ] **Confusion:** People don't understand what's being built → Requirements unclear
- [ ] **Misalignment:** Stakeholders disagree on priorities → Need alignment session
- [ ] **Feasibility Concerns:** Team says it's much harder than expected → Scope or approach issue
- [ ] **Low Engagement:** Users don't care about feature → Value hypothesis wrong
- [ ] **Frequent Changes:** Requirements changing constantly → Unstable vision or poor research
- [ ] **No Feedback:** Nobody commenting or engaging → Not enough collaboration

### When to Escalate

- [ ] Fundamental vision questions (scope, viability)
- [ ] Major technical feasibility issues
- [ ] Significant stakeholder disagreement
- [ ] Resources or timeline at risk
- [ ] User feedback contradicts assumptions

---

## Feedback Review Cadences

### Continuous (Daily/Weekly)

- [ ] Task-level feedback during standups
- [ ] Code review feedback
- [ ] Bug/issue reports

### Regular (Weekly/Bi-weekly)

- [ ] Story refinement sessions
- [ ] Sprint retrospectives
- [ ] User testing sessions

### Periodic (Monthly)

- [ ] Epic priority review
- [ ] Roadmap adjustment
- [ ] Stakeholder check-ins

### Strategic (Quarterly)

- [ ] Vision validation
- [ ] Success metrics review
- [ ] Strategic alignment

---

## Template: Feedback Review Meeting

**Meeting:** [Vision/Epic/Story] Feedback Review
**Date:** [YYYY-MM-DD]
**Attendees:** [Names and roles]
**Duration:** [60-90 minutes]

**Agenda:**

1. **Review Current State** (10 min)
   - Present current requirements
   - Highlight recent changes
   - Share context

2. **Collect Feedback** (30 min)
   - Go through feedback questions for this level
   - Capture all input (no debate yet)
   - Use checklist above

3. **Discussion** (20 min)
   - Discuss key themes and patterns
   - Validate or invalidate assumptions
   - Identify areas of disagreement

4. **Decisions** (15 min)
   - Determine what changes to make
   - Assign action items
   - Set next review date

5. **Wrap-up** (5 min)
   - Summarize decisions
   - Confirm action items and owners
   - Thank participants

**Follow-up:**
- [ ] Update GitHub issues within 48 hours
- [ ] Communicate changes to broader team
- [ ] Schedule next review

---

Use this checklist to establish regular, effective feedback loops that keep your requirements aligned with user needs and stakeholder goals throughout the product lifecycle.
