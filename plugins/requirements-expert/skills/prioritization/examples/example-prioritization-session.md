# Example Prioritization Session

This document shows the output of a complete MoSCoW prioritization session for an **E-commerce Platform MVP**. It demonstrates:

- Session structure and facilitation
- Evaluation of items against decision criteria
- Trade-off discussions and decisions
- Stakeholder alignment process
- Final prioritization with rationale

This example demonstrates the session format and discussion patterns to follow when conducting prioritization.

---

## Session Information

**Date:** 2025-01-28

**Facilitator:** Product Manager

**Participants:**

- Product Manager (business perspective)
- Tech Lead (technical perspective)
- UX Designer (user perspective)
- Engineering Manager (resource perspective)

**Scope:** Prioritizing 15 epics for e-commerce platform

**Target:** MVP launch in 3 months with 2 developers

**Constraints:**

- Limited development capacity (2 full-time engineers)
- Fixed 3-month timeline for MVP
- Budget constraints limiting third-party integrations
- Need to validate market before major investment

---

## Decision Criteria

The team agreed on the following criteria and weights:

| Criterion | Weight | Description |
|-----------|--------|-------------|
| User Value | High | Does this directly improve user experience or enable core tasks? |
| Business Value | High | Does this drive revenue, acquisition, or strategic goals? |
| Technical Risk | Medium | How much uncertainty or complexity is involved? |
| Effort | Medium | How much development time and resources required? |
| Dependencies | High | What must exist before this can be built? |

---

## Items Evaluated

### Initial Item List

| # | Epic | Description |
|---|------|-------------|
| 1 | Product Catalog | Browse, search, and view product details |
| 2 | Shopping Cart | Add, remove, update items before purchase |
| 3 | Checkout & Payment | Complete purchases with payment processing |
| 4 | User Accounts | Registration, login, profile management |
| 5 | Order Management | Sellers fulfill and track orders |
| 6 | Product Search & Filtering | Advanced search, faceted filtering |
| 7 | Email Notifications | Order confirmations, shipping updates |
| 8 | Product Reviews | Ratings and reviews from customers |
| 9 | Wishlist | Save products for later |
| 10 | Product Recommendations | "You might also like" suggestions |
| 11 | Social Sharing | Share products to social media |
| 12 | Mobile App | Native iOS/Android applications |
| 13 | Loyalty Program | Points, rewards, and member benefits |
| 14 | Multi-vendor Support | Multiple sellers on platform |
| 15 | International Shipping | Ship to multiple countries |

---

## Evaluation Discussion

### Must Have Candidates

The team evaluated each item for "Must Have" status:

**Product Catalog (Epic 1):**

- _Product Manager:_ "Cannot sell without products. Users need to see what we offer."
- _Tech Lead:_ "Foundation for all other shopping features."
- _Decision:_ **Must Have** - Core to value proposition

**Shopping Cart (Epic 2):**

- _UX Designer:_ "Standard e-commerce expectation. Users won't buy without it."
- _Engineering Manager:_ "Relatively straightforward to implement."
- _Decision:_ **Must Have** - Cannot complete purchases without it

**Checkout & Payment (Epic 3):**

- _Product Manager:_ "This is how we make money. Non-negotiable."
- _Tech Lead:_ "Payment integration is complex but Stripe makes it manageable."
- _Decision:_ **Must Have** - Revenue depends on this

**User Accounts (Epic 4):**

- _UX Designer:_ "Users need to track their orders."
- _Tech Lead:_ "Also needed for cart persistence across devices."
- _Discussion:_ Could we do guest checkout only?
- _Product Manager:_ "Repeat customers need accounts. Guest checkout is workaround."
- _Decision:_ **Must Have** - Track orders, build relationships

**Order Management (Epic 5):**

- _Engineering Manager:_ "Sellers can't fulfill without this."
- _Product Manager:_ "If we can't ship, we can't sell."
- _Decision:_ **Must Have** - Operational necessity

### Should Have Discussion

**Product Search & Filtering (Epic 6):**

- _UX Designer:_ "Critical for stores with many products."
- _Product Manager:_ "How many products at launch? Maybe 50-100."
- _Tech Lead:_ "For <100 products, category browsing works."
- _Decision:_ **Should Have** - Important but browsable at small scale

**Email Notifications (Epic 7):**

- _Product Manager:_ "Order confirmation is expected."
- _Engineering Manager:_ "Could manually send initially, but doesn't scale."
- _Discussion:_ What's the manual workaround cost?
- _Decision:_ **Should Have** - Expected but workaround exists

**Product Reviews (Epic 8):**

- _UX Designer:_ "Builds trust, especially for new store."
- _Product Manager:_ "Can launch without, but want soon after."
- _Decision:_ **Should Have** - Trust builder, not launch blocker

### Could Have Discussion

**Wishlist (Epic 9):**

- _UX Designer:_ "Nice engagement feature."
- _Product Manager:_ "Users can bookmark or just add to cart."
- _Decision:_ **Could Have** - Convenience, not essential

**Product Recommendations (Epic 10):**

- _Tech Lead:_ "Requires purchase data we won't have at launch."
- _Product Manager:_ "Manual 'featured products' could work initially."
- _Decision:_ **Could Have** - Needs data, defer until post-launch

**Social Sharing (Epic 11):**

- _Product Manager:_ "Marketing nice-to-have."
- _UX Designer:_ "Users can copy/paste URL."
- _Decision:_ **Could Have** - Low priority marketing feature

### Won't Have Discussion

**Mobile App (Epic 12):**

- _Tech Lead:_ "2 developers, 3 months. We can't do mobile too."
- _Product Manager:_ "Web-first strategy. Responsive web on mobile."
- _Decision:_ **Won't Have** - Resource constraint, web-first

**Loyalty Program (Epic 13):**

- _Product Manager:_ "Need customers first before loyalty program."
- _Engineering Manager:_ "Adds significant complexity."
- _Decision:_ **Won't Have** - Premature, phase 2

**Multi-vendor Support (Epic 14):**

- _Product Manager:_ "Starting as single vendor to validate model."
- _Tech Lead:_ "Multi-vendor is complex architecture change."
- _Decision:_ **Won't Have** - Business model decision, not MVP

**International Shipping (Epic 15):**

- _Engineering Manager:_ "Tax, customs, currency - too complex for MVP."
- _Product Manager:_ "Domestic-only to start. Validate locally first."
- _Decision:_ **Won't Have** - Operational complexity, phase 2

---

## Trade-off Decisions

### Key Trade-off 1: Guest Checkout vs. User Accounts

**Discussion:**

- Guest checkout allows faster purchase (fewer steps)
- Accounts enable order tracking, repeat purchases, personalization
- Guest checkout can be added later as option

**Decision:** Require accounts for MVP, add guest checkout in phase 2

**Rationale:** Accounts provide more value for repeat customers and order tracking. Can revisit if conversion rate suffers.

### Key Trade-off 2: Advanced Search vs. Category Browsing

**Discussion:**

- Full search with filtering is better UX
- At 50-100 products, category navigation works
- Search investment significant for small catalog

**Decision:** Category browsing for MVP, add search after catalog grows

**Rationale:** Engineering effort better spent on core checkout flow. Search becomes essential at 500+ products.

### Key Trade-off 3: Automated vs. Manual Email Notifications

**Discussion:**

- Users expect order confirmation emails
- Can manually send from admin initially
- Automated system takes 2-3 days to build

**Decision:** Manual for first 2 weeks, automate before scale

**Rationale:** Quick workaround buys time. Prioritize revenue-generating features first.

---

## Final Prioritization

### Must Have (5 epics - 33%)

| # | Epic | Rationale | Sequence |
|---|------|-----------|----------|
| 1 | Product Catalog | Cannot sell without products | 1st |
| 2 | Shopping Cart | Core purchase flow | 2nd |
| 3 | Checkout & Payment | Revenue generation | 3rd |
| 4 | User Accounts | Order tracking, repeat business | 4th |
| 5 | Order Management | Fulfillment operations | 5th |

### Should Have (3 epics - 20%)

| # | Epic | Rationale | Workaround |
|---|------|-----------|------------|
| 6 | Product Search & Filtering | UX improvement for larger catalogs | Category browsing |
| 7 | Email Notifications | Expected communication | Manual send initially |
| 8 | Product Reviews | Trust and social proof | Launch without, add quickly |

### Could Have (3 epics - 20%)

| # | Epic | Rationale |
|---|------|-----------|
| 9 | Wishlist | Engagement feature, low priority |
| 10 | Product Recommendations | Needs purchase data first |
| 11 | Social Sharing | Marketing nice-to-have |

### Won't Have (4 epics - 27%)

| # | Epic | Rationale | Revisit When |
|---|------|-----------|--------------|
| 12 | Mobile App | Web-first, resource constraint | After web stability |
| 13 | Loyalty Program | Need customers first | 6 months post-launch |
| 14 | Multi-vendor Support | Single vendor to start | If marketplace model validated |
| 15 | International Shipping | Too complex for MVP | Domestic demand saturated |

---

## Distribution Analysis

| Priority | Count | Percentage | Target | Status |
|----------|-------|------------|--------|--------|
| Must Have | 5 | 33% | ≤60% | Well under target |
| Should Have | 3 | 20% | ~20% | On target |
| Could Have | 3 | 20% | ~20% | On target |
| Won't Have | 4 | 27% | Documented | Clear exclusions |

**Analysis:** The team maintained discipline by keeping Must Haves at 33%, well under the 60% threshold. This leaves buffer capacity for unexpected complexity.

---

## Validation

### MVP Viability Check

- [x] Can customers browse products? (Product Catalog)
- [x] Can customers add items to cart? (Shopping Cart)
- [x] Can customers complete purchases? (Checkout & Payment)
- [x] Can customers track orders? (User Accounts)
- [x] Can sellers fulfill orders? (Order Management)

**Conclusion:** MVP is viable. Core e-commerce flow complete.

### Dependency Check

```text
Product Catalog (no dependencies)
    └── Shopping Cart (needs products to add)
        └── Checkout & Payment (needs cart contents)
            └── Order Management (needs completed orders)

User Accounts (no dependencies, parallel track)
```

**Conclusion:** Dependencies properly sequenced.

### Stakeholder Sign-off

| Stakeholder | Approved | Comments |
|-------------|----------|----------|
| Product Manager | Yes | "Focused scope, can deliver MVP on time" |
| Tech Lead | Yes | "Achievable with 2 engineers in 3 months" |
| UX Designer | Yes | "Core experience solid, can enhance later" |
| Engineering Manager | Yes | "Resource-realistic plan" |

---

## Action Items

### Immediate (This Week)

- [ ] Update GitHub Projects with Priority custom field values
- [ ] Apply priority labels to all epic issues
- [ ] Order backlog by priority sequence
- [ ] Communicate prioritization to full team
- [ ] Begin Sprint 1 with Product Catalog

### Follow-up

- [ ] Re-prioritize at end of Month 1 based on progress
- [ ] Review "Won't Have" items after MVP launch
- [ ] Gather user feedback on Should Have priorities
- [ ] Assess search need when catalog reaches 200 products

---

## Session Notes

### What Worked Well

- Clear decision criteria established upfront
- Everyone's perspective valued (product, tech, design, operations)
- Explicit trade-off discussions documented decisions
- Won't Haves clearly stated to prevent scope creep

### Lessons for Next Time

- Time-box category discussions (30 min per category)
- Bring data on user needs when available
- Have fallback/workaround options pre-identified
- Document dissenting opinions for future reference

---

## Summary

This prioritization session demonstrates:

1. **Collaborative decision-making** - All perspectives included
2. **Criteria-based evaluation** - Consistent standards applied
3. **Explicit trade-off discussion** - Decisions and rationale captured
4. **Disciplined Must Have category** - 33% (well under 60% limit)
5. **Clear Won't Haves** - Scope boundaries explicitly stated
6. **Stakeholder alignment** - Everyone approved the final prioritization

This session format demonstrates the recommended approach for prioritization workshops.
