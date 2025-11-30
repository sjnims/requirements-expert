# Example Feedback Workflow

This document demonstrates a complete feedback collection and incorporation cycle for an **E-commerce Platform** project. It shows how to gather stakeholder feedback on a vision, document it in GitHub issue comments, update requirements, and communicate changes.

Use this as a reference when running your own feedback workflows.

---

## Context

**Project:** ShopFlow E-commerce Platform

**Stage:** Vision validation (post-creation, pre-epic)

**Vision Issue:** #1 - ShopFlow Product Vision

**Feedback Goal:** Validate vision with key stakeholders before identifying epics

---

## Step 1: Identify Feedback Sources

For vision-level feedback, involve:

| Stakeholder | Role | Perspective |
|-------------|------|-------------|
| Sarah Chen | VP Product | Strategic alignment, market fit |
| Marcus Johnson | Tech Lead | Technical feasibility, architecture |
| Emily Rodriguez | UX Lead | User needs, experience design |
| David Kim | Sales Director | Customer demand, competitive position |

---

## Step 2: Collect Feedback

For additional collection methods (user research, stakeholder reviews, team feedback, automated feedback), see `references/feedback-techniques.md`.

### Feedback Session Notes

**Date:** 2025-01-28

**Format:** 60-minute review meeting

**Facilitator:** Product Manager

### Raw Feedback Collected

**Sarah Chen (VP Product):**

> "The problem statement is strong, but I think we're underestimating the mobile-first trend. Our target users are increasingly shopping on mobile devices. The vision should emphasize mobile experience more prominently."
>
> "Success metrics look good, but we should add a mobile conversion rate metric specifically."

**Marcus Johnson (Tech Lead):**

> "The scope looks achievable for MVP. One concern: real-time inventory sync is mentioned but could be complex. We should either simplify to near-real-time (5-minute refresh) or explicitly call out the infrastructure investment needed."
>
> "The multi-vendor marketplace capability should be in Won't Have—it's a significant architecture change and we should validate single-vendor first."

**Emily Rodriguez (UX Lead):**

> "Target user description is good but missing a key segment: gift buyers. During holidays, 30-40% of purchases are gifts. This affects the checkout flow (gift wrapping, different shipping address, gift messages)."
>
> "Wishlist is mentioned in 'Could Have' but for gift buyers it's closer to 'Should Have'—they share wishlists with family."

**David Kim (Sales Director):**

> "Competitive positioning is accurate. One addition: customer support integration is becoming table stakes. Competitors all have chat support. We should address this in scope."
>
> "The pricing tier assumption ($50-200 average order) matches our target market well."

---

## Step 3: Document Feedback in GitHub

Add feedback as a comment on the vision issue:

### Example GitHub Issue Comment

```markdown
## Vision Feedback - Stakeholder Review (2025-01-28)

**Participants:** Sarah Chen, Marcus Johnson, Emily Rodriguez, David Kim

**Facilitator:** Product Manager

### Key Feedback Themes

#### 1. Mobile Experience (Sarah Chen)
- Vision should emphasize mobile-first approach more prominently
- Add mobile conversion rate to success metrics
- **Impact:** Medium - Scope clarification needed

#### 2. Technical Feasibility (Marcus Johnson)
- Real-time inventory sync may be over-scoped; suggest near-real-time (5-min refresh)
- Multi-vendor marketplace should be explicit Won't Have
- **Impact:** Medium - Scope adjustment recommended

#### 3. Gift Buyer Segment (Emily Rodriguez)
- Missing target user: gift buyers (30-40% of holiday purchases)
- Wishlist more important for gift scenarios
- **Impact:** High - Target user gap identified

#### 4. Customer Support (David Kim)
- Chat support becoming table stakes in market
- Should be addressed in scope (even if Won't Have for MVP)
- **Impact:** Low - Competitive positioning note

### Decisions Needed

- [ ] Add gift buyer persona to target users?
- [ ] Elevate wishlist from Could Have to Should Have?
- [ ] Add mobile conversion rate metric?
- [ ] Clarify real-time vs near-real-time inventory?
- [ ] Add customer support chat to scope (Won't Have for MVP)?

### Next Steps

1. Update vision based on validated feedback (see decisions above)
2. Schedule follow-up with Emily for gift buyer persona details
3. Tech spike on inventory sync requirements
4. Communicate changes to stakeholders

cc: @sarah-chen @marcus-johnson @emily-rodriguez @david-kim
```

---

## Step 4: Analyze and Decide

For comprehensive validation checklists at each requirements level, see `references/feedback-checklist.md`.

### Feedback Analysis

| Feedback Item | Source | Validity | Impact | Decision |
|---------------|--------|----------|--------|----------|
| Mobile-first emphasis | Sarah | Validated by market data | Medium | Accept - Update vision |
| Mobile conversion metric | Sarah | Measurable, actionable | Low | Accept - Add metric |
| Near-real-time inventory | Marcus | Technical reality | Medium | Accept - Clarify scope |
| Multi-vendor Won't Have | Marcus | Aligned with MVP strategy | Low | Accept - Explicit exclusion |
| Gift buyer persona | Emily | Validated by sales data | High | Accept - Add persona |
| Wishlist priority bump | Emily | Depends on strategy | Medium | Defer - Revisit at epic prioritization |
| Customer support chat | David | Competitive pressure | Low | Accept - Add to Won't Have with note |

### Decision Rationale

**Accepted changes:**

- Gift buyer persona addresses a real gap (validated by 30-40% holiday purchase data)
- Mobile emphasis aligns with market trends and strategic direction
- Near-real-time inventory is more achievable and adequate for MVP
- Explicit Won't Haves prevent scope creep

**Deferred:**

- Wishlist priority will be evaluated during epic prioritization with full context

---

## Step 5: Update Requirements

### Vision Issue Updates

#### Target Users Section

Add new persona:

```markdown
### Secondary Users

**Gift Buyers:**
- **Who:** Shoppers purchasing for others (holidays, birthdays, special occasions)
- **Characteristics:**
  - 30-40% of purchases during holiday seasons
  - Need different shipping address than billing
  - Value gift wrapping and gift message options
  - Share wishlists with family and friends
- **Goals:** Find appropriate gifts, easy gifting experience, share preferences
- **Pain Points:** Confusing checkout for gifts, no wishlist sharing, no gift options
```

#### Success Metrics Section

Add metric:

```markdown
| Mobile conversion rate | 2.5%+ | 6 months |
```

#### Scope Section

Clarify inventory:

```markdown
**In Scope:**
- Near-real-time inventory sync (5-minute refresh cycle)
  - Note: Real-time sync deferred due to infrastructure complexity
```

Add to Out of Scope:

```markdown
**Out of Scope:**
- Multi-vendor marketplace (single vendor for MVP validation)
- Customer support chat integration (evaluate for phase 2 based on support volume)
```

---

## Step 6: Communicate Changes

### Stakeholder Update Comment

Add follow-up comment to the vision issue:

```markdown
## Vision Updated - Feedback Incorporated (2025-01-29)

Thank you all for the valuable feedback! Here's how it was incorporated:

### Changes Made

**Target Users:**
- Added gift buyer persona based on Emily's feedback
- Documented gift-specific needs (wrapping, messages, wishlist sharing)

**Success Metrics:**
- Added mobile conversion rate metric (target: 2.5%+) per Sarah's suggestion

**Scope Clarifications:**
- Inventory sync clarified as near-real-time (5-min refresh) per Marcus
- Multi-vendor marketplace explicitly listed as Won't Have
- Customer support chat added to Won't Have with phase 2 note

### Deferred Decisions

- **Wishlist priority:** Will evaluate during epic prioritization
  - Current: Could Have
  - Emily's input noted for gift buyer scenarios

### What's Next

1. Vision is now ready for epic identification
2. Gift buyer persona will inform story creation
3. Mobile-first emphasis will guide UX decisions
4. Tech spike on inventory sync scheduled for next sprint

Thanks again for your input! Please review the updated vision and flag any concerns.

cc: @sarah-chen @marcus-johnson @emily-rodriguez @david-kim
```

---

## Step 7: Validate Changes

### Validation Checklist

- [x] All feedback items addressed (accepted, rejected with rationale, or deferred)
- [x] Changes documented in issue history
- [x] Stakeholders notified of updates
- [x] Deferred items tracked for later
- [x] Next steps clear
- [x] Vision ready for next phase (epic identification)

---

## GitHub Comment Templates

Use these templates for consistent feedback documentation:

### Feedback Collection Template

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

### Feedback Incorporated Template

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

### Feedback Rejection Template

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

## Tips for Effective Feedback Workflows

### Before the Session

- Share requirements in advance (give stakeholders time to review)
- Prepare specific questions aligned with feedback goals
- Identify the right mix of perspectives (product, tech, design, business)

### During Collection

- Create safe space for honest feedback (no defending, just listening)
- Capture exact quotes when possible
- Ask clarifying questions to understand root concerns
- Note who said what for follow-up

### After Collection

- Analyze patterns across feedback sources
- Distinguish opinions from validated facts
- Make decisions promptly while context is fresh
- Document everything in GitHub for traceability

### Communication

- Close the loop with everyone who provided feedback
- Explain what was accepted and why
- Explain what was rejected and why
- Thank contributors for their time and input

---

## Related Resources

- `references/feedback-techniques.md` - Methods for collecting feedback
- `references/stage-feedback-guide.md` - Stage-specific guidance
- `references/feedback-checklist.md` - Checklists for feedback reviews
