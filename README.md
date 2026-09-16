# GetPaid — invoices that chase themselves

Freelancers lose money to silence: the invoice goes out, the client goes
quiet, and the follow-up never happens. GetPaid watches every invoice,
reminds, escalates, and reconciles — the freelancer just gets paid.

Built with **Flutter** (app + web) and **Serverpod** (backend, database,
auth, scheduled work) for the *Build Something Real* Serverpod hackathon.

## The loop (90 seconds to understand it)

1. Create an invoice → **Send** → status `sent`, the chase clock starts.
2. Day 3: polite **nudge**. Day 7: **firm** reminder. Day 14: **final
   notice** with late fee. Every touch is logged on the invoice timeline.
3. Client pays → **Mark paid** → receipt (`GP-1-1`) is issued, status
   `paid`, pending chase touches are cancelled. A paying client is never
   dunned.
4. **Judge time-lapse**: `+4 / +8 / +15 days` buttons run the *exact same*
   chase core as the production scheduler, but with a virtual clock — the
   whole 14-day story in seconds, nothing mocked.

## How it uses Serverpod and Flutter

- **Serverpod endpoints** (`getpaid_server/lib/src/billing/`):
  customer/invoice CRUD, `sendInvoice`, `getThread`, `markPaid`,
  `simulate(daysAhead)`.
- **Serverpod future calls**: the real-time chase engine. `sendInvoice`
  schedules three idempotent touches (+3/+7/+14d); `markPaid` cancels
  them. At-least-once delivery is safe by construction (sent tiers are
  never re-sent).
- **Serverpod database**: `Customer`, `Invoice`, `InvoiceItem`,
  `Reminder`, `Payment` tables with migrations. Every query is scoped to
  the caller's auth identity — users can never see each other's invoices.
- **Serverpod auth**: email identity provider (verification code +
  password), JWT sessions. The app boots into a sign-in gate.
- **Flutter**: one codebase — `getpaid_flutter` builds the mobile app and
  the web app. The server serves the web build itself from `/`.

## Run it locally

Requirements: Flutter 3.38+, Dart 3.13+, Docker.

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

```bash
cd smoke && dart pub get
dart authed.dart   # registers 2 users, runs the full loop, proves isolation
```

Expected: both users register, Bob sees 0 of Alice's invoices and is
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
smoke/                   # backend verification scripts (authed.dart)
```

## What was deliberately left out

Real payment rails (mark-paid + receipt; Stripe is the stretch goal),
multi-currency, teams. The smallest complete version of the product.
