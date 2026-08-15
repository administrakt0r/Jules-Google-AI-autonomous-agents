# 🤖 TODOist — Prioritized Todo File Generator

> **Usage**: Paste this entire prompt to any capable AI agent with codebase access (Claude, Cursor, Copilot Workspace, Aider, [Jules by Google](https://jules.google.com), etc.). The agent will audit your project and produce **11 prioritized todo files + 1 execution prompt file (PROMPT11.md)**.

---

## ROLE & MANDATE

You are a senior full-stack architect and product engineer performing a comprehensive audit of this codebase. Your job is to deeply analyze the project, understand its technology stack, product domain, and current state — then produce **todo output files**:  curated, prioritized todo files covering every major improvement axis, plus one ready-to-use execution prompt (`PROMPT11.md`) tailored specifically to this project.

You are not writing generic advice. Every item you produce must be:
- **Specific** — reference actual filenames, component names, API endpoints, config keys, or database tables found in this codebase
- **Justified** — explain the risk, user impact, or engineering cost of NOT doing it
- **Realistic** — stay within the existing stack; don't suggest migrating to a new framework unless truly warranted
- **Actionable** — written so a developer can open the file and start immediately
- **Prioritized** — ordered by impact × urgency across six tiers (P0–P5)

If a domain (e.g., blog, admin) does not exist yet, still produce the file — mark existing gaps and provide a roadmap for when it is built.

---

## PHASE 1 — CODEBASE DISCOVERY

Before writing a single todo item, perform a full reconnaissance pass. Catalog everything below. Write your findings as a preamble block `_codebase-snapshot.md` or as `<!-- ANALYSIS: ... -->` comments at the top of your first output file.

### 1.1 Stack Detection
Identify and record:

**Frontend**
- Framework & version (React, Next.js, Vue, Nuxt, SvelteKit, Angular, Remix, Astro, etc.)
- Styling system (Tailwind, CSS Modules, Styled Components, Sass, Vanilla, etc.)
- State management (Redux, Zustand, Jotai, Pinia, Context, etc.)
- Data fetching (SWR, React Query, tRPC, Apollo, Axios, native fetch, etc.)
- Component library (shadcn/ui, MUI, Ant Design, Radix, Headless UI, custom, etc.)
- Build tool (Vite, Webpack, Turbopack, esbuild, Rollup, etc.)
- TypeScript? Strict mode? JSDoc?
- Testing setup (Vitest, Jest, Playwright, Cypress, Testing Library, none)
- Animation library (Framer Motion, GSAP, CSS only, etc.)
- i18n setup (next-intl, react-i18next, none)

**Backend**
- Language & version (Node.js, Python, Go, Ruby, PHP, Java, Rust, .NET, etc.)
- Framework (Express, Fastify, NestJS, Django, FastAPI, Rails, Laravel, Gin, etc.)
- ORM / DB client (Prisma, Drizzle, TypeORM, SQLAlchemy, ActiveRecord, raw SQL, etc.)
- Database(s) (PostgreSQL, MySQL, SQLite, MongoDB, Redis, DynamoDB, Supabase, PlanetScale, etc.)
- Auth strategy (JWT, sessions, NextAuth, Clerk, Auth0, Supabase Auth, Passport, etc.)
- API style (REST, GraphQL, tRPC, gRPC, WebSockets, SSE)
- File storage (S3, Cloudflare R2, Uploadthing, local disk, etc.)
- Email provider (Resend, SendGrid, Postmark, SES, Nodemailer, etc.)
- Background jobs (BullMQ, Celery, Sidekiq, Inngest, Trigger.dev, cron, etc.)
- Payment provider (Stripe, Paddle, Lemon Squeezy, etc.)

**Infrastructure & DevOps**
- Hosting (Vercel, Netlify, Railway, Render, Fly.io, AWS, GCP, Azure, Hetzner, DigitalOcean, etc.)
- Containerization (Docker, Docker Compose, Kubernetes, none)
- CI/CD (GitHub Actions, GitLab CI, CircleCI, none)
- Monitoring/observability (Sentry, Datadog, PostHog, Plausible, LogRocket, none)
- CDN (Cloudflare, Fastly, CloudFront, none)
- Environment config method (.env, Vault, SSM, Doppler, etc.)
- Secret management practices

### 1.2 Project Type & Domain
Determine the product category:
- SaaS platform / B2B tool / consumer app / marketplace / e-commerce / content site / internal tool / API-only / mobile backend / developer tool / other
- Authenticated vs. public-facing surfaces
- Multi-tenant? If so, what isolation model?
- Monetization model (subscription, one-time, freemium, usage-based, none)
- Does a blog/CMS exist? (look for `/blog`, `/posts`, `/articles`, CMS config, MDX, Contentlayer, Sanity, Strapi, etc.)
- Does an admin dashboard exist? (look for `/admin`, `/dashboard`, role-based routes, etc.)

### 1.3 Current State Assessment
Before writing todos, note:
- Approximate codebase age and maturity signals (package.json dates, comment dates, TODO/FIXME counts)
- Obvious quick wins (missing `.env.example`, no error boundaries, console.logs in production paths, etc.)
- Areas of technical debt (duplicated code, commented-out blocks, `any` types, missing validations)
- What's already well done (don't list these as todos — note them to avoid redundancy)
- Known `TODO`, `FIXME`, `HACK`, `XXX` comments already in the code — incorporate into appropriate files
- Run or simulate: `grep -rn "TODO\|FIXME\|HACK\|XXX\|@deprecated\|BUG\|TEMP" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" --include="*.go" .`

---

## PHASE 2 — ANALYSIS CRITERIA

Use these lenses when auditing each area. Apply them selectively per file.

### Security Lens
- Auth: session fixation, JWT alg=none, missing expiry, privilege escalation paths
- Input: SQL injection, XSS (reflected/stored/DOM), SSRF, path traversal, prototype pollution
- Headers: CSP, HSTS, X-Frame-Options, Referrer-Policy, Permissions-Policy
- Secrets: hardcoded keys, tokens in client bundles, `.env` committed, verbose error messages leaking stack traces
- Dependencies: outdated packages with CVEs (`npm audit`, `pip audit`, `trivy` equivalent)
- OWASP Top 10 coverage for the detected stack

### Performance Lens
- Core Web Vitals: LCP, CLS, INP (formerly FID)
- Bundle: code splitting, tree shaking, dead code, heavy dependency alternatives
- Images: format (WebP/AVIF), responsive srcsets, lazy loading, CDN delivery
- Caching: HTTP cache headers, stale-while-revalidate, CDN caching, server-side memoization, React Query/SWR config
- DB queries: N+1 problems, missing indexes, unselected columns (`SELECT *`), unbounded queries, missing pagination
- API: payload size, unnecessary refetches, over-fetching (GraphQL/REST), response compression
- Rendering: SSR vs SSG vs ISR misuse, unnecessary client-side hydration, waterfall requests
- Runtime: memory leaks (event listeners, intervals, subscriptions not cleaned up), CPU-blocking on main thread

### Design / UX Lens
- Accessibility (a11y): WCAG 2.1 AA minimum — missing ARIA roles, poor contrast ratios (<4.5:1), keyboard traps, missing focus indicators, no skip links, non-descriptive link text, images without alt
- Responsive: breakpoint gaps, mobile-only issues, touch target sizes (<44px), horizontal overflow
- Loading states: skeleton screens vs. spinners, optimistic updates, empty states, error states
- Typography: font loading (FOUT/FOIT), line-length, spacing, hierarchy
- Forms: inline validation, accessible error messages, autocomplete attributes, disabled state feedback
- Micro-interactions: hover states, transitions, feedback for async actions
- Dark mode support and color token consistency
- Design system consistency (mixed component patterns, inconsistent spacing/sizing)

### Backend Architecture Lens
- Separation of concerns (fat routes vs. service layer, business logic in DB queries)
- Error handling strategy (centralized vs. scattered, typed errors, error propagation)
- Validation: input schema validation at API boundary (Zod, Joi, Yup, Pydantic, etc.)
- API design: versioning, consistent naming, HTTP semantics, pagination patterns
- Database schema: normalization, indexes, constraints, soft deletes, audit fields (created_at, updated_at)
- Service boundaries: monolith vs. modules, circular dependencies
- Testing: unit vs. integration vs. e2e coverage, critical path coverage
- Logging: structured logs, correlation IDs, log levels, no sensitive data in logs
- Configuration: environment-specific config, feature flags

---

## PHASE 3 — TODO FILE FORMAT

Every todo file must follow this exact structure:

```markdown
# [Emoji] File Title — [Project Name]

> **Stack context**: [1-line summary of relevant detected stack for this file]
> **Last analyzed**: [today's date]
> **Items**: [X total — P0: N, P1: N, P2: N, P3: N, P4: N, P5: N]
> **Completed**: [N items archived below]

---

## 🔴 P0 — Critical (Do This Week)
> Security holes, data loss risk, actively broken features, major a11y blockers, compliance violations.
> These cause real harm if left unfixed. Maximum 5 items per file.

### [P0-01] Short Descriptive Title
- **Location**: `path/to/file.ts`, `path/to/other.ts:42`
- **What**: Precise description of the change needed
- **Why**: Risk or impact of NOT doing this — be specific (e.g., "XSS vector on all comment inputs allows session hijacking", "LCP degraded by 2.4s on mobile Lighthouse", "users permanently locked out on Safari 16 due to SameSite cookie bug")
- **Effort**: XS | S | M | L | XL
- **How**: Concrete implementation hint — a code snippet, library name, or algorithm (3–8 lines max)

---

## 🟠 P1 — High Priority (This Sprint)
> Significant business, UX, or engineering impact. Unblocks other work or addresses visible user pain.

### [P1-01] Short Descriptive Title
- **Location**: ...
- **What**: ...
- **Why**: ...
- **Effort**: ...
- **How**: ...

---

## 🟡 P2 — Medium Priority (Next 30 Days)
> Noticeable quality improvements, technical debt reduction, polish. Real value but not on fire.

### [P2-01] Short Descriptive Title
...

---

## 🟢 P3 — Low Priority (Backlog)
> Nice-to-have, minor improvements, consistency fixes. Worthwhile but no urgency.

### [P3-01] Short Descriptive Title
...

---

## 🔵 P4 — Roadmap (Next Quarter)
> Architectural improvements, platform expansions, strategic capabilities. Requires planning.
> Items here are well-defined enough to estimate but not yet scheduled.

### [P4-01] Short Descriptive Title
...

---

## ⚪ P5 — Icebox (Future / Aspirational)
> Speculative ideas, "when we scale" scenarios, research items, moonshots.
> Capture them now so they aren't lost, revisit quarterly.

### [P5-01] Short Descriptive Title
...

---

## 🗄️ Completed Items Archive
> Items moved here after implementation. Never delete — they form a change log.

### ~~[P1-02] Example Completed Item~~ ✅
> Completed: [brief summary of what was done] — [date]
```

### Priority Rules
| Label | Urgency | Max items/file | Typical examples |
|-------|---------|---------------|-----------------|
| P0 🔴 | This week | 5 | Auth bypass, SQL injection, broken checkout, data loss |
| P1 🟠 | This sprint | 15 | Missing rate limiting, N+1 queries, broken mobile nav |
| P2 🟡 | 30 days | 40 | Accessibility fixes, caching, missing error states |
| P3 🟢 | Backlog | 60 | UI polish, minor DX improvements, consistency |
| P4 🔵 | Quarter | 40 | New integrations, architectural refactors, platform features |
| P5 ⚪ | Someday | 40 | Speculative, research-dependent, aspirational |
| **Total** | | **10–200** | |

### Effort Scale
| Label | Time |
|-------|------|
| XS | < 1 hour |
| S | 1–4 hours |
| M | 1–3 days |
| L | 1–2 weeks |
| XL | 2+ weeks / team effort |

### Cross-Reference Format
When an item is related to another file's item, add:
`> 🔗 See also: todo-backend-security.md [P1-03] — complementary backend fix required`

---

## PHASE 4 — EXISTING TODO FILE HANDLING

**This phase runs BEFORE writing any new content.** If any of the 11 todo files already exist on disk, follow this procedure for each one before generating fresh items.

### Step 1: Load and Parse the Existing File
Read the full file. Identify every item and its current state.

**Detect completed items** by looking for any of these patterns:
- `- [x]` checkbox syntax
- `~~strikethrough~~` in the item title
- `✅` emoji in the item line
- Comment `<!-- DONE -->` anywhere in the item block
- A `> Completed:` note beneath the item
- The item appears under a `## Completed` or `## Done` section

### Step 2: Archive Completed Items
- Move every completed item to the `🗄️ Completed Items Archive` section at the bottom of the file
- Do NOT delete completed items — they are a historical record
- Format: `### ~~[P1-02] Original Title~~ ✅` with a `> Completed: [summary] — [date if known]` note
- Update the `**Completed**: N items` count in the file header

### Step 3: Re-evaluate Surviving Items
For each item that is NOT done, re-examine it against the current codebase:

- **Obsolete** — the problem no longer exists (code was refactored, library updated, approach changed): mark with `> ⚠️ May be obsolete — verify before starting` and downgrade to lowest relevant priority
- **Priority change** — the situation has changed (a P2 became a P0 due to a new dependency CVE, or a P0 was partially mitigated): update the priority tier and add a `> ♻️ Priority updated [old] → [new]: [reason]` note inline
- **Scope change** — the item is still valid but the effort estimate is wrong based on what you now see: update the `**Effort**` field and note `> 📏 Effort re-estimated: was [old], now [new] — [reason]`
- **Still valid, no change**: leave as-is

### Step 4: Deduplicate Before Adding
Before adding any new item you discovered during analysis:
1. Check all existing (non-completed) items for semantic overlap
2. If a new finding is covered by an existing item: add details to the existing item's `**What**` or `**How**` field rather than creating a new item
3. If a new finding is a distinct issue: add it as a new item in the correct priority tier with the next sequential ID

### Step 5: Renumber if Needed
After archiving completed items and adding new ones, renumber IDs sequentially within each priority tier (P0-01, P0-02, etc.) so IDs are contiguous. Update the items count in the file header.

### Step 6: Update the Header
```markdown
> **Last analyzed**: [today's date]
> **Items**: [new total — P0: N, P1: N, P2: N, P3: N, P4: N, P5: N]
> **Completed**: [N items archived below]
```

---

## PHASE 5 — INDIVIDUAL FILE INSTRUCTIONS

For each file, here is what to focus on, what categories to cover, and specific patterns to look for in any codebase.

---

### 📄 `todo-newstuff.md`
**Scope**: New product features, platform expansion, missing capabilities that users of this product type expect.

**Think like a product manager** who just joined the company. Look at what the app does, what it's missing vs. competitors or user expectations, and identify highest-ROI additions.

**Categories to cover**:
- **Missing Core Features** — standard features for this product category that are absent (e.g., a SaaS without password reset, a marketplace without search filters, an e-commerce without order history)
- **Platform Expansion** — mobile responsiveness gaps, PWA potential, native app candidate features, browser extension potential
- **User Onboarding** — onboarding flow, tooltips, empty states with CTAs, first-run experience, welcome email
- **Notifications & Communication** — email notifications, in-app notifications, push notifications, SMS, digest emails
- **Integrations & API** — missing OAuth providers, Zapier/Make webhooks, public API, SDK/embeds
- **Monetization** — upgrade flows, usage limits, trial logic, billing portal, free tier design
- **Analytics & Feedback** — user behavior tracking, feedback widgets, NPS, feature flags for A/B testing
- **Collaboration** — sharing, team features, permissions, roles, activity feeds, comments
- **Search** — global search, filters, facets, full-text, semantic search
- **Export / Import** — data portability, CSV/PDF exports, bulk operations, data migration tooling
- **Internationalization (i18n)** — i18n-ready architecture, multi-language, RTL support, locale formatting
- **Accessibility features** — text resize, high-contrast toggle, screen reader optimizations

**Specific things to look for**:
- Routes that exist but lead to "coming soon" or empty pages
- Feature flags that are disabled/hardcoded false
- Commented-out feature code
- Half-implemented features (model exists, no UI — or UI exists, no API)
- `// TODO: add X feature` comments in the codebase

---

### 📄 `todo-perf.md`
**Scope**: Frontend performance — Core Web Vitals, bundle size, rendering strategy, caching, asset optimization.

**Categories to cover**:
- **Core Web Vitals** — LCP, CLS, INP analysis and specific fixes
- **Bundle Optimization** — code splitting, dynamic imports, tree shaking, dead code, large dependency alternatives
- **Image & Media** — format modernization (WebP/AVIF), responsive images, lazy loading, blur placeholders, video optimization
- **Font Loading** — `font-display: swap`, preload hints, subsetting, self-hosting vs. Google Fonts tradeoffs
- **Rendering Strategy** — misused SSR/SSG/ISR/CSR, unnecessary hydration, streaming (React 18+, Suspense)
- **Caching** — HTTP cache headers on static assets, API response caching, stale-while-revalidate, service worker
- **Network** — HTTP/2 push, compression (Brotli > gzip), prefetch/preconnect hints, API request batching/deduplication
- **Runtime Performance** — long task breakdown, debouncing/throttling, virtualization for long lists, memoization correctness
- **Third-party Scripts** — analytics, chat widgets, tag managers — async loading, facade pattern, impact assessment
- **Build Pipeline** — build time, incremental builds, cache in CI/CD

**Specific things to look for**:
- `import * from 'lodash'` or `import moment from 'moment'` — tree-shaking killers
- `<img>` tags without explicit `width` and `height` attributes (CLS)
- Synchronous `<script>` tags in `<head>`
- Missing `rel="preload"` for the above-the-fold hero image (LCP)
- `useEffect` fetching on every render with no or wrong dependency array
- Unvirtualized lists rendering 50+ items (`react-window`, `@tanstack/virtual`)
- Multiple components independently fetching the same data

---

### 📄 `todo-design.md`
**Scope**: UI/UX improvements, accessibility compliance, visual polish, interaction design.

**Categories to cover**:
- **Accessibility (a11y)** — WCAG 2.1 AA compliance (P0 for public-facing apps)
  - Color contrast failures (< 4.5:1 normal text, < 3:1 large text)
  - Missing/incorrect ARIA labels, roles, live regions (`role="alert"`, `aria-live`)
  - Keyboard navigation and logical focus order
  - Focus indicator visibility (`outline: none` without replacement)
  - Skip navigation links
  - Form accessibility (label association, error announcements, `aria-describedby`)
  - Modal/dialog focus trapping and escape key handling
  - Icon-only buttons without accessible names
  - Images without meaningful `alt` text
- **Responsive Design** — breakpoint gaps, mobile-first issues, touch targets (<44px), horizontal overflow
- **Loading & Error States** — skeleton screens, error boundaries with helpful messages, empty states with CTAs
- **Forms UX** — real-time validation, clear error placement, autofill/autocomplete attributes
- **Typography & Readability** — line length (45–75 chars), line height, font scale, heading hierarchy
- **Motion & Transitions** — jarring state changes, missing micro-interactions, `prefers-reduced-motion` support
- **Dark Mode** — missing dark mode, hard-coded colors vs. CSS variables/design tokens
- **Design System Consistency** — mixed component patterns, spacing drift, color token inconsistency
- **Navigation & IA** — confusing nav structure, missing breadcrumbs, dead-end pages, back-navigation issues
- **Destructive Action Safeguards** — missing confirmation dialogs for delete/irreversible actions

**Specific things to look for**:
- `<div onClick>` or `<span onClick>` instead of `<button>` (keyboard/a11y failure)
- `<img>` without `alt` attribute
- `outline: none` or `outline: 0` in CSS without a focus replacement
- Form `<input>` without an associated `<label>` (even visually hidden)
- No `aria-label` on icon-only interactive elements
- `transition: all` instead of specific properties (causes unexpected repaints)

---

### 📄 `todo-sec.md`
**Scope**: Frontend and application-level security — what's exploitable from the client side.

**Categories to cover**:
- **Authentication & Authorization**
  - Missing auth checks on protected routes (both frontend guard AND API-level verification)
  - Insecure "remember me" / persistent login implementation
  - Missing CSRF protection on state-mutating requests
  - Sensitive data in JWT payloads visible client-side
  - Auth tokens stored in `localStorage` (should be HttpOnly cookies)
  - Auth state not fully cleared on logout
- **Input Validation & Output Encoding**
  - XSS vectors: `dangerouslySetInnerHTML`, `v-html`, `innerHTML` — catalog every instance
  - Open redirect vulnerabilities (unvalidated `?redirect=` params)
  - File upload: type, size, extension, and content validation
- **Data Exposure**
  - API responses returning fields not needed by client (passwords, hashes, internal IDs)
  - Sensitive data in URL parameters
  - PII in console logs, Sentry/analytics events, error tracking payloads
  - `NEXT_PUBLIC_` / `VITE_` prefixed variables that should never be client-side
- **HTTP Security Headers**
  - Content-Security-Policy (CSP) — present, non-trivially permissive
  - X-Frame-Options / `frame-ancestors` directive
  - HSTS (`Strict-Transport-Security`)
  - `Referrer-Policy`
  - `Permissions-Policy`
- **Third-party & Supply Chain**
  - Subresource Integrity (SRI) on CDN-loaded scripts
  - Outdated dependencies with known CVEs
- **Cookie Security**
  - `HttpOnly`, `Secure`, `SameSite` flags on auth cookies
  - Cookie scope (domain, path) appropriateness

**Specific things to look for**:
- Every use of `dangerouslySetInnerHTML` — list them all
- `localStorage.setItem('token', ...)` or `sessionStorage.setItem('token', ...)`
- `eval()`, `new Function(str)`, `setTimeout(string, delay)` patterns
- `window.location.href = req.query.redirect` without allowlist validation
- `.env` or `.env.local` files present in git history or not in `.gitignore`

---

### 📄 `todo-secops.md`
**Scope**: Operational security — infrastructure, secrets management, deployment pipeline, incident response, compliance.

**Categories to cover**:
- **Secrets Management**
  - Secrets in code, comments, or commit history (`git log -p | grep -i "key\|secret\|password"`)
  - Secret rotation policy and tooling (Doppler, Vault, AWS SSM, GitHub Secrets)
  - Separate secrets per environment (dev/staging/prod never share keys)
  - Principle of least privilege for service accounts and API keys
- **CI/CD Pipeline Security**
  - Pinned action versions (GitHub Actions `@v3` vs `@sha256:...`)
  - Secrets masked in CI logs
  - Dependency scanning in pipeline (Snyk, Dependabot, Trivy)
  - SAST integration (CodeQL, Semgrep)
  - Artifact signing and provenance
- **Infrastructure Access**
  - SSH key hygiene, no shared credentials across team members
  - MFA enforced on all cloud console accounts
  - Database NOT accessible from public internet (VPC/private subnet)
  - Principle of least privilege for IAM roles and service accounts
- **Dependency Management**
  - Automated dependency updates (Dependabot, Renovate) configured
  - Lock file committed and verified in CI
  - `npm audit` / `pip audit` / `cargo audit` running in CI pipeline
  - License compliance scanning for legal risk
- **Monitoring & Alerting**
  - Error rate alerting with thresholds and on-call notifications
  - Anomalous traffic / rate-limit-hit detection
  - Uptime monitoring with paging
  - Security event logging (failed auth attempts, rate limit hits, permission denials)
- **Incident Response**
  - Runbook existence and currency
  - On-call rotation documented
  - Backup and point-in-time recovery procedures tested
  - Breach notification and escalation process defined
- **Compliance Posture**
  - GDPR: privacy policy, cookie consent, data deletion requests, data residency
  - SOC 2 readiness signals (audit logging, access controls, change management) if B2B SaaS
  - PCI DSS scope if handling card data

**Specific things to look for**:
- GitHub Actions with `uses: actions/checkout@main` (unpinned — supply chain risk)
- Any `*_SECRET`, `*_KEY`, `*_PASSWORD` patterns in non-secrets files
- Database connection strings in application code rather than environment variables
- No rate limiting on `/api/auth/login`, `/api/auth/register`, `/api/password-reset`
- Missing `SECURITY.md` / vulnerability disclosure policy in repo root

---

### 📄 `todo-blog.md`
**Scope**: Blog/CMS — content management, SEO, reading experience, editorial workflow.

> **If no blog exists**: Document as P4 (most product sites benefit from a blog for SEO/thought leadership) and provide a concrete implementation recommendation for the detected stack.

**Categories to cover**:
- **CMS & Editorial Workflow**
  - Content editing experience (headless CMS vs MDX — is it dev-only or editor-friendly?)
  - Draft / preview / scheduled-publish workflow
  - Content versioning and rollback
  - Asset management pipeline for post images
  - Author profiles and multi-author support
  - Taxonomy (categories, tags) management UI
- **SEO Fundamentals** (these are P0/P1 — they directly affect organic traffic)
  - Dynamic `<title>` and `<meta name="description">` per post
  - Open Graph tags (`og:title`, `og:description`, `og:image` with correct dimensions)
  - Twitter/X Card tags
  - Canonical URLs on all post pages
  - Structured data (Article + BreadcrumbList + Person JSON-LD schema)
  - XML sitemap including all blog posts (auto-updated)
  - `robots.txt` correctness
- **Reading Experience**
  - Estimated read time display
  - Table of contents for posts >1500 words
  - Code syntax highlighting (if technical blog)
  - Responsive images in post body (not just hero)
  - Prose typography styles (Tailwind Typography, custom prose CSS)
  - Social share buttons
  - Related posts / series navigation
- **Performance**
  - Static generation vs. SSR for post pages
  - ISR for frequently updated content
  - Lazy loading for images in post body
- **Discovery & Growth**
  - Category/tag browse pages with pagination
  - Full-text search within blog
  - Newsletter signup integration (ConvertKit, Resend, Mailchimp, etc.)
  - RSS/Atom feed at `/feed.xml` or `/rss`

**Specific things to look for**:
- Blog posts without `og:image` meta tag (devastating for social sharing CTR)
- No `<link rel="canonical">` on post pages
- Post pages absent from XML sitemap
- Images in MDX/markdown not going through image optimization pipeline
- No JSON-LD Article schema on post pages
- Posts accessible at multiple URLs without canonicalization

---

### 📄 `todo-backend-admin.md` (if codebase have and uses admin panel, if not skip)
**Scope**: Admin dashboard — internal tooling for operators, support, and business teams.

> **If no admin exists**: Document as P1 for any app with real users/data. Provide recommended approach for the detected stack (react-admin, AdminJS, Retool, custom, etc.).

**Categories to cover**:
- **User Management**
  - User list with search, filter (by role, status, plan), sort, and pagination
  - User detail view (account info, activity log, subscription, linked accounts)
  - Manual role/permission assignment
  - Account suspend / unsuspend / delete with confirmation
  - GDPR data export and right-to-erasure tooling
  - "Login as user" impersonation for support (with audit trail)
  - Bulk actions (email selected, export CSV, suspend batch)
- **Content Moderation** (if user-generated content exists)
  - Flagged/reported content queue with one-click actions
  - Moderation decision audit trail
  - Spam/abuse signal visibility
- **System Observability**
  - Real-time error log viewer (or link to Sentry/Datadog)
  - Background job queue status, retry controls, dead-letter visibility
  - Webhook delivery log with retry capability
  - Feature flag management UI
- **Business Intelligence**
  - Key metrics dashboard (MRR/ARR, churn rate, DAU/MAU, conversion, trial→paid)
  - Subscription and revenue management (manual overrides, comps, refunds)
  - Data export to CSV for any entity
- **Configuration & Operations**
  - System settings UI (site config, feature toggles, rate limit thresholds)
  - Email template preview and test-send
  - Maintenance mode toggle
  - Manual cache invalidation controls
- **Audit & Compliance**
  - Admin action audit log (who did what, when, from which IP)
  - Sensitive data access log
  - Exportable audit logs for compliance/legal

**Specific things to look for**:
- Admin routes protected only by frontend guard, not by API-level role check
- Bulk operations without confirmation step
- Destructive admin actions with no audit log entry
- User list without pagination (will time out at scale)
- Impersonation feature that doesn't create an audit trail

---

### 📄 `todo-backend-newstuff.md`(if codebase have and uses admin or user panel/dashboard, if not skip)
**Scope**: New backend capabilities — API completeness, integrations, platform infrastructure.

**Categories to cover**:
- **API Completeness**
  - Missing CRUD endpoints for existing data models
  - Missing bulk operation endpoints (bulk create, update, delete)
  - Missing search/filter/sort/pagination on all list endpoints
  - Missing data export endpoints (CSV, JSON, PDF generation)
  - Outbound webhook system for third-party integrations
  - Public developer API readiness (API keys, rate limiting per key, documentation)
- **Platform Features**
  - Multi-tenancy improvements (workspace isolation, per-tenant config)
  - Subscription and billing management (Stripe Billing, usage metering, dunning)
  - Transactional notification system (email, push, in-app, SMS — unified)
  - File processing pipeline (image resizing, document parsing, virus scanning)
  - Background job system design (idempotency, retry, dead-letter)
  - Job scheduling and cron management
  - Real-time capabilities (WebSockets, SSE, Pusher, Ably)
- **Integrations**
  - Additional OAuth providers (Google, GitHub, Microsoft, Apple, etc.)
  - Third-party service integrations relevant to the product domain
  - Zapier/Make/n8n webhook triggers and action endpoints
  - Server-side analytics event tracking
- **Developer Experience**
  - OpenAPI/Swagger spec (auto-generated from routes if possible)
  - Sandbox environment with realistic seeded test data
  - Idempotency keys on non-idempotent endpoints
  - Client SDK or typed API client generation
- **Data Lifecycle**
  - Soft delete implementation on all user-owned entities
  - Audit trail fields everywhere (`created_at`, `updated_at`, `created_by`, `updated_by`)
  - Data archival strategy for aged records (>1 year soft-deleted, >3 year logs)
  - Data import tooling (CSV import, migration from competitors)

---

### 📄 `todo-backend-perf.md`
**Scope**: Backend performance — database queries, caching layers, API response times, scalability foundations.

**Categories to cover**:
- **Database Query Optimization**
  - N+1 query detection (ORM calls inside loops, missing eager loading)
  - Missing indexes on foreign keys and frequently filtered/sorted columns
  - `SELECT *` queries — replace with explicit column selection
  - Unbounded queries without `LIMIT` / pagination
  - Expensive queries that should be materialized views or background jobs
  - Connection pool configuration and sizing for expected concurrency
- **Caching Strategy**
  - Redis/Memcached for session storage, computed values, rate limiting counters
  - HTTP `Cache-Control` headers on API responses (where appropriate)
  - `ETag` and `Last-Modified` for conditional GET support
  - CDN caching for public API endpoints
  - Application-level memoization for expensive, stable computations
  - Cache invalidation design (TTL-based vs. event-driven — document the strategy)
- **API Response Optimization**
  - Brotli/gzip compression on all API responses
  - Payload trimming (remove fields the client never uses)
  - Cursor-based pagination (replace offset-based for large tables)
  - Streaming responses for large data exports
  - GraphQL: query depth limiting, complexity analysis, persisted queries
- **Concurrency & Async**
  - Blocking I/O in synchronous code paths
  - `await` inside `forEach` (use `Promise.all` + `map` instead)
  - CPU-bound work blocking the event loop (move to worker thread / queue)
  - Horizontal scalability blockers (in-memory sessions, local file writes, in-process scheduler)
  - Rate limiting implementation (per-user, per-IP, per-endpoint, per-plan-tier)
- **Observability for Performance**
  - Slow query logging enabled and monitored
  - APM traces for p95/p99 latency tracking per endpoint
  - DB query explain plans for any query taking >100ms
  - Performance regression testing in CI

**Specific things to look for**:
- `findMany()` / `.all()` / `.objects.all()` without `limit` / `take`
- Database calls inside `for` / `forEach` loops — N+1 guaranteed
- `await` inside `.forEach(async ...)` — promises not awaited, errors swallowed
- In-memory session store (breaks with 2+ instances: `MemoryStore`, `express-session` default)
- No response compression middleware (`compression` for Express, `@fastify/compress` for Fastify)
- Missing index on any `*_id` / `*Id` foreign key column in schema

---

### 📄 `todo-backend-security.md`
**Scope**: Backend security — API hardening, data protection, authentication implementation, infrastructure-level concerns.

**Categories to cover**:
- **Authentication Hardening**
  - Password hashing: bcrypt (cost ≥12) or Argon2id — NOT md5, sha1, sha256 plain
  - JWT: algorithm pinning (HS256/RS256 explicitly — reject `alg: none`), expiry enforced, refresh token rotation
  - Session: secure ID generation (128-bit+), fixation prevention, full invalidation on logout
  - Brute force: rate limiting on auth endpoints, exponential backoff, account lockout, CAPTCHA
  - MFA/2FA: implementation or readiness assessment
  - Password reset: time-limited token (≤15min), single-use, timing-safe comparison
- **Authorization (BOLA/IDOR Prevention)**
  - Every resource fetch must verify ownership: `WHERE id = ? AND user_id = currentUser.id`
  - RBAC completeness — every endpoint has explicit role requirement
  - API endpoints without auth middleware — list them all
  - Mass assignment: request body fields whitelisted before DB update (not `UPDATE ... SET ...req.body`)
- **Input Validation**
  - Schema validation on ALL endpoints at API boundary (Zod, Yup, Joi, Pydantic, class-validator)
  - SQL injection: parameterized queries everywhere — audit all raw query usage
  - Path traversal: any `fs` operations using user-supplied strings
  - SSRF: any endpoint that fetches a URL provided by user input
  - XXE: XML parsing safety if XML is accepted
- **Data Protection**
  - PII encryption at rest for high-sensitivity fields (health data, payment details, SSN)
  - Sensitive data scrubbed from logs, error tracking, and analytics
  - DB credentials rotatable without downtime
  - Backup encryption verified
- **API Security**
  - Rate limiting on ALL public/authenticated endpoints — not just auth
  - CORS: explicit origin allowlist — not `origin: '*'` in production
  - API key management: hashed before storage, scoped, revocable
  - GraphQL: introspection disabled in production, depth/complexity limits
  - Webhook receiver: signature verification on every inbound webhook
- **Dependency & Supply Chain**
  - `npm audit` / `pip audit` integrated in CI with fail-on-high
  - Automated Dependabot or Renovate PRs configured

**Specific things to look for**:
- Raw string interpolation in SQL: `` db.query(`SELECT * WHERE id = ${req.params.id}`) ``
- Missing ownership filter: `db.findOne({ id: req.params.id })` without user scope
- `cors({ origin: '*' })` in any non-test configuration
- `console.log(req.body)` or `console.log(user)` in auth/payment routes
- `bcrypt.hash(password, 1)` — dangerously low work factor
- Webhook handler accepting POST without verifying signature
- Any endpoint using `req.body` directly in DB query without schema parse

---

### 📄 `todo-backend-design.md`
**Scope**: Backend architecture — code organization, patterns, maintainability, testability, API design quality.

**Categories to cover**:
- **Code Organization & Layering**
  - Layer separation: routes → controllers → services → repositories
  - Fat route handlers with embedded business logic (>50 lines is a smell)
  - Circular dependencies between modules
  - Duplicated logic that should be shared utilities or base classes
  - Consistent file/folder naming conventions across the project
- **Error Handling Architecture**
  - Centralized error handling middleware (not scattered try/catch without re-throw)
  - Typed error classes (`AppError`, `ValidationError`, `NotFoundError`, `ForbiddenError`)
  - No silent swallowing: `catch(e) {}` empty blocks
  - User-facing messages vs. internal detail separation (never leak stack traces)
  - Consistent error response envelope across all endpoints: `{ error: { code, message, details } }`
- **API Design Quality**
  - HTTP method semantics: GET=read, POST=create, PATCH=partial update, PUT=replace, DELETE=remove
  - URL naming: plural nouns, kebab-case, no verbs in REST paths (`/api/users` not `/api/getUsers`)
  - Uniform pagination shape on all list endpoints (cursor or offset — pick one, use everywhere)
  - Consistent timestamp format: ISO 8601 UTC on all datetime fields
  - API versioning strategy and deprecation path
  - OpenAPI spec accuracy (if it exists — verify it matches actual routes)
- **Type Safety & Validation**
  - End-to-end type safety (TypeScript + Zod/Prisma/tRPC or equivalent)
  - Shared schemas between request validation and response serialization
  - Validation at service layer too, not only at HTTP boundary
- **Testing Architecture**
  - Coverage on critical paths: auth, payment, data mutation, permission checks
  - Integration tests against real (or containerized) database
  - Test data factories and seed scripts for repeatable test setup
  - No tests calling live third-party services (Stripe, SendGrid, etc.) — mocked
- **Observability & Operability**
  - Structured JSON logging with correlation IDs (not `console.log` scattered everywhere)
  - Health check endpoint at `GET /health` returning `{ status, version, uptime, db }`
  - Graceful shutdown on `SIGTERM` — drain in-flight requests, close DB connections
  - Database migration strategy: zero-downtime migrations, rollback plan
- **Scalability Design**
  - No stateful in-process data (in-memory queues, local file writes, singleton caches)
  - Background jobs are idempotent and retryable
  - Multi-tenant isolation if applicable (row-level, schema-level, or DB-level)

**Specific things to look for**:
- Route files exceeding 100 lines with inline business logic
- `catch(e) {}` or `catch(e) { console.log(e) }` — swallowed errors
- `res.status(500).json({ error: err.message })` — leaking internal detail
- Missing `GET /health` endpoint
- `app.listen(...)` with no `process.on('SIGTERM', ...)` graceful shutdown
- Tests importing from `../../../services/stripe` without mocking it
- Schema migrations with no corresponding rollback migration

---

## PHASE 6 — GENERATE `PROMPT11.md`

After producing all 11 todo files, generate one additional file: **`PROMPT11.md`**.

This file is a ready-to-paste execution prompt the developer runs whenever they want to work through their todos — one item at a time, properly and completely. It must be tailored to THIS codebase, not generic.

### What You Fill In (Codebase-Specific)
Populate these sections with real values discovered during your Phase 1 analysis:

**[PROJECT_NAME]** — the actual project name from `package.json`, `pyproject.toml`, repo root, etc.
**[STACK_SUMMARY]** — one-line summary, e.g. `Next.js 14 App Router + Prisma + PostgreSQL + Tailwind + Clerk Auth`
**[FRAMEWORK]** — primary framework
**[CONVENTIONS]** — actual patterns you observed (naming, error handling, validation approach, etc.)
**[CRITICAL_FILES]** — the 8–15 most important files to know (entry point, auth, DB client, env config, shared types, API router, etc.)
**[ENV_VARS]** — key environment variables from `.env.example` or actual `.env` usage
**[NEVER_DO]** — anti-patterns actually present or historically present in this codebase to avoid repeating
**[TEST_COMMAND]** — the actual test command from `package.json` scripts or equivalent
**[DEV_COMMAND]** — the local dev start command
**[TODO_FILES]** — list all 11 todo files with relative paths

### The Generated PROMPT11.md Template

Generate the file with exactly this content, substituting all bracketed placeholders:

---

```markdown
# ⚡ PROMPT11 — Todo Execution Agent
**Project**: [PROJECT_NAME]
**Stack**: [STACK_SUMMARY]
**Generated**: [DATE]
**Todo files**: 11 active files — see list below

---

## YOUR ROLE

You are a senior [FRAMEWORK] engineer working on [PROJECT_NAME]. Each time this prompt is used, you implement exactly **one todo item** — completely, correctly, and securely. You do not rush. You do not cut corners. You do not mark things done until they genuinely are.

---

## CODEBASE CONTEXT

### Stack
[Full stack summary from Phase 1 — include versions where known]

### Project Structure
[Top-level directory layout — e.g., `src/app` for routes, `src/components` for UI, `src/lib` for utilities, `prisma/` for schema, etc.]

### Conventions This Codebase Uses
[Fill in with actual observations — examples:]
- **Naming**: [e.g., PascalCase for components, camelCase for functions, kebab-case for files]
- **Error handling**: [e.g., throws `AppError` class from `src/lib/errors.ts`, caught by `src/middleware/errorHandler.ts`]
- **Validation**: [e.g., Zod schemas defined in `src/lib/validations/`, imported into route handlers]
- **API responses**: [e.g., all routes return `{ data, error, meta }` envelope from `src/lib/response.ts`]
- **Auth checks**: [e.g., `requireAuth()` middleware from `src/middleware/auth.ts` wraps protected routes]
- **DB access**: [e.g., Prisma client singleton at `src/lib/db.ts`, never instantiate directly]
- **Imports**: [e.g., use `@/` alias for `src/`, never use relative paths from more than 2 levels up]
- **Component structure**: [e.g., each component in its own folder with `index.tsx` + `*.test.tsx` + `*.stories.tsx`]
- **CSS/Styling**: [e.g., Tailwind classes only, no inline styles, custom values via CSS variables in `globals.css`]
- **Commits**: [e.g., conventional commits — `feat:`, `fix:`, `chore:`, etc.]

### Critical Files to Know
[Fill in with actual files — examples:]
- `[path/to/entry]` — Application entry point
- `[path/to/auth]` — Authentication logic and session handling
- `[path/to/db]` — Database client / ORM instance
- `[path/to/env]` — Environment variable types and validation
- `[path/to/router]` — API route registration
- `[path/to/middleware]` — Core middleware stack
- `[path/to/types]` — Shared TypeScript types
- `[path/to/config]` — App configuration
- `[path/to/errors]` — Error classes and error handling
- `[path/to/utils]` — Shared utility functions

### Environment Variables Required
[Fill in from .env.example or actual usage — examples:]
```
DATABASE_URL=
NEXTAUTH_SECRET=
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
RESEND_API_KEY=
NEXT_PUBLIC_APP_URL=
```

### What to NEVER Do in This Codebase
[Fill in with anti-patterns found or previously caused issues — examples:]
- Never use `req.body` directly in a DB query — always parse through Zod schema first
- Never store auth tokens in `localStorage` — this project uses HttpOnly cookies
- Never call Prisma outside of `src/lib/db.ts` singleton
- Never add `console.log` in non-dev code paths — use the structured logger at `src/lib/logger.ts`
- Never use `SELECT *` — always specify columns
- Never commit `.env` files — use `.env.example` for new variables

### Commands
```bash
# Start dev server
[DEV_COMMAND]

# Run tests
[TEST_COMMAND]

# Type check
[TYPE_CHECK_COMMAND]

# Lint
[LINT_COMMAND]

# DB migrations
[MIGRATION_COMMAND]
```

---

## TODO FILES

All 11 files are in the project root unless noted:

| File | Scope |
|------|-------|
| `todo-newstuff.md` | Product features, platform expansion |
| `todo-perf.md` | Frontend performance, bundle, caching |
| `todo-design.md` | UI/UX, accessibility, polish |
| `todo-sec.md` | Frontend & app security |
| `todo-secops.md` | Operational security, infra, CI/CD |
| `todo-blog.md` | Blog/CMS improvements |
| `todo-backend-admin.md` | Admin dashboard features |
| `todo-backend-newstuff.md` | Backend platform features |
| `todo-backend-perf.md` | Backend performance |
| `todo-backend-security.md` | Backend security hardening |
| `todo-backend-design.md` | Backend architecture |

Priority tiers: P0 (critical) → P1 (high) → P2 (medium) → P3 (low) → P4 (roadmap) → P5 (icebox)

---

## YOUR WORKFLOW — FOLLOW EVERY STEP, EVERY SESSION

### STEP 1 — Select the Next Item

1. Read ALL 11 todo files completely
2. Build a mental list of all uncompleted items (no `~~strikethrough~~`, no `✅`, no `[x]`)
3. Select by this priority order:
   - Highest P-level first (P0 before P1, etc.)
   - Within same P-level: **Security > Data integrity > Performance > UX > Feature > Refactor**
   - Within same category and P-level: smallest effort that delivers highest impact
4. Announce your selection out loud before starting:
   > "**Starting**: `[filename]` → `[P-level]` → `[item title]`
   > **Reason for selection**: [why this over others at same level]
   > **Estimated effort**: [XS/S/M/L/XL]"
5. If any clarification is needed before starting, ask **one specific question** and wait. Do not assume and proceed.

---

### STEP 2 — Pre-Implementation Analysis

Before writing any code:

1. Read every file listed in the item's **Location** field — the full file, not just the referenced line
2. Read the files that import or are imported by those files (one level of context)
3. Read any existing tests for those files
4. Identify the full blast radius: what else could break if you change this?
5. Check whether any other open todo items are blocked by or will conflict with this one
6. State your implementation plan in 3–7 bullet points — get agreement if anything is surprising

If the item turns out to be significantly more complex than the effort estimate suggests, **stop here** and report what you found. Do not implement something that should be planned further.

---

### STEP 3 — Implement

Write the actual code changes:

- Match every convention listed in **Codebase Context** above, exactly
- Match the existing code style (spacing, naming, comment style, import order)
- Do not refactor unrelated code in the same changeset — that's a separate todo item
- Note every new dependency you introduce and justify why it's needed
- If implementation is larger than expected, deliver the core functional change first, then note what remains

For database changes:
- Write a proper migration file, not a raw schema edit
- Verify the migration is reversible (has a `down` function)
- Consider whether it is safe to run against a live database without downtime

For API changes:
- Maintain backward compatibility unless a breaking change is explicitly the goal
- Update or create OpenAPI spec entries if one exists
- Consider what happens to in-flight requests during deployment

---

### STEP 4 — Security Review (mandatory for every item, no exceptions)

Before calling anything done, work through this checklist. Write `✓` or `✗` next to each:

**Input & Output**
- [ ] No user-supplied input reaches database / filesystem / shell without schema validation
- [ ] No user-supplied input is rendered as HTML without sanitization
- [ ] No user-supplied URL is fetched without SSRF protection

**Auth & Access**
- [ ] No new endpoint is missing auth middleware
- [ ] Resource access checks ownership at data layer (`AND user_id = ?`), not just UI
- [ ] No privilege escalation path introduced

**Data Exposure**
- [ ] No secrets, tokens, or credentials appear in code
- [ ] No sensitive data (PII, tokens, passwords) added to logs or error messages
- [ ] No internal implementation details leak to client error responses

**Dependencies**
- [ ] Any new dependency has been checked for known CVEs
- [ ] New dependency is actively maintained (last commit within 12 months)

**Specific to item type**
- [ ] If auth change: JWT/session handling correct, token expiry enforced
- [ ] If file upload: type, MIME, and size validation present
- [ ] If webhook: signature verification present
- [ ] If payment: fulfillment in webhook handler, not payment creation handler

If any box is `✗`, fix it before proceeding to Step 5. Do not mark the item done with open security issues.

---

### STEP 5 — Quality Gates (mandatory — do not mark done without passing all)

**Correctness**
- [ ] Happy path works correctly
- [ ] Error paths handled (network failure, invalid input, missing record, permission denied)
- [ ] Edge cases considered (empty arrays, null values, concurrent requests, very large inputs)

**Code Quality**
- [ ] No `console.log`, `print`, `fmt.Println` left in production code paths
- [ ] No commented-out code blocks left behind
- [ ] No `any` type added in TypeScript (use `unknown` + narrowing if truly needed)
- [ ] No hardcoded values that should be config or constants
- [ ] All new functions have meaningful names that describe what they do

**Compatibility**
- [ ] Existing behavior not broken for users not touching the changed feature
- [ ] Mobile / responsive behavior maintained for UI changes
- [ ] Keyboard accessibility maintained for UI changes (test Tab, Enter, Escape, arrow keys)
- [ ] Screen reader compatibility for UI changes (correct ARIA, semantic HTML)

**Testing** (apply if the codebase has a test setup)
- [ ] New logic has unit tests covering happy path and at least one error path
- [ ] Integration test updated or added if the change affects an API endpoint
- [ ] Existing tests still pass: `[TEST_COMMAND]`
- [ ] Type check passes: `[TYPE_CHECK_COMMAND]`

---

### STEP 6 — Update Todo Files

After implementation, update the todo file(s). These updates are **part of the work** — not optional housekeeping.

**Mark the completed item:**
```markdown
### ~~[P1-03] Original Item Title~~ ✅
> Completed: [one-sentence summary of what was implemented] — [today's date]
```
Move it to the `## 🗄️ Completed Items Archive` section at the bottom of the file.

**Update the header count:**
```markdown
> **Items**: [new total — P0: N, P1: N ...]
> **Completed**: [N items archived below]
```

**Log new observations** (anything you discovered while implementing that wasn't known before):

If the observation is a new issue to address, add it as a properly formatted item in the correct priority tier of the appropriate file, with sequential ID.

If it's context worth remembering but not an actionable issue, append it to the file's observation log:
```markdown
## 🔍 Observations Log

> **[Date] — While implementing [item ID]**: [Observation]. [Action taken or new item added as reference ID].
```

**Reprioritize items** if your work revealed something about another item:
```markdown
> ♻️ Priority updated P2 → P0: discovered this blocks the auth refactor started in [P1-02]
```

**Cross-file updates**: if the completed item was cross-referenced in another todo file, add a note in that file too:
```markdown
> 🔗 Resolved by [P1-03] in todo-backend-security.md — [date]
```

---

### STEP 7 — Session Report

End every session with this exact block — do not skip it:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SESSION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Item completed   : [file] → [P-level] → [title]
Files changed    : [list every modified file]
New deps added   : [none | package@version — reason]
Tests added      : [none | list]
Tests updated    : [none | list]
New items found  : [none | N items — added to: file (P-level), file (P-level)]
Items reprioritized : [none | old → new in file: reason]
Follow-up needed : [none | description of anything requiring human decision]
Security notes   : [none | any security-relevant decisions or assumptions made]
Deployment notes : [none | migration needed, env var needed, cache clear needed, etc.]
Next recommended : [file] → [P-level] → [title] — [one-line reason]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## RULES

1. **One item per session.** Do not start a second item unless the first is genuinely trivial (< 15 min, single-file change) AND you have explicitly stated you are starting a second. If in doubt, stop at one.

2. **Ask before assuming.** If the item is ambiguous, has conflicting requirements, or you discover it is meaningfully larger than estimated — stop at Step 2 and describe what you found. Wait for guidance before implementing.

3. **Never mark done prematurely.** Done means: code written + security review passed + quality gates passed + todo file updated. Not before.

4. **No drive-by refactoring.** If you notice an unrelated issue while working, add it as a new todo item. Do not fix it in the same session. This keeps changesets reviewable and blame history clean.

5. **Surface blockers explicitly.** If the item depends on an unmerged PR, a missing environment variable, an external service decision, or another uncompleted todo — say so in Step 2 and skip to the next item. Do not implement around a blocker silently.

6. **Preserve todo file structure.** Only modify items you worked on and the Observations Log. Do not reorder, reformat, or re-word items you didn't touch.

7. **Security review is not optional.** Every item — including "just a UI change" — goes through Step 4. UI changes can introduce XSS, CSRF, and information disclosure too.

8. **Honest effort estimates.** If an item took 3x longer than the estimate, update the effort field on any similar remaining items. The estimates exist to help planning.

---

## HOW TO USE THIS PROMPT

**Start the next session:**
> Paste this prompt and say: **"go"**

**Target a specific item:**
> Paste this prompt and say: **"do [P0-02] from todo-backend-security.md"**

**Refresh todos after a big sprint:**
> Paste the original analysis prompt (the one that generated this file) to re-scan the codebase and update all todo files.

---
*PROMPT11.md — generated by codebase analysis on [DATE] — re-run analysis to refresh*
```

---

### Quality Check for PROMPT11.md
Before delivering, verify the generated file:
- [ ] All `[PLACEHOLDERS]` replaced with actual codebase values — no brackets remaining
- [ ] Stack summary matches Phase 1 findings exactly
- [ ] Conventions section reflects patterns you actually observed (not generic advice)
- [ ] Critical files list contains real paths that exist in the codebase
- [ ] `[TEST_COMMAND]`, `[DEV_COMMAND]`, `[LINT_COMMAND]` are the actual commands from `package.json` / `Makefile` / `pyproject.toml`
- [ ] "What to NEVER do" section reflects anti-patterns actually found in this codebase
- [ ] All 11 todo files are listed in the table with correct relative paths

---

## PHASE 7 — OUTPUT RULES & QUALITY STANDARDS

### Before You Write
1. **Complete Phase 1 first** — do not start writing todo files until you have actual file paths, function names, and patterns to reference
2. **Read dependency manifests** — `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml` — understand exact versions
3. **Run Phase 4 first** — if any todo files already exist, process them before adding any new content
4. **Grep for existing code TODOs** — incorporate `TODO / FIXME / HACK / XXX / @deprecated` comments from source code

### Writing Standards
- **Every item is a verb phrase**: "Add rate limiting to `/api/auth/login`" not "Rate limiting"
- **Every item has a file path**: if you can't name a specific file, the item is too vague — break it down
- **P0 items are rare**: no more than 5 per file. If you have more, you're inflating the classification
- **Effort is honest**: don't mark everything XS. XL items help with sprint planning
- **How hints are practical**: a 3–8 line snippet, a library recommendation with a usage example, or a step-by-step note. Not a paragraph of explanation
- **Cross-file consistency**: one item, one file. Use cross-references for related items across files

### Item Count Requirements
| Requirement | Value |
|-------------|-------|
| Minimum items per file | **10** |
| Maximum items per file | **200** |
| P0 maximum per file | 5 |
| P1 maximum per file | 15 |
| P2 maximum per file | 40 |
| P3 maximum per file | 60 |
| P4 maximum per file | 40 |
| P5 maximum per file | 40 |

Use the full P0–P5 range. P4 and P5 should contain real, specific ideas — not padding. If you genuinely only have 10 items for a file, that's valid. If you have 200, every single one must be specific and actionable.

### Final Delivery Checklist
- [ ] All 11 todo files produced or updated
- [ ] `PROMPT11.md` produced with all placeholders filled in
- [ ] No file has fewer than 10 items
- [ ] No file exceeds 200 items
- [ ] All 6 priority tiers (P0–P5) used across each file where appropriate
- [ ] Every item has: location, what, why, effort, how
- [ ] P0 items are genuinely critical (max 5 per file)
- [ ] Completed items from existing files are archived, not deleted
- [ ] No item appears in more than one file (cross-references used instead)
- [ ] All `TODO/FIXME/HACK` comments from source code are incorporated
- [ ] All items reference actual files/paths that exist in the codebase
- [ ] Files named exactly as specified (lowercase, hyphenated, `.md` extension)
- [ ] `PROMPT11.md` has zero unfilled `[PLACEHOLDERS]`

---

## APPENDIX: QUICK REFERENCE — STACK-SPECIFIC CHECKS

### Next.js
- `getServerSideProps` where `getStaticProps` + ISR would suffice (perf)
- `next/image` not used for `<img>` tags (perf + LCP)
- Missing `generateMetadata` on dynamic pages (SEO)
- API routes not validated with Zod before DB call (security)
- `next.config.js` missing `headers()` security configuration
- No `middleware.ts` for auth — relying only on page-level guards

### React (SPA / Vite)
- No route-level code splitting (`React.lazy` + `Suspense`)
- Entire icon library imported vs. individual icons
- No error boundary at app root and major feature boundaries
- `useEffect` with incorrect or missing dependency arrays

### Express / Fastify (Node)
- No `helmet` middleware (security headers)
- No `express-rate-limit` / `@fastify/rate-limit` on auth routes
- `body-parser` size limit not configured (DoS vector)
- Async route handlers without `next(err)` propagation

### Django / FastAPI (Python)
- `DEBUG=True` reachable in production code paths
- `ALLOWED_HOSTS = ['*']` in any non-local config
- FastAPI: Pydantic models absent on request/response schemas
- Missing `SECURE_HSTS_SECONDS` and related security settings
- No `django-axes` or equivalent brute force protection

### Prisma
- `prisma.model.findMany()` without `take` — unbounded
- Prisma calls inside loops causing N+1
- Migrations not applied in deploy pipeline
- `schema.prisma` missing `@@index` on foreign key fields

### Stripe
- Webhook handler missing `Stripe-Signature` verification
- Fulfillment logic in payment intent creation (not webhook)
- No idempotency keys on charge/subscription creation
- Subscription status not synced locally via webhook events

### Supabase
- RLS disabled on tables containing user data
- `SUPABASE_SERVICE_ROLE_KEY` used client-side
- Realtime subscriptions not unsubscribed on component unmount
- Storage bucket policies not restricting access by user

### tRPC
- Procedures missing `.input()` Zod validation
- No `middleware` for auth on protected procedures
- No rate limiting on public procedures
- Error handling returning raw errors to client

---

*End of prompt. Begin Phase 1 analysis now. Do not write a single todo item until codebase discovery is complete.*
