# Feedback Templates

Ready-to-use GitHub comment templates for documenting feedback throughout the requirements lifecycle.

---

## Feedback Collection Template

Use this template when documenting feedback received from stakeholders, users, or team members.

```markdown
## [Level] Feedback - [Type] (YYYY-MM-DD)

**Participants:** [Names and roles]
**Facilitator:** [Name]

### Key Feedback Themes

#### 1. [Theme Name] ([Source])
- [Specific feedback point]
- [Specific feedback point]
- **Impact:** [High/Medium/Low] - [Brief explanation]

### Decisions Needed

- [ ] [Decision item 1]
- [ ] [Decision item 2]

### Next Steps

1. [Action item]
2. [Action item]

cc: @[stakeholder1] @[stakeholder2]
```

---

## Feedback Incorporated Template

Use this template when communicating how feedback was addressed.

```markdown
## [Level] Updated - Feedback Incorporated (YYYY-MM-DD)

Thank you for the valuable feedback! Here's how it was incorporated:

### Changes Made

**[Section 1]:**
- [Change description]

**[Section 2]:**
- [Change description]

### Deferred Decisions

- **[Item]:** [Reason for deferral, when it will be revisited]

### What's Next

1. [Next step]
2. [Next step]

cc: @[stakeholder1] @[stakeholder2]
```

---

## Feedback Rejection Template

Use this template when feedback cannot be incorporated, with clear rationale.

```markdown
## Feedback Response - [Item] (YYYY-MM-DD)

Thank you for the suggestion about [topic].

**Decision:** Not incorporated at this time

**Rationale:**
- [Reason 1]
- [Reason 2]

**Alternative approach:**
[If applicable, what we're doing instead]

**Revisit:**
[When/if this will be reconsidered]

Happy to discuss further if you have questions.

cc: @[feedback-provider]
```

---

## Feedback Review Meeting Template

Use this template to structure and document feedback review meetings.

```markdown
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
   - Use checklist from `feedback-checklist.md`

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
```

---

## Usage Tips

- **Be consistent:** Use the same template format across all feedback documentation
- **Tag stakeholders:** Always cc relevant people so they receive notifications
- **Include dates:** Timestamps help track the evolution of requirements
- **Link to evidence:** Reference user quotes, data, or research that supports feedback
- **Close the loop:** Always follow up with feedback providers about how their input was used

## Related Resources

- `feedback-checklist.md` - Checklists for conducting feedback reviews at each level
- `feedback-techniques.md` - Methods for collecting feedback from various sources
- `stage-feedback-guide.md` - Detailed guidance for feedback at each requirements level
- `../examples/feedback-workflow-example.md` - Complete example of feedback workflow in action
