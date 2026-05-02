---
name: agentic-docs-architecture
description: "Use when working in a repo organized for AI-agent effectiveness — tiered docs (guides/architecture/features/reference), AGENTS.md/CLAUDE.md per crate, change-impact tables, compiler-enforced doc lints. Trigger this PROACTIVELY whenever adding or modifying crates/packages, writing or updating documentation, scaffolding new projects, or after making code changes that may have downstream doc impact. Specific triggers: 'where should this doc go', 'update AGENTS.md', 'add a crate', 'where do I document X', 'what else do I need to update', 'change-impact', 'critical invariants', 'module map', when editing any AGENTS.md/CLAUDE.md, when adding a public Rust API, when changing a trait/struct/enum/config field that other code depends on, when starting work in a Rust workspace with #![warn(missing_docs)], when an agent needs to know the canonical place to write docs vs. invariants vs. references, or when reviewing a PR that touches docs and code together. Silence on doc-impact is how docs rot — reach for this skill instead."
---

# Agentic Docs Architecture

Tiered documentation pattern designed so AI agents (and humans) can find rules, change code safely, and keep docs from rotting. The architecture is opinionated: every file has one place to live, every change has a known set of follow-ups, and the compiler enforces what it can.

## The core idea (read this first)

> Every boundary exists so that when something breaks, you find it in under 30 seconds.

Three forces shape the layout:

1. **Failures must localize.** Trait boundaries between crates act as firewalls — a bug in one crate doesn't cascade. If a tool fails inside an agent loop, you know it's the tool *or* the loop, not both. This is what makes the `Tool<Ctx>` trait, the `LlmProvider` trait, and friends non-negotiable: they're the seams along which problems get pinned.
2. **Docs must not drift.** Code changes constantly. Free-form docs can't keep up. Two mechanisms enforce freshness: (a) the Rust compiler (`#![warn(missing_docs)]`, `#![deny(rustdoc::broken_intra_doc_links)]`, doc tests) and (b) the **change-impact table** — a hand-written map of "if you change X, also update Y" that lives in every well-documented crate.
3. **Agents need to know the rules.** Every crate has an `AGENTS.md` (often symlinked or duplicated as `CLAUDE.md`) that states the invariants, the verify command, and the docs index. Without that file, agents invent conventions, misplace files, and ship code that compiles but doesn't fit. With it, they pick up any crate, follow the rules, and produce a PR that passes CI.

When you operate in this repo, you are participating in those three forces. Don't bypass them — extend them.

## The doc tree (where things live)

Every well-documented crate (and the root) follows this layout. You don't get to invent a new tier — pick the right one.

```
<crate>/
├── AGENTS.md              ← rules, invariants, verify, docs index (entry point for agents)
├── CLAUDE.md              ← symlink or copy of AGENTS.md (so Claude Code picks it up)
├── README.md              ← human-facing feature index — links into docs/
├── src/
│   └── lib.rs             ← #![warn(missing_docs)], #![deny(rustdoc::broken_intra_doc_links)]
└── docs/
    ├── guides/            ← how-to (getting-started.md, testing.md, observability.md)
    ├── architecture/      ← concepts (overview.md, loop-lifecycle.md, context-generic.md)
    ├── features/          ← one file per feature, deep dive (tools.md, hooks.md, retry.md, …)
    └── reference/         ← exhaustive tables (agent-config.md, events.md, errors.md,
                              messages.md, module-map.md, change-impact.md)
```

### Choosing the tier

| You're writing…                             | Goes in              | Example                         |
| ------------------------------------------- | -------------------- | ------------------------------- |
| Step-by-step "how do I do X"                | `docs/guides/`       | `getting-started.md`            |
| A concept that spans multiple modules       | `docs/architecture/` | `loop-lifecycle.md`             |
| Deep dive on one feature                    | `docs/features/`     | `overflow-compaction.md`        |
| Exhaustive list (every variant, every flag) | `docs/reference/`    | `events.md`, `agent-config.md`  |
| Rule that is invariably true of this crate  | `AGENTS.md`          | "Tool errors wrap to ToolResult" |
| What to update when X changes               | `docs/reference/change-impact.md` | Trait change → features/tools.md |

If you can't decide, pick **features/** for narrow topics and **architecture/** for cross-cutting ones. References are reserved for things that need to be enumerated, not narrated.

## AGENTS.md — the per-crate entry point

This file is the contract between the crate and any agent (human or AI). Keep it short. Push detail into `docs/`. The template:

```markdown
# <crate-name>

<One-line description of what the crate does.>

## Verify

```bash
cargo test -p <crate> && cargo clippy -p <crate> -- -D warnings && cargo doc -p <crate> --no-deps
```

## Module ownership

Module ownership and key rules: see [docs/reference/module-map.md](docs/reference/module-map.md).

## Critical invariants

1. <Numbered, named rule that is always true. Short, declarative.>
2. <Another invariant.>
…

Scoped rules (relevant only when touching that subsystem) live in the feature
doc's `## Invariants` section: [feature-A](docs/features/feature-a.md), …

## Change impact

When you change X, also update Y: see [docs/reference/change-impact.md](docs/reference/change-impact.md).

## Docs

| Doc                                 | Covers                                  |
| ----------------------------------- | --------------------------------------- |
| [README](README.md)                 | Feature index — start here              |
| [Guides](docs/guides/)              | Getting started, testing, observability |
| [Architecture](docs/architecture/)  | Overview, lifecycle, generics           |
| [Features](docs/features/)          | One file per feature                    |
| [Reference / Module map](docs/reference/module-map.md) | Every module with its invariant rules |
| [Reference / Change impact](docs/reference/change-impact.md) | What to update when X changes |
```

A full template is in `references/agents-md-template.md`.

### What to put in "Critical invariants"

These are global, durable rules — true of the whole crate, not just one module. Examples that *belong*:

- "Tool errors are wrapped in `ToolResult::error(...)` and sent back to the LLM — never returned as `HarnessError`."
- "Hook panics are caught (`catch_unwind`) — default action used, loop continues."
- "`AgentEvent` must stay `Clone` — String errors only, no error types."

What does *not* belong (push into `docs/features/<x>.md` under a `## Invariants` heading instead):

- Rules that only matter when you're in one specific module.
- Step-by-step procedures.
- Anything that changes more than once a quarter.

The test: if a violation of the rule would surprise an agent reading code anywhere in the crate, it's an invariant. Otherwise it's scoped — push it down.

## The change-impact table — the anti-drift weapon

This is the single highest-leverage doc pattern in the architecture. It lives at `docs/reference/change-impact.md` and is **the authoritative map** of what to update when you change something.

Format:

```markdown
| If you change…                  | Also update…                                   |
| ------------------------------- | ---------------------------------------------- |
| `Tool` trait                    | `docs/features/tools.md`                       |
| `HookSet` fields or actions     | `docs/features/hooks.md`                       |
| `AgentConfig` fields            | `docs/reference/agent-config.md` + `docs/guides/getting-started.md` |
| `AgentEvent` variants           | `docs/reference/events.md` + `docs/features/streaming-events.md` |
| Module name or responsibility   | `docs/reference/module-map.md`                 |
| Loop flow                       | `docs/architecture/loop-lifecycle.md`          |
```

When you make a code change, **read this table** before committing. If the row exists, update both columns in the same PR. If no row exists for the type of change you made, **add a row** — that's how the table grows.

A working template with common entries is in `references/change-impact-template.md`.

### Compile-time enforcement (use it where possible)

For some changes, the compiler can enforce the update. Two patterns from the wild:

```rust
// Force replay/canonicalize logic to consciously incorporate every new field.
#[non_exhaustive]
pub struct CompletionRequest { … }

// In replay.rs:
fn canonicalize_request(req: &CompletionRequest) -> CanonicalRequest {
    let CompletionRequest { messages, tools, model, temperature, /* exhaustive destructure */ } = req;
    // … if a new field is added, this destructure stops compiling.
}
```

Prefer compile-time enforcement when the doc-update is mechanical. Use the table when it isn't.

## Compiler-enforced docs (Rust)

Every Rust crate in this pattern sets these at the top of `lib.rs` (or in `Cargo.toml` lints):

```rust
#![warn(missing_docs)]
#![deny(rustdoc::broken_intra_doc_links)]
```

And the workspace sets:

```toml
[workspace.lints.clippy]
all = { level = "warn", priority = -1 }
pedantic = { level = "warn", priority = -1 }
nursery = { level = "warn", priority = -1 }

[workspace.lints.rust]
unsafe_code = "forbid"
```

What this means for you, as an agent:

- **Every public item needs a doc comment.** No exceptions. The compiler will yell.
- **Cross-references like ``[`Message`]`` must resolve.** If you rename a type, the compiler catches stale doc links.
- **Doc tests run on every `cargo test`.** A `///` example that calls `Foo::new("x")` *is a test*. If `new` is renamed, the doc test breaks. Use this — write doc tests for every non-trivial public function. They can never go stale.
- **No `unsafe` anywhere.** If you think you need it, you're wrong, or you need to have a conversation first.
- **Clippy pedantic + nursery is on.** Don't suppress lints with `#[allow(...)]` reflexively. If clippy warns, the warning is usually right.

Workflow rule: after every code change, run the crate's verify command. It should be a single line in `AGENTS.md` (`cargo test -p X && cargo clippy -p X -- -D warnings && cargo doc -p X --no-deps`). If it fails, you're not done.

## Trait boundaries are firewalls — preserve them

The reason `Tool<Ctx>`, `LlmProvider`, `HookSet`, `MessageStore`, `CompactionStrategy`, etc. are traits is to make failures localize. When you're tempted to:

- add a downcast (`dyn Any`, `downcast_ref::<MyCtx>`)
- pass a concrete type where a trait would do
- merge two trait responsibilities into one giant trait
- add a method to a trait that only one impl needs

**Stop.** You are about to weaken a firewall. The architecture's promise — find the bug in 30 seconds — depends on these boundaries staying clean. If you genuinely need to change a trait, treat it as a major change: update the change-impact table, write tests for both sides of the boundary, and bring it up explicitly rather than slipping it into a larger PR.

The flip side: when you write *new* code, lean on traits aggressively. Every external dependency (LLM, browser, filesystem, time) should be behind a trait so it can be mocked. AI agents in particular cannot test against real services, but they can absolutely write mock-based unit tests — *if* the boundaries support it.

## Generators — never scaffold by hand

The repo provides generators:

```bash
bun run g:rust-crate <name>     # new Rust crate
bun run g:ts-lib <name>         # new TS package
bun run g:react-app <name>      # new React+Vite app
bun run g:website <name>        # new Next.js site
bun run g:mobile-app <name>     # new Expo app
```

Generators bake in: workspace deps, lints, formatter config, tags (`type:lib`, `lang:rust`, `scope:web`), test setup, instrumentation (`#[instrument]` for libs, `os_telemetry::init()` for bins), AGENTS.md skeleton, and registration in workspace manifests.

If you find yourself running `cargo new` or hand-creating a `package.json`, you're doing it wrong. The next agent will inherit your inconsistency. Use the generator. If a generator doesn't exist for what you need, the right move is to *write the generator*, not to scaffold once and ship.

## Workflow: when you make changes

A reliable change loop in this codebase looks like:

```
1. Read AGENTS.md for the crate(s) you'll touch.
   ├─ Note the verify command.
   ├─ Skim the critical invariants.
   └─ Glance at docs/reference/change-impact.md.
2. Make the change.
3. Look up your change in change-impact.md.
   ├─ If a row matches → update the listed docs in the same change.
   ├─ If no row matches but the change has cross-cutting impact → add a row.
   └─ If the change is purely internal → no doc update needed.
4. If you added/removed a public API → write or update the doc comment (compiler will check).
5. If you added a non-trivial public function → add a doc test.
6. Run the verify command from AGENTS.md.
   └─ Must include: cargo test, cargo clippy -D warnings, cargo doc --no-deps.
7. Run nx affected -t lint,test from the repo root for cross-project effects.
8. bun run format.
```

Don't skip step 3. It is the single most common point of failure in agent-generated PRs.

## Common pitfalls (be alert)

- **Putting an invariant in a feature doc.** If it's true crate-wide, it belongs in AGENTS.md. If it's only true in a subsystem, it belongs under `## Invariants` in the relevant feature doc.
- **Adding a doc to the wrong tier.** "How to enable thinking" is a guide. "All AgentConfig fields" is a reference. "What `OverflowPolicy` does and why" is a feature. "How the loop drives turns" is architecture. When in doubt, ask: is this exhaustive (reference), procedural (guide), conceptual (architecture), or focused-deep-dive (feature)?
- **Forgetting to symlink CLAUDE.md → AGENTS.md.** Claude Code reads CLAUDE.md by convention. The symlink keeps a single source of truth.
- **Updating code without the change-impact follow-up.** This is the biggest single source of doc rot. Read the table.
- **Suppressing clippy with `#[allow]` to make a warning go away.** The warning is usually a real signal. Fix the underlying issue.
- **Writing doc comments without examples.** If a function is non-trivial, the example is what saves the next agent (and acts as a compiled test). Cost is low, payoff is permanent.
- **Letting CLAUDE.md and AGENTS.md drift.** If they're not symlinked, edit both. Better: make them a symlink and stop thinking about it.

## When this skill doesn't apply

- The repo isn't using this pattern (no `docs/{guides,architecture,features,reference}` tree, no AGENTS.md, no change-impact table). Don't impose it on a repo that hasn't adopted it — the value comes from consistency.
- A trivial one-line fix (typo, comment, formatting) — running the full doc-impact check is overkill. Use judgment.
- Pure refactors that change no public API and no behavior — no doc update is needed; the verify command still must pass.

## References

- `references/agents-md-template.md` — full AGENTS.md template, ready to fill in.
- `references/change-impact-template.md` — change-impact table starter with common rows.
- `references/why-this-architecture.md` — short version of the philosophical grounding (clean interfaces, fast feedback, agent effectiveness). Read this when you're writing a new crate's docs and need to internalize the "why."
