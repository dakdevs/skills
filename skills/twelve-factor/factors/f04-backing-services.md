# Factor IV — Backing Services

> **Rule:** Treat backing services as attached resources.

## The principle

A **backing service** is anything the app talks to over the network: databases (Postgres, MySQL, Mongo), queues (RabbitMQ, SQS, Kafka), caches (Redis, Memcached), mail (SMTP, SES, Postmark), object storage (S3, GCS), external APIs (Stripe, Twilio, Google Maps), observability (Datadog, Sentry).

The app should make **no distinction** between a service it runs locally and one it consumes from a third party. Both are *attached resources*, addressed by a URL or connection string supplied via config (f03).

## Why this exists

Operational flexibility. When the database is dying, you need to repoint the app at a replica with a config change — not a code change, build, and redeploy. When you outgrow self-hosted Postgres and move to RDS, no code should change. When you swap Postmark for SES, no code should change.

If the app's code embeds knowledge of *which* database it's talking to (vs just "the database at this URL"), every infra change becomes an engineering project.

## Compliance

- Connection strings / URLs come from env (f03).
- Code accepts a URL and connects. It does not branch on hostname or provider.
- Each distinct resource is its own URL. Two databases for sharding = `DATABASE_URL_SHARD_A` + `DATABASE_URL_SHARD_B`, not a single shared connection pool with hard-coded shard logic.
- Failover, rotation, and migration happen by changing the URL and restarting (or signal-reload) — no code deploy.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| `if isProduction: connect to RDS else: connect to local SQLite` | Different driver, different SQL dialect, different bugs (also violates f10) |
| Hard-coded `s3.amazonaws.com` URL | Can't swap to MinIO/GCS/local; can't even test against a stub |
| Postmark-specific email code, parallel SES-specific email code, gated by env | Should be one SMTP/HTTP-API client behind one config'd endpoint |
| App initiates its own database — runs `pg_ctl start` from boot script | Backing services are attached, not started by the app |
| Library imports tied to a specific provider (`require 'aws-sdk'` everywhere for what should be S3-compatible storage) | Use a provider-agnostic interface where possible |

## Modern interpretation

- **Service binding (CloudFoundry, K8s ServiceBindings):** Standardized way to inject backing-service credentials as env vars. Fully f04-compliant.
- **Vendor SDKs are okay** for behaviors that are genuinely vendor-specific (S3 multipart upload semantics differ from GCS). The factor is about *how the app is wired*, not avoiding all SDK use.
- **Sidecars (Envoy, Istio):** A sidecar that proxies to a backing service is a backing service from the app's perspective. The app talks to `localhost:1234`, the sidecar handles the rest. f04-compliant.
- **Managed service migrations:** RDS → Aurora → Neon → some new thing. The point of f04 is that this is a config change, not a code project.

## Quick check

> "If I gave you a different `DATABASE_URL` (same engine, different host) right now, would the app run unchanged?"

Yes → compliant.

> "Could I run this app locally against `docker run postgres` with one env var change?"

Yes → compliant.
