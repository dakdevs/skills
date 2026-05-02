# Modern Interpretations

The 12 factors were codified in 2011 against Heroku. The principles still hold; the *examples* have aged. This file translates each factor to modern runtimes (Kubernetes, Docker Compose, serverless, managed PaaS) and flags where the original guidance needs adjustment.

## Heroku 2011 → 2026 stack quick map

| 2011 (Heroku) | 2026 (typical) |
|---------------|----------------|
| Procfile | Kubernetes Deployment per process type, or `docker compose` services |
| Dyno | Pod / Container / Function instance |
| Buildpack | Dockerfile / Buildpacks v3 / Nixpacks |
| Heroku Postgres add-on | RDS / Cloud SQL / Neon / Supabase |
| Heroku release | K8s rollout / Helm release / ArgoCD sync |
| Heroku CLI deploy | GitHub Actions → image registry → orchestrator |
| Foreman (local) | docker compose / Tilt / devcontainers |

---

## Per-factor modern context

### f01 Codebase
- **Monorepos are fine.** The factor is about *logical* codebase per app, not physical repo. Bazel/Nx/Turborepo monorepos with multiple deployable apps each satisfy f01.
- **Polyrepos are also fine.**
- **Forks for customers** still violate the factor — use config and feature flags instead.

### f02 Dependencies
- **Containers are partial isolation by default.** A container is the modern `bundle exec`.
- **Lockfiles still essential** — image build must be reproducible.
- **Distroless / scratch base images** are the strongest f02 expression.
- **Vendoring** (Go modules, npm `node_modules`, Cargo `vendor/`) is f02 with belt and suspenders — fully offline reproducibility.
- **Reproducible builds (Nix, Bazel)** are the gold standard.

### f03 Config
- **K8s ConfigMap + Secret mounted as env** = f03-compliant.
- **K8s Secret mounted as file** = acceptable but env-as-string is the cleaner contract.
- **Vault / AWS Secrets Manager / GCP Secret Manager / Doppler** — sourcing config from these into env is the standard modern pattern. The secret manager is *infrastructure*; the env var contract is the f03 part.
- **OIDC-based dynamic credentials** (no static keys at all) is the next evolution — pair with f03 by injecting at runtime.
- **`.env` in development only**, never in production. Production env comes from the orchestrator.
- **Feature-flag SDKs (LaunchDarkly, Unleash, Flagsmith)** — the *flag values* are dynamic config fetched at runtime. The SDK config (API key, endpoint) is still f03 env vars.

### f04 Backing services
- **Service binding (CloudFoundry, K8s ServiceBindings)** — standardized injection. Fully aligned.
- **Sidecars (Envoy, Istio, Cloud SQL Proxy)** — the app talks to `localhost:port`, the sidecar handles the rest. f04-compliant.
- **DBaaS / managed services** — the "attached resource" is just an external URL. The whole point of f04.
- **Vendor SDKs (AWS, GCP)** are fine when behavior is genuinely vendor-specific. The factor is about how you *wire* the resource, not avoiding all vendor knowledge.

### f05 Build, release, run
- **Container image SHA = build ID.**
- **Release = image + ConfigMap/Secret hash.**
- **GitOps (ArgoCD, Flux, Spinnaker)** — Git is the release ledger.
- **Immutable infrastructure** — no SSH-and-edit, ever.
- **Helm releases / kubectl rollouts** are first-class release identifiers; rollback is `helm rollback` / `kubectl rollout undo`.
- **Avoid `:latest` tags in prod manifests.** Pin to digest (`@sha256:...`) for true immutability.

### f06 Processes
- **WebSocket connections are stateful at the network layer; that's fine.** The pub/sub state behind them goes to Redis / NATS / similar — that's the f06 piece.
- **Edge runtimes (Cloudflare Workers, Vercel Edge, Deno Deploy)** are aggressively stateless — KV/Durable Objects are explicit backing services.
- **StatefulSets exist for backing services** (databases, brokers). They are *infrastructure*, not application processes.

### f07 Port binding
- **Containers expose ports**; orchestrator routes. ✅
- **Lambda / Cloud Run / Functions** — no port bound by user code; runtime invokes a function. The *spirit* — self-contained, no external server container required — is satisfied. The platform's invocation is the equivalent of port routing.
- **Service mesh sidecars** bind the public port; app binds an internal port. Still self-contained at the app's port.

### f08 Concurrency
- **One Deployment per process type**, autoscaled independently (HPA, KEDA).
- **Worker queues drive autoscaling** via queue-depth metrics (KEDA, Lambda event source mappings).
- **Goroutines / async / threads** inside one process are intra-process concurrency — orthogonal to f08, use both.
- **Serverless** treats each invocation as ~ a process; concurrency is invocations. Aligned with the spirit.
- **Don't mix process types in one container** unless your orchestrator can launch them as separate workloads.

### f09 Disposability
- **K8s SIGTERM + grace period (default 30s) → SIGKILL.** Use `preStop` hook + readiness flip to drain LB before SIGTERM.
- **Lambda freeze model** — no SIGTERM. Cold-start time *is* the modern disposability metric.
- **Spot / preemptible instances** are economic only if disposability holds.
- **Startup probes** (K8s `startupProbe`) for legitimately slow apps — but treat slow startup as a defect, not a permanent state.
- **Crash-only design** is more relevant than ever — autoscaling kills processes constantly.

### f10 Dev/prod parity
- **docker compose for local backing services** — same image as prod.
- **Devcontainers / Codespaces / Gitpod** for prebuilt parity.
- **Tilt / Skaffold / Garden** for local Kubernetes loops mirroring prod manifests.
- **Ephemeral PR preview environments** > long-lived staging.
- **LocalStack / stripe CLI mocks / Mailtrap** are pragmatic stand-ins for third-party services that can't run locally — treat as known-leaky and verify in a real-service staging.
- **Continuous deployment** is the time-gap closer.

### f11 Logs
- **stdout / stderr** captured by container runtime → kubelet → log shipper → aggregator. f11-native.
- **Structured JSON logs** are the modern default (`pino`, `slog`, `zap`, `structlog`).
- **OpenTelemetry logs** with trace correlation is the modern overlay — emit through stdout, OTel collector handles routing.
- **Sidecar shippers (Fluent Bit, Vector)** or DaemonSets — env handles aggregation.
- **Don't log to external HTTP services from the app** — couples uptime, defeats the spirit.

### f12 Admin processes
- **K8s Jobs** with the same image as the Deployment — canonical f12.
- **Helm hooks (`pre-upgrade`)** for migration jobs at release boundaries.
- **`kubectl exec` is fine for read-only inspection**, not for state-changing operations (no audit trail, divergent process).
- **Lambda one-off invocations / `aws ecs run-task`** for serverless equivalents.
- **CronJobs** for scheduled tasks — same image, same release, same config.

---

## Where 2011 doctrine breaks down

A few places the original guidance needs updating, not just translating:

**1. Serverless inverts some assumptions.**
- f06 (stateless) and f09 (disposable) become *runtime invariants*, not app responsibilities — the platform enforces them.
- f07 (port binding) is satisfied differently — the runtime invokes you.
- Cold start replaces SIGTERM as the disposability concern.

**2. Edge runtimes have no filesystem and tight memory limits.**
- f02 (dependencies) — careful about bundled native binaries; many won't work.
- f06 (statelessness) — easy. KV stores and Durable Objects are explicit backing services.

**3. Service mesh blurs port-binding ownership.**
- f07 — the "port" your app binds is sometimes proxied through a sidecar. The principle (self-contained) holds; the literal port the world sees is the sidecar's.

**4. Multi-tenancy at the app layer.**
- f03 implies one app, one config. Multi-tenant SaaS handles per-tenant config in a backing service (database, KMS-encrypted), not env. The factor still holds — env is for *deploy* config, not *tenant* config.

**5. Database migrations during deploy windows.**
- f12 (admin processes) needs to compose with zero-downtime deploys — backwards-compatible migrations done in stages, each stage a release (f05). The factors don't tell you *how* to do this, but their interaction does.

**6. Stateful streaming workloads (Kafka consumers, Flink jobs).**
- They violate f06 in the strict sense (offsets, partitioning, processing state). They are stateful workloads — closer to backing services architecturally. Treat them as such; deploy with StatefulSets, accept that they're not as disposable as web tier.
