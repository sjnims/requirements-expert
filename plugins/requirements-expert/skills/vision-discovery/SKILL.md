---
name: Vision Discovery
description: This skill should be used when the user asks to "discover vision", "create a vision", "define product vision", "document vision", "what should my vision be", "help me with vision", or when starting a new requirements project and needs to establish the foundational product vision before identifying epics or stories.
version: 0.2.0
---

# Vision Discovery

## Overview

Vision discovery is the critical first step in the requirements lifecycle. A clear, well-articulated product vision provides direction for all subsequent work—epics, user stories, and tasks all flow from and align with the vision. This skill guides the process of discovering and documenting a compelling product vision through structured questioning and best practices.

## Purpose

A product vision defines:
- **What problem** is being solved
- **Who** will benefit from the solution
- **Why** this solution matters
- **What success looks like** when achieved

The vision serves as a north star for all product decisions, helping teams stay aligned and prioritize work that delivers the most value.

## When to Use This Skill

Use vision discovery when:
- Starting a new product or feature from scratch
- The user has a vague idea but needs help articulating it clearly
- Existing vision is unclear, outdated, or poorly defined
- Team lacks alignment on product direction
- Before identifying epics (vision must exist first)

## Vision Discovery Process

### Step 1: Understand the Problem Space

Begin by exploring the problem being solved. Ask probing questions to uncover the root issue:

**Essential Questions:**
- What problem are you trying to solve?
- Who experiences this problem?
- How do they currently address it (workarounds, competitors, manual processes)?
- Why is the current situation unsatisfactory?
- What happens if this problem remains unsolved?

**Technique:** Use the "5 Whys" technique to dig deeper into root causes. When the user describes a problem, ask "why is that a problem?" repeatedly to uncover underlying issues.

### Step 2: Identify Target Users

Clearly define who will use and benefit from the solution:

**Essential Questions:**
- Who is the primary user/customer?
- Are there secondary users (admins, support staff, etc.)?
- What are their key characteristics (role, expertise level, context)?
- What are their goals and motivations?
- What pain points do they experience?

**Output:** Create user personas or archetypes with specific, concrete details. Avoid vague descriptions like "business users"—be specific: "marketing managers at mid-size B2B companies tracking campaign ROI."

### Step 3: Define the Solution Vision

Articulate what the solution is and how it addresses the problem:

**Essential Questions:**
- In one sentence, what does this product do?
- What makes this solution different or better than alternatives?
- What are the 2-3 core capabilities that define this product?
- What is explicitly NOT part of this vision (scope boundaries)?

**Technique:** Use the "elevator pitch" format: "For [target users] who [need/problem], [product name] is a [category] that [key benefit]. Unlike [alternatives], our product [unique differentiator]."

### Step 4: Establish Success Metrics

Define how success will be measured:

**Essential Questions:**
- How will we know if this product is successful?
- What metrics matter most (usage, revenue, satisfaction, efficiency)?
- What does "good" look like in 6 months? 1 year?
- What user behaviors indicate value delivery?

**Output:** Specific, measurable success criteria. Avoid vanity metrics—focus on indicators of genuine value and impact.

### Step 5: Document the Vision

Create a structured vision document in GitHub Projects as an issue with Type: Vision. Use the template structure from `references/vision-template.md`.

**Core Sections:**

1. **Problem Statement** - What problem exists and why it matters
2. **Target Users** - Who will use this and their key characteristics
3. **Solution Overview** - What the product is and does
4. **Core Value Proposition** - Why users will choose this solution
5. **Success Metrics** - How success will be measured
6. **Scope & Boundaries** - What's included and explicitly excluded

**Additional Sections (as applicable):**

7. **Strategic Alignment** - Business goals, market opportunity, competitive landscape
8. **Risks & Assumptions** - Key assumptions that must hold true, known risks and mitigations

## Best Practices

### Keep It Concise

A vision should be digestible in 5-10 minutes. Aim for:
- 1-2 paragraphs for each major section
- Total length: 500-1,000 words
- Clear, jargon-free language

### Make It Inspiring Yet Realistic

Balance ambition with achievability:
- Articulate a compelling future state
- Ground it in real user needs and market realities
- Avoid buzzwords and hype
- Focus on genuine value creation

### Focus on "Why" Not "How"

The vision defines direction, not implementation:
- Describe outcomes and benefits, not technical solutions
- Avoid specifying features or architecture
- Leave room for discovery during epic and story creation
- Answer "what problem" and "why it matters," not "how we'll build it"

### Ensure Alignment

Before finalizing the vision:
- Review with key stakeholders
- Confirm it resonates with target users
- Verify it aligns with business goals
- Check that success metrics are measurable

### Iterate and Refine

Vision is not set in stone:
- Refine as new information emerges
- Update when market conditions or user needs change
- Use feedback from epic and story creation to improve clarity
- Treat vision as a living document

## Integration with GitHub Projects

Create the vision as a GitHub issue in the relevant GitHub Project:

**Issue Title:** "Product Vision: [Product Name]"

**Issue Description:** Full vision document with all sections

**Two-Layer Metadata (both required):**

Set BOTH custom fields AND labels to ensure proper filtering:

| Layer | Field | Value | Purpose |
|-------|-------|-------|---------|
| Custom Field | Type | Vision | Project views and filtering |
| Custom Field | Status | Active | Project status tracking |
| Label | `type:vision` | - | Cross-project queries, API filtering |

**Why both?** Custom fields are project-specific and enable GitHub Projects views and filtering. Labels are portable across GitHub and enable API-based filtering and cross-project queries.

### Parent-Child Hierarchy

**The vision issue becomes the parent of ALL epics.** This establishes the root of the requirements hierarchy:

```text
Vision Issue (#1, Type: Vision)
  └── Epic Issue (#2, parent: #1)
  └── Epic Issue (#3, parent: #1)
  └── Epic Issue (#4, parent: #1)
```

This hierarchy enables:

- **Clear traceability**: Trace any task back to the originating vision
- **Impact analysis**: Understand what's affected when vision changes
- **Progress tracking**: Monitor completion across the entire requirements tree
- **Native GitHub features**: Leverage GitHub's built-in issue relationship tools

All epics will be created as child issues of this vision issue, establishing clear traceability throughout the requirements lifecycle.

## Common Pitfalls to Avoid

### Too Vague

❌ "Build a platform for users to interact"
✅ "Enable marketing managers to track campaign ROI across channels in real-time"

### Too Prescriptive

❌ "Build a React app with a dashboard showing charts"
✅ "Provide visibility into campaign performance to enable data-driven decisions"

### Scope Creep

❌ Vision that includes everything: e-commerce, social, analytics, AI, blockchain...
✅ Focused vision with clear boundaries: "Campaign ROI tracking, NOT creative design or email delivery"

### Unmeasurable Success

❌ "Be the best product in the market"
✅ "Achieve 10,000 active users with 70%+ weekly retention within 12 months"

## Quick Reference: Vision Discovery Flow

1. **Problem Space** → Understand what problem exists and why it matters
2. **Target Users** → Define who experiences the problem and will use the solution
3. **Solution Vision** → Articulate what the solution is and its core value
4. **Success Metrics** → Establish measurable success criteria
5. **Document** → Create vision issue in GitHub Projects
6. **Validate** → Review with stakeholders and refine
7. **Proceed** → Move to epic identification once vision is solid

## Reference Files

For detailed vision templates:

| Reference | When to Load | Path |
|-----------|--------------|------|
| **vision-template.md** | Creating vision issue content or documenting vision | `references/vision-template.md` |

## Next Steps

After completing vision discovery:
1. Create the vision issue in GitHub Projects
2. Share with stakeholders for feedback
3. Proceed to epic identification using the epic-identification skill
4. Reference the vision throughout all subsequent requirements work

The vision is the foundation—invest time to get it right before moving to epics and stories.
