# Epic Discovery Techniques

This reference provides detailed guidance on six techniques for identifying epics from a product vision. Use these techniques individually or in combination to ensure comprehensive epic coverage.

---

## 1. User Journey Mapping

Map the end-to-end journeys users will take through your product to identify the major capabilities needed at each stage.

### When to Use

- Product has clear user workflows or processes
- Multiple user touchpoints exist
- User experience is a primary concern

### Process

1. **Identify Key User Types**: List the primary personas who will use the product
2. **Map Entry Points**: How do users first encounter or access the product?
3. **Trace Core Workflows**: What steps do users take to achieve their goals?
4. **Identify Exit Points**: How do users complete their journey or leave?
5. **Note Pain Points**: Where might users struggle or need support?

### Epic Extraction

Each major stage or transition in the journey often maps to an epic:

- **Onboarding Journey** → "User Onboarding & Registration" epic
- **Core Activity** → "Content Creation" or "Data Entry" epic
- **Review/Analysis** → "Analytics & Reporting" epic
- **Sharing/Export** → "Collaboration & Sharing" epic

### Example

For a project management tool:

| Journey Stage | Epic Candidate |
|---------------|----------------|
| Sign up and setup | User Onboarding |
| Create first project | Project Management |
| Add team members | Team Collaboration |
| Track progress | Progress Tracking & Reporting |
| Complete and archive | Project Lifecycle Management |

---

## 2. Capability Decomposition

Break down the vision into the 5-10 major things the product must do, grouping related functionality into logical capabilities.

### When to Use

- Vision describes what the product should accomplish
- Product has distinct functional areas
- Technical and business stakeholders need alignment

### Process

1. **List Vision Outcomes**: What does the vision say the product will enable?
2. **Identify Required Capabilities**: What must the product DO to deliver those outcomes?
3. **Group Related Functions**: Cluster similar or dependent capabilities together
4. **Name the Groups**: Give each cluster a capability name (noun phrase)
5. **Validate Coverage**: Does each vision outcome map to at least one capability?

### Epic Extraction

Each capability group becomes an epic candidate:

- Group of authentication functions → "User Authentication & Authorization" epic
- Group of data handling functions → "Data Import/Export" epic
- Group of team features → "Collaboration Features" epic

### Example

Vision: "Enable small businesses to manage customer relationships effectively"

| Capability Group | Functions Included | Epic |
|------------------|-------------------|------|
| Contact Management | Add, edit, search, segment contacts | Customer Data Management |
| Communication | Email, call logging, notes | Customer Communication |
| Pipeline | Deals, stages, forecasting | Sales Pipeline |
| Reporting | Dashboards, exports, analytics | Analytics & Reporting |

---

## 3. Stakeholder Needs Analysis

Examine what different user types and stakeholders need from the product to identify role-specific capabilities.

### When to Use

- Multiple user roles exist (admin, end-user, manager)
- Different stakeholders have different needs
- Access control or permissions are important

### Process

1. **List All Stakeholders**: End users, admins, managers, external parties
2. **Document Each Role's Needs**: What does each stakeholder need to accomplish?
3. **Identify Unique Capabilities**: What capabilities are specific to certain roles?
4. **Find Shared Capabilities**: What do multiple roles need?
5. **Map to Epics**: Group needs into capability-based epics

### Epic Extraction

Role-specific needs often reveal epics:

- Admin needs → "User Management", "System Configuration" epics
- Manager needs → "Reporting & Analytics", "Team Oversight" epics
- End-user needs → "Core Workflow", "Personal Settings" epics

### Example

| Stakeholder | Key Needs | Epic Candidates |
|-------------|-----------|-----------------|
| End User | Create content, collaborate | Content Creation, Collaboration |
| Team Lead | Monitor progress, assign work | Team Management, Reporting |
| Admin | Manage users, configure system | User Management, System Settings |
| External Partner | View shared content | External Sharing & Access |

---

## 4. Technical Enablers Identification

Identify infrastructure, platform, or foundational capabilities required to support user-facing features.

### When to Use

- Product requires significant technical foundation
- Integrations with external systems are needed
- Performance, security, or scalability are critical

### Process

1. **Review User-Facing Epics**: What technical capabilities do they require?
2. **Identify Shared Infrastructure**: What technical needs appear across multiple epics?
3. **List External Dependencies**: What third-party systems must be integrated?
4. **Consider Non-Functional Requirements**: Security, performance, compliance
5. **Create Technical Epics**: Group infrastructure needs into coherent epics

### Epic Extraction

Technical needs become infrastructure epics:

- Authentication/authorization needs → "Identity & Access Management" epic
- External system connections → "Third-party Integrations" epic
- Data synchronization needs → "Data Pipeline & Sync" epic
- Performance requirements → "Performance & Scalability" epic

### Example

| Technical Need | Scope | Epic |
|----------------|-------|------|
| User authentication | SSO, MFA, session management | Identity & Access Management |
| Payment processing | Stripe, PayPal integration | Payment Integration |
| File storage | Upload, CDN, versioning | File Management Infrastructure |
| Search | Full-text, filters, indexing | Search Infrastructure |

---

## 5. Value Stream Mapping

Trace the flow of value from initial input to final outcome to identify where major capabilities are needed.

### When to Use

- Product transforms inputs into valuable outputs
- Process efficiency is important
- Multiple handoffs or stages exist

### Process

1. **Identify Value Input**: What enters the system? (data, requests, content)
2. **Trace Transformations**: How is the input processed and transformed?
3. **Map Value Additions**: Where is value added at each stage?
4. **Identify Outputs**: What valuable outputs are produced?
5. **Extract Capabilities**: What capabilities enable each value-adding step?

### Epic Extraction

Each value-adding stage suggests an epic:

- Input stage → "Data Ingestion" or "Content Upload" epic
- Processing stage → "Data Processing" or "Workflow Engine" epic
- Output stage → "Report Generation" or "Export & Delivery" epic

### Example

For a document processing product:

| Value Stage | Activity | Epic |
|-------------|----------|------|
| Input | Upload documents | Document Ingestion |
| Processing | Extract data, validate | Document Processing |
| Enrichment | Add metadata, classify | Document Intelligence |
| Output | Generate reports, export | Reporting & Export |
| Storage | Archive, retrieve | Document Management |

---

## 6. Gap Analysis

Compare the current state (or competitor offerings) with the desired future state to identify capability gaps that become epics.

### When to Use

- Replacing or improving an existing system
- Competitive analysis has been done
- Clear "before and after" vision exists

### Process

1. **Document Current State**: What exists today? What can users do now?
2. **Define Future State**: What should users be able to do?
3. **Identify Gaps**: What's missing between current and future?
4. **Prioritize Gaps**: Which gaps are most critical to close?
5. **Convert to Epics**: Each significant gap becomes an epic

### Epic Extraction

Gaps become epics:

- Missing capability → New epic for that capability
- Insufficient capability → Enhancement epic
- Broken capability → Fix/rebuild epic

### Example

| Current State | Future State | Gap | Epic |
|---------------|--------------|-----|------|
| Manual data entry | Automated import | Automation | Data Import Automation |
| Basic reports | Interactive dashboards | Visualization | Analytics Dashboard |
| Email notifications | Multi-channel alerts | Channels | Notification System |
| No mobile access | Full mobile app | Platform | Mobile Application |

---

## Combining Techniques

For comprehensive epic identification, use multiple techniques:

1. **Start with User Journey Mapping** to understand the user perspective
2. **Apply Capability Decomposition** to ensure technical completeness
3. **Use Stakeholder Needs** to catch role-specific requirements
4. **Add Technical Enablers** for infrastructure epics
5. **Validate with Gap Analysis** to ensure nothing is missed

Cross-reference results from different techniques to validate epic completeness and identify any gaps.

---

## Quick Reference

| Technique | Best For | Key Question |
|-----------|----------|--------------|
| User Journey Mapping | UX-focused products | "What journey do users take?" |
| Capability Decomposition | Feature-rich products | "What must the product DO?" |
| Stakeholder Needs | Multi-role products | "What does each role need?" |
| Technical Enablers | Complex integrations | "What infrastructure is required?" |
| Value Stream Mapping | Process-oriented products | "How does value flow?" |
| Gap Analysis | Replacements/upgrades | "What's missing today?" |
