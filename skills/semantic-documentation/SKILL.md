---
name: semantic-documentation
description: "Write and edit semantically dense documentation, README prose, API references, docstrings, and code comments. Use for documentation or comment work, preserving contracts, rationale, and executable behavior. Self-contained for on-demand invocation or repository inclusion."
---

# Semantic Documentation

Write compact, precise documentation and comments that preserve the reader's ability to understand and act. Apply to the requested artifacts; this skill works independently of any standing writing skill.

## Establish meaning

Use supplied facts, relevant code, tests, and existing documentation to establish the contract. Distinguish implemented behavior, intended behavior, and unverified claims. If sources conflict, use the authority specified by the task; otherwise investigate or flag the discrepancy rather than inventing a resolution.

Preserve inputs, defaults, omitted-versus-null distinctions, outputs, errors, side effects, ordering, concurrency, limits, units, versions, and prerequisites when relevant. Documentation work does not authorize changing implementation.

## Compress deliberately

Replace explanations with established concepts only when their defining properties hold. “Idempotent record creation; retries still incur charges” preserves a boundary that “idempotent requests” loses. Retain actors, logical relationships, uncertainty, exceptions, evidence, and authorization limits. Never add unsupported guarantees or requirements.

Prefer direct verbs, concrete subjects, and the shortest precise expression. Remove filler and duplicate explanations. Keep qualifications beside their claims. Preserve substantive content unless the task authorizes summarization or omission. Match the audience; retain useful examples and explain unfamiliar terms when needed.

Consult only the relevant [semantic thesaurus](references/semantic-thesaurus.md) section when a term choice warrants it. The vocabulary is illustrative, not mandatory.

## Documentation

- State the contract or purpose first, then the conditions needed to use it correctly. Preserve task-required detail, examples, evidence, and warnings.
- Preserve identifiers, commands, flags, defaults, units, quotations, links, cross-references, and public anchors where exactness matters. Keep runnable examples and doctests behaviorally intact; never abbreviate executable syntax to save words.
- Respect the repository's terminology, structure, generated-file boundaries, and source-of-truth conventions. Edit the authoritative source of generated prose when in scope.
- Flag material factual corrections or unresolved discrepancies. Do not silently convert desired behavior into a claim about current behavior.

## Comments and docstrings

- Preserve **why**, invariants, ownership, failure modes, compatibility constraints, and nonobvious tradeoffs. Keep supporting issue links and conditions for future removal.
- Remove comments that only narrate obvious code when they carry no independent meaning or repository-mandated role. Retain useful navigation and accessibility context.
- Keep rationale adjacent to the code it explains. Preserve public docstring contracts and meaningful documentation tags.
- Preserve machine-significant comments and their required placement: suppression directives, coverage pragmas, purity annotations, code-generation markers, license notices, and tool-consumed tags. Edit only safe explanatory prose around them.
- Restrict comment cleanup to prose. Preserve executable tokens, non-documentation strings, directive adjacency, and runnable example behavior. For requested docstring edits, retain delimiters, structured tags, and tool-consumed values while revising descriptive text.

## Verify and use

Check that expanding the revised text restores the same material claims and limits, without stronger guarantees. Inspect the diff for lost contracts, broken references, and unintended behavior changes. Run applicable formatting, documentation, and example checks required by the repository. Word counts alone do not establish token savings.

Invoke `$semantic-documentation` for an artifact or follow the [repository integration guide](references/repository-use.md). Load the [evaluations](references/writing-evaluations.md) only when testing this skill.
