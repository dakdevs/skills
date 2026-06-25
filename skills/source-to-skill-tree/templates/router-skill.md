# Router SKILL.md Template

Use this as the starting point for generated source-derived skills.

```markdown
---
name: [skill-name]
description: "CRITICAL: Use when [task/domain]. Triggers on: [source-derived trigger terms, user phrases, file types, error signals, task signals]."
globs: ["[optional file globs]"]
metadata:
  origin_title: "[source title]"
  origin_author: "[source author or organization]"
  origin_url: "[source URL if any]"
  origin_path: "[local path if any]"
  origin_note: "Authored expansion based on the source; not a verbatim copy."
---

# [Skill Title]

> **Version:** 1.0.0 | **Last Updated:** [YYYY-MM-DD]
>
> **Origin Credit:** This skill tree is based on [source title] by [source author].

## Intent

[One to three paragraphs describing what the skill enables.]

## Document Map

| File | Purpose |
|------|---------|
| `source.md` | Origin credit, source map, adaptation scope |
| `architecture.md` | Operating model for the skill |
| `workflows/...` | How to apply the source |
| `references/...` | Detailed concepts |
| `examples/...` | Worked examples |

## Routing

| User Signal | Read First | Then Read |
|-------------|------------|-----------|
| [signal] | `[local-file.md]` | `[local-file.md]` |

## Full Application Route

1. `source.md`
2. `architecture.md`
3. [workflow files]
4. [relevant topic files]
5. [examples]

## Priority Order

1. [source-derived priority]
2. [source-derived priority]

## Output Format

[What the agent should return or modify.]
```
