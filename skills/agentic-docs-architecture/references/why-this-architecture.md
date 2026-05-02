# Why this architecture

Short version of the philosophical grounding. Read this when you're setting up a new crate's docs and want to internalize why the layout is what it is — not because the rules are arbitrary, but because every rule is paying for a specific, recurring pain.

## The core rule: clean interfaces

Every crate, every trait, every module boundary exists to answer one question:

> When something breaks, can you find it in under 30 seconds?

Clean interfaces mean:

- Each crate has a small, well-defined public API.
- Dependencies flow one direction (no cycles).
- Failures are localized — a bug in one crate doesn't cascade.
- Testing is isolated — mock the interface, test the implementation.

When a tool fails inside an agent loop, you know it's either the tool implementation or the loop — never both — because the `Tool<Ctx>` trait is the boundary. Without clean interfaces, a bug in a shared utility breaks 15 things and you spend an hour tracing the chain. With them, the compiler and the toolchain do that work for you.

## Why tiered docs (guides / architecture / features / reference)

Each tier exists because mixing them is what produces unreadable docs:

- **Guides** answer "how do I do X?" — procedural, step-by-step.
- **Architecture** answers "how does this fit together?" — conceptual, cross-cutting.
- **Features** answer "what does this one thing do, deeply?" — narrow, opinionated.
- **Reference** answers "what are all the X?" — exhaustive, table-shaped.

A reference doc that tries to teach is incomplete. A guide that tries to enumerate is overwhelming. Architecture that tries to be exhaustive is unreadable. Feature docs that try to do everything become README dumps. Splitting them lets each be the *best version* of itself.

This also helps agents. When an agent asks "what fields does AgentConfig have?", the answer is a single reference table — not a hunt across guides and architecture docs. When it asks "how do I add a tool?", the answer is a guide. The tier tells you *what shape the answer should take*.

## Why AGENTS.md (and CLAUDE.md)

Without per-crate agent guidance, AI agents:

- invent conventions
- create files in wrong locations
- skip the verify command
- miss invariants that aren't visible from the code alone
- produce code that compiles but doesn't match the project's patterns

With AGENTS.md:

- the rules are stated up front
- the verify command is one line away
- invariants are explicit
- the change-impact table prevents doc drift

Research backs this up: structured per-module agent guidance is associated with substantially lower runtime and reduced token consumption for AI coding agents while maintaining task completion. The cost is one short file per crate. The payoff is every future agent interaction.

## Why the change-impact table

This is the single highest-leverage doc pattern in the architecture.

Free-form docs rot because nobody knows when to update them. The change-impact table makes the obligation explicit: you changed `X`, the table tells you which docs to update in the same PR. It's a checklist that grows with the codebase.

The table is also a *signal*. If you keep wanting to update many rows for one change, your code is too coupled. If a doc is never referenced from the table, it might be dead. The shape of the table tells you about the shape of your architecture.

## Why compiler-enforced docs (Rust)

Three lints turn the compiler into a docs reviewer:

- `#![warn(missing_docs)]` — every public item must have a doc comment.
- `#![deny(rustdoc::broken_intra_doc_links)]` — cross-references like `` [`Foo`] `` must resolve. Renaming a type breaks the build, not just the docs.
- doc tests — every `///` example compiles on `cargo test`. Examples cannot rot.

The result: `cargo doc` produces a complete, accurate API reference that *cannot* lie about the code, because it was checked alongside the code. Manual docs always accumulate stale references. Compiler-checked docs cannot.

## Why no `unsafe`

`unsafe_code = "forbid"` workspace-wide eliminates an entire class of memory-safety bugs by default. The cost is tiny (very few real codebases need unsafe outside FFI / perf inner loops); the payoff is total. If a crate genuinely needs unsafe, it must opt out — which is the right time to have that conversation.

## Why generators, not hand-scaffolding

The 5th project someone hand-creates will have slightly different lint config, missing tags, wrong test runner, or no telemetry. These inconsistencies compound: one project passes CI while another fails on the same code, and nobody knows why.

Generators encode the conventions once. Every new crate is consistent. Agents are particularly bad at scaffolding from memory — they miss config files, use wrong dependency versions, forget workspace registration. Generators eliminate that whole failure mode.

## Why this compounds

Each pattern is useful alone. Together they form a feedback loop:

```
Generators enforce conventions
  → Consistent crates across the repo
    → AGENTS.md teaches the rules
      → Agents follow the same patterns
        → nx affected works reliably
          → CI is fast and precise
            → Smaller, focused PRs
              → Reviews are faster
                → Bugs found earlier
                  → Clean interfaces locate bugs instantly
                    → Compiler catches doc drift
                      → Docs stay fresh for the next agent
```

The investment is front-loaded; the payoff is continuous. Setting up generators, lints, doc tests, and AGENTS.md takes a few days. After that, every new crate, every new feature, every agent interaction benefits automatically. The architecture gets *better* as the repo grows, not worse.

## The goal

An AI agent picks up any crate in this repo, reads the AGENTS.md, implements a change, runs the verification commands, and produces a PR that passes CI — without needing a human to explain conventions, fix structure, or clean up tests. A human developer does the same with the same confidence.

The architecture is opinionated specifically so humans and AI agents alike can spend their time building features instead of fighting the toolchain.
