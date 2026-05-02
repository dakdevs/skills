# Factor XII — Admin Processes

> **Rule:** Run admin/management tasks as one-off processes in an identical environment.

## The principle

Admin tasks — DB migrations, data fixes, REPL sessions, scheduled jobs, maintenance scripts — run as **one-off processes** that share **the same code, same release, same config, same dependency isolation** as the long-running app processes.

They live **in the application repo**, not in a side repo, not in a wiki, not as scattered DevOps scripts.

## Why this exists

Admin work is where outages get made. A migration written against last week's schema, a script that ran with stale config, a "one-time fix" that turned out not to be one-time — all happen when admin tasks diverge from the app's environment.

By running admin tasks against the *same release* as production, with the *same dependencies*, you eliminate an entire class of "wait, what version of the migration code did you run?" incidents.

## Compliance

- **Admin scripts ship in the app repo**, in the same codebase (f01).
- **Run with same isolation as the app:** `bundle exec rake db:migrate`, `python manage.py shell`, `npm run db:migrate` invoked inside the same container/runtime image.
- **Run against a specific release**, not against `main`. The migration that ran in prod is *the migration in release v123*, not "whatever was on main when ops ran it."
- **Same config (env vars).** Migration sees the same `DATABASE_URL` and secrets the app sees.
- **Logged the same way** — to stdout (f11), captured by the environment.
- **Idempotent where possible.** Re-running a migration shouldn't break things.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| Migrations live in a separate `ops` repo | Versioning drifts from app code; migrations applied against the wrong code |
| "SSH into prod and run psql" | Bypasses the release; no audit, no isolation, no record |
| Admin scripts use a different Python virtualenv than the app | Different deps → different behavior than app code paths |
| `manage.py migrate` run from a developer's laptop against prod DB | Wrong config, wrong network path, wrong audit trail |
| One-off fix-it scripts kept in someone's `~/scripts/` | Lost when they leave; no review, no version |
| Cron job runs an arbitrary script with stale config baked in | Drift; will fail or quietly do the wrong thing |

## Modern interpretation

- **Kubernetes Jobs:** Run `image: <same release>` with the migration command. Identical env, identical release. ✅
- **`kubectl exec` into a running pod for a one-off:** Acceptable for read-only ops (a quick `psql` to inspect). For writes, prefer a Job — it leaves an audit trail and runs with a clean process.
- **Helm hooks (`pre-upgrade` migration job):** Standard pattern for tying migration to release.
- **Init containers:** Sometimes used for migrations; works but couples migration to pod start. Cleaner to use a Job that runs once per release.
- **Lambda / Cloud Run:** Invoke the same image/code as a one-off task. Same container, different entrypoint.
- **Don't use a "bastion" with manually installed tools** to run admin tasks — same divergence risks. Bastion should `kubectl exec` / `aws ecs run-task` into the actual app image.

## Migration-specific guidance

- **Migrations are append-only.** No edits to a deployed migration; ship a new one.
- **Backwards-compatible migrations** for zero-downtime deploys: add column → ship code that writes both → backfill → ship code that reads new only → drop old. Each step is a release (f05).
- **Long migrations run as Jobs**, not in `preStop` / `init` paths that block deploys.
- **Idempotent or transactional.** Re-runnable on retry.

## Quick check

> "If a developer needs to run a migration in prod, what do they do?"

Acceptable answer: "Run `kubectl create job --from=cronjob/migrate` (or equivalent) — it pulls the same image, same env vars, runs once, logs to stdout, leaves a record."

Unacceptable answer: "SSH into prod and run the script manually." / "Pip-install some tools and connect to the prod DB from their laptop."
