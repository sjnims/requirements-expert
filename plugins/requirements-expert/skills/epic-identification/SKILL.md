---
name: Epic Identification
description: This skill should be used when the user asks to "identify epics", "create epics", "what epics do I need", "break down vision into epics", "define major features", "find all epics", or when they have a vision and need to identify the major capabilities or features that will deliver on that vision.
version: 0.2.0
---

# Epic Identification

## Overview

Epic identification is the process of breaking down a product vision into major capabilities or features. Epics represent significant bodies of work that are too large for a single iteration but directly contribute to achieving the vision. This skill guides the systematic discovery and definition of epics from a product vision.

## Purpose

Epics serve as the middle layer in the requirements hierarchy:
- **Above**: Product Vision (the "why" and "what" at highest level)
- **Epics**: Major capabilities (the "what" at feature level)
- **Below**: User Stories (the "what" at detailed level)

Well-defined epics:
- Organize work into logical, valuable chunks
- Enable roadmap planning and sequencing
- Provide clear scope boundaries for teams
- Facilitate prioritization of major capabilities

## When to Use This Skill

Use epic identification when:
- Vision document exists and needs to be broken down
- User asks what major features or capabilities are needed
- Planning a product roadmap from a vision
- Validating that all necessary epics have been identified
- Refining or adding to an existing set of epics

**Prerequisite:** Vision must exist before identifying epics. If no vision exists, use the vision-discovery skill first.

## Epic Identification Process

### Step 1: Review the Vision

Begin by thoroughly understanding the vision:

**Key Actions:**
- Read the vision issue in GitHub Projects
- Identify core capabilities mentioned or implied
- Note user goals and success metrics
- Understand scope boundaries (what's included/excluded)

**Extract Signals:**
- What major capabilities does the solution need?
- What user journeys must be supported?
- What integration points or dependencies exist?
- What success metrics drive capability requirements?

### Step 2: Identify Major Capabilities

Break down the vision into distinct major capabilities:

**Discovery Techniques:**

**User Journey Mapping:**
- What are the end-to-end journeys users will take?
- Each major journey often maps to one or more epics
- Example: "User Onboarding", "Content Creation", "Analytics & Reporting"

**Capability Decomposition:**
- What are the 5-10 major things this product must do?
- Group related functionality into logical capabilities
- Example: "User Authentication", "Data Import/Export", "Collaboration Features"

**Stakeholder Needs:**
- What capabilities do different user types need?
- Admin vs. end-user capabilities
- Example: "User Management", "Permissions & Access Control"

**Technical Enablers:**
- What infrastructure or foundational capabilities are required?
- APIs, integrations, data pipelines
- Example: "Third-party Integrations", "Data Synchronization"

### Step 3: Define Epic Characteristics

For each identified capability, determine if it qualifies as an epic:

**Epic Criteria:**
- **Valuable**: Delivers significant user or business value
- **Large**: Too big to complete in a single iteration (typically multiple user stories)
- **Cohesive**: Represents a logical grouping of related functionality
- **Bounded**: Has clear scope—what's included and excluded
- **Measurable**: Success can be defined and tracked

**Size Guideline:**
- An epic typically contains 3-12 user stories
- Takes multiple sprints/iterations to complete
- If smaller, consider combining with related epics
- If larger, consider splitting into multiple epics

### Step 4: Name and Describe Each Epic

Create clear, descriptive titles and summaries:

**Epic Naming:**
- Use noun phrases describing the capability
- Be specific but concise (3-6 words)
- Focus on "what" not "how"

**Good Examples:**
- "User Authentication & Authorization"
- "Campaign Performance Dashboard"
- "Automated Email Notifications"
- "Third-party Calendar Integration"

**Poor Examples:**
- "Build the backend" (too vague, technical)
- "Make users happy" (outcome, not capability)
- "Phase 1" (not descriptive)

**Epic Description Structure:**

Use the template from `${CLAUDE_PLUGIN_ROOT}/skills/epic-identification/references/epic-template.md`:
1. **Overview** - What this epic delivers
2. **User Value** - Why this matters to users
3. **Scope** - What's included and excluded
4. **Success Criteria** - How we know it's done
5. **Dependencies** - Other epics or external factors required

### Step 5: Validate Completeness

Ensure all necessary epics have been identified:

**Validation Questions:**
- Do these epics, collectively, deliver the full vision?
- Are there gaps in user journeys or capabilities?
- Have we covered all target user types and their needs?
- Are success metrics from the vision addressable with these epics?
- Have we identified necessary infrastructure or technical epics?

**Gap Analysis Technique:**
- Map epics back to vision sections (problem, users, capabilities, metrics)
- Identify vision elements not covered by any epic
- Create additional epics to fill gaps

### Step 6: Organize and Prioritize

Structure epics for planning and sequencing:

**Logical Grouping:**
- Group related epics (e.g., all authentication-related, all reporting-related)
- Identify epic clusters that deliver cohesive value together

**Dependency Mapping:**
- Which epics must come before others?
- What's the critical path through epic delivery?
- Example: "User Authentication" likely precedes "User Profile Management"

**Initial Prioritization:**
- Apply MoSCoW framework (Must/Should/Could/Won't)
- Consider value, risk, dependencies, effort
- Use the prioritization skill for detailed prioritization

### Step 7: Create Epic Issues in GitHub Projects

For each epic, create a GitHub issue in the relevant GitHub Project:

**Issue Title:** "[Epic Name]"

**Issue Description:** Full epic definition using template

**Custom Fields:**
- Type: Epic
- Priority: [Must Have / Should Have / Could Have]
- Status: Not Started

**Labels:**
- `type:epic`
- `priority:[moscow-level]`

**Parent:** Link to Vision issue as parent

All user stories for this epic will be created as child issues, establishing hierarchy.

## Epic Templates and Patterns

### Common Epic Patterns

**User-Facing Capabilities:**
- User Onboarding & Registration
- Profile & Settings Management
- Core Workflow/Activity (varies by product)
- Search & Discovery
- Notifications & Alerts

**Data & Content:**
- Data Import/Export
- Content Creation & Editing
- Content Organization (tags, folders, etc.)
- Data Visualization & Reporting

**Collaboration & Sharing:**
- Team/Organization Management
- Permissions & Access Control
- Sharing & Collaboration Features
- Activity Feeds & History

**Integration & APIs:**
- Third-party Integrations
- Public API
- Webhooks & Event Streaming

**Infrastructure/Technical:**
- Authentication & Authorization
- Performance & Scalability
- Data Migration
- Offline Support

### Example: E-commerce Product

**Vision:** "Enable small businesses to sell products online easily"

**Identified Epics:**
1. Product Catalog Management
2. Shopping Cart & Checkout
3. Payment Processing Integration
4. Order Management & Fulfillment
5. Customer Account Management
6. Admin Dashboard & Analytics
7. Marketing & Promotions
8. Email Notifications

Each maps to a major capability needed to deliver the vision.

## Best Practices

### Right Level of Granularity

Epics should be:
- **Not too big**: "Build the entire platform" → Split into multiple epics
- **Not too small**: "Add a button" → This is a task, not an epic
- **Just right**: "Shopping Cart & Checkout" → Major capability with multiple stories

### Focus on Capabilities, Not Implementation

❌ "Build React components for dashboard"
✅ "Analytics Dashboard"

❌ "Set up PostgreSQL database"
✅ "Data Storage & Persistence" (if it's a major capability)

### Ensure User-Centric Value

Every epic should answer: "What can users do with this that they couldn't before?"

If an epic is purely technical with no user-facing impact, consider:
- Is it really necessary as a standalone epic?
- Can it be folded into a user-facing epic?
- Is it an enabler for multiple epics? (Then it's valid as infrastructure epic)

### Avoid Epic Overlap

Epics should be distinct and non-overlapping:
- Clear boundaries between epics
- Related functionality grouped into one epic, not split across several
- If unsure, combine into one epic and split later if needed

### Plan for Iteration

Epics will likely be refined:
- Initial identification may miss epics—add them as discovered
- Epics may be split or combined as understanding grows
- Scope boundaries may shift during user story creation
- This is normal—embrace learning and adaptation

## Integration with Requirements Lifecycle

### Before Epic Identification

**Vision exists** (created via vision-discovery skill)
- Problem, users, solution, success metrics defined
- Scope boundaries established

### During Epic Identification

**Create epic issues** in GitHub Projects
- Each epic is a child of the vision issue
- Epics organized and prioritized

### After Epic Identification

**Proceed to user story creation** (user-story-creation skill)
- Select an epic and break it down into stories
- Iterate epic-by-epic until all epics have stories

## Common Pitfalls to Avoid

### Too Many Epics

- More than 15-20 epics often indicates too much granularity
- Consider combining related epics
- Large products may need epic grouping into themes/initiatives

### Too Few Epics

- Fewer than 5 epics often indicates insufficient breakdown
- Vision may need decomposition into more specific capabilities
- Consider all user types, journeys, and infrastructure needs

### Implementation-Focused Epics

❌ "API Development"
✅ "Third-party Integration Support"

❌ "Database Schema"
✅ "Data Storage & Management" (if user-facing)

### Missing Infrastructure Epics

Don't forget necessary enablers:
- Authentication/Authorization
- Data migration/import
- Performance optimization (if critical to UX)
- Compliance/Security features

## Quick Reference: Epic Identification Flow

1. **Review Vision** → Understand problem, users, capabilities, metrics
2. **Identify Capabilities** → Use journey mapping, decomposition, stakeholder needs
3. **Validate as Epics** → Check criteria: valuable, large, cohesive, bounded, measurable
4. **Name & Describe** → Clear titles, structured descriptions using template
5. **Check Completeness** → Ensure all vision elements covered, no gaps
6. **Organize** → Group logically, map dependencies
7. **Prioritize** → Apply MoSCoW framework
8. **Create Issues** → Add to GitHub Projects as children of vision
9. **Proceed** → Move to user story creation for each epic

## Additional Resources

### Reference Files

For detailed epic templates and examples:
- **`${CLAUDE_PLUGIN_ROOT}/skills/epic-identification/references/epic-template.md`** - Complete epic definition template

## Next Steps

After completing epic identification:
1. Create epic issues in GitHub Projects (as children of vision issue)
2. Prioritize epics using the prioritization skill
3. Select highest-priority epic and proceed to user story creation
4. Iterate through all epics, creating user stories for each

Epics provide the roadmap from vision to execution—invest time to identify them comprehensively and define them clearly.
