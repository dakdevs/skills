# Evaluation

## Purpose

Evals check whether the generated skill makes future agents produce better skill trees than they
would without it.

Do not overcomplicate evals for a quick utility skill. Start with a small set of realistic prompts.

## Recommended Test Prompts

Use prompts that require structure, source credit, and local routed docs:

1. "Turn this blog post URL into a skill tree like rust-router. Make sure it credits the author."
2. "I have a 180-page PDF manual. Create a skill tree from it with workflows, troubleshooting, and examples."
3. "This generated skill is too thin. Expand it into a real document tree without copying the source."

## Assertions

Useful assertions:

- Creates `SKILL.md`.
- Creates `source.md`.
- Creates `architecture.md`.
- Creates at least three local detailed docs for multi-section sources.
- Includes source credit in frontmatter metadata.
- Includes source credit in `source.md`.
- Does not route to unrelated existing skills.
- Includes verification guidance.
- Includes at least one realistic example.
- Includes eval prompts or explicitly explains why evals were skipped.

## Lightweight Manual Evaluation

If the full benchmark harness is not run, still inspect:

- Does the tree match the source structure?
- Did it transform concepts into actions?
- Can a future agent route to the right local file?
- Is source credit clear?
- Are there signs of excessive copying?

## When to Run Full Skill-Creator Evals

Run full evals when:

- The skill will be reused often.
- The source-to-skill workflow must be reliable across many domains.
- The user asks for benchmarking.
- You are changing the skill's trigger description.

Follow the `skill-creator` evaluation loop when running full evals.
