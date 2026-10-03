---
name: semantic-density
description: "Standing writing discipline for general agent use. Apply across answers, reasoning summaries, plans, handoffs, delegation, and tool-facing prose to maximize recoverable meaning per token. Use as a baseline in agent Markdown or invoke for a task."
---

# Semantic Density

Use precise concepts to express the required meaning in the fewest useful tokens. Apply silently from the first draft across tasks. Compress expression while preserving necessary reasoning, investigation, and verification.

- Replace verbose explanations with established concepts when their defining properties hold: **idempotent**, **underdetermined**, **circular**, **invariant**, **provisional**. Prefer the shortest precise expression, whether technical or ordinary.
- Preserve material claims, actors, relationships, scope, conditions, exceptions, negation, quantities, uncertainty, provenance, and authorization boundaries. Keep may/must, necessary/sufficient, and observed/inferred distinct.
- Name the subject and retain its limits: “Invoice creation is idempotent; emails repeat.” Preserve mechanisms and next actions when material.
- Remove filler, repetition, ceremonial transitions, and redundant summaries. Keep logical connectors such as **unless**, **because**, and **only if**. Avoid invented jargon, unexplained shorthand, and keyword fragments.
- Match the reader and honor requested detail, examples, tone, and format. Shared terminology can compress meaning; unfamiliar terminology may increase explanation cost.
- Preserve exact commands, identifiers, literals, quotations, units, schemas, and required formats. Do not add unsupported guarantees or requirements; label assumptions.
- When editing, omit substantive content only if summarization or omission is authorized. If a hard limit cannot fit required meaning, state the conflict.

Briefly check recoverability: would expanding the wording restore the same claims and limits? Keep clearer wording whenever further compression increases ambiguity or reconstruction effort.

## Use

Invoke `$semantic-density` for a task, or copy the self-contained [standing instruction](assets/agent-instructions.md) into the agent's governing Markdown. The instruction works without loading additional files on every task.

This skill is independently portable: copy its whole folder into a repository and reference its `SKILL.md` from that repository's agent instructions. It has no sibling-skill dependency.

Optimize total context cost, including instructions and glosses. Fewer words do not guarantee fewer tokens; claim token savings only when measured with the target tokenizer.

Use the [evaluations](references/writing-evaluations.md) only when testing this skill.
