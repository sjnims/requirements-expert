# Task Template

Use this template when creating task issues in GitHub Projects. Copy the structure below into the issue description.

---

## Task: [Action-oriented title]

### Description

[Clear description of what needs to be done. Be specific about the objective and context.]

---

### Acceptance Criteria

[Define specific, testable conditions that must be met for this task to be considered complete]

- [ ] Criterion 1: [Specific, observable outcome]
- [ ] Criterion 2: [Specific, observable outcome]
- [ ] Criterion 3: [Specific, observable outcome]
- [ ] Criterion 4: [Specific, observable outcome]
- [ ] Criterion 5: [Specific, observable outcome]

---

### Technical Notes

[Optional: Implementation details, patterns to follow, files to modify, libraries to use, etc.]

**Files to Modify:**
- [File 1]
- [File 2]

**Patterns to Follow:**
- [Pattern or example to reference]

**Dependencies:**
- [External libraries, services, or other tasks]

---

### Definition of Done

At task level, done means:

- [ ] All acceptance criteria met
- [ ] Code written and works as expected
- [ ] Tests written (if applicable)
- [ ] Code reviewed (if using PR process)
- [ ] No new warnings or errors introduced
- [ ] Changes committed with clear commit message

---

**Parent:** [Link to User Story Issue]
**Estimate:** [Optional: 2h, 4h, 1d, etc.]
**Assignee:** [Optional: Person responsible]

---

## Examples by Type

### Frontend Task Example

**Task: Create campaign filter UI component**

**Description:**
Implement React component that allows users to filter campaigns by date range using start and end date pickers.

**Acceptance Criteria:**

- [ ] Component renders two date picker inputs (start date, end date)
- [ ] Component accepts `onFilterChange` callback prop
- [ ] Emits selected dates when user changes either date picker
- [ ] Validates that end date is not before start date
- [ ] Shows inline error message when validation fails
- [ ] Component is accessible (ARIA labels, keyboard navigation)
- [ ] Component is responsive on mobile and desktop
- [ ] Unit tests cover all functionality with >80% coverage

**Technical Notes:**

Files to Modify:
- `/src/components/filters/CampaignDateFilter.tsx` (create new)
- `/src/components/filters/index.ts` (add export)

Patterns to Follow:
- Use existing `DatePicker` component from design system
- Follow component structure in `/src/components/filters/StatusFilter.tsx`
- Use Formik for form state management

Dependencies:
- Design system DatePicker component
- date-fns library for date manipulation

---

### Backend Task Example

**Task: Implement GET /api/campaigns endpoint with date filtering**

**Description:**
Create API endpoint that returns list of campaigns filtered by optional date range query parameters.

**Acceptance Criteria:**

- [ ] Endpoint accepts `startDate` and `endDate` query params (ISO 8601 format)
- [ ] Returns campaigns with `created_at` between specified dates (inclusive)
- [ ] Returns all campaigns if no date params provided
- [ ] Returns 400 error with clear message if date format invalid
- [ ] Returns 400 error if end date is before start date
- [ ] Returns 200 with empty array if no campaigns match criteria
- [ ] Response follows standard campaign schema (id, name, created_at, etc.)
- [ ] Query uses database indexes for performance (<100ms response time)
- [ ] Endpoint documented in API docs with examples
- [ ] Integration tests cover all scenarios

**Technical Notes:**

Files to Modify:
- `/src/api/campaigns/routes.ts` (add GET route)
- `/src/api/campaigns/controller.ts` (add getCampaigns method)
- `/src/api/campaigns/service.ts` (add filtering logic)
- `/docs/api/campaigns.md` (add documentation)

Patterns to Follow:
- Use existing repository pattern
- Follow error handling in `/src/api/utils/errorHandler.ts`
- Use Joi for query parameter validation

---

### Database Task Example

**Task: Add indexes for campaign date filtering performance**

**Description:**
Create database indexes to optimize queries that filter campaigns by date range.

**Acceptance Criteria:**

- [ ] Migration creates index on `campaigns.created_at` column
- [ ] Migration creates composite index on `(status, created_at)` for filtered queries
- [ ] Migration includes rollback script to remove indexes
- [ ] Migration runs successfully in dev environment without errors
- [ ] Migration tested with rollback - confirms clean revert
- [ ] Query execution time for date-filtered queries reduced to <100ms
- [ ] Index usage confirmed via EXPLAIN ANALYZE
- [ ] Migration documented in `/migrations/README.md`

**Technical Notes:**

Files to Create:
- `/migrations/YYYYMMDDHHMMSS_add_campaign_date_indexes.sql`
- `/migrations/YYYYMMDDHHMMSS_add_campaign_date_indexes_down.sql`

SQL to Include:
```sql
CREATE INDEX idx_campaigns_created_at ON campaigns(created_at);
CREATE INDEX idx_campaigns_status_created_at ON campaigns(status, created_at);
```

---

### Testing Task Example

**Task: Write integration tests for campaign date filtering**

**Description:**
Create comprehensive integration tests for the campaign date filtering API endpoint to ensure correct behavior across all scenarios.

**Acceptance Criteria:**

- [ ] Test: Filtering with valid date range returns correct campaigns
- [ ] Test: Filtering with no matches returns empty array with 200 status
- [ ] Test: Invalid date format returns 400 error with helpful message
- [ ] Test: End date before start date returns 400 error
- [ ] Test: Edge case - start date equals end date works correctly
- [ ] Test: Edge case - very large date range (10 years) performs acceptably
- [ ] Test: Omitting date params returns all campaigns
- [ ] All tests pass locally and in CI environment
- [ ] Test coverage for filtering logic is >90%

**Technical Notes:**

Files to Create/Modify:
- `/tests/integration/api/campaigns/filtering.test.ts`

Patterns to Follow:
- Use existing test utilities in `/tests/utils/testSetup.ts`
- Follow AAA pattern (Arrange, Act, Assert)
- Clean up test data in afterEach hook

---

### Documentation Task Example

**Task: Document campaign date filtering in user guide**

**Description:**
Add comprehensive user-facing documentation for the new campaign date filtering feature in the user guide.

**Acceptance Criteria:**

- [ ] New section added to `/docs/user-guide/managing-campaigns.md`
- [ ] Section includes annotated screenshot showing filter UI
- [ ] Step-by-step instructions for using date filters
- [ ] Explanation of what happens when no campaigns match
- [ ] Common error messages documented with solutions
- [ ] Example use cases provided (e.g., "View last month's campaigns")
- [ ] Links to related documentation (campaign management, reporting)
- [ ] Documentation reviewed for clarity and grammar
- [ ] Screenshots are up-to-date and clearly labeled

**Technical Notes:**

Files to Modify:
- `/docs/user-guide/managing-campaigns.md`
- Add screenshots to `/docs/images/campaign-filtering/`

Style Guide:
- Follow documentation style in `/docs/STYLE_GUIDE.md`
- Use second person ("you can filter campaigns...")
- Include both positive and edge case examples

---

### Research/Spike Task Example

**Task: Evaluate date picker libraries for campaign filtering UI**

**Description:**
Research and recommend a date picker library for the campaign filtering feature. Evaluate options based on accessibility, mobile support, and bundle size.

**Acceptance Criteria:**

- [ ] At least 3 libraries evaluated (e.g., react-datepicker, react-day-picker, MUI DatePicker)
- [ ] Comparison matrix created with: accessibility score, mobile UX, bundle size, license
- [ ] Each library tested with quick prototype
- [ ] Recommendation documented with justification
- [ ] Any integration challenges identified
- [ ] Fallback option identified if primary choice has issues
- [ ] Findings shared with team for feedback
- [ ] Decision documented in `/docs/decisions/date-picker-library.md`

**Technical Notes:**

Evaluation Criteria:
- Accessibility (keyboard nav, screen readers, ARIA)
- Mobile experience (touch-friendly, responsive)
- Bundle size (<20KB ideal)
- Customization options (styling, localization)
- Active maintenance and community support

**Time Box:** Maximum 4 hours for evaluation

---

## Quick Checklist

Before creating a task, verify:

- [ ] Title is action-oriented (starts with verb)
- [ ] Description clearly states what needs to be done
- [ ] Has 3-5 specific acceptance criteria
- [ ] Acceptance criteria are testable/verifiable
- [ ] Includes relevant technical notes or context
- [ ] Right-sized (2 hours to 2 days max)
- [ ] Linked to parent user story
- [ ] Has appropriate labels (type, technical area)
