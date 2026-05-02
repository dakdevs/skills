# Factor V — Build, Release, Run

> **Rule:** Strictly separate build and run stages.

## The principle

Three distinct stages, in order, with no shortcut between them:

1. **Build.** Take a commit + dependencies, produce an executable bundle (binary, container image, jar, tarball).
2. **Release.** Combine a build with config (f03) for a specific deploy. The result is **immutable** and gets a unique ID (timestamp, semver, monotonic counter, git SHA + config hash).
3. **Run.** Execute the release in the target environment. The runtime should be as dumb and uneventful as possible — pull release, start process, done.

Releases form an **append-only ledger**. You never edit a release. To change anything, you make a new release.

## Why this exists

The build stage is rich, complex, and developer-supervised. The run stage happens at 3am, on a machine reboot, after a node failure, with no human in the loop. Pushing complexity into the run stage means failures happen unattended.

Immutability of releases gives you:
- **Trivial rollback.** "Promote release v107 again" — no git, no rebuild, no panic.
- **Auditability.** Exactly one artifact per release ID, forever.
- **Reproducibility.** What ran in prod *is* the artifact, not "main at the time of deploy."

## Compliance

- **Build artifacts are immutable.** Once built, a container image / tarball / jar is never modified.
- **Releases are immutable.** A release = one build + one config snapshot. Rotating a single env var creates a new release.
- **Runtime does not mutate code.** No `git pull` on the server. No `npm install` at boot.
- **Unique release IDs.** `v123`, `2026-05-01T10:23:45Z-a3f2`, `git-abc123-cfg-456`. Whatever — must be unique and recorded.
- **Forward-only normally, but rollback is just promoting an older release.**

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| `ssh prod && git pull && pm2 restart` | Build, release, and run collapsed into one mutable runtime. No rollback path. |
| Container image tagged `:latest` in production | Not a unique release ID; you cannot say what's running |
| Editing files on a production server "to fix it real quick" | Mutates the release; next restart erases the fix |
| Running `npm install` at container start | Mixes build into run; slow boot, network failure mode at boot |
| Building from `main` instead of a specific commit/tag | Non-reproducible — the same release ID could mean different code |
| "Hot patches" applied via SSH | All of the above, with audit problems |

## Modern interpretation

- **Container images are the canonical build artifact.** Image SHA = build ID.
- **Release = image + ConfigMap/Secret hash.** A K8s Deployment's `revisionHistory` is your release ledger; each rollout is a release.
- **GitOps (ArgoCD, Flux):** the desired state in Git + the rendered manifests = release. The ledger is the Git history.
- **Immutable infrastructure:** every change is a new image, a new release. No SSH, no `kubectl exec` to edit running pods.
- **Rollback by re-applying an old release**, not by reverting code. `kubectl rollout undo`, `helm rollback`, `argocd app rollback`.

## Quick check

> "Can I tell you exactly what code and exactly what config is running in prod right now, by name? And can I roll back to last week's release with a single command?"

Yes to both → compliant.
