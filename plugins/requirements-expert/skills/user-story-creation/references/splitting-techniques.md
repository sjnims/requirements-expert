# Story Splitting Techniques

When user stories are too large to complete in a single iteration, use these techniques to split them into smaller, valuable pieces.

---

## Overview

Effective story splitting:

- Maintains independent value in each piece
- Keeps stories testable and deliverable
- Enables faster feedback cycles
- Reduces risk of incomplete work

The goal is to create smaller stories that each deliver user value, not to decompose into technical tasks.

---

## Technique 1: Workflow Steps

Split a large story by steps in the user workflow.

### When to Use

- Story describes a multi-step process
- User journey has distinct phases
- Each step delivers standalone value

### Example

**Large Story:**

```text
User can manage their subscription
```

**Split by Workflow Steps:**

```text
Story 1: User can view subscription details
Story 2: User can upgrade subscription plan
Story 3: User can downgrade subscription plan
Story 4: User can cancel subscription
Story 5: User can reactivate cancelled subscription
```

### Application Tips

- Map out the full workflow first
- Identify natural breakpoints
- Start with the happy path, add variations later
- Ensure each step is independently valuable

---

## Technique 2: Operations (CRUD)

Split by different operations on the same data or entity.

### When to Use

- Story involves create, read, update, delete operations
- User needs to manage a collection of items
- Different operations have different complexity

### Example

**Large Story:**

```text
User can manage team members
```

**Split by Operations:**

```text
Story 1: User can view team member list
Story 2: User can invite new team members
Story 3: User can remove team members
Story 4: User can change team member roles
Story 5: User can resend invitation to pending members
```

### Application Tips

- Start with Read (view) - usually simplest
- Add Create, then Update, then Delete
- Each operation can have its own complexity
- Consider which operations are essential vs. nice-to-have

---

## Technique 3: Business Rules

Split by different business rules, variations, or conditions.

### When to Use

- Story has multiple business rule variations
- Different conditions require different handling
- Rules have varying complexity

### Example

**Large Story:**

```text
System applies discount codes
```

**Split by Business Rules:**

```text
Story 1: System applies percentage discount codes (e.g., 20% off)
Story 2: System applies fixed-amount discount codes (e.g., $10 off)
Story 3: System applies buy-one-get-one promotions
Story 4: System validates discount code expiration dates
Story 5: System applies minimum purchase requirements for discounts
```

### Application Tips

- List all business rules/variations first
- Start with the most common case
- Group related rules if they're simple
- Complex rules may need their own story

---

## Technique 4: Happy Path vs. Variations

Start with the simplest case, then add complexity incrementally.

### When to Use

- Story has a simple core with complex edge cases
- Error handling adds significant complexity
- Advanced features build on basic functionality

### Example

**Large Story:**

```text
User can upload files
```

**Split by Complexity:**

```text
Story 1: User can upload single image file (basic case)
Story 2: User can upload multiple files at once
Story 3: User can drag and drop files to upload
Story 4: System validates file types and shows errors
Story 5: System validates file size limits
Story 6: User can resume interrupted uploads
```

### Application Tips

- Identify the minimal happy path first
- Add error handling as separate stories
- Add advanced features incrementally
- Each story should still be independently valuable

---

## Technique 5: Data Variations

Split by different data types, sources, or formats.

### When to Use

- Story handles multiple data types
- Different data sources require different handling
- Format variations add complexity

### Example

**Large Story:**

```text
System imports contact data
```

**Split by Data Variations:**

```text
Story 1: System imports contacts from CSV file
Story 2: System imports contacts from Excel file
Story 3: System imports contacts from Google Contacts
Story 4: System imports contacts from Outlook
Story 5: System handles duplicate contacts during import
```

### Application Tips

- Start with the most common format/source
- Add additional formats based on priority
- Consider which variations are MVP vs. later
- Duplicate handling often deserves its own story

---

## Technique 6: Platforms/Interfaces

Split by different platforms, devices, or interfaces.

### When to Use

- Feature needs to work across platforms
- Different interfaces have different requirements
- Platform-specific work adds complexity

### Example

**Large Story:**

```text
User receives notifications
```

**Split by Platform:**

```text
Story 1: User receives in-app notifications
Story 2: User receives email notifications
Story 3: User receives SMS notifications
Story 4: User receives push notifications on mobile
Story 5: User can configure notification preferences
```

### Application Tips

- Start with the primary platform
- Consider which platforms are MVP requirements
- Platform-specific stories can be parallelized
- Preference management is often a separate story

---

## Technique 7: User Roles

Split by different user types or permission levels.

### When to Use

- Different users have different needs
- Permissions add complexity
- User types have different workflows

### Example

**Large Story:**

```text
Users can manage project settings
```

**Split by Role:**

```text
Story 1: Project owner can edit project name and description
Story 2: Project owner can change project visibility
Story 3: Project admin can manage project members
Story 4: Project member can view project settings
Story 5: Project owner can transfer ownership
```

### Application Tips

- Identify all user roles involved
- Start with the primary user type
- Permission checks may be separate stories
- Role-specific features can be prioritized differently

---

## Technique 8: Performance Tiers

Split by different performance or quality levels.

### When to Use

- Basic functionality is simpler than optimized version
- Performance optimization is significant work
- Different tiers serve different user needs

### Example

**Large Story:**

```text
Dashboard loads quickly with large datasets
```

**Split by Performance:**

```text
Story 1: Dashboard loads with pagination (100 items per page)
Story 2: Dashboard implements virtual scrolling for large lists
Story 3: Dashboard caches frequently accessed data
Story 4: Dashboard lazy-loads charts and visualizations
Story 5: Dashboard shows loading indicators for async data
```

### Application Tips

- Start with functional but simple implementation
- Add performance optimizations incrementally
- Measure before and after each improvement
- User-perceived performance may differ from technical metrics

---

## Quick Reference: Choosing a Technique

| Story Characteristic | Recommended Technique |
|---------------------|----------------------|
| Multi-step process | Workflow Steps |
| CRUD operations | Operations |
| Multiple conditions | Business Rules |
| Simple core + complex edges | Happy Path vs. Variations |
| Multiple formats/sources | Data Variations |
| Multiple platforms | Platforms/Interfaces |
| Multiple user types | User Roles |
| Performance-sensitive | Performance Tiers |

---

## Splitting Anti-Patterns

### ❌ Splitting by Technical Layer

```text
Story 1: Build database schema
Story 2: Create API endpoints
Story 3: Build frontend UI
```

**Problem:** Each story has no user value alone. Creates dependencies.

**Instead:** Use vertical slicing—each story delivers end-to-end value.

### ❌ Creating Task-Sized Stories

```text
Story 1: Add submit button
Story 2: Style the form
Story 3: Add validation
```

**Problem:** These are tasks, not stories. No independent value.

**Instead:** Keep them as one story with these as tasks within it.

### ❌ Splitting Too Small

```text
Story 1: User can enter first name
Story 2: User can enter last name
Story 3: User can enter email
```

**Problem:** Too granular, overhead exceeds value.

**Instead:** "User can complete registration form" as one story.

---

## Validation Checklist

After splitting, verify each resulting story:

- [ ] **Independent**: Can be completed without other stories
- [ ] **Valuable**: Delivers user-facing value alone
- [ ] **Testable**: Has clear acceptance criteria
- [ ] **Small**: Fits in 1-5 days
- [ ] **Complete**: Represents a working increment

If any story fails these checks, reconsider the split.
