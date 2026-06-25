# Tree Architecture

## Purpose

The architecture step decides how the source becomes a navigable skill package.

A good skill tree optimizes for future use. The future agent should load only the documents needed
for the task.

## Top-Level Router

`SKILL.md` owns:

- Frontmatter name and trigger description.
- One-paragraph intent.
- Source credit summary.
- Document map.
- Routing table.
- Full-review or full-application route.
- Priority order.
- Output format.

It should not hold all extracted knowledge. Keep it under 500 lines when possible.

## Required Core Files

Every source-derived skill tree should include:

```text
SKILL.md
source.md
architecture.md
```

`source.md` proves provenance and adaptation scope.

`architecture.md` explains the mental model that connects the documents. Without it, the tree tends
to become a pile of summaries.

## Folder Selection

Choose folders based on source shape.

| Source Shape | Folder Pattern |
|--------------|----------------|
| "Ten ways to..." article | `checks/`, `workflows/`, `examples/` |
| Methodology book | `principles/`, `practices/`, `workflows/`, `case-studies/` |
| API or framework docs | `references/`, `patterns/`, `workflows/`, `examples/` |
| Research paper | `methods/`, `findings/`, `limitations.md`, `workflows/` |
| Operational manual | `workflows/`, `runbooks/`, `troubleshooting/`, `references/` |
| Design philosophy | `principles/`, `heuristics/`, `anti-patterns/`, `examples/` |

## Routing Tables

Create routes from user signal to local document.

Good route:

| User Signal | Read First | Then Read |
|-------------|------------|-----------|
| Hydration mismatch | `checks/02-hydration-proof.md` | `checks/01-server-proof.md` |

Bad route:

| User Signal | Route |
|-------------|-------|
| React issue | Read everything |

## Document Granularity

Split when:

- A topic has distinct triggers.
- A future agent would only need that topic for some tasks.
- The source has independent sections with different workflows.
- A file grows beyond roughly 250 to 350 lines.

Merge when:

- Two sections are always applied together.
- A document would be a thin summary with no behavior.
- The distinction mirrors source headings but not actual use.

## Locality Rule

Route to local documents created in the generated skill tree. Only reference other skills when:

- The source itself explicitly depends on another domain.
- The user asks for integration with existing skills.
- The external skill handles a separate tool workflow, not the source's core content.

Do not add unrelated companion skills to make the tree look connected.

## Architecture File Template

```markdown
# Architecture: [Skill Model Name]

## Core Model
[Explain the source's operating model in your own words.]

## Layers
[Show the layers or phases that organize the skill.]

## Dependency Order
[Explain what must be read or applied before what.]

## Invariants
[List the rules that should remain true after applying the skill.]

## Failure Modes
[List common ways agents misuse this knowledge.]

## Output Goal
[State what correct application produces.]
```
