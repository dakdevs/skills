# Factor IX — Disposability

> **Rule:** Maximize robustness with fast startup and graceful shutdown.

## The principle

Processes can be started or killed **at a moment's notice**. They:

- **Start fast** (target: a few seconds to ready). Slow boot = slow scaling, slow deploys, slow recovery.
- **Shut down gracefully on SIGTERM.** Stop accepting new work, finish (or hand off) in-flight work, exit.
- **Survive sudden death.** Crashes, OOM kills, hardware failure — the system stays correct because work is requeued and idempotent.

This is **crash-only design**: graceful shutdown and crash recovery use the same code paths.

## Why this exists

Every operational benefit of cloud-native architecture depends on this. Autoscaling, rolling deploys, spot instances, preemptible VMs, node-failure recovery — all of them constantly start and kill processes. If your app doesn't tolerate this, you've opted out of the cloud value proposition.

## Compliance

### Startup

- **Boot to ready in seconds.** Not minutes.
- **No blocking warm-up that must complete before serving.** If you need a cache, fill it lazily and serve from a cold cache correctly.
- **Health/readiness checks are honest.** "Ready" means "I can serve traffic now," not "the process is up."

### Shutdown (web)

On `SIGTERM`:
1. Stop accepting new connections at the listener.
2. Let in-flight requests finish, with a deadline (typical: 10–30s).
3. Close DB pools, flush logs, exit 0.

### Shutdown (worker)

On `SIGTERM`:
1. Finish current job *or* requeue it — depending on cost.
2. Don't ack work that wasn't completed.
3. Use queue protocols that support NACK / visibility timeout (RabbitMQ, SQS, Beanstalkd).

### Crash recovery

- **Jobs are idempotent.** Reprocessing them produces the correct result.
- **Jobs are reentrant.** They can be picked up by a different worker mid-flight.
- **Use queue features that requeue automatically** when a worker disconnects.
- **Locks have timeouts.** A worker that died holding a lock must not block the system forever.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| App takes 60–120s to start (loads everything eagerly) | Slow scale, slow rollback, autoscaling oscillates |
| Worker `ack`s a job, then does the work | Crash mid-job → silent loss |
| Worker has no SIGTERM handler — orchestrator must `SIGKILL` | In-flight work lost on every deploy |
| "Shutdown" closes the DB pool *before* draining requests | In-flight requests fail at the end of every deploy |
| Locks held in app process memory with no timeout | Worker crash → lock orphaned forever |
| Health check returns 200 before DB pool is ready | LB sends traffic to a dead-on-arrival pod |

## Modern interpretation

- **Kubernetes:** SIGTERM is sent, then a grace period (`terminationGracePeriodSeconds`, default 30s), then SIGKILL. Use a `preStop` hook + readiness probe flip to drain LB connections before SIGTERM. Use `startupProbe` if your app legitimately needs warmup time, but treat slow startup as a bug to fix.
- **Lambda / Functions:** No SIGTERM; runtime *freezes* the process. Init code is the "startup," and the platform handles disposability for you. Cold start is the modern equivalent of slow startup — minimize it.
- **Spot instances / preemptible VMs:** Often give you ~30s notice (sometimes 2 min). Disposability is what lets you use these cheap instances at all.
- **Drain protocols:** `kubectl drain`, AWS lifecycle hooks, GCP node drain — all rely on the app behaving correctly on SIGTERM.

## Quick check

> "If I `kill <pid>` a worker mid-job, does the job complete on another worker? With no manual intervention, no data loss, no double processing?"

Yes → compliant.

> "When I do a rolling deploy with continuous traffic, do users notice?"

If they see 5xx errors during deploys, your shutdown is not graceful.
