# GetPaid — invoices that chase themselves

**Live:** https://getpaid.serverpod.space/ · **Demo video (68s):** [demo-video-getpaid.mp4](./demo-video-getpaid.mp4)
· **Judge login:** `kiter2509@gmail.com` / `Judge-demo-123` (fresh DRAFT invoice waiting, plus one settled invoice showing the full story)

## Thesis

Freelancers don't lose money to unpaid invoices — they lose it to *silence*.
The invoice goes out, the client goes quiet, and the follow-up never happens
because chasing feels awkward, easy to forget, and impossible to scale across
a dozen clients. Existing invoicing tools stop at paperwork: they render the
PDF and wish you luck.

GetPaid's thesis: **the invoice itself should do the chasing.** A freelancer
should be able to press Send once and trust that a polite nudge, a firm
reminder, and a final notice with a late fee will go out on schedule — and
stop the instant money arrives. The product isn't an invoice editor with
reminders bolted on; it's a **chase engine with an invoice attached**.

## The loop (90 seconds)

1. Create an invoice → **Send** → status `sent`, the chase clock starts.
2. Day 3: polite **nudge**. Day 7: **firm** reminder. Day 14: **final notice**
   with late fee. Every touch is logged on the invoice timeline.
3. Client pays → **Mark paid** → receipt (`GP-<invoice>-<n>`) is issued,
   status `paid`, pending chase touches are cancelled. **A paying client is
   never dunned.**
4. **Judge time-lapse**: `+4 / +8 / +15 days` buttons run the *exact same*
   chase core as the production scheduler, but with a virtual clock — the
   whole 14-day story in seconds, nothing mocked.

## How it uses Serverpod and Flutter

- **Serverpod endpoints** (`getpaid_server/lib/src/billing/`):
  customer/invoice CRUD, `sendInvoice`, `getThread`, `markPaid`,
  `simulate(daysAhead)`.
- **Serverpod future calls** — the real-time chase engine. `sendInvoice`
  schedules three idempotent touches (+3/+7/+14d, one scheduled call per
  tier); `markPaid` cancels them. At-least-once delivery is safe by
  construction: sent tiers are never re-sent. The judge time-lapse calls
  the same `runChaseStep(session, now: ...)` core as the production
  scheduler, but with a virtual clock — one code path, two clocks.
- **Serverpod database**: `Customer`, `Invoice`, `InvoiceItem`, `Reminder`,
  `Payment` tables with versioned migrations. Every query is scoped to the
  caller's auth identity — users can never see each other's invoices
  (proven by `smoke/authed.dart`: Bob sees 0 of Alice's invoices and is
  blocked from her thread).
- **Serverpod auth**: email identity provider (verification code +
  password), JWT sessions. The app boots into a sign-in gate. On Serverpod
  Cloud, codes are delivered by the Cloud email service.
- **Serverpod Cloud**: deployed at `getpaid.serverpod.space` (API +
  Insights + web) with managed Postgres. Deploy: `serverpod cloud deploy
  -p getpaid`.
- **Flutter**: one codebase — `getpaid_flutter` builds the mobile app and
  the web app; the server serves the web build itself from `/`. The home
  screen is an outstanding-money dashboard (total, open/overdue counts,
  per-client names); the invoice thread is a timeline where every reminder
  has a copy-to-clipboard button, so a freelancer can paste a chase touch
  into any email client today.

## Vision & roadmap

The hackathon slice proves the loop: send → chase → paid → receipt. What it
becomes:

- **Real delivery rails** — reminders go out as real emails (per-client
  tone settings, reply detection: a client reply pauses the chase and pings
  the freelancer).
- **Real money rails** — Stripe/PayPal links on every touch; `markPaid`
  becomes webhook-confirmed instead of manual.
- **Smart escalation** — per-client payment-history scoring: chronic late
  payers get firmer tiers earlier; reliable ones get gentler treatment.
- **Teams & accountants** — multi-user workspaces, aging reports, export.
- **Mobile** — the same Flutter codebase ships iOS/Android with push on
  every chase event and payment.

Non-goals (deliberately out): multi-currency, invoice design templates,
accounting-suite depth. The wedge is the chase, not the paperwork.

## Run it locally

Requirements: Flutter 3.47+, Dart 3.13+, Docker, Serverpod CLI 4.0.0
(`dart pub global activate serverpod_cli 4.0.0`).

```bash
# 1. Database + cache
cd getpaid_server && docker compose up -d

# 2. Server (applies migrations, API :8080, web :8082)
dart bin/main.dart --apply-migrations

# 3. Web app — build once, copy into the server, restart it.
#    The server serves the app at http://localhost:8082/ :
cd ../getpaid_flutter && flutter build web --release
cp -r build/web/. ../getpaid_server/web/app/
#    then restart the server from step 2
```

Sign up with any email address — in development the verification code is
printed in the server console log (`Registration code for <email>`).

## Prove the backend without the UI

Unit tests live in the repo (chase schedule, escalating copy, identifier
scheme):

```bash
cd getpaid_server && dart test test/chase_logic_test.dart
```

CI (`.github/workflows/tests.yml`) additionally boots Postgres + Redis and
runs the full generated integration suite. Multi-user isolation is proven
there and by `smoke/authed.dart`: Bob sees 0 of Alice's invoices and is
blocked from her thread, Alice's `simulate(15)` fires
`nudge, firm, finalNotice`, payment issues receipt `GP-1-1`.

## Project layout

```
getpaid_server/          # Serverpod backend
  lib/src/billing/       # *.spy.yaml models (one definition per file),
                         # invoice_endpoint.dart, chase_logic.dart (shared
                         # chase core), chase_future_call.dart
  lib/server.dart        # auth (email IdP) + web routes
  migrations/            # versioned schema migrations
  config/development.yaml# external Postgres on :8090 (dataPath off)
getpaid_flutter/         # Flutter app (mobile + web)
  lib/screens/           # invoice_list_screen, invoice_detail_screen (timeline),
                         # sign_in_screen (auth gate)
smoke/                   # backend verification scripts (authed.dart, seed_demo.dart)
```

## What was deliberately left out

Real payment rails (mark-paid + receipt; Stripe is the stretch goal),
real email delivery on the chase touches, multi-currency, teams. The
smallest complete version of the product.
