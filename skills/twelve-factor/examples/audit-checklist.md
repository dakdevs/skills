# 12-Factor Audit Checklist

Use this to walk an existing app and report compliance. Score each factor: ✅ pass, ⚠️ partial, ❌ fail, n/a. Note evidence and a one-line remediation for each non-pass.

## How to use

1. Read each factor's leaf file (`factors/f0X-*.md`) before judging — the checklist below is shorthand.
2. Audit by **looking at code, configs, and runtime behavior**, not by asking the team. Self-reports are unreliable.
3. Report back as a table; group remediations by effort (config-only > code change > architectural).
4. **Lead with the *why*** for each violation — the failure mode it enables, not the rule it breaks.

---

## Checklist

### f01 Codebase
- [ ] One repo (or one logical app in a monorepo) per app
- [ ] No forks/branches encoding environment
- [ ] Shared code lives in versioned libraries, not copy-paste
- [ ] No multi-app codebases with collapsed deploys

### f02 Dependencies
- [ ] Manifest declares every runtime dep (`package.json` + lockfile, etc.)
- [ ] Lockfile committed
- [ ] Runtime version pinned (`.nvmrc`, `engines`, base image tag)
- [ ] No reliance on system tools not bundled in the image
- [ ] One-command install on a clean machine reproduces dev env

### f03 Config
- [ ] No secrets in source / lockfile / config files in repo
- [ ] All deploy-varying config sourced from env vars
- [ ] No `if env === 'production'` branches gating behavior
- [ ] No environment-named config files (`config.prod.yml` etc.)
- [ ] Could open-source the repo today without leaking credentials

### f04 Backing services
- [ ] Every backing service connection comes from a config var
- [ ] No hard-coded provider hostnames
- [ ] Same code path for local-and-third-party variants of same service type
- [ ] App does not start its own backing services
- [ ] Swapping a service URL requires zero code changes

### f05 Build, release, run
- [ ] Build artifacts are immutable (image SHA, jar hash, etc.)
- [ ] Releases have unique IDs (not `:latest`)
- [ ] Release ledger exists (rollouts, deploys table, GitOps history)
- [ ] No SSH-and-edit on prod
- [ ] Rollback to last known good is one command
- [ ] No `npm install` / `bundle install` at runtime

### f06 Processes
- [ ] No in-process session state (sessions in Redis/DB)
- [ ] No local-disk uploads or persistent state
- [ ] No sticky-session reliance in load balancing
- [ ] In-memory caches are derived/computable, never source-of-truth
- [ ] App tolerates `kill -9` of any single instance

### f07 Port binding
- [ ] Webserver bundled as a library, not external infra
- [ ] App listens on `PORT` (or equivalent) from env
- [ ] App runs with `./app` (or `docker run`) — no Apache/Tomcat container required
- [ ] Routing/TLS handled at the edge (LB, ingress), not by the app

### f08 Concurrency
- [ ] Distinct process types (web, worker, scheduler) declared
- [ ] Each type scales independently (HPA per type, etc.)
- [ ] No daemonization, no PID files
- [ ] Process supervision delegated to systemd / orchestrator
- [ ] Cron not running in-process on web instances

### f09 Disposability
- [ ] Boot to ready in seconds (target: <10s, hard limit: <30s)
- [ ] Readiness probe honest (true 200 = traffic-ready)
- [ ] SIGTERM handled: drain, finish in-flight, exit cleanly
- [ ] Workers requeue on shutdown (NACK / visibility timeout)
- [ ] Jobs idempotent / reentrant
- [ ] Locks have timeouts
- [ ] Rolling deploys produce zero user-visible errors

### f10 Dev/prod parity
- [ ] Same DB engine + version in dev as prod
- [ ] Same Redis/queue/etc. engine in dev as prod
- [ ] Containerized dev (or VM) — Linux for Linux prod
- [ ] Devs deploy their own code
- [ ] Time from `git push` to prod is hours, not weeks
- [ ] Staging diverges from prod in resource size only, not topology

### f11 Logs
- [ ] App writes events to stdout (and stderr for errors)
- [ ] No file paths or rotation logic in app code
- [ ] No app-side log shipping (Splunk client embedded, etc.)
- [ ] One event per line; structured JSON preferred
- [ ] Trace/request IDs propagated
- [ ] Stdout unbuffered

### f12 Admin processes
- [ ] Migrations and admin scripts live in app repo
- [ ] Run via same image / same isolation as the app
- [ ] Run against a specific release, not `main`
- [ ] Same env (DATABASE_URL, etc.) as the app
- [ ] No "SSH and run psql / python" workflows for state-changing ops
- [ ] Audit trail exists (Job logs, deployment history)

---

## Reporting template

```markdown
# 12-Factor Audit: <app name>

| Factor | Score | Evidence | Remediation |
|--------|-------|----------|-------------|
| 1. Codebase | ✅ | One repo, clean history | — |
| 2. Dependencies | ⚠️ | No lockfile | Add `package-lock.json`, commit |
| 3. Config | ❌ | API keys in `config/secrets.yml` | Move to env, source from secret manager |
| 4. Backing services | ✅ | All via DATABASE_URL etc. | — |
| 5. Build/release/run | ⚠️ | Uses `:latest` tag | Pin to image digest |
| 6. Processes | ❌ | In-process session store | Move sessions to Redis |
| 7. Port binding | ✅ | Express on PORT env | — |
| 8. Concurrency | ⚠️ | Web + workers in one process | Split process types |
| 9. Disposability | ❌ | 90s startup, no SIGTERM handler | Lazy-load init; add graceful shutdown |
| 10. Dev/prod parity | ❌ | SQLite dev, Postgres prod | Use Postgres in dev via docker compose |
| 11. Logs | ✅ | JSON to stdout | — |
| 12. Admin processes | ⚠️ | Migrations in side repo | Move into app repo |

## Remediations by effort

**Config-only / quick:**
- Pin image digest (f05)
- Add lockfile (f02)
- Move migrations into app repo (f12)

**Code change:**
- Move sessions to Redis (f06)
- Add SIGTERM handler + drain logic (f09)
- Move secrets to env + secret manager (f03)

**Architectural / multi-PR:**
- Split web and worker process types (f08)
- Make backing services interchangeable; remove SQLite dev path (f10 + f04)
- Reduce startup time (f09)
```

## Auditor's prioritization heuristic

When everything is broken, fix in this order — earlier wins compound:

1. **f03** (config) — credential leaks are the highest-blast-radius issue.
2. **f05** (build/release/run) — without immutable releases you can't safely change anything else.
3. **f06** (processes) — without statelessness, scaling and recovery are unsafe.
4. **f09** (disposability) — without graceful start/stop, every fix-deploy hurts users.
5. **f10** (dev/prod parity) — divergence creates new bugs faster than you can fix old ones.
6. The rest — usually faster to address once the foundation is sound.
