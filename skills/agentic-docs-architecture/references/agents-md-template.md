# AGENTS.md template

Drop this in at the root of a crate (and symlink `CLAUDE.md` → `AGENTS.md`). Replace the bracketed parts. Keep it short — push detail into `docs/`. The whole file should usually fit on one screen.

```markdown
# <crate-name>

<One-sentence description of what this crate does — what it owns, what it doesn't.>

## Verify

```bash
cargo test -p <crate> && cargo clippy -p <crate> -- -D warnings && cargo doc -p <crate> --no-deps
```

## Module ownership

Module ownership and key rules: see [docs/reference/module-map.md](docs/reference/module-map.md).

## Critical invariants

1. <Numbered, named rule that is true everywhere in this crate. Short, declarative, surprising-if-violated.>
2. <Another invariant.>
3. <…>

Scoped rules (relevant only when touching that subsystem) live in the feature
doc's `## Invariants` section: [feature-A](docs/features/feature-a.md),
[feature-B](docs/features/feature-b.md).

## Change impact

When you change X, also update Y: see [docs/reference/change-impact.md](docs/reference/change-impact.md).

## Docs

| Doc                                                          | Covers                                  |
| ------------------------------------------------------------ | --------------------------------------- |
| [README](README.md)                                          | Feature index — start here              |
| [Guides](docs/guides/)                                       | Getting started, testing, observability |
| [Architecture](docs/architecture/)                           | Overview, lifecycle, generics           |
| [Features](docs/features/)                                   | One file per feature — see README tree  |
| [Reference / Module map](docs/reference/module-map.md)       | Every module with its invariant rules   |
| [Reference / Change impact](docs/reference/change-impact.md) | What to update when X changes           |
```

## What goes in "Critical invariants"

A real example list (from `os-harness`) — note the style: each item is a single declarative sentence, often naming a type, with the *why* implicit in the wording.

1. Tool errors are wrapped in `ToolResult::error(...)` and sent back to the LLM — never returned as `HarnessError`.
2. Hook panics are caught (`catch_unwind`) — default action used, loop continues.
3. `ToolCallStarted` / `ToolCallCompleted` events only emitted for executed calls — not blocked calls.
4. `AgentEvent` must stay `Clone` — String errors only, no error types.
5. System prompt is built once at loop start, not per-turn.
6. `Ctx: Send + Sync + 'static` — no `Any` bounds, no downcasting.

These are the rules an agent (or a tired human) might violate without the file in front of them. They're the sharpest edges of the design — break one and something downstream goes sideways.

## What does *not* go in invariants

- Procedures ("first do X, then Y").
- Anything that changes more than once a quarter.
- Rules that are only true inside one module — those go in `docs/features/<x>.md` under `## Invariants`.
- Aspirational guidance ("we should be careful about…"). State the rule plainly or leave it out.

## The Docs table — what to link

The table is a discovery aid, not an exhaustive catalog. Link the high-traffic entries:

- `README.md` — feature index, the human entry point.
- `docs/guides/` — top-level link is fine if there are multiple guides; named link if there's one canonical guide.
- `docs/architecture/` — same.
- `docs/features/` — top-level link to the directory; the README inside lists features.
- `docs/reference/<each-table>` — these get **named** links because they're often consulted directly. At minimum: `module-map.md`, `change-impact.md`. Add more (events, errors, config) as the crate grows.

If you find yourself with 20+ rows in this table, the crate is overgrown — consider whether the docs index inside `README.md` should be the discovery surface and the AGENTS.md table should shrink to the must-knows.

## Symlink CLAUDE.md

Claude Code reads `CLAUDE.md` by convention. Make it a symlink so there's one source of truth:

```bash
cd <crate>
ln -s AGENTS.md CLAUDE.md
```

If symlinks are awkward in your repo (Windows checkouts, certain CI setups), commit two copies and add a CI check that diffs them.
