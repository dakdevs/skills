# dakdevs/skills

Agent skills for Claude Code.

## Install

Install all skills:

```
npx skills add dakdevs/skills
```

Install a single skill:

```
npx skills add dakdevs/skills -s <skill-name>
```

## Skills

### best-practice-first

```
npx skills add dakdevs/skills -s best-practice-first
```

Research-first development — enforces official docs lookup, codebase pattern analysis, and pitfall identification before any implementation begins. Invoke with `/best-practice-first` or by saying "do it right", "research first", etc.

### pr-this

```
npx skills add dakdevs/skills -s pr-this
```

Create or update a draft pull request for the current branch using `gh` CLI. Idempotent — always re-assesses the full diff and either creates a new PR or updates the existing one.

### tldraw-canvas

```
npx skills add dakdevs/skills -s tldraw-canvas
```

Interact with open [tldraw](https://tldraw.com) desktop canvases via a local HTTP API. Create, read, update, and delete shapes. Build diagrams, flowcharts, wireframes, and visual layouts programmatically.
