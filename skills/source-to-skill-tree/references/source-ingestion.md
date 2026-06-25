# Source Ingestion

## Purpose

Ingestion creates a reliable map of the source before any skill files are written.

The source map protects against two common failures:

- Building a tree from a shallow skim.
- Copying the source instead of transforming it.

## General Rules

- Use the source the user provided. If it is a URL and the content may have changed, browse it.
- For local files, inspect metadata and extract text with the appropriate tool.
- For books and PDFs, preserve page or chapter references when available.
- For websites, preserve page URLs and the navigation structure.
- For pasted content, treat the chat message as the source and note that no external verification
  was performed unless you actually performed it.
- Track missing or inaccessible sections.
- Respect copyright. Do not reproduce long passages. Paraphrase and cite.

## Blog Post or Article

Capture:

- Title, author, URL, publication date if visible, access date.
- Headings and subheadings.
- The argument flow.
- Named concepts.
- Examples or code samples.
- Explicit recommendations.
- Implied workflow.

Likely tree shape:

```text
SKILL.md
source.md
architecture.md
checks/
workflows/
examples/
evals/
```

## Website or Documentation Site

Capture:

- Root URL.
- Pages visited.
- Navigation hierarchy.
- Page-level purpose.
- Stable URLs.
- Version selector or product version, if present.
- Contradictions or duplicated guidance across pages.

Likely tree shape:

```text
SKILL.md
source.md
architecture.md
workflows/
references/
patterns/
examples/
```

For large sites, create a `source-map.md` with the page inventory.

## Book or Ebook

Capture:

- Title, author, edition, publisher if available.
- Chapter list.
- Major claims by chapter.
- Practices, exercises, case studies, and models.
- Terminology.
- Cross-chapter dependencies.

Likely tree shape:

```text
SKILL.md
source.md
architecture.md
principles/
practices/
workflows/
case-studies/
examples/
evals/
```

Do not try to encode an entire book in one `SKILL.md`. Use progressive disclosure aggressively.

## PDF or Paper

Capture:

- Title, authors, publication venue if available.
- Page count.
- Abstract or thesis in paraphrase.
- Section headings.
- Figures/tables that carry operational value.
- Methods, algorithms, evaluation setup, findings, limitations.

Likely tree shape:

```text
SKILL.md
source.md
architecture.md
methods/
findings/
workflows/
limitations.md
examples/
```

For research papers, make limitations first-class. A skill built from a paper should not present
tentative findings as universal rules.

## Source Inventory Template

```markdown
# Source Inventory

## Origin
- Title:
- Author:
- URL or file:
- Date published:
- Date accessed:
- Source type:

## Structure
| Section | Pages or URL | What it contributes | Target doc |
|---------|--------------|---------------------|------------|

## Extraction Notes
- Terms:
- Procedures:
- Decision points:
- Anti-patterns:
- Examples:
- Verification ideas:

## Gaps
- Missing or inaccessible content:
- Assumptions:
- Freshness risks:
```
