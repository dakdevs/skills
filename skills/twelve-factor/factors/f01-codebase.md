# Factor I — Codebase

> **Rule:** One codebase tracked in revision control, many deploys.

## The principle

A **codebase** is a single repository (or in DVCS, multiple repos sharing a root commit). An **app** maps to exactly one codebase. A **deploy** is any running instance — production, staging, a developer's laptop. The same codebase backs all deploys, possibly at different revisions.

## Why this exists

When one app spans multiple codebases, you don't have an app — you have a distributed system. You lose the ability to ask "what code is running where?" because the answer is fragmented. Versioning, rollback, audit, and onboarding all break.

When multiple apps share *the same* codebase, you've conflated independent change cadences. A bug fix in one app forces a redeploy of every other app, or worse, drifts unfixed in the others.

## Compliance

- **One repo per app.** If two services have independent release cycles and independent owners, they are two apps.
- **Shared code goes in libraries**, consumed via the dependency manager (see f02). Not via copy-paste, not via git submodules of source.
- **Many deploys is normal.** prod, staging, every developer's laptop, every PR preview environment. They run the same codebase at different commits.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| "Service A and Service B live in the same repo and deploy together" | Either they're really one app (fine) or they should be split (one app = one codebase) |
| "We copied the auth module into three repos" | Should be a versioned library |
| "Production runs from a separate fork" | Forks are not deploys; they're a different codebase. Merge or split into two apps |
| "There's a `prod` branch we cherry-pick to" | Branches encode environment; environment belongs in config (f03) and release ID (f05) |

## Modern interpretation

- **Monorepos are fine** — Bazel/Nx/Turborepo monorepos host many apps, each app being one logical codebase. The factor is about the *logical* codebase per app, not the physical repo.
- **Polyrepos are fine** — also satisfy the factor.
- The dividing line: each app has independent build, release, and run.
- See `patterns/modern-interpretations.md` for monorepo guidance.

## Quick check

> "If I run `git log` for this app's codebase, do I see *only* this app's history? And conversely, is *all* of this app's history there?"

Yes to both → compliant.
