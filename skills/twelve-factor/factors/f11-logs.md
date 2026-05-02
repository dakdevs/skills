# Factor XI — Logs

> **Rule:** Treat logs as event streams. Write to stdout. Let the environment route them.

## The principle

Logs are a **stream of time-ordered events**, one event per line. The app writes them, **unbuffered**, to **stdout**. That's it.

The app does not:
- Open log files
- Rotate log files
- Manage log directories
- Decide where logs are shipped

That is the **execution environment's** job — the orchestrator, log shipper, or platform captures stdout, aggregates, and routes to wherever (S3, Elasticsearch, Splunk, Loki, Datadog, BigQuery).

## Why this exists

Apps that own their log files own a long tail of operational concerns: disk full, permissions, rotation, compression, shipping, retention. None of these are app concerns. Each one is an outage waiting to happen ("we lost logs because the disk filled up").

Stdout is the lowest common denominator. Every container runtime, every PaaS, every init system captures it for free. By writing to stdout you delegate routing to whatever the environment already does well.

## Compliance

- **Write to stdout** (and stderr for errors, if your stack distinguishes — both are captured).
- **One log event per line.** Multi-line events break aggregators; serialize stack traces into a single line or use a format the aggregator understands (JSON).
- **Unbuffered** (or at least line-buffered) so events don't sit in a buffer when the process is killed.
- **No log file paths** in code. No log rotation in code. No `RotatingFileHandler` in production config.
- **Structured logs (JSON) when possible.** Aggregators love them; humans tail them with `jq`.
- **Include trace/request IDs** so you can correlate across services.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| App writes to `/var/log/myapp/app.log` | Filesystem responsibility leaks into the app |
| `RotatingFileHandler` in code | Log rotation is the env's job |
| App ships its own logs to Splunk via embedded HTTP client | Coupling; if Splunk is down, the app is too. Let the env handle shipping |
| Multi-line stack traces written naively | Log aggregator parses them as N events; correlation breaks |
| `print()` for some events, `logger.info()` for others, with different formats | Inconsistent stream — make all events go through one logger |
| Logs to stdout *and* a file | Pick one. Stdout. |
| Buffered stdout that loses events on crash | Set `PYTHONUNBUFFERED=1` / equivalent |

## Modern interpretation

- **Containers:** stdout/stderr captured by the runtime (Docker → json-file driver, K8s → kubelet → log shipper). f11-native.
- **Sidecar log shippers (Fluent Bit, Vector, Filebeat):** They tail stdout and forward. The app is unchanged.
- **DaemonSet log collectors:** Same idea, one-per-node.
- **Lambda / Cloud Run / serverless:** stdout is automatically captured by the platform (CloudWatch, Cloud Logging). Fully aligned.
- **OpenTelemetry logs:** A modern overlay — emit structured events with trace context. Still goes through stdout in most setups; the OTel collector handles routing.
- **Structured JSON logging is the modern default.** `pino`, `slog`, `zap`, `structlog`. One JSON object per line.

## Quick check

> "If I `kubectl logs` (or `docker logs`, or `journalctl -u myapp`) the process, do I see every event the app emitted?"

Yes → compliant.

> "If the log aggregator is down, does the app keep running normally?"

Yes → compliant. (If no, you've coupled them.)
