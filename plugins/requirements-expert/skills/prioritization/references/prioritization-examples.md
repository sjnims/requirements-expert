# Prioritization at Different Levels

This reference provides detailed examples of applying MoSCoW prioritization at each level of the requirements hierarchy: epics, user stories, and tasks. Load this when conducting prioritization sessions or when helping users understand level-specific considerations.

For the core MoSCoW framework and prioritization process, see the main skill documentation.

---

## Prioritizing Epics

**Context:** Determining which major capabilities to build first

### Key Considerations

| Factor | Questions to Ask |
|--------|------------------|
| Strategic alignment | Does this directly support the vision? |
| Foundation vs. enhancement | Is this required before other epics can start? |
| User journey completeness | Can users accomplish core goals without this? |
| Market differentiation | Does this differentiate from competitors? |

### Example: E-commerce Platform Epics

| Priority | Epic | Rationale |
|----------|------|-----------|
| **Must Have** | User Authentication | Cannot transact without accounts |
| **Must Have** | Core Workflow (Browse → Cart → Checkout) | Essential user journey |
| **Must Have** | Payment Processing | Cannot complete purchases without this |
| **Should Have** | Advanced Analytics | Important for optimization, not launch-critical |
| **Should Have** | Team Collaboration | Enhances operations, workaround exists |
| **Could Have** | Custom Branding | Nice-to-have for enterprise customers |
| **Could Have** | API Access | Enables integrations, not core to MVP |
| **Won't Have** | Mobile App | Web-first strategy; phase 2 |

### Epic Prioritization Patterns

- **Foundation first:** Authentication, data models, core workflows before enhancements
- **End-to-end value:** Complete a user journey before adding features
- **Risk reduction:** Tackle high-uncertainty epics early to learn

---

## Prioritizing User Stories

**Context:** Determining which stories within an epic to implement first

### Key Considerations

| Factor | Questions to Ask |
|--------|------------------|
| Happy path | Does this enable the primary success scenario? |
| Core vs. enhancement | Is this fundamental or an improvement? |
| Foundation vs. polish | Does other work depend on this? |
| Usage frequency | How often will users encounter this? |

### Example: Campaign Management Epic Stories

| Priority | Story | Rationale |
|----------|-------|-----------|
| **Must Have** | Create campaign | Core CRUD operation |
| **Must Have** | View campaign list | Users must see what exists |
| **Must Have** | Edit campaign basics | Essential modification capability |
| **Should Have** | Duplicate campaign | Significant time-saver, workaround exists |
| **Should Have** | Archive campaign | Important for organization, not blocking |
| **Should Have** | Bulk operations | Efficiency for power users |
| **Could Have** | Campaign templates | Convenience feature |
| **Could Have** | Custom fields | Advanced customization |
| **Won't Have** | Campaign scheduling | Separate epic scope |

### Story Prioritization Patterns

- **Happy path first:** Login before password reset, create before edit
- **Read before write:** View list before bulk delete
- **Success before error:** Core flow before edge case handling
- **Frequent before rare:** Daily actions before monthly reports

---

## Prioritizing Tasks

**Context:** Determining sequence of implementation tasks within a story

### Key Considerations

| Factor | Questions to Ask |
|--------|------------------|
| Technical dependencies | What must exist before this can work? |
| Iterative progress | Can we get a working slice early? |
| Testing strategy | When should tests be written? |
| Documentation timing | When should docs be updated? |

### Example: "Filter Campaigns by Date" Story Tasks

| Priority | Task | Rationale |
|----------|------|-----------|
| **Must Have** | Backend date filtering logic | Foundation for feature |
| **Must Have** | Basic UI with date pickers | User-facing implementation |
| **Must Have** | Frontend-backend integration | Complete the slice |
| **Should Have** | Validation and error handling | Quality and UX |
| **Should Have** | Unit tests for filter logic | Confidence and maintainability |
| **Could Have** | Date range presets (Last 7 days, etc.) | Convenience enhancement |
| **Won't Have** | Save filter preferences | Separate story scope |

### Task Prioritization Patterns

- **Backend before frontend:** Data layer → API → UI
- **Vertical slice:** Get something working end-to-end early
- **Test alongside:** Write tests as you build, not all at end
- **Document as you go:** Update docs while context is fresh

---

## Cross-Level Consistency

Ensure priority flows logically across levels:

| Rule | Example |
|------|---------|
| Must Have epic contains Must Have stories | "Payment" epic → "Process payment" story |
| High-priority story has high-priority core tasks | "Login" story → "Authenticate user" task |
| Won't Have items remain out of scope | "Mobile" epic → No mobile-specific stories sneak in |

### Inheritance Guidelines

- Epic priority sets upper bound for story priorities
- Story priority sets upper bound for task priorities
- Exception: Infrastructure tasks may be Must Have regardless of parent story priority
