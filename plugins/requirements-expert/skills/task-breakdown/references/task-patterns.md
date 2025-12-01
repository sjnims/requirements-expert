# Common Task Patterns

This reference provides proven task breakdown patterns for common software development scenarios. Use these patterns as starting points, adapting them to your specific context.

---

## Overview

Task patterns are repeatable structures for breaking down common types of work. Benefits:

- **Faster breakdown**: Don't start from scratch each time
- **Complete coverage**: Patterns include commonly forgotten tasks
- **Consistent structure**: Teams develop shared vocabulary
- **Accurate estimation**: Known patterns are easier to estimate

### When to Use Patterns

| Scenario | Pattern to Use |
|----------|----------------|
| Building entity management (users, products, orders) | CRUD Operations |
| Adding a new capability | Feature Implementation |
| Connecting external systems | Integration |
| Improving existing code | Refactoring |
| Fixing production issues | Bug Fix |
| Migrating to new systems | Migration |

---

## CRUD Operations Pattern

Use this pattern when implementing create, read, update, and delete operations for an entity.

### Standard CRUD Task Set

For a complete entity (e.g., "Campaign"), expect 8-12 tasks:

| Task | Layer | Typical Effort |
|------|-------|----------------|
| Create entity schema/model | Data | 2-4h |
| Implement Create endpoint | Backend | 3-4h |
| Implement Read/Get endpoint | Backend | 2-3h |
| Implement List endpoint with pagination | Backend | 3-4h |
| Implement Update endpoint | Backend | 2-3h |
| Implement Delete endpoint | Backend | 2-3h |
| Create entity form component | Frontend | 4-6h |
| Create entity list view | Frontend | 4-6h |
| Write CRUD integration tests | Testing | 4-6h |
| Document entity API | Documentation | 2-3h |

### Example: Campaign CRUD

```text
Story: Marketing user can manage campaigns

Tasks:
1. Create campaigns table schema with indexes
2. Implement POST /api/campaigns endpoint
3. Implement GET /api/campaigns/:id endpoint
4. Implement GET /api/campaigns with filtering/pagination
5. Implement PUT /api/campaigns/:id endpoint
6. Implement DELETE /api/campaigns/:id endpoint
7. Create CampaignForm component for create/edit
8. Create CampaignList component with actions
9. Write integration tests for campaign endpoints
10. Document campaign API endpoints
```

### CRUD Task Checklist

For each CRUD operation, ensure:

**Create:**

- [ ] Input validation implemented
- [ ] Required fields enforced
- [ ] Unique constraints checked
- [ ] Created timestamp set automatically
- [ ] Returns created entity with ID

**Read:**

- [ ] Returns 404 if not found
- [ ] Authorization check (can user see this?)
- [ ] Related data loaded as needed
- [ ] Response format documented

**List:**

- [ ] Pagination implemented
- [ ] Filtering options available
- [ ] Sorting configurable
- [ ] Total count included
- [ ] Performance acceptable with large datasets

**Update:**

- [ ] Input validation implemented
- [ ] Partial updates supported
- [ ] Updated timestamp set automatically
- [ ] Returns 404 if not found
- [ ] Concurrency handled (optimistic locking)

**Delete:**

- [ ] Soft delete vs. hard delete decided
- [ ] Returns 404 if not found
- [ ] Related data handled appropriately
- [ ] Cascade rules applied
- [ ] Authorization check implemented

### CRUD Variations

| Variation | Additional Tasks |
|-----------|------------------|
| Soft delete | Add restore endpoint, filter by deleted status |
| Audit trail | Add history tracking, implement audit log |
| Bulk operations | Add bulk create/update/delete endpoints |
| Import/export | Add CSV/JSON import and export |
| Versioning | Add version tracking, implement diff view |

---

## Feature Implementation Pattern

Use this pattern when adding a new user-facing capability.

### Standard Feature Task Flow

Typical order for implementing a new feature:

```text
Phase 1: Foundation (Backend-first)
├── Design data model
├── Create schema/migrations
├── Implement core API endpoints
└── Add business logic

Phase 2: Interface (Frontend)
├── Create UI components
├── Connect to API
├── Handle loading and error states
└── Implement user interactions

Phase 3: Quality
├── Write tests
├── Performance optimization
└── Documentation
```

### Example: Campaign Date Filtering Feature

```text
Story: Marketing user can filter campaigns by date range

Tasks:
1. [Data] Add indexes for date range queries
2. [Backend] Add date filter params to GET /api/campaigns
3. [Backend] Implement date validation logic
4. [Frontend] Create DateRangeFilter component
5. [Frontend] Integrate filter with campaign list
6. [Frontend] Add clear filters functionality
7. [Testing] Write integration tests for date filtering
8. [Testing] Create E2E test for filter workflow
9. [Docs] Document filter feature in user guide
```

### Feature Task Dependencies

Map task dependencies to enable parallel work:

```text
                    ┌─────────────────┐
                    │ 1. Add indexes  │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │ 2. Add filter   │
                    │    params       │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
     ┌────────▼────┐  ┌──────▼─────┐  ┌─────▼─────┐
     │ 3. Validate │  │ 4. Create  │  │ 7. Write  │
     │    logic    │  │    DateUI  │  │   tests   │
     └─────────────┘  └──────┬─────┘  └───────────┘
                             │
                    ┌────────▼────────┐
                    │ 5. Integrate    │
                    │    with list    │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │ 6. Clear filter │
                    └────────┬────────┘
                             │
              ┌──────────────┴──────────────┐
              │                             │
     ┌────────▼────────┐           ┌────────▼────────┐
     │ 8. E2E tests    │           │ 9. Document     │
     └─────────────────┘           └─────────────────┘
```

### Feature Task Checklist

Before marking feature complete:

- [ ] All planned tasks completed
- [ ] Feature works end-to-end
- [ ] Edge cases handled
- [ ] Error states graceful
- [ ] Performance acceptable
- [ ] Tests provide adequate coverage
- [ ] Documentation updated
- [ ] Feature flag configured (if applicable)

---

## Integration Pattern

Use this pattern when connecting to external services or APIs.

### Standard Integration Task Set

| Task | Purpose | Typical Effort |
|------|---------|----------------|
| Research API documentation | Understand capabilities | 2-4h |
| Implement authentication | Connect securely | 2-4h |
| Create service client | Encapsulate API calls | 3-4h |
| Implement data mapping | Transform between systems | 2-4h |
| Add error handling | Handle failures gracefully | 2-3h |
| Implement retry logic | Handle transient failures | 2-3h |
| Write integration tests | Verify integration works | 3-4h |
| Document integration | Capture setup and usage | 2-3h |

### Example: Payment Gateway Integration

```text
Story: User can pay for subscription via Stripe

Tasks:
1. [Research] Review Stripe API docs and SDKs
2. [Backend] Configure Stripe API credentials
3. [Backend] Create StripeClient service wrapper
4. [Backend] Implement payment intent creation
5. [Backend] Implement webhook handler for events
6. [Backend] Add retry logic for failed API calls
7. [Frontend] Integrate Stripe Elements for card input
8. [Frontend] Handle payment success/failure states
9. [Testing] Write integration tests with test mode
10. [Docs] Document Stripe integration setup
```

### Integration Error Handling

Every integration should handle:

| Error Type | Handling Strategy |
|------------|-------------------|
| Authentication failures | Refresh credentials, alert admin |
| Rate limiting | Implement backoff, queue requests |
| Timeout | Retry with exponential backoff |
| Invalid response | Log details, return generic error |
| Service unavailable | Retry, fall back if possible |

### Integration Task Checklist

Before marking integration complete:

- [ ] Authentication works in all environments
- [ ] All required API endpoints integrated
- [ ] Data mapping handles all cases
- [ ] Errors logged with useful context
- [ ] Retry logic prevents transient failures
- [ ] Timeouts configured appropriately
- [ ] Rate limits respected
- [ ] Webhook verification implemented
- [ ] Integration tested against sandbox
- [ ] Credentials stored securely
- [ ] Documentation includes troubleshooting

---

## Refactoring Pattern

Use this pattern when improving existing code without changing functionality.

### Standard Refactoring Task Set

| Task | Purpose |
|------|---------|
| Document current behavior | Capture what should stay the same |
| Write characterization tests | Ensure behavior preserved |
| Perform refactoring | Make the improvement |
| Run existing tests | Verify nothing broke |
| Update documentation | Reflect changes |
| Remove deprecated code | Clean up old patterns |

### Example: Refactoring Campaign Service

```text
Story: Improve campaign service maintainability

Tasks:
1. [Docs] Document current campaign service methods
2. [Testing] Add tests for uncovered edge cases
3. [Backend] Extract date filtering logic to utility
4. [Backend] Replace raw queries with repository methods
5. [Backend] Add type annotations to all methods
6. [Testing] Verify all tests still pass
7. [Docs] Update code comments and JSDoc
8. [Cleanup] Remove deprecated helper functions
```

### Refactoring Task Checklist

Before marking refactoring complete:

- [ ] All existing tests pass
- [ ] No functionality changed
- [ ] Code is measurably improved (less duplication, better structure)
- [ ] New patterns documented
- [ ] Deprecated code removed
- [ ] Team aware of changes

---

## Bug Fix Pattern

Use this pattern when fixing production issues.

### Standard Bug Fix Task Set

| Task | Purpose |
|------|---------|
| Reproduce the bug | Confirm issue exists |
| Write failing test | Capture expected behavior |
| Identify root cause | Understand why it happens |
| Implement fix | Correct the issue |
| Verify test passes | Confirm fix works |
| Check for related issues | Prevent similar bugs |

### Example: Fixing Date Filter Bug

```text
Bug: Date filter allows end date before start date

Tasks:
1. [Testing] Write test that reproduces the bug
2. [Backend] Add date range validation to filter logic
3. [Frontend] Add client-side validation to date picker
4. [Frontend] Show clear error message for invalid range
5. [Testing] Verify fix with original test case
6. [Testing] Add tests for other edge cases
```

### Bug Fix Task Checklist

Before marking bug fix complete:

- [ ] Bug can no longer be reproduced
- [ ] Regression test added
- [ ] Root cause understood and addressed
- [ ] No new issues introduced
- [ ] Fix deployed to affected environments
- [ ] Users notified if applicable

---

## Migration Pattern

Use this pattern when moving to new systems, frameworks, or architectures.

### Standard Migration Task Set

| Task | Purpose |
|------|---------|
| Analyze current state | Understand what exists |
| Design target state | Define where you're going |
| Plan migration steps | Break into incremental changes |
| Set up parallel running | Old and new coexist |
| Migrate incrementally | Move piece by piece |
| Validate at each step | Ensure nothing breaks |
| Clean up old system | Remove deprecated code |

### Example: Migrating to New Date Library

```text
Story: Migrate from moment.js to date-fns

Tasks:
1. [Research] Inventory all moment.js usages
2. [Research] Map moment methods to date-fns equivalents
3. [Backend] Install date-fns, keep moment.js
4. [Backend] Migrate utility functions to date-fns
5. [Frontend] Migrate date formatting to date-fns
6. [Frontend] Migrate date calculations to date-fns
7. [Testing] Run all tests, fix any failures
8. [Cleanup] Remove moment.js dependency
9. [Docs] Update coding guidelines for date handling
```

### Migration Task Checklist

Before marking migration complete:

- [ ] All functionality preserved
- [ ] All tests pass
- [ ] Performance equal or better
- [ ] Old dependency removed
- [ ] Documentation updated
- [ ] Team trained on new approach

---

## Pattern Selection Guide

Use this decision tree to select the right pattern:

```text
What are you building?
│
├─ Managing entities (users, products, etc.)?
│  └─ Use CRUD Operations Pattern
│
├─ Adding new user-facing capability?
│  └─ Use Feature Implementation Pattern
│
├─ Connecting external service?
│  └─ Use Integration Pattern
│
├─ Improving existing code structure?
│  └─ Use Refactoring Pattern
│
├─ Fixing a defect?
│  └─ Use Bug Fix Pattern
│
└─ Moving to new technology?
   └─ Use Migration Pattern
```

---

## Combining Patterns

Complex features often combine multiple patterns.

### Example: Adding Campaign Analytics Dashboard

This combines:

- **CRUD** for saving dashboard configurations
- **Feature Implementation** for the dashboard UI
- **Integration** for analytics data source

```text
Tasks using combined patterns:

CRUD (Dashboard Config):
1. Create dashboard_configs table
2. Implement config CRUD endpoints

Integration (Analytics):
3. Research analytics API
4. Create analytics client wrapper
5. Implement data fetching with caching

Feature (Dashboard UI):
6. Create Dashboard component
7. Create chart widgets
8. Implement date range selector
9. Add loading and error states

Quality:
10. Write integration tests
11. Document dashboard usage
```

---

## Quick Reference: Pattern Task Counts

| Pattern | Typical Tasks | Typical Effort |
|---------|---------------|----------------|
| CRUD Operations | 8-12 tasks | 1-2 weeks |
| Feature Implementation | 6-10 tasks | 1-2 weeks |
| Integration | 8-12 tasks | 1-2 weeks |
| Refactoring | 5-8 tasks | 3-5 days |
| Bug Fix | 4-6 tasks | 1-3 days |
| Migration | 6-10 tasks | 1-3 weeks |
