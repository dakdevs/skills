# Factor III — Config

> **Rule:** Store config in the environment.

## The principle

**Config is everything that varies between deploys.** Database URLs, API keys, third-party credentials, hostnames, feature flags that differ per environment. It must live *outside the codebase*, injected via environment variables at runtime.

What is **not** config: internal app wiring (Rails routes, Spring bean graph, framework configuration that is identical across all deploys). That belongs in code.

## Why this exists

Config and code change at different rates and for different reasons. Mixing them creates two failure modes:

1. **Credential leaks.** If config lives in code, sooner or later a secret gets committed.
2. **Combinatorial sprawl.** "We have a `dev_config.yml`, a `staging_config.yml`, a `prod_config.yml`, a `prod_eu_config.yml`..." Each new deploy demands a new file. Each file diverges. New deploys take forever to spin up.

Environment variables are language-agnostic, OS-agnostic, granular (each var is independent), and trivially per-deploy.

## The litmus test

> Could this codebase be open-sourced *right now* without leaking a single credential?

If no, config has leaked into code. Fix it.

## Compliance

- **Secrets in env vars**, sourced from a secret manager (Vault, AWS Secrets Manager, GCP Secret Manager, Doppler, 1Password Connect) at deploy time.
- **No `.env` files in production**, and `.env` always in `.gitignore`. `.env.example` (with placeholders, no real values) is fine and recommended.
- **One variable per setting.** Don't ship a single `CONFIG_BLOB` JSON env var — defeats granularity.
- **No environment groupings in code.** Don't write `if env == "production"`; instead read individual vars (`DATABASE_URL`, `LOG_LEVEL`).

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| `config/secrets.yml` checked into repo | Credential leak waiting to happen |
| `config.production.js`, `config.staging.js` | Combinatorial sprawl; can't add a new deploy without code change |
| `if NODE_ENV === 'production'` branching everywhere | Behavior should be driven by individual config vars, not a magic env name |
| `.env.production` in repo (even if gitignored locally — someone will commit it) | Secrets in git history. Use a secret manager |
| Hard-coded `localhost:5432` "for now" | Will ship to prod that way |
| Reading config from `etc/myapp.conf` on disk | OS-specific, fragile, hard to inject in containers |

## Modern interpretation

- **Kubernetes:** ConfigMap (non-secret) + Secret (secret), mounted as env vars → f03-compliant. Mounted as files is acceptable but env-var injection is the cleaner contract.
- **Vault / AWS Secrets Manager:** Inject at deploy/start time as env vars. The secret manager is *not* the violation; sourcing config from it into env is the modern f03 pattern.
- **dotenv in development:** Fine for local dev. Production should never load a `.env` file from disk — env should come from the orchestrator.
- **`NODE_ENV` is allowed** as a coarse signal that affects build-time choices (minification, source maps), but should not gate runtime behavior — that needs individual flags.
- **Feature flags (LaunchDarkly, Unleash, Flagsmith):** Strictly speaking these are dynamic config, fetched at runtime, not env. The principle holds — config is not code — but the delivery mechanism differs. Treat the flag SDK config (API key, endpoint) as f03 env vars.

## Quick check

> "If I rotate a database password, can I deploy the new value without a code change, a new build, or a config-file edit?"

Yes → compliant.
