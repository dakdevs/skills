---
name: pr-this
description: Create or update a draft pull request for the current branch using `gh` CLI. Triggers on "PR this", "create a PR", "open a PR", "make a PR", "submit PR". Idempotent - always re-assesses the full diff and either creates a new PR or updates the existing one. Creates draft PRs by default; say "do not draft" to create a ready-for-review PR instead.
---

# PR This

Create or update a well-crafted draft PR from the current branch against `main`.

## Behavior

Idempotent. Every invocation re-assesses the full diff against the base branch from
scratch and builds a completely fresh title and body. If a PR already exists for the
current branch it updates it; otherwise it creates a new one. No special flags needed -
just run `/pr-this` again whenever the branch changes.

**CRITICAL: When updating an existing PR, you MUST NOT read or reference the old PR
title or body. Do NOT run `gh pr view --json body` or similar. The old description is
dead - it reflects a previous state of the branch and will contaminate your output.
Derive everything exclusively from the current `git diff main...HEAD`. Every section
(Summary, What, Why, Diagram) must be written from scratch based solely on what the
diff shows right now.**

## Workflow

### 0. Stage and commit all changes

Before creating/updating the PR, ensure everything is committed.

1. Run `git status` to see all untracked and modified files.
2. Review the list. **Questionable files** - files that might not belong in the repo (e.g., `.env`, credentials, large binaries, editor configs, OS files, build artifacts) - should be flagged. Use the `AskUserQuestion` tool to ask the user whether to include each questionable file. List them all in a single question.
3. Stage everything the user approved (or everything if nothing was questionable):
   ```bash
   git add <files...>
   ```
4. Commit with a descriptive message summarizing all uncommitted work:
   ```bash
   git commit -m "$(cat <<'EOF'
   <message>

   Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
   EOF
   )"
   ```
5. If there are no uncommitted changes, skip this step and proceed.

### 1. Gather context

Run in parallel:

```bash
git log --oneline main..HEAD           # all commits on this branch
git diff --stat main...HEAD            # file-level summary
git diff main...HEAD                   # full diff
gh repo view --json nameWithOwner -q .nameWithOwner  # org/repo for links
git rev-parse HEAD                     # SHA for permalinks
git log main..HEAD --format="%s"       # commit messages for title conventions
```

Also read recent merged PR titles to match repo conventions:

```bash
gh pr list --state merged --limit 5 --json title -q '.[].title'
```

### 2. Clarify intent

Before analyzing, use `AskUserQuestion` to ask the user about the motivation
and goals behind the changes. Ask concisely - e.g., "What's the main goal of
this PR? Any specific wins or context I should highlight?" Use their answer to
inform the Summary and Why sections. If the branch name and commits already
make the intent crystal clear, you may skip this step.

### 3. Analyze changes

From the diff, commit history, and user's stated intent, identify:

- **What** changed (files, modules, functions)
- **Why** it changed (the motivation - from user's answer, commits, branch name, code context)
- **Who benefits** from this change and how (see "Who this helps" guidance below)
- **Notable areas** reviewers should look at closely

### 4. Build the PR title

Match the repo's existing commit/PR title conventions (e.g., conventional commits `feat:`, `fix:`, or freeform). Keep it under 70 chars.

### 5. Build the PR body

Use this structure:

```markdown
## Summary

1-3 sentences. Plain English - no jargon, no code references, no file names.
Analyze the diff and state objectively what this PR achieves. Frame wins in
terms of concrete outcomes: product improvements, developer experience gains,
performance or speed improvements, new capabilities unlocked, reliability or
correctness increases, reduced complexity, etc. This should read like a
confident release note - what got better and why it matters. If the PR does
multiple things, cover all of them. Must be a strong, quick-read
representation that anyone (engineer or not) immediately understands the value of.
If and only if the scope genuinely can't fit in 3 sentences, switch to bullet
points - one per win. Keep each bullet to one sentence.

## What

1-3 bullet points. Each should be one sentence max. Link to specific code lines
when it compresses context better than describing. Use GitHub permalink format:
`https://github.com/{org}/{repo}/blob/{sha}/{path}#L{start}-L{end}`

## Why

1-2 sentences on motivation. What problem does this solve or what does it enable?

## Who this helps

Identify the real people who benefit from this change and say specifically how.
Think honestly about this - don't inflate the impact or reach for vague claims.

**Customer:** Name the actual audience - end users, other engineers on the team,
ops/SRE, the author's future self, a specific downstream service's consumers, etc.
Be specific. "Users" is almost never the right answer - say which users and in
what context. If the change is pure internal cleanup that only helps the next
person who touches this code, say that honestly.

**Impact:** 1-2 sentences on what concretely gets better for them. Not what the
code does differently - what the *person* experiences differently. Faster page
loads they'll notice? Fewer false alerts waking them up? A confusing API they
no longer have to work around? An error message that now actually tells them
what went wrong? If the impact is indirect or delayed (e.g., "this unblocks X
which will eventually let us do Y"), say so - don't pretend the end user feels
it today if they don't.

If multiple groups benefit, list them separately. If the honest answer is "this
mostly helps us maintain the codebase" - that's a valid customer and a real win,
just say it plainly.

## Diagram

<mermaid diagram - see below>

## Notes for reviewers

Optional. Only include if there are genuinely tricky areas, known limitations,
or decisions worth calling out. Skip this section entirely if there's nothing
non-obvious.
```

**Tone:** casual, professional, direct. No filler. Write like you're talking to
a senior engineer over coffee - they don't need hand-holding, just the signal.

**HARD REQUIREMENT: NEVER use emdashes anywhere in PR titles, bodies, commit
messages, or any output. Use regular dashes (-) or rewrite the sentence instead.**

**Never** include any AI attribution anywhere - no "Generated with Claude Code", no "Generated by Claude", no "Co-authored by AI", no bot footers, nothing. Not in the PR title, body, or commit messages created in step 7.

**Code links:** Use `[descriptive text](permalink)` whenever pointing at a
specific function, struct, or block is clearer than explaining it in prose.
Build permalinks from the SHA and file paths gathered in step 1.

### 6. Mermaid diagram

**Always use Before / After diagrams.** Every PR diagram section must contain
two separate mermaid diagrams showing the system before and after the change.
This is the default and only format. If the PR is a one-line config change or
a simple rename where a diagram adds no value, skip the `## Diagram` section
entirely - but if you include diagrams, they must be before/after.

**Ask yourself before adding diagrams:** "Does this help a reviewer understand
the PR faster than reading the bullet points?" If no, don't include them.

#### Choosing the right diagram type

Pick the type that best communicates the *nature of the change*:

- **flowchart** - control flow, request paths, pipelines, decision trees
- **sequenceDiagram** - temporal interactions between services/components (who calls whom, in what order)
- **classDiagram** - struct/type relationships, module boundaries, inheritance
- **graph** - dependency or data flow between modules

Both diagrams should use the same diagram type for easy comparison.

#### What to show

The diagrams should tell a **specific story** about the PR:

- Show the **relevant slice** of the system, not the entire architecture. Only
  include nodes/edges that are touched by the PR or that provide necessary
  context for understanding what changed.
- Label edges with **what flows through them** (data types, event names, HTTP
  methods) - not just arrows connecting boxes.
- Use **real names** from the code (function names, service names, struct names)
  so the diagram maps directly to the diff.
- Keep it **compact**. If a diagram has more than ~12 nodes, you're showing
  too much. Zoom in on the interesting part.

#### Color coding (After diagram only)

The "Before" diagram should be **plain** (no color) - it represents the old state.

The "After" diagram uses color to highlight what's new or changed. Colors must
work in both GitHub light and dark mode - use medium-tone fills with explicit
white text (`color:#fff`):

```
style NodeName fill:#2ea043,stroke:#3fb950,color:#fff  %% added (green)
style NodeName fill:#d29922,stroke:#e3b341,color:#fff  %% changed (amber)
style NodeName fill:#388bfd,stroke:#58a6ff,color:#fff  %% unchanged context (blue, use sparingly)
```

Include a legend at the bottom of the After diagram:

```
subgraph Legend
  direction LR
  added[Added]
  changed[Changed]
  style added fill:#2ea043,stroke:#3fb950,color:#fff
  style changed fill:#d29922,stroke:#e3b341,color:#fff
end
```

#### Format

Always use this format:

````markdown
### Before

<1 sentence caption explaining what the reviewer is looking at>

```mermaid
<diagram showing the old structure - NO color coding, all nodes neutral>
```

### After

<1 sentence caption explaining what changed>

```mermaid
<diagram showing the new structure - use green for added, amber for changed>
```
````

Rules:
- Each diagram must be **self-contained and independently readable**. A reviewer
  should understand each one without cross-referencing the other.
- Use **the same node IDs** for components that exist in both diagrams so the
  reviewer can visually map what moved or changed.
- Both diagrams must have a **brief caption** (1 sentence) above them.

#### Syntax validation

Before including the diagram in the PR body, double-check for common mermaid
syntax errors:
- Subgraph names must NOT be quoted (use `subgraph My Name`, not `subgraph "My Name"`)
- Node IDs cannot contain spaces or special characters
- Arrow syntax must be valid (`-->`, `-.->`, `==>`)
- Style declarations must reference existing node IDs
- Nested subgraphs must be properly closed with `end`

### 7. Push and create or update the PR

#### 7a. Push the branch

```bash
git push -u origin HEAD
```

#### 7b. Check for an existing PR

Only fetch the PR number and URL - nothing else. Do NOT fetch the old title or body.

```bash
gh pr view --json number,url 2>/dev/null
```

If a PR already exists, update it. If not, create one.

#### If no PR exists - create

Default is `--draft`. If the user said "do not draft", omit `--draft`.

```bash
gh pr create --base main --draft --title "<title>" --body "$(cat <<'EOF'
<body>
EOF
)"
```

#### If a PR already exists - update

**IMPORTANT: The title and body you pass here MUST be built entirely from the
current diff (steps 1-6). Do NOT read the old PR body. Do NOT carry forward any
content from a previous description. Do NOT try to "merge" old and new content.
Treat this as if you are writing the PR description for the first time - because
the branch has changed, the old description is stale and wrong.**

```bash
gh pr edit <number> --title "<title>" --body "$(cat <<'EOF'
<body>
EOF
)"
```

Print the PR URL when done.
