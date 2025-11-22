# User Story Template

Use this template when creating user story issues in GitHub Projects. Copy the structure below into the issue description.

---

## User Story: [Brief title from user perspective]

### Story

**As a** [specific user type/persona],
**I want** [goal or capability],
**So that** [benefit or value].

---

### Context

[Optional: Additional background or context that helps understand this story. Why is this needed? What problem does it solve?]

---

### Acceptance Criteria

[Define specific, testable conditions that must be met for this story to be considered complete]

**Format Option 1: Given-When-Then**

- **Given** [context or starting state]
  **When** [action taken]
  **Then** [expected outcome]

- **Given** [another context]
  **When** [another action]
  **Then** [another outcome]

**Format Option 2: Simple Checklist**

- [ ] Criterion 1: [Specific, observable outcome]
- [ ] Criterion 2: [Specific, observable outcome]
- [ ] Criterion 3: [Specific, observable outcome]

---

### Notes & Assumptions

[Optional: Any assumptions, constraints, or additional notes]

**Assumptions:**
- [Assumption 1]
- [Assumption 2]

**Constraints:**
- [Constraint 1]
- [Constraint 2]

**Out of Scope:**
- [What's NOT included in this story]

---

### Definition of Done

At story level, done means:

- [ ] All acceptance criteria met
- [ ] Code reviewed and merged
- [ ] Unit tests written and passing
- [ ] Integration tests passing (if applicable)
- [ ] Documented (user-facing docs, API docs, etc.)
- [ ] Tested in staging environment
- [ ] Acceptance confirmed by product owner/stakeholder

---

### Tasks

[Tasks will be created as child issues of this story. Link them here when created]

- Link to Task 1
- Link to Task 2
- [Tasks will be linked as children when created]

---

**Parent:** [Link to Epic Issue]
**Children:** [Task Issues will be linked here]

---

## Examples

### Example 1: Campaign Filtering

**As a** marketing manager,
**I want** to filter campaigns by date range,
**So that** I can analyze performance for specific time periods.

**Acceptance Criteria:**

- [ ] Date picker UI allows selection of start date and end date
- [ ] Only campaigns with activity within the selected date range are displayed
- [ ] If end date is before start date, system shows validation error
- [ ] "Clear filters" button returns to showing all campaigns
- [ ] Selected date range is preserved when navigating away and returning

**Notes:**
- Use native browser date pickers for best UX
- Default to "last 30 days" on initial page load

---

### Example 2: Password Reset

**As a** user who forgot my password,
**I want** to receive a password reset link via email,
**So that** I can regain access to my account.

**Acceptance Criteria:**

- **Given** I click "Forgot Password" on the login page
  **When** I enter my email address and submit
  **Then** I receive an email with a reset link within 2 minutes

- **Given** I click the reset link in the email
  **When** the link is less than 1 hour old
  **Then** I'm taken to a page to set a new password

- **Given** I enter a new password meeting requirements (8+ chars, etc.)
  **When** I submit the new password
  **Then** my password is updated and I'm redirected to login

- **Given** I click a reset link
  **When** the link is more than 1 hour old
  **Then** I see an error message saying the link expired

**Assumptions:**
- User email must already exist in system
- Reset links expire after 1 hour for security

**Out of Scope:**
- Multi-factor authentication (separate story)
- Account recovery without email access (separate story)

---

### Example 3: File Upload

**As a** content creator,
**I want** to upload image files to my media library,
**So that** I can use them in my posts and campaigns.

**Acceptance Criteria:**

- [ ] "Upload" button is clearly visible in media library
- [ ] Clicking "Upload" opens file browser allowing image selection
- [ ] Supported formats: JPG, PNG, GIF, WebP (max 10MB per file)
- [ ] Upload progress indicator shows during upload
- [ ] On success, uploaded image appears in media library immediately
- [ ] On failure (wrong format, too large), clear error message is shown
- [ ] Multiple files can be selected and uploaded at once

**Technical Notes:**
- Images should be automatically resized/optimized on server
- Store originals and generate thumbnails

---

## INVEST Check

Before finalizing a story, verify it meets INVEST criteria:

- [ ] **Independent**: Can be completed without depending on other stories
- [ ] **Negotiable**: Details are discussable, not fixed implementation
- [ ] **Valuable**: Delivers clear value to users or stakeholders
- [ ] **Estimable**: Team can reasonably estimate size/effort
- [ ] **Small**: Fits within a single iteration (1-5 days)
- [ ] **Testable**: Has clear acceptance criteria that can be verified

If any criteria aren't met, refine the story before committing to it.
