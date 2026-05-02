# Factor VIII — Concurrency

> **Rule:** Scale out via the process model.

## The principle

Concurrency comes from running **more processes**, not from making one process bigger. Different workloads get different **process types** — `web` for HTTP, `worker` for background jobs, `scheduler` for cron, `consumer` for queue-driven, etc.

The **process formation** is the array of process types and their counts: `web=10, worker=4, scheduler=1`. Scaling is a change to this formation.

## Why this exists

Vertical scaling has a ceiling — and once you hit it, you have nowhere to go. Horizontal scaling (more processes, possibly across machines) has practically no ceiling, *if* the app is stateless (f06) and disposable (f09).

Different workloads have different scaling profiles. Web traffic spikes by 10× at noon. Background jobs spike when a customer kicks off an export. Scaling them together wastes money. Splitting them into process types lets each scale on its own signal.

## Compliance

- **Process types named and isolated.** `web`, `worker`, etc. — declared somewhere (Procfile, Kubernetes Deployment per type, container with multiple commands).
- **Horizontal scaling is a config change**, not a code change. `web=10 → web=30`.
- **App does not daemonize itself**, does not write PID files, does not manage child processes for the same workload (workers managing workers within a single process is fine — pre-fork pattern is OK).
- **Process supervision is delegated**: systemd, container orchestrator, K8s controller, Foreman in dev. The app exits on failure; the supervisor restarts it.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| App calls `fork()` and detaches; writes `/var/run/myapp.pid` | Should be foreground, supervisor-managed |
| One process tries to handle web traffic *and* background jobs | Coupled scaling; each starves the other under load |
| Cron jobs run on a `web` process via in-process scheduler | One web process becomes the de facto cron leader; HA story is a mess. Use a `scheduler` process type or external scheduler |
| Threads/coroutines used as the primary scaling mechanism, ignoring multi-process | Hits CPU/GIL/per-process limits; can't scale beyond one machine |
| `nohup ... &` used to launch the app | Daemonization done wrong; supervisor is what matters |

## Modern interpretation

- **Kubernetes:** Each process type = one Deployment (or StatefulSet). HPA scales each type independently. ✅
- **Procfile + Foreman / Honcho:** Original Heroku model, still valid for local dev.
- **Container per process type.** Don't bake `web` and `worker` into one image-with-multiple-commands unless the orchestrator can launch them separately.
- **Goroutines / async / threads inside one process** are fine — they're the *intra-process* concurrency mechanism. f08 governs *inter-process* scaling. Use both.
- **Serverless:** Each function invocation is roughly a process. Concurrency = invocations. Fully aligned with the spirit of f08.
- **Auto-scaling rules per process type** (CPU for web, queue depth for worker) is the modern formation control.

## Quick check

> "Can I scale my background workers from 5 to 50 without touching the web tier? Without a code change?"

Yes → compliant.

> "If I lose the machine running my single 'cron' process, does another one take over?"

If the answer involves manual intervention, your scheduler is a single point of failure — split or use a managed scheduler.
