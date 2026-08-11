---
name: pr-this
description: Create or update a draft pull request for the current branch using `gh` CLI. Triggers on "PR this", "create a PR", "open a PR", "make a PR", "submit PR". Idempotent - always re-assesses the full diff and either creates a new PR or updates the existing one. PR titles are framed around the product issue solved or prevented; PR bodies lead with a tight, evidence-backed "Why" section aimed at engineers. Creates draft PRs by default; say "do not draft" to create a ready-for-review PR instead.
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
(Why, Summary, What, Who this helps, Diagram) must be written from scratch based
solely on what the diff shows right now.**

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

Before analyzing, use `AskUserQuestion` to gather the evidence needed to write a
tight, argument-proof **Why** section. Ask concisely and aim for specifics over
opinions - e.g., "What concrete problem does this address, and what evidence do we
have it's real (tickets, metrics, incidents, blocked work)?" Use their answer to
ground every claim in observed facts. If the branch name, commits, and diff already
make the rationale and evidence crystal clear, you may skip this step.

### 3. Analyze changes

From the diff, commit history, and user's stated intent, identify:

- **Why** - the observed problem, concrete evidence it is real, and how this change
  addresses it (write this first)
- **What** changed (files, modules, functions)
- **Who benefits** from this change and how (see "Who this helps" guidance below)
- **Notable areas** reviewers should look at closely

### 4. Build the PR title

**Frame the title as solving or preventing a product issue, not as describing the
change.** The title is the first thing a reviewer reads and the only thing many
people will ever read - it should communicate the outcome, not the mechanics.

**Rules:**

- Lead with the product effect: what gets fixed, prevented, unblocked, sped up,
  or made safer. The reader should know what is better after merge, in user or
  operator terms.
- Use an active, outcome verb: `Fix`, `Prevent`, `Stop`, `Restore`, `Unblock`,
  `Speed up`, `Remove`, `Allow`, `Enable`. Avoid implementation verbs as the
  primary framing: `Refactor`, `Rewrite`, `Migrate`, `Update`, `Introduce`,
  `Add support for`.
- Name the user-visible or operator-visible symptom, not the file or module. A
  reviewer should be able to picture the broken or improved experience.
- Match the repo's existing title conventions. If the repo uses conventional
  commits, choose the prefix that reflects the product framing:
  - `fix:` - solving an existing product issue
  - `perf:` - solving a speed or efficiency issue
  - `feat:` - enabling a new product capability
  - `chore:` / `refactor:` - preventing a future product issue (only when no
    user-visible effect exists; the title body must still name the issue
    being prevented)
- Under 70 characters. Plain English. No jargon, no internal codenames, no file
  paths.

**Examples:**

| Bad (implementation framing) | Good (product framing) |
|---|---|
| Refactor session middleware to use BetterAuth client | Speed up dashboard loads and prevent silent sign-outs |
| Add retry logic to Stripe sync worker | Stop nightly Stripe syncs from stalling on rate limits |
| Migrate auth check to shared helper | Fix blank screen shown after session expiry |
| Update logger config | Stop dropping error logs during deploys |
| Introduce caching for user lookups | Cut profile page load time on cold requests |
| Remove deprecated cookie parser | Prevent future breakage when Node 20 drops the legacy parser |

If the change is genuinely internal with no current or imminent product impact
(e.g., test infrastructure, doc-only changes), it is acceptable to use a
descriptive title with the appropriate conventional-commits prefix (`test:`,
`docs:`, `chore:`). In every other case, the title must name the product issue
being solved or prevented.

### 5. Build the PR body

**Write the body top-down.** Draft `## Why` first - everything else supports it.
The audience is engineers: be tight, specific, and honest. A reviewer should
finish this section in 15 seconds and know exactly what is wrong and why this
fixes it.

Use this structure:

```markdown
## Why

**Required layout (3 blocks, no more):**

> **<One-line lede.>** State the product problem this solves or prevents in one
> sentence. Engineer audience - light technical terms are fine, but no file or
> function names. Cut every word that isn't load-bearing.

**Evidence:**
- 2-4 single-line bullets. Each must cite something concrete: a metric, a count,
  a date range, a ticket ID, an incident, a deprecation, a blocked workstream.
  No adjectives masquerading as evidence.

**Fix:** One sentence on what this PR does about it. Name the mechanism and the
outcome. If there's a real tradeoff, name it in a short clause.

**Length cap:** ~8 lines rendered. If it's longer, cut. Never collapse the blocks
into a paragraph. Never drop the labels.

**Tone (diplomatic, hard to argue with):**

- Describe, don't accuse. "Returns 500 on empty input" beats "is broken".
- Cite, don't assert. A number beats an adjective every time.
- Measured words: "consistently", "regularly", not "always", "constantly".
- Concede what's true. If the current approach was reasonable at the time, say so
  in 3 words. Small concessions make the larger point unassailable.
- "We", not "you". No urgency theater - skip "critical", "blocker", "must merge"
  unless the evidence justifies it.

**Argument-proofing check:** Before finalizing, ask:

- Could a reviewer dispute any factual claim? If yes, cite it or cut it.
- Have I addressed the obvious counterargument ("this can wait", "the workaround
  is fine", "scope is too big")? If a real objection exists, acknowledge it in one
  phrase and explain why the fix still holds.
- Would the author of the original code feel respected reading this?

**Examples:**

Bad (dense paragraph, no evidence, sounds like a TLDR):
"Dashboard requests currently resolve user sessions through a custom, hand-rolled
session proxy endpoint that manually fetches and validates raw JSON over the
network. This duplicates the auth client and was originally added for cookie
propagation. We replace it with the server-side auth client directly and add a
5-minute cache."

Good (tight, scannable, evidence-led):

> **Every dashboard load makes an extra network hop for a session check the auth
> library now handles natively.**

**Evidence:**
- 40-80ms tail latency on cold dashboard loads, traced to the proxy hop.
- Duplicates auth-client validation; breaks silently if the session schema drifts.
- The cookie-propagation bug this worked around (BetterAuth #2434) is fixed in
  the version we're on.

**Fix:** Replace the custom proxy with the server-side auth client and add a
5-minute session cookie cache. Behavior is unchanged for signed-in users.

---

Bad (vague, overstated, accusatory):
"The auth middleware is broken and needs to be refactored urgently."

Good (specific, measured, scannable):

> **Expired sessions show users a blank screen instead of redirecting to
> sign-in.**

**Evidence:**
- 14 support tickets in the last 3 weeks reference the blank-screen behavior.
- Onboarding rollout is paused until the sign-in flow is reliable end-to-end.
- No regression coverage on the expired-session path for dashboard routes.

**Fix:** Route expired sessions through the existing redirect helper and add a
regression test so the gap doesn't reopen.

## Summary

1-2 sentences. Plain English - no jargon, no code references, no file names.
State objectively what this PR does and delivers. This section confirms the
technical scope after the reader already understands the rationale. Don't repeat
the Why section - assume they read it. Focus on the outcome: what got better,
faster, safer, or simpler.

## What

1-3 bullet points. Each should be one sentence max. Link to specific code lines
when it compresses context better than describing. Use GitHub permalink format:
`https://github.com/{org}/{repo}/blob/{sha}/{path}#L{start}-L{end}`

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
The **Why** section follows the same tone but tighter and more polished: every
claim is evidence-backed, every word load-bearing. Confident without being
forceful. Specific without being accusatory.

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
