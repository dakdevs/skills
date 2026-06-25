# Document Writing

## Purpose

Skill documents should make source knowledge executable by an agent.

Do not write passive chapter summaries unless the user explicitly asks for study notes. A skill tree
needs instructions, decisions, checks, and outputs.

## Source Credit

Credit the source in two places:

1. `SKILL.md` frontmatter metadata.
2. `source.md`.

Recommended frontmatter:

```yaml
metadata:
  origin_title: "..."
  origin_author: "..."
  origin_url: "..."
  origin_note: "Authored expansion based on the source; not a verbatim copy."
```

For a local or user-provided source, use `origin_path` or `origin_description` instead of
`origin_url`.

## Copyright Handling

- Prefer paraphrase.
- Use short quotes only when necessary for exact terminology.
- Do not reproduce long passages, tables, or chapters.
- Do not preserve the source's whole structure if it would recreate the work. Preserve the useful
  operational architecture instead.
- For books and paid sources, keep references to chapter/page names but write original guidance.

## Transform Sections into Operations

For each source section, ask:

| Source Feature | Skill Doc Form |
|----------------|----------------|
| Claim | Principle or invariant |
| Step-by-step advice | Workflow |
| List of mistakes | Anti-pattern or check file |
| Example | Worked example with generalized lesson |
| Taxonomy | Routing or decision table |
| Argument | Architecture model |
| Caveat | Limitation or quality gate |
| Exercise | Eval prompt or practice task |

## Standard Topic File Structure

```markdown
# [Topic]

## Origin
[Which source section this came from.]

## Problem Shape
[When this topic matters.]

## Core Idea
[Paraphrased operational idea.]

## Decision Rules
[How to choose this path.]

## Procedure
[What to do.]

## Verification
[How to check it worked.]

## Failure Modes
[How agents misuse this topic.]

## Related Docs
[Local links only unless external integration is required.]
```

## Writing Quality Bar

Each document should contain at least three of:

- Decision table.
- Procedure.
- Review checklist.
- Verification checklist.
- Example.
- Anti-pattern list.
- Output template.
- Routing guidance.

If a document contains only a summary, revise it.

## Avoid These Failures

- Reprinting the source.
- Making every source heading a file even when the files are empty.
- Creating only `SKILL.md`.
- Adding generic advice not grounded in the source.
- Adding unrelated existing skill routes.
- Omitting limitations.
- Omitting source credit.
