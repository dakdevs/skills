# Change-impact table template

This file lives at `docs/reference/change-impact.md` in each well-documented crate. It is the **authoritative map** of "if you change X, also update Y." Every code change should be checked against this table before commit.

## Header

```markdown
# Change impact

When you change X in <crate>, also update Y — this table is the authoritative map.

Docs live in a tree under `docs/`:

- `docs/features/<feature>.md` — per-feature deep dives
- `docs/reference/<type>.md` — exhaustive tables (config, events, errors, module-map)
- `docs/architecture/<topic>.md` — overview, lifecycle, generics
- `docs/guides/<task>.md` — getting-started, testing, observability
```

## Common rows (adapt for your crate)

| If you change…                                | Also update…                                                                |
| --------------------------------------------- | --------------------------------------------------------------------------- |
| A public trait (signature or contract)        | `docs/features/<feature>.md` (the feature that owns the trait)              |
| A trait's set of impls (added/removed)        | `docs/features/<feature>.md`                                                |
| A config struct field (added/removed/renamed) | `docs/reference/<config>.md` + `docs/guides/getting-started.md`             |
| An enum variant (added/removed)               | `docs/reference/<enum>.md` + the feature doc that introduced it             |
| An error variant                              | `docs/reference/errors.md`                                                  |
| Module name or responsibility                 | `docs/reference/module-map.md`                                              |
| A workspace-wide convention or invariant      | `AGENTS.md` (Critical invariants section)                                   |
| Top-level loop / lifecycle / control flow     | `docs/architecture/<lifecycle>.md`                                          |
| Cross-cutting design principle                | `docs/architecture/overview.md`                                             |
| A scoped invariant (one subsystem)            | `docs/features/<feature>.md` under `## Invariants`                          |
| Test organization or mocking patterns         | `docs/guides/testing.md`                                                    |
| Span/event instrumentation                    | `docs/guides/observability.md`                                              |
| MCP / FFI / external-protocol integration     | `AGENTS.md` invariants + `docs/features/<integration>.md` + relevant references |

## Compile-time enforcement (preferred where possible)

Some doc-update obligations can be enforced by the compiler instead of by this table. Two patterns:

```rust
// 1. #[non_exhaustive] + exhaustive destructure
//    Forces sibling code to consciously incorporate every new field.
#[non_exhaustive]
pub struct CompletionRequest {
    pub messages: Vec<Message>,
    pub tools: Vec<Tool>,
    pub model: String,
    pub temperature: Option<f32>,
}

// elsewhere (e.g. canonicalize for replay):
fn canonicalize(req: &CompletionRequest) -> CanonicalRequest {
    let CompletionRequest { messages, tools, model, temperature } = req;
    // …
    // If a new field is added to CompletionRequest, this destructure
    // stops compiling until the new field is handled.
}
```

```rust
// 2. #[non_exhaustive] enum + exhaustive match
#[non_exhaustive]
pub enum CompletionChunk {
    Content(String),
    ToolCall(ToolCall),
    Done,
}

// elsewhere (e.g. recording bundle):
match chunk {
    CompletionChunk::Content(s) => …,
    CompletionChunk::ToolCall(tc) => …,
    CompletionChunk::Done => …,
    // adding a new variant breaks this match → forced to update encoding.
}
```

When a row in the table can be replaced by a compile-time check, **prefer the check** and add a row noting the enforcement instead:

| `CompletionRequest` field   | `providers/replay.rs::canonicalize_request` (enforced by `#[non_exhaustive]` + exhaustive destructure — code will fail to compile until the new field is incorporated) |
| `CompletionChunk` variant   | `providers/replay.rs::RecordedChunk` + `From<&CompletionChunk>` (enforced by `#[non_exhaustive]` + exhaustive match) |

This way, future agents can't forget — the compiler reminds them.

## How to use this table (for the agent reading it)

1. After writing your code change, scan the **left column** for anything that matches.
2. For each matching row, open the docs in the right column and update them in the same change.
3. If your change doesn't fit any existing row, ask: would the next person changing this same thing be expected to update some doc? If yes, **add a row** so they don't have to figure it out from scratch.
4. If your change is purely internal (private function, refactor with no public API impact), no doc update is needed — but the verify command in `AGENTS.md` still has to pass.

## Anti-patterns

- **A row that says "update everything related to X."** Be specific about *which* file. The point is to remove ambiguity.
- **A table that hasn't been touched in months.** Either the code is unusually stable (rare) or the table is being ignored. Audit it during the next reasonable PR.
- **Letting the table grow to 100+ rows.** That's a sign the architecture is too coupled — every change touches everything. Consolidate or split the crate.
