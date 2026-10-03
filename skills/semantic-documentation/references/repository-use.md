# Repository Integration

This skill is self-contained. Copy the entire `semantic-documentation` folder into your repository, including `agents/`, `assets/`, and `references/`. For example, use `skills/semantic-documentation/`; if the repository already has a skill directory, follow that convention.

Append the [repository instruction](../assets/repo-instructions.md) to the repository's root `AGENTS.md` or equivalent agent Markdown. Its path assumes the example layout; adjust it for another location or a nested instruction file. Preserve existing instructions and their scope.

This explicit instruction makes the skill usable without relying on any particular tool's automatic discovery. It loads for documentation and comment tasks. It neither requires nor enables the general writing skill.

To also apply the general discipline, copy the separate `semantic-density` folder to `skills/semantic-density/` and add this instruction to the root agent Markdown:

> Apply `skills/semantic-density/SKILL.md` as the standing writing discipline across tasks. Read it once when needed; preserve explicit requests for detail and format.

Alternatively, embed that skill's `assets/agent-instructions.md` directly for a self-contained baseline with no recurring file load.

Keep relative references inside each skill intact. Copy either skill independently or both together. Do not copy only `SKILL.md` for documentation work: its thesaurus and supporting resources travel with it.
