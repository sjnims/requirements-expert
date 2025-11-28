# Common Epic Patterns

This reference provides universal and domain-specific epic patterns to accelerate epic identification. Use these patterns as starting points, adapting them to your specific product context.

---

## Universal Epic Patterns

These patterns appear across most software products regardless of domain.

### User Management & Identity

| Epic | Description |
|------|-------------|
| User Onboarding & Registration | Sign-up flows, account creation, initial setup |
| Authentication & Authorization | Login, SSO, MFA, session management |
| User Profile Management | Profile editing, preferences, settings |
| Role & Permission Management | Access control, role assignment, permissions |

### Core User Experience

| Epic | Description |
|------|-------------|
| Search & Discovery | Finding content, filtering, navigation |
| Notifications & Alerts | In-app, email, push notifications |
| Help & Support | Documentation, tooltips, support tickets |
| Personalization | User preferences, customization, themes |

### Data & Content

| Epic | Description |
|------|-------------|
| Data Import/Export | Bulk import, export formats, migrations |
| Content Creation & Editing | Create, edit, version content |
| Content Organization | Tags, folders, categories, hierarchies |
| File Management | Upload, storage, preview, download |

### Collaboration & Social

| Epic | Description |
|------|-------------|
| Team/Organization Management | Teams, workspaces, organizations |
| Sharing & Permissions | Share content, access levels |
| Comments & Discussions | Threaded comments, mentions, reactions |
| Activity Feeds & History | Audit logs, activity streams, notifications |

### Integration & Platform

| Epic | Description |
|------|-------------|
| Third-party Integrations | Connect external services |
| Public API | REST/GraphQL API for developers |
| Webhooks & Events | Event-driven integrations |
| Single Sign-On (SSO) | Enterprise identity providers |

### Analytics & Reporting

| Epic | Description |
|------|-------------|
| Dashboards & Visualization | Charts, graphs, real-time displays |
| Report Generation | Scheduled reports, exports |
| Usage Analytics | User behavior, engagement metrics |
| Audit & Compliance | Audit trails, compliance reports |

### Infrastructure

| Epic | Description |
|------|-------------|
| Performance & Scalability | Optimization, caching, load handling |
| Security & Compliance | Encryption, security audits, certifications |
| Data Migration | Legacy system migration, data transformation |
| Offline Support | Offline-first, sync, conflict resolution |

---

## Domain-Specific Patterns

### E-commerce / Marketplace

| Epic | Typical Scope |
|------|---------------|
| Product Catalog Management | Products, categories, inventory, pricing |
| Shopping Cart & Checkout | Cart, checkout flow, guest checkout |
| Payment Processing | Payment gateways, refunds, invoicing |
| Order Management | Order tracking, fulfillment, returns |
| Customer Accounts | Order history, saved addresses, wishlists |
| Marketing & Promotions | Discounts, coupons, campaigns |
| Seller/Vendor Management | Multi-vendor support, seller tools |
| Reviews & Ratings | Product reviews, seller ratings |

### SaaS / B2B Platform

| Epic | Typical Scope |
|------|---------------|
| Subscription Management | Plans, billing, upgrades/downgrades |
| Multi-tenancy | Tenant isolation, tenant administration |
| Admin Console | System configuration, tenant management |
| Usage Metering & Billing | Usage tracking, invoicing, quotas |
| Onboarding & Activation | Trial setup, guided tours, activation |
| Customer Success Tools | Health scores, usage insights |
| White-labeling | Custom branding, domains |
| Enterprise Features | SSO, advanced security, SLAs |

### Mobile Application

| Epic | Typical Scope |
|------|---------------|
| Mobile Authentication | Biometrics, device trust, secure storage |
| Offline Mode | Local storage, sync, conflict resolution |
| Push Notifications | Notification management, deep linking |
| Device Features | Camera, GPS, contacts integration |
| App Performance | Startup time, memory, battery optimization |
| App Store Presence | Listings, ratings, updates |
| Cross-platform Sync | State sync across devices |
| Accessibility | Screen readers, dynamic type, VoiceOver |

### API / Developer Platform

| Epic | Typical Scope |
|------|---------------|
| API Design & Documentation | OpenAPI specs, interactive docs |
| Developer Portal | Registration, API keys, documentation |
| Authentication & Security | OAuth, API keys, rate limiting |
| SDKs & Client Libraries | Language-specific SDKs |
| Sandbox Environment | Test environment, mock data |
| Usage Analytics | API metrics, endpoint analytics |
| Versioning & Deprecation | Version management, migration guides |
| Developer Support | Forums, tickets, status page |

### Content Management / Publishing

| Epic | Typical Scope |
|------|---------------|
| Content Authoring | Rich text editor, media embedding |
| Content Workflow | Draft, review, publish states |
| Media Library | Image/video management, optimization |
| Content Scheduling | Scheduled publishing, content calendar |
| Multi-language Support | Localization, translation management |
| SEO & Metadata | Meta tags, sitemaps, structured data |
| Content Distribution | RSS, social sharing, syndication |
| Templates & Layouts | Page templates, component library |

### Healthcare / Clinical

| Epic | Typical Scope |
|------|---------------|
| Patient Management | Patient records, demographics |
| Clinical Documentation | Notes, orders, results |
| Appointment Scheduling | Calendar, booking, reminders |
| Medication Management | Prescriptions, drug interactions |
| Care Coordination | Referrals, care plans, handoffs |
| Compliance & Privacy | HIPAA, consent management, audit |
| Patient Portal | Patient access, messaging, records |
| Clinical Decision Support | Alerts, guidelines, protocols |

### Financial Services / Fintech

| Epic | Typical Scope |
|------|---------------|
| Account Management | Accounts, balances, statements |
| Transaction Processing | Transfers, payments, scheduling |
| Identity Verification | KYC, document verification |
| Fraud Detection | Monitoring, alerts, investigation |
| Regulatory Compliance | Reporting, audits, regulations |
| Financial Reporting | Statements, tax documents |
| Notifications & Alerts | Transaction alerts, balance notifications |
| Secure Authentication | MFA, device binding, biometrics |

---

## Using Patterns Effectively

### Pattern Selection Process

1. **Identify your domain**: Which domain-specific pattern set applies?
2. **Start with universals**: Most products need user management, notifications, etc.
3. **Add domain patterns**: Layer in domain-specific epics
4. **Customize names**: Adapt generic names to your product's language
5. **Validate against vision**: Ensure patterns align with your specific vision

### Avoiding Pattern Pitfalls

- **Don't force-fit**: Not every pattern applies to every product
- **Customize scope**: Adjust epic scope to match your product size
- **Combine when small**: Merge related patterns if your product is simpler
- **Split when large**: Break patterns into multiple epics for complex products
- **Validate value**: Each epic should deliver user or business value

### Pattern Adaptation Example

**Generic Pattern**: "User Onboarding & Registration"

| Product Type | Adapted Epic |
|--------------|--------------|
| Consumer app | "Social Sign-up & Profile Setup" |
| Enterprise SaaS | "Organization Provisioning & Admin Setup" |
| Developer tool | "Account & API Key Setup" |
| Healthcare | "Patient Registration & Consent" |

---

## Quick Reference: Epic Starter Sets

### Minimum Viable Product (5-7 epics)

1. User Authentication
2. Core Workflow (product-specific)
3. Data Management
4. Basic Notifications
5. Settings & Profile

### Standard Product (10-15 epics)

All MVP epics plus:

- Advanced User Management
- Search & Discovery
- Collaboration Features
- Analytics Dashboard
- Integrations
- Help & Support

### Enterprise Product (15-25 epics)

All Standard epics plus:

- Multi-tenancy
- Advanced Security
- Compliance & Audit
- Admin Console
- SSO & Enterprise Auth
- Advanced Analytics
- API & Developer Tools
