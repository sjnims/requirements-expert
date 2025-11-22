# MoSCoW Prioritization Worksheet

Use this worksheet to systematically prioritize requirements using the MoSCoW framework.

---

## Prioritization Session Info

**Date:** [YYYY-MM-DD]
**Facilitator:** [Name]
**Participants:** [Names/roles of stakeholders involved]
**Scope:** [What are we prioritizing? Epics for Q1? Stories for Sprint 5?]
**Target/Goal:** [What are we trying to achieve? MVP? V1.0? Next release?]
**Constraints:** [Time, budget, team size, deadlines]

---

## Decision Criteria

**Value to Users:** [Weight: High / Medium / Low]
- Impact on user experience
- Number of users affected
- Frequency of use

**Business Value:** [Weight: High / Medium / Low]
- Revenue impact
- Strategic importance
- Competitive advantage

**Risk:** [Weight: High / Medium / Low]
- Technical complexity
- Uncertainty / unknowns
- Market assumptions

**Effort:** [Weight: High / Medium / Low]
- Time required
- Resources needed
- Technical dependencies

---

## Items to Prioritize

List all items (epics, stories, or tasks) that need prioritization:

| ID | Item Name | Description | Value | Risk | Effort | Dependencies |
|----|-----------|-------------|-------|------|--------|--------------|
| 1  | [Name]    | [Brief desc]| H/M/L | H/M/L| H/M/L  | [IDs]        |
| 2  | [Name]    | [Brief desc]| H/M/L | H/M/L| H/M/L  | [IDs]        |
| 3  | [Name]    | [Brief desc]| H/M/L | H/M/L| H/M/L  | [IDs]        |
|... | ...       | ...         | ...   | ...  | ...    | ...          |

---

## MoSCoW Classification

### Must Have (≤60% of items)

**Critical requirements without which the product cannot launch or function**

| ID | Item Name | Rationale |
|----|-----------|-----------|
| [#]| [Name]    | [Why this is absolutely essential] |
| [#]| [Name]    | [Why this is absolutely essential] |
|... | ...       | ... |

**Total Must Haves:** [Count] out of [Total] = [%]

---

### Should Have (~20% of items)

**Important requirements that significantly enhance value but can be deferred if necessary**

| ID | Item Name | Rationale | Workaround if Deferred |
|----|-----------|-----------|------------------------|
| [#]| [Name]    | [Why important but not critical] | [How users cope without it] |
| [#]| [Name]    | [Why important but not critical] | [How users cope without it] |
|... | ...       | ... | ... |

**Total Should Haves:** [Count] out of [Total] = [%]

---

### Could Have (~20% of items)

**Nice-to-have requirements that provide marginal value**

| ID | Item Name | Rationale |
|----|-----------|-----------|
| [#]| [Name]    | [Why nice to have but low priority] |
| [#]| [Name]    | [Why nice to have but low priority] |
|... | ...       | ... |

**Total Could Haves:** [Count] out of [Total] = [%]

---

### Won't Have (This Time)

**Requirements explicitly excluded from current scope**

| ID | Item Name | Rationale | Future Consideration? |
|----|-----------|-----------|----------------------|
| [#]| [Name]    | [Why not now] | [When might we revisit?] |
| [#]| [Name]    | [Why not now] | [When might we revisit?] |
|... | ...       | ... | ... |

**Total Won't Haves:** [Count] out of [Total] = [%]

---

## Sequencing Within Categories

### Must Haves - Execution Order

Ordered by dependencies, risk, and value:

1. [Item name] - [Reason for sequence position]
2. [Item name] - [Reason for sequence position]
3. [Item name] - [Reason for sequence position]
...

### Should Haves - Execution Order

1. [Item name] - [Reason for sequence position]
2. [Item name] - [Reason for sequence position]
...

### Could Haves - Execution Order

1. [Item name] - [Reason for sequence position]
2. [Item name] - [Reason for sequence position]
...

---

## Validation & Sanity Checks

### Distribution Check

- **Must Haves:** [%] (Target: ≤60%)
- **Should Haves:** [%] (Target: ~20%)
- **Could Haves:** [%] (Target: ~20%)
- **Won't Haves:** [%]

**Is distribution balanced?** [Yes / No]
**If no, what needs adjustment?** [Notes]

### MVP Viability Check

**Can we ship a viable product with just "Must Haves"?** [Yes / No]

**Does it deliver core value?** [Yes / No]

**Would users pay for / use it?** [Yes / No]

**Are all critical user journeys covered?** [Yes / No]

### Dependency Check

**Are all dependencies respected in sequencing?** [Yes / No]

**Any items prioritized high that depend on low-priority items?** [List if any]

### Stakeholder Alignment

**Have key stakeholders reviewed and approved?** [Yes / No]

**Any major disagreements?** [Notes]

**Consensus achieved?** [Yes / No]

---

## Decisions & Trade-offs

Document key decisions and trade-offs made during prioritization:

**Decision 1:**
- **What:** [What was decided]
- **Rationale:** [Why]
- **Trade-off:** [What was sacrificed or deferred]

**Decision 2:**
- **What:** [What was decided]
- **Rationale:** [Why]
- **Trade-off:** [What was sacrificed or deferred]

...

---

## Action Items

**Immediate Actions:**
- [ ] Update GitHub Projects with priority labels
- [ ] Update custom "Priority" field on all issues
- [ ] Order backlog by priority
- [ ] Communicate prioritization to team
- [ ] Begin work on first "Must Have" item

**Follow-up Actions:**
- [ ] Schedule re-prioritization review [Date]
- [ ] Gather user feedback on priorities [Date]
- [ ] Re-assess "Won't Haves" for future releases [Date]

---

## Notes & Comments

[Any additional notes, context, or discussion points from the prioritization session]

---

## Revision History

| Date | Change | By |
|------|--------|-----|
| [YYYY-MM-DD] | Initial prioritization | [Name] |
| [YYYY-MM-DD] | Re-prioritized based on user feedback | [Name] |
| [YYYY-MM-DD] | Moved Item X from Should to Must | [Name] |

---

## Example: E-commerce MVP

**Scope:** Prioritizing epics for e-commerce platform MVP
**Target:** Launch in 3 months with core functionality
**Constraints:** 2 developers, limited budget

### Must Have (5 epics)

1. **Product Catalog** - Cannot sell without products
2. **Shopping Cart** - Core functionality for purchases
3. **Checkout & Payment** - Must be able to complete purchases
4. **User Accounts** - Track orders, save preferences
5. **Order Management** - Sellers need to fulfill orders

### Should Have (3 epics)

6. **Product Search & Filtering** - Important for UX, but can browse categories initially
7. **Email Notifications** - Enhances experience, but can manually check orders
8. **Product Reviews** - Builds trust, but not critical for launch

### Could Have (3 epics)

9. **Wishlist** - Nice feature, low priority
10. **Product Recommendations** - Enhances discovery, not essential
11. **Social Sharing** - Marketing feature, not core

### Won't Have (4 epics)

12. **Mobile App** - Web-first strategy, mobile later
13. **Loyalty Program** - Phase 2 feature
14. **Multi-vendor Support** - Single vendor for MVP
15. **International Shipping** - Domestic only for MVP

**Distribution:** 5 Must (45%), 3 Should (27%), 3 Could (27%) = Balanced ✓

**MVP Viable:** Yes - Can sell products, accept payment, fulfill orders ✓

**Sequence:** Product Catalog → Shopping Cart → Checkout → User Accounts → Order Management
