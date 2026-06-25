# Example: Book to Skill Tree

## Source Shape

A book usually contains a system, not just a list. Preserve the system by building layers:

- Core model.
- Principles.
- Practices.
- Case studies.
- Workflows.
- Anti-patterns.
- Exercises or evals.

## Example File Map

```text
book-derived-skill/
|-- SKILL.md
|-- source.md
|-- architecture.md
|-- principles/
|   |-- 01-foundation.md
|   |-- 02-tradeoffs.md
|   `-- 03-operating-model.md
|-- practices/
|   |-- planning.md
|   |-- execution.md
|   `-- review.md
|-- case-studies/
|   `-- generalized-lessons.md
|-- workflows/
|   |-- apply-the-method.md
|   `-- diagnose-failures.md
|-- examples/
|   `-- end-to-end-application.md
`-- evals/
    `-- evals.json
```

## Chapter Mapping

Do not make one file per chapter by default. Chapters are source structure; skill trees need use
structure.

Better mapping:

| Chapter Material | Skill Tree Destination |
|------------------|------------------------|
| Repeated argument | `architecture.md` |
| Durable rule | `principles/*.md` |
| Step-by-step method | `workflows/*.md` |
| Concrete behavior | `practices/*.md` |
| Failure story | `case-studies/*.md` or anti-pattern doc |
| End-of-chapter exercise | `evals/evals.json` or `examples/*.md` |

## Book-Specific Quality Bar

For a full book, the tree should show:

- Cross-chapter dependencies.
- The author's operating model in paraphrase.
- Limitations and scope.
- Concrete application workflow.
- Examples that synthesize multiple chapters.
- Evals that test whether an agent can apply the model, not just recall terms.
