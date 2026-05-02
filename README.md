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

### best-practices

```
npx skills add dakdevs/skills -s best-practices
```

Research-first development — enforces official docs lookup, codebase pattern analysis, and pitfall identification before any implementation begins. Invoke with `/best-practices` or by saying "do it right", "research first", etc.

### pr-this

```
npx skills add dakdevs/skills -s pr-this
```

Create or update a draft pull request for the current branch using `gh` CLI. Idempotent — always re-assesses the full diff and either creates a new PR or updates the existing one.

### claude-agent-team

```
npx skills add dakdevs/skills -s claude-agent-team
```

Spin up a team of specialized Claude agents for implementation tasks. Each agent owns a layer of the stack (core, integration, surface, verification) and works from deep internals outward. Invoke with `/claude-agent-team` or by saying "team go", "agent team go", etc.

### tldraw-canvas

```
npx skills add dakdevs/skills -s tldraw-canvas
```

Interact with open [tldraw](https://tldraw.com) desktop canvases via a local HTTP API. Create, read, update, and delete shapes. Build diagrams, flowcharts, wireframes, and visual layouts programmatically.

### twelve-factor

```
npx skills add dakdevs/skills -s twelve-factor
```

Tree-based router skill for [The Twelve-Factor App](https://12factor.net/) methodology. Top-level `SKILL.md` triggers on cloud-native / SaaS / containerized-app questions and routes to 12 leaf factor files (codebase, dependencies, config, backing services, build-release-run, processes, port binding, concurrency, disposability, dev/prod parity, logs, admin processes), plus cross-cutting guides for symptom → violation reverse lookup, modern (K8s / Docker / serverless) interpretations, and a walk-the-12 audit checklist for existing apps.

### agentic-docs-architecture

```
npx skills add dakdevs/skills -s agentic-docs-architecture
```

Tiered documentation pattern for repos organized for AI-agent effectiveness — `AGENTS.md`/`CLAUDE.md` per crate, `docs/{guides,architecture,features,reference}` tree, change-impact tables, compiler-enforced doc lints. Tells the agent where docs live, what AGENTS.md should contain, when to update the change-impact table, and why trait boundaries are firewalls. Triggers on adding/modifying crates, writing docs, or changing public APIs that have downstream doc impact.
