# Quality Gates

Run these checks before declaring a source-derived skill tree complete.

## File Tree Gate

The tree should usually include:

- `SKILL.md`.
- `source.md`.
- `architecture.md`.
- At least one workflow file.
- Multiple detailed topic files when the source has multiple ideas.
- At least one example for non-trivial sources.
- Eval prompts when the skill can be tested.

Fail the gate if the result is only a top-level router for a multi-section source.

## Provenance Gate

Check:

- Source title is present.
- Author or organization is present when known.
- URL, file path, or source description is present.
- Access date is present for web sources when available.
- Adaptation scope says the tree is an authored expansion, not a copy.

## Copyright Gate

Check:

- No long copied passages.
- No copied full tables.
- No chapter-scale paraphrase that follows the original too closely.
- Quotes, if any, are short and justified.
- The skill can be useful without reproducing the source.

## Routing Gate

Check:

- Every route points to an existing local file.
- Routes are based on user signals or task signals.
- There are no fabricated external dependencies.
- Full-review route exists for broad tasks.
- Focused route exists for narrow tasks.

## Operability Gate

Each major document should tell the future agent:

- When to use it.
- What to do.
- What to avoid.
- What to output.
- How to verify.

Fail the gate if documents only summarize.

## Frontmatter Gate

Verify:

- YAML parses.
- `name` equals the directory name.
- `description` contains trigger conditions.
- Metadata credits the source when the tree is source-derived.

Example command:

```bash
ruby -ryaml -e 'p YAML.load_file(ARGV[0])["name"]' /path/to/SKILL.md
```

## Link and Path Gate

Verify:

- All document map paths exist.
- Referenced templates exist.
- Referenced examples exist.
- If mirrored, source and destination match.

Example command:

```bash
find /path/to/skill -maxdepth 3 -type f | sort
diff -qr /source/skill /mirrored/skill
```

## Completion Report Gate

Final response should include:

- Created skill path.
- File count and total lines.
- Whether `.claude` was updated.
- Verification performed.
- Any evals not run.
