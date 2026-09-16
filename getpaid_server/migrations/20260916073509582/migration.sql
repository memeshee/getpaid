BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customer" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "company" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invoice" (
    "id" bigserial PRIMARY KEY,
    "number" text NOT NULL,
    "customerId" bigint NOT NULL,
    "amountCents" bigint NOT NULL,
    "currency" text NOT NULL,
    "notes" text,
    "status" text NOT NULL,
    "issueDate" timestamp without time zone NOT NULL,
    "dueDate" timestamp without time zone NOT NULL,
    "sentAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invoice_item" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "description" text NOT NULL,
    "quantity" bigint NOT NULL,
    "unitPriceCents" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "amountCents" bigint NOT NULL,
    "paidAt" timestamp without time zone NOT NULL,
    "method" text,
    "receiptNo" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reminder" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "tier" text NOT NULL,
    "status" text NOT NULL,
    "dueAt" timestamp without time zone NOT NULL,
    "sentAt" timestamp without time zone,
    "subject" text,
    "body" text,
    "simulated" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR getpaid
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('getpaid', '20260916073509582', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916073509582', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
