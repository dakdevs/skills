# Anti-Pattern Reverse Lookup

When the user describes a *symptom* rather than naming a factor, look it up here, then load the linked factor file.

## By symptom

| Symptom | Violates | Reading order |
|---------|----------|---------------|
| ".env file committed to repo" | f03 | f03-config |
| "Hard-coded API key in source" | f03 | f03-config |
| "Different `config.production.js` per environment" | f03 | f03-config |
| "We have `if NODE_ENV === 'production'` everywhere" | f03 | f03-config |
| "Sticky sessions / session affinity" | f06 | f06-processes |
| "Lost cart on app restart" | f06 | f06-processes |
| "User uploads written to local disk" | f06 + f04 | f06, then f04 |
| "In-memory cache that we can't lose" | f06 | f06-processes (cache → backing service) |
| "WebSocket online users counter is wrong per instance" | f06 | f06-processes |
| "App is a `.war` deployed into Tomcat we manage" | f07 | f07-port-binding |
| "Apache config file separate from app, must be tuned per env" | f07 | f07-port-binding |
| "We SSH in and `git pull` on the server" | f05 | f05-build-release-run |
| "We edit files on prod to fix things" | f05 | f05-build-release-run |
| "Container tagged `:latest` in prod" | f05 | f05-build-release-run |
| "Container takes 60+ seconds to boot" | f09 + f05 | f09-disposability, then f05 |
| "Rolling deploy causes 5xx errors" | f09 | f09-disposability |
| "App writes to `/var/log/myapp.log`" | f11 | f11-logs |
| "We use a RotatingFileHandler in prod" | f11 | f11-logs |
| "App ships its own logs to Splunk via embedded HTTP" | f11 | f11-logs |
| "Migrations live in a separate ops repo" | f12 + f01 | f12, then f01 |
| "Devs SSH into prod to run admin scripts" | f12 + f10 | f12, then f10 |
| "SQLite locally, Postgres in prod" | f10 + f04 | f10, then f04 |
| "Different MySQL versions in dev vs prod" | f10 | f10-dev-prod-parity |
| "App calls `fork()` and detaches; writes a PID file" | f08 | f08-concurrency |
| "Web tier handles background jobs in-process" | f08 | f08-concurrency |
| "Cron job runs on one specific web instance" | f08 | f08-concurrency |
| "App relies on system `imagemagick`" | f02 | f02-dependencies |
| "Different versions of Node on different boxes" | f02 + f10 | f02, then f10 |
| "`pip install -r requirements.txt` with no lockfile" | f02 | f02-dependencies |
| "Service A and Service B share the same repo and deploy together" | f01 | f01-codebase |
| "We forked the codebase to make a customer-specific build" | f01 + f03 | f01, then f03 |
| "Hard-coded `s3.amazonaws.com` URL" | f04 | f04-backing-services |
| "Different code path for local SMTP vs Postmark" | f04 | f04-backing-services |
| "Worker `ack`s the job, then does the work" | f09 | f09-disposability |
| "Locks held in process memory with no timeout" | f09 | f09-disposability |
| "Health check returns 200 before DB is ready" | f09 | f09-disposability |

## By outage type

When you investigate a postmortem, these factors are usually involved:

| Outage shape | Likely factors |
|--------------|----------------|
| Secret leaked to logs/git | f03 (and f11 if logged) |
| Couldn't roll back quickly | f05 |
| Deploys cause user-visible errors | f05, f09 |
| Autoscaling thrashes / never stabilizes | f06, f09 |
| Lost data on restart | f06 |
| "Worked in staging, broke in prod" | f10, f02, f03 |
| Disk full from log files | f11 |
| Migration applied wrong version of script | f12, f05 |
| Single instance is a SPOF for cron / scheduling | f08 |
| Onboarding takes a week to get set up | f02, f10 |

## Common multi-factor footguns

**"We're putting more state in the database to be 12-factor compliant" — but the database is now a SPOF.**
- f06 says state goes to backing services. f04 says backing services are attached. f10 says use the same engine in dev. None of them say "the DB never fails." Plan for read replicas, retries, circuit breakers — those are app-design concerns, complementary to 12-factor.

**"We containerized but it still doesn't autoscale."**
- Containerization gets you f01–f07 and partial f10 cheaply. f06 (statelessness), f08 (process model), f09 (disposability) are independent — a slow-booting, sticky-session app in a container scales as poorly as one outside.

**"We use env vars but secrets are still leaking."**
- f03 is necessary, not sufficient. Pair with: secret manager, log-redaction, no `console.log(process.env)` in code, build artifacts that don't bake secrets in.
