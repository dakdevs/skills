# Create Skill Tree Workflow

## Goal

Turn source material into a reusable skill tree that future agents can apply without rereading the
entire source.

The deliverable is a directory of local docs, not a single summary.

## Phase 1: Clarify Inputs

Identify:

- Source type: book, PDF, blog post, article, website, docs site, transcript, paper, manual.
- Source location: URL, local file path, pasted text, screenshots, or mixed inputs.
- Destination: `.agents/skills`, `.claude/skills`, repository folder, or output artifact.
- Target skill name.
- Intended users and tasks.
- Expected output style: router, checklist tree, principles tree, workflow tree, API reference tree.
- Whether to create eval prompts and run an evaluation loop.

If the user already gave enough information, proceed. Do not block on questions that can be resolved
by inspecting the source.

## Phase 2: Ingest the Source

Follow `references/source-ingestion.md`.

Capture a source inventory:

```markdown
# Source Inventory

## Origin
- Title:
- Author:
- URL or file:
- Access date:
- Source type:

## Structure
| Source Section | Purpose | Skill Candidate |
|----------------|---------|-----------------|

## Constraints
- Copyright constraints:
- Missing sections:
- Source freshness concerns:
```

For websites, include each relevant page. For PDFs and books, include page ranges or chapter names
when available.

## Phase 3: Extract the Operable Model

Do not start writing files until the source has been converted into a model.

Extract:

- Core claims.
- Procedures.
- Decision points.
- Error cases.
- Anti-patterns.
- Examples.
- Domain vocabulary.
- Safety or legal constraints.
- Verification steps.
- Assumptions the source makes.

Then classify each item:

| Item Type | Becomes |
|-----------|---------|
| Concept | `architecture.md` or `references/concept.md` |
| Procedure | `workflows/*.md` |
| Checklist | `checks/*.md` |
| Recurring technique | `patterns/*.md` |
| Warning | quality gate or anti-pattern doc |
| Example | `examples/*.md` |
| Testable task | `evals/evals.json` |

## Phase 4: Design the File Map

Read `references/tree-architecture.md`.

Create the document map before writing. A good map has:

- One top-level router.
- One source credit file.
- One architecture file.
- Workflow files for how to apply the source.
- Detailed topic files that are small enough to load selectively.
- At least one example that shows multiple documents composing.
- Eval prompts if the skill output can be tested.

## Phase 5: Write the Skill Tree

Use `templates/router-skill.md` and `templates/source-notes.md`.

Write in this order:

1. `SKILL.md`.
2. `source.md`.
3. `architecture.md`.
4. Workflows.
5. Detailed topic docs.
6. Examples.
7. Evals.

The `SKILL.md` should tell the future agent what to read, not contain every detail itself.

## Phase 6: Verify

Read `references/quality-gates.md`.

Minimum verification:

- YAML frontmatter parses.
- `name` matches the directory.
- Every path in the document map exists.
- Source title, author, URL/path, and adaptation note are present.
- No unsupported external skill routes were added.
- Long source passages were not copied.
- The tree has enough local detail to be useful without rereading the source.
- If mirrored to another skill store, `diff -qr` shows the copies match.

## Phase 7: Report

Report the installed path, file count, total lines, source credit, and verification. If evals were
not run, say that explicitly.
