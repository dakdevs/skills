---
name: source-to-skill-tree
description: "CRITICAL: Use when turning any source material into a reusable skill tree: book, ebook, PDF, blog post, article, website, documentation site, transcript, course notes, research paper, manual, or long-form reference. Triggers on: turn this into a skill, make a skill tree, convert this book into skills, extract a skill from this PDF, turn this blog post into a routed skill, create docs from a website, source-to-skill, knowledge-to-skill, skill tree from URL, skill tree from document, preserve source credit, cite origin, architect a skill tree, or build a multi-file skill from source material."
globs: ["**/*.pdf", "**/*.md", "**/*.txt", "**/*.html", "**/*.docx", "**/*.epub", "**/SKILL.md"]
---

# Source to Skill Tree

Use this skill to transform source material into a self-contained skill tree.

The output is not a summary. The output is an operational skill package: a `SKILL.md` router plus
local documents that help a future agent apply the source's knowledge to real tasks.

## Core Rule

Convert source knowledge into behavior.

Every generated skill tree must answer:

1. When should the skill trigger?
2. What should the agent do first?
3. Which local document should the agent read for each source-derived topic?
4. What should the agent produce or change?
5. How should the agent verify that it applied the source correctly?
6. How is the original source credited without copying excessive source text?

## Document Map

| File | Purpose |
|------|---------|
| `workflows/create-skill-tree.md` | End-to-end creation workflow |
| `references/source-ingestion.md` | How to ingest books, PDFs, blogs, and websites |
| `references/tree-architecture.md` | How to design the routed document structure |
| `references/document-writing.md` | How to write source-derived skill docs |
| `references/quality-gates.md` | Final checks before calling the skill complete |
| `references/evaluation.md` | Practical eval prompts and assertions for skill trees |
| `templates/router-skill.md` | Template for the generated `SKILL.md` |
| `templates/source-notes.md` | Template for source credit and adaptation notes |
| `examples/blog-post-tree.md` | Example architecture for a blog-post-derived skill |
| `examples/book-tree.md` | Example architecture for a book-derived skill |
| `evals/evals.json` | Starter eval prompts for this skill |

## Routing

| User Input | Read First | Then Read |
|------------|------------|-----------|
| URL, blog post, article, website | `references/source-ingestion.md` | `workflows/create-skill-tree.md` |
| PDF, ebook, book chapter, local document | `references/source-ingestion.md` | `references/tree-architecture.md` |
| "Architect this into a skill tree" | `references/tree-architecture.md` | `workflows/create-skill-tree.md` |
| "Make sure it credits the source" | `references/document-writing.md` | `templates/source-notes.md` |
| "Make it like rust-router" | `references/tree-architecture.md` | `templates/router-skill.md` |
| "Test the skill" or "eval it" | `references/evaluation.md` | `evals/evals.json` |
| Existing generated tree feels thin | `references/quality-gates.md` | `examples/blog-post-tree.md` or `examples/book-tree.md` |

## Required Output Shape

Default generated tree:

```text
new-skill-name/
|-- SKILL.md
|-- source.md
|-- architecture.md
|-- workflows/
|   |-- review-workflow.md
|   `-- implementation-workflow.md
|-- references/
|   `-- topic-or-concept.md
|-- patterns/
|   `-- named-pattern.md
|-- examples/
|   `-- progressive-walkthrough.md
`-- evals/
    `-- evals.json
```

Adjust the folders to match the source. A small blog post may need `checks/` instead of
`references/`. A book may need `principles/`, `practices/`, `case-studies/`, and `exercises/`.

## Non-Negotiables

- Credit the source in `SKILL.md` metadata and `source.md`.
- Do not copy long passages from copyrighted sources. Use short quotes only when necessary.
- Do not route to unrelated existing skills just because they exist.
- Do not create a thin router with no local documents when the source has multiple ideas.
- Do not summarize chapters as passive notes. Convert them into actions, checks, workflows,
  patterns, decision tables, and verification steps.
- Keep the top-level `SKILL.md` under 500 lines when possible. Move detail into local files.
- Prefer ASCII in generated files unless the source or target language requires otherwise.

## Default Workflow

1. Read `references/source-ingestion.md`.
2. Build a source inventory and section map.
3. Read `references/tree-architecture.md`.
4. Design the skill tree file map before writing files.
5. Write `SKILL.md`, `source.md`, `architecture.md`, workflow docs, detailed topic docs, examples,
   and eval prompts.
6. Read `references/quality-gates.md`.
7. Verify frontmatter, links, source credit, file tree, and absence of unsupported external routes.
8. If the user has both `.agents/skills` and `.claude/skills`, mirror the finished tree only when
   requested or when the conversation establishes that preference.

## Completion Report

When done, report:

- Skill path.
- Number of files and total line count.
- Source credit location.
- Verification performed.
- Whether it was mirrored to another skill store.
