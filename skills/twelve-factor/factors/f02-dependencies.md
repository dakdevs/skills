# Factor II — Dependencies

> **Rule:** Explicitly declare and isolate dependencies.

## The principle

Two requirements, both mandatory:

1. **Declare** every dependency exactly, in a manifest checked into the codebase (`package.json` + lockfile, `Gemfile.lock`, `requirements.txt` / `poetry.lock`, `go.mod`/`go.sum`, `Cargo.lock`).
2. **Isolate** at runtime so the app cannot accidentally use anything not declared (virtualenv, `bundle exec`, container image, `node_modules`, vendored modules).

Both. Declaration without isolation lets system libraries leak in. Isolation without declaration leaves the manifest wrong.

## Why this exists

The app must be reproducible from the manifest alone. A new engineer with the language runtime + dependency manager should reach a working install with one command. Production should boot the same way, with the same versions, every time.

When dependencies are implicit, "works on my machine" becomes the dominant failure mode. Subtle version drift between dev, CI, and prod produces bugs that are unreproducible.

## Compliance

- **Lockfiles are mandatory.** Manifest alone (no lock) is insufficient — version ranges drift.
- **No reliance on system tools.** If your app shells out to `convert` (ImageMagick), `curl`, `ffmpeg`, those are dependencies. Either bundle them (in the container image, vendored binary) or treat the missing tool as a documented runtime requirement and declare it.
- **No "globally installed" CLI** as a hard runtime requirement.
- **Build deps and runtime deps both declared.** Dev-only deps (test frameworks, linters) can be separated, but production runtime deps must be exact.

## Anti-patterns

| Smell | What's wrong |
|-------|--------------|
| `pip install -r requirements.txt` with unpinned versions and no lockfile | Non-reproducible. Pin via `pip-compile` / Poetry / uv |
| `apt-get install imagemagick` documented in a wiki, not in the Dockerfile | System dep should be in the image build |
| Reliance on a globally-installed `node` / `python` of unspecified version | Pin runtime version (`.tool-versions`, `.nvmrc`, `engines` field) |
| "Run `npm install -g foo` first" in README | If `foo` is a runtime dep, vendor it or invoke via `npx foo` from devDependencies |
| `node_modules` not isolated (one app's modules visible to another) | Container or per-project install isolates this |

## Modern interpretation

- **Containers solve isolation by default** — the image *is* the isolation boundary. The Dockerfile is partially the dependency manifest.
- **Lockfiles still matter** even in containers — the image build needs to be reproducible.
- **Multi-stage builds** keep build-only deps out of the runtime image.
- **Distroless / scratch base images** are the strongest form of f02 isolation: the only thing in the image is what you declared.
- **Reproducible builds** (Nix, Bazel) are f02 taken to its conclusion.

## Quick check

> "On a fresh box with only the language runtime installed, does one command produce a working build identical to production?"

Yes → compliant.
