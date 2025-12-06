# MoSCoW Framework Reference

## Overview

MoSCoW is a prioritization framework that categorizes requirements into four levels based on their criticality to project success. The acronym stands for Must Have, Should Have, Could Have, and Won't Have.

## Must Have

**Definition:** Requirements critical for success. Without these, the product fails to deliver core value or is fundamentally broken.

**Characteristics:**

- Non-negotiable for initial release
- Product is not viable without these
- Legal, regulatory, or safety requirements
- Core functionality essential to vision

**Examples:**

- User authentication (for a product requiring accounts)
- Payment processing (for an e-commerce product)
- Core workflow (the main thing users do)

**Classification Criteria** (evaluate each before classifying):

- Cannot ship without this feature
- Delivers essential core value to primary users
- Legal, regulatory, or contractual requirement
- Users would reject the product without this

**Typical Percentage:** <60% of total requirements

## Should Have

**Definition:** Important requirements that significantly enhance value but aren't absolutely critical for initial release. Can be deferred if necessary.

**Characteristics:**

- High impact, not mission-critical
- Significantly improves user experience
- Differentiates from competitors
- Can work around absence (though painful)

**Examples:**

- Advanced filtering and search
- Batch operations
- Export to multiple formats
- Email notifications

**Classification Criteria** (evaluate each before classifying):

- Significantly improves user experience or value
- Users can achieve goals without this, but with difficulty
- Provides important competitive differentiation
- Delay causes pain but not product failure

**Typical Percentage:** ~20% of total requirements

## Could Have

**Definition:** Nice-to-have requirements that provide marginal value. Include only if time and resources permit.

**Characteristics:**

- Low impact on core value
- "Nice to have" enhancements
- Polish and convenience features
- Easy to cut if needed

**Examples:**

- Customizable themes
- Additional chart types
- Keyboard shortcuts
- Tooltips and help text

**Classification Criteria** (evaluate each before classifying):

- Users unlikely to notice if missing
- Provides marginal or incremental value only
- Primarily a convenience or polish feature
- Easily added in a future release

**Typical Percentage:** ~20% of total requirements

## Won't Have (This Time)

**Definition:** Requirements explicitly excluded from current scope. May be considered for future releases but are off the table now.

**Characteristics:**

- Out of current scope
- Lower priority than other work
- Not aligned with current goals
- Explicitly deferred or rejected

**Examples:**

- Mobile app (when focusing on web first)
- AI-powered features (for MVP)
- Advanced analytics (phase 2 feature)
- Third-party integrations (beyond core)

**Classification Criteria** (evaluate each before classifying):

- Does not align with current vision and goals
- Better suited for a future release
- Including this risks delaying more important work
- Can be explicitly documented as "not now"

**Purpose:** Prevents scope creep by making exclusions explicit

## Classification Decision Tree

Apply these questions in order for each item:

1. **Is this legally, contractually, or safety-required?**
   - Yes → **Must Have**

2. **Would the product be fundamentally broken or fail to deliver core value without this?**
   - Yes → **Must Have**

3. **Does this significantly improve value but have a viable workaround?**
   - Yes → **Should Have**

4. **Is this a nice-to-have enhancement with marginal impact?**
   - Yes → **Could Have**

5. **Is this explicitly out of scope for this release?**
   - Yes → **Won't Have**

## Distribution Guidelines

| Category | Target % | Rationale |
|----------|----------|-----------|
| Must Have | <60% | If higher, reconsider what's truly essential |
| Should Have | ~20% | Important enhancements |
| Could Have | ~20% | Nice-to-have polish |
| Won't Have | Variable | Document explicit exclusions |

## Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Everything is Must Have | No prioritization | Apply strict criteria; challenge each item |
| No Won't Haves | Scope creep risk | Explicitly document exclusions |
| Percentages ignored | Imbalanced backlog | Rebalance if Must Have exceeds 60% |
| Skipping criteria | Inconsistent decisions | Use decision tree for every item |

## When to Re-Classify

Re-evaluate priorities when:

- New information emerges about user needs
- Market conditions change
- Technical constraints are discovered
- Stakeholder priorities shift
- Timeline or budget changes
