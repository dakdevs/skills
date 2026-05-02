# Factor VI — Processes

> **Rule:** Execute the app as one or more stateless, share-nothing processes.

## The principle

App processes hold **no persistent state** between requests. Memory and local filesystem are scratch space at best — usable for the lifetime of a single request, never relied on after. Anything that must persist goes to a backing service (f04): database, cache, object store.

**No sticky sessions.** Any request can land on any process. Any process can be killed at any moment. The system stays correct.

## Why this exists

Statelessness is what makes horizontal scaling and disposability possible. The moment a process holds state another process can't see, you've created an invisible coupling: scaling out is broken, restarts lose data, autoscaling triggers data loss, every process becomes a snowflake.

Sticky sessions specifically break: load balancing (skewed by session count), failover (sessions vanish on restart), deploys (rolling updates evict sessions), and capacity planning.

## Compliance

- **No in-memory session state** that survives a request. Session data → Redis/Memcached/DB with TTL.
- **No local filesystem caching** of anything that matters past one request. User uploads → object store. Compiled assets → built into the image (f05).
- **No "warm" caches you can't lose.** A cold cache should produce correct (slower) behavior. If the cache is required, it's a backing service.
- **Idempotent request handling.** Any request can be retried on a different process.
- **In-memory caching is fine for derived/computable data**, never for source-of-truth state.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| `req.session = {}` stored in process memory | Sticky-session-only; breaks load balancing & restarts |
| User uploads written to local `/uploads` directory | Lost on restart; not visible to other processes |
| In-memory job queue (`setTimeout(processJob, ...)`) | Lost on restart; no retry semantics |
| WebSocket "online users" counter as a local Map | Per-process view of global state — wrong on every instance |
| Generated PDF cached on local disk for 24 hours | Other processes can't see it; lost on restart |
| File-based locks (`flock /tmp/myapp.lock`) | Don't span machines; meaningless in a multi-process deploy |

## Modern interpretation

- **Stateful workloads exist** (databases, caches, brokers). They are *backing services*, not application processes. Run them with StatefulSets / managed services, not via app code.
- **WebSocket / SSE connections** are stateful in the sense of being long-lived TCP — that's fine. The factor is about *application state*, not connection state. The state behind the socket (subscriptions, pub/sub) belongs in Redis pub/sub or similar.
- **Edge runtimes / serverless functions** are aggressively stateless by design — fully aligned with f06.
- **Service workers / sidecars / agents** can be stateful for caching/observability concerns; they're infra, not the app.

## Quick check

> "If I `kill -9` any single process right now, does the system stay correct? Does another process pick up the work?"

Yes to both → compliant.

> "If I scale from 3 instances to 30, do the new instances start serving correctly within seconds, with no warm-up?"

Yes → compliant.
