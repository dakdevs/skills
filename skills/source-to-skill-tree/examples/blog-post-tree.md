# Example: Blog Post to Skill Tree

## Source Shape

A blog post often has one strong argument and several named sections.

Do not create only a single summary file. Convert each section into a check, workflow step, pattern,
or decision rule.

## Example File Map

```text
blog-derived-skill/
|-- SKILL.md
|-- source.md
|-- architecture.md
|-- checks/
|   |-- 01-first-check.md
|   |-- 02-second-check.md
|   `-- 03-third-check.md
|-- workflows/
|   |-- review-workflow.md
|   `-- implementation-workflow.md
|-- examples/
|   `-- progressive-application.md
`-- evals/
    `-- evals.json
```

## Router Strategy

Use the post's section headings as candidates, then rename them by task signal.

Example:

| Source Heading | Skill Doc |
|----------------|-----------|
| "Make it server-proof" | `checks/01-server-proof.md` |
| "Make it hydration-proof" | `checks/02-hydration-proof.md` |
| "Make it future-proof" | `checks/10-future-proof.md` |

## Required Expansion

Each check file should add:

- Problem shape.
- Broken assumption.
- Design invariant.
- Implementation pattern.
- Review questions.
- Verification.
- Related docs.

This is the difference between a skill tree and a summary.
