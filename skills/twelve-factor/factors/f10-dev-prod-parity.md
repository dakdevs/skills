# Factor X — Dev/Prod Parity

> **Rule:** Keep development, staging, and production as similar as possible.

## The principle

Three classic gaps to close:

| Gap | Traditional | 12-factor |
|-----|-------------|-----------|
| **Time** | Code reaches prod in days/weeks | Hours or minutes |
| **Personnel** | Devs write code, ops deploys | Devs deploy what they wrote |
| **Tools** | Nginx/SQLite/macOS dev, Apache/MySQL/Linux prod | Same stack everywhere |

Of these, **the tools gap is the biggest landmine** — especially for backing services.

## Why this exists

The whole point of testing is that "passing in dev" predicts "passing in prod." Every divergence between environments breaks that prediction. Subtle SQL dialect differences, file system case sensitivity, timezone defaults, JSON serialization quirks — they ship as bugs the first time the prod-only edge case hits.

Closing the time and personnel gaps is what continuous deployment *is*. Without parity, CD is unsafe.

## Compliance

- **Same backing service engines** in dev as prod. Postgres in dev, Postgres in prod. Redis in dev, Redis in prod. Don't substitute.
- **Same OS family** if at all possible. Linux container locally, Linux container in prod.
- **Same versions** of language runtime, libraries, OS. Pin via lockfiles + container base images.
- **Devs deploy.** Devs are on the rotation. Devs see their own prod errors.
- **Continuous deployment** of every merge to main, gated by tests + maybe a manual prod approval. The dev → prod loop is hours, not weeks.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| SQLite in dev, Postgres in prod | Different SQL dialects; transactions, constraints, JSON support differ |
| MySQL 5.7 in dev, MySQL 8.0 in prod | Auth changes, default charset changes, GROUP BY behavior differences |
| In-memory cache in dev, Memcached in prod | Different eviction, different serialization, different concurrency model |
| Local file system for uploads in dev, S3 in prod | Path semantics, atomicity, eventual consistency all differ |
| `/etc/hosts`-driven dev URLs vs real DNS in prod | Dev never exercises real DNS / TLS / cert flows |
| "Works on my Mac" — Linux-only library quirks not caught | Container or Linux VM in dev solves this |
| Different timezone or locale on dev box | `Date.now()` and string formatting drift silently |

## Modern interpretation

- **Containers + docker-compose for local dev** is the canonical f10 solution. Run the same Postgres image locally as in prod.
- **Devcontainers / Codespaces / Gitpod:** prebuilt dev environment matching prod runtimes.
- **Tilt / Skaffold / Garden:** local Kubernetes loops that mirror prod manifests.
- **Ephemeral preview environments per PR:** stronger parity than long-lived staging — a fresh prod-shaped env per branch.
- **Managed-service local stand-ins (LocalStack, Stripe CLI mocks, Mailtrap):** Reasonable when running the real third-party in dev is impossible. Treat them as known-leaky and verify in a staging environment that *does* hit the real service.
- **Staging that diverges from prod is worse than no staging.** A "staging" that always lags or differs trains the team to ignore staging signals.

## Quick check

> "If I diff `dev` and `prod` configs, the only differences are hostnames, credentials, and resource sizes. The engines and versions are identical."

Yes → compliant.

> "How long from `git push` to running in prod? Hours? → ✅. Weeks? → ❌."

> "Have I, the developer who wrote the code, ever responded to a production alert for it?"

Yes → personnel gap closed.
