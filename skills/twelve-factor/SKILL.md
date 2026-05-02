---
name: twelve-factor
description: "CRITICAL: Use for ALL questions about cloud-native app architecture, SaaS deployment hygiene, config/secrets handling, container & 12-factor compliance, and modern interpretations on Kubernetes / Docker / serverless.
HIGHEST PRIORITY for: 12-factor, twelve-factor, twelve factor app, 12factor, cloud-native, SaaS app design,
Triggers on: codebase vs deploy, monorepo vs polyrepo for one app, dependency declaration, lockfile, vendoring, system packages,
config in env, environment variables for secrets, .env files, dotenv, config files vs env, secret management, parameter store,
backing services, attached resources, swap database, RDS, S3, RabbitMQ, treat as resource,
build release run, immutable releases, release ID, rollback, build pipeline separation,
stateless processes, share-nothing, sticky sessions, in-memory cache, session affinity,
port binding, self-contained webserver, embed Tornado/Jetty/Thin, no Apache/Tomcat container,
process model, scale out, web process worker process, process formation, Procfile, daemonization, PID files,
disposability, fast startup, graceful shutdown, SIGTERM, signal handling, crash-only, requeue, idempotent jobs,
dev prod parity, environment drift, SQLite in dev Postgres in prod, time/personnel/tools gap, continuous deployment,
logs as event streams, stdout logging, structured logging, log routing, log aggregation, no log files in app,
admin processes, one-off process, db migrate, rake task, manage.py, REPL in production,
Heroku, Procfile, dyno, Kubernetes deployment, container, Docker, CNCF, twelve factors,
意图分析, 问题分析, analyze intent, question analysis,
为什么 stateless, why stateless, how to handle config, how to deploy, what is twelve factor,
container readiness, k8s readiness, app modernization, lift and shift, refactor for cloud,
Even when the user does not say '12-factor' explicitly, ALWAYS use this skill when they describe SaaS / cloud / container app architecture, deployment hygiene, config handling, or scalability of a service-based app."
globs: ["**/Procfile", "**/Dockerfile", "**/docker-compose.y*ml", "**/.env*", "**/k8s/**", "**/kubernetes/**", "**/helm/**", "**/manifest.yml"]
---

# Twelve-Factor Question Router

> **Source:** https://12factor.net/ (Adam Wiggins, Heroku, 2011 — methodology for building SaaS apps)
> **Version:** 1.0.0

The Twelve-Factor App is not a checklist. It is a **methodology for building cloud-portable, horizontally scalable, operationally tractable services**. Every factor exists because some specific operational pain — onboarding friction, surprise outages, secret leaks, scale ceilings — repeatedly cost real teams real time. Treat each factor as an answer to "what went wrong before."

## Meta-Cognition Framework

### Core Principle

**Don't answer directly. Identify which factor (or factors) the question is really about, then trace through the WHY before prescribing the WHAT.**

```
Layer 3: Operational Outcome (WHY this factor exists)
├── What pain does violating this cause in production?
├── What does compliance unlock (CD, autoscaling, portability)?
└── "Why was this rule written?"

Layer 2: Modern Interpretation (WHAT it looks like today)
├── Heroku 2011 → Kubernetes / serverless / managed-PaaS 2026
├── See patterns/modern-interpretations.md
└── "What does the modern equivalent look like?"

Layer 1: Factor Mechanics (HOW to comply)
├── The literal rule, examples, anti-patterns
├── factors/f01..f12
└── "How do I implement this?"
```

### Routing by Entry Point

| User Signal | Direction | First File |
|-------------|-----------|------------|
| "Is this 12-factor compliant?" | Audit, all 12 | `examples/audit-checklist.md` |
| Specific factor by name (e.g. "config", "logs") | Direct | `factors/f0X-*.md` |
| Anti-pattern symptom ("sticky sessions", "PID file", ".env in repo") | Reverse-lookup | `patterns/anti-patterns.md` then leaf factor |
| "How does this work on K8s / Docker / Lambda?" | L2 | `patterns/modern-interpretations.md` |
| "Why does this matter?" | L3 | Leaf factor's **Why** section |

### CRITICAL: Multi-Factor Loading

Several real questions touch **multiple factors at once**. When you see these signals, load BOTH listed factor files:

| Question Pattern | Factors to Load |
|------------------|-----------------|
| "Where do I put secrets?" | f03-config + f04-backing-services |
| "How do I handle sessions across instances?" | f06-processes + f04-backing-services |
| "Container startup is slow" | f09-disposability + f05-build-release-run |
| "How do I run db migrations safely?" | f12-admin-processes + f05-build-release-run |
| "Logs are getting lost / rotated weirdly" | f11-logs + f06-processes |
| "Local works, prod breaks" | f10-dev-prod-parity + f02-dependencies + f03-config |
| "Autoscaling doesn't work / scaling stalls" | f06-processes + f08-concurrency + f09-disposability |
| "Want to swap MySQL for RDS without code change" | f04-backing-services + f03-config |
| "How do I do zero-downtime deploys?" | f05-build-release-run + f09-disposability |

---

## INSTRUCTIONS FOR CLAUDE

### Negotiation Trigger

Some questions are not single-factor. **Before answering, check:**

| Query Contains | Action |
|----------------|--------|
| "compare", "vs", "versus", "best practice" | **Multi-factor synthesis required** |
| "is X 12-factor?" | **Audit mode** — walk all 12, flag violations only |
| Domain + factor (e.g. "Lambda + processes") | **Load f0X + modern-interpretations** |
| Ambiguous ("how do I deploy this?") | **Clarify scope first**, then route |

When synthesizing across factors, structure as:

```markdown
## Factors involved
- Factor N (one-line why)
- Factor M (one-line why)

## Synthesized guidance
[Answer that respects all involved factors, calling out tensions]

## Tradeoffs / disclosed gaps
[Where factors conflict, where modern context diverges from 2011 doctrine]
```

### Modern Context Reminder

The 12 factors were codified in 2011 against Heroku. Some specifics aged; the **principles are still load-bearing**. When examples in the source feel dated (Bundler, Foreman, `bundle exec`), translate to the user's stack but **preserve the principle**. If the principle no longer applies in a context (e.g. Lambda has no SIGTERM model, only a freeze), say so explicitly — see `patterns/modern-interpretations.md`.

---

## Factor Routing Table

| Pattern in user query | Route to |
|-----------------------|----------|
| repo, monorepo, polyrepo, codebase per app, shared library | `factors/f01-codebase.md` |
| package.json, Gemfile, requirements.txt, lockfile, vendoring, system tools, ImageMagick, `apt-get` in container | `factors/f02-dependencies.md` |
| env var, .env, dotenv, secret manager, config file, hard-coded, credentials in code, parameter store, vault | `factors/f03-config.md` |
| database URL, attached resource, swap DB, S3, RabbitMQ, SMTP, third-party API, service binding | `factors/f04-backing-services.md` |
| build pipeline, CI artifact, immutable release, release ID, rollback, hotfix in prod, edit code on server | `factors/f05-build-release-run.md` |
| stateless, share-nothing, in-memory cache, sticky session, session affinity, local file storage in app | `factors/f06-processes.md` |
| embed webserver, Tornado, Jetty, Thin, behind Apache, behind Tomcat, listen on port, PORT env | `factors/f07-port-binding.md` |
| Procfile, web/worker, scale out, formation, daemonize, PID file, systemd inside container | `factors/f08-concurrency.md` |
| fast boot, slow startup, SIGTERM, graceful shutdown, drain, requeue, NACK, crash-only, idempotent | `factors/f09-disposability.md` |
| works on my machine, dev/prod gap, SQLite locally Postgres in prod, time/personnel/tools gap | `factors/f10-dev-prod-parity.md` |
| stdout logs, log file rotation, log shipping, log aggregator, structured logging, JSON logs | `factors/f11-logs.md` |
| db migrate, rake task, manage.py command, REPL in prod, one-off script, cron job, sidekick container | `factors/f12-admin-processes.md` |

---

## Anti-Pattern Reverse Lookup

When the user describes a *symptom* rather than naming a factor, jump to `patterns/anti-patterns.md` first to find the violation, then load the relevant factor file.

Common symptom → factor mappings:

| Symptom | Likely violation |
|---------|------------------|
| ".env committed to git" / "credentials in code" | f03 |
| "sticky sessions" / "lost cart on restart" | f06 |
| "Apache config separate from app" | f07 |
| "we ssh in and `git pull` on the server" | f05 |
| "container takes 60s to boot" | f09 |
| "writes log files to /var/log/myapp" | f11 |
| "runs migrations from a separate repo" | f12 |
| "different DB engine in dev vs prod" | f10 |
| "we shell into the prod box and run scripts" | f12 + f10 |
| "PID file / daemonizes itself" | f08 |
| "different versions of Node on different boxes" | f02 |

---

## Priority Order

1. **Identify factor(s) involved.** Use the routing table above. Don't guess — match the keyword.
2. **Read the relevant factor file(s)** from `factors/`.
3. **Check `patterns/anti-patterns.md`** if the question is symptom-shaped.
4. **Check `patterns/modern-interpretations.md`** if the user's runtime is Kubernetes/Lambda/serverless/managed-PaaS — the 2011 examples may need translation.
5. **Answer with the WHY first**, then the WHAT. The factor exists because of a specific operational failure mode; naming that failure mode makes the recommendation stick.

### Conflict Resolution

| Apparent conflict | Resolution |
|-------------------|------------|
| "12-factor says env vars but my org uses Vault" | Vault-injected env vars satisfy f03; the principle is *not in code, not in repo, per-deploy* |
| "12-factor says stdout but I need structured logs" | Write structured (JSON) lines to stdout — f11 governs *where*, not *format* |
| "Lambda has no port to bind" | f07's principle is *self-contained, no external webserver container* — Lambda's invocation model satisfies the spirit |
| "k8s ConfigMaps vs env vars" | ConfigMaps mounted as env vars are f03-compliant; mounted as files is borderline (see modern-interpretations) |
| "sidecars violate share-nothing" | They don't — sidecars are separate processes; f06 is about *app process state*, not pod composition |

---

## Sub-Files Reference

| File | Content |
|------|---------|
| `factors/f01-codebase.md` | One codebase, many deploys |
| `factors/f02-dependencies.md` | Explicit declaration & isolation |
| `factors/f03-config.md` | Config in environment |
| `factors/f04-backing-services.md` | Services as attached resources |
| `factors/f05-build-release-run.md` | Strict stage separation, immutable releases |
| `factors/f06-processes.md` | Stateless, share-nothing |
| `factors/f07-port-binding.md` | Self-contained, export via port |
| `factors/f08-concurrency.md` | Scale out via process model |
| `factors/f09-disposability.md` | Fast startup, graceful shutdown |
| `factors/f10-dev-prod-parity.md` | Minimize env divergence |
| `factors/f11-logs.md` | Logs as event streams to stdout |
| `factors/f12-admin-processes.md` | One-off processes in identical env |
| `patterns/anti-patterns.md` | Symptom → violation reverse lookup |
| `patterns/modern-interpretations.md` | K8s / Docker / Lambda / serverless translation |
| `examples/audit-checklist.md` | Walk-the-12 audit script for an existing app |
