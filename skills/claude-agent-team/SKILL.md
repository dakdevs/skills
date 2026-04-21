---
name: claude-agent-team
description: Spin up a Claude agent team for implementation tasks. Use when user says "team go", "agent team go", "agent team", "/claude-agent-team", or wants a coordinated multi-agent approach to a feature or task.
---

# Claude Agent Team

Spin up a team of specialized agents using TeamCreate and the Task tool. Each agent owns a layer of the stack and works from the deep internals outward toward the surface.

## Philosophy

- **Internals outward**: Start from the core — data models, domain logic, protocols — and build toward the surface (APIs, UI, integration). Never start at the surface and hack inward.
- **Expert ownership**: Each agent is an expert in their layer. They make architecturally sound decisions for their domain, not expedient ones.
- **No hacks**: If something doesn't fit cleanly, redesign the approach. Do not paper over problems with workarounds, shims, or suppressed errors.
- **Context-aware**: Every agent must read and understand the existing codebase patterns, conventions, and surrounding code before making changes. Work WITH the codebase, not against it.

## Team Structure

Assign agents based on the task's layers. Typical roles:

| Role | Focus | Agent Type |
|------|-------|------------|
| **core** | Data models, domain logic, core crates/modules, invariants | general-purpose |
| **integration** | APIs, protocols, service boundaries, IPC, message formats | general-purpose |
| **surface** | UI, CLI, user-facing behavior, output formatting | general-purpose |
| **verification** | Tests, validation, ensuring nothing regressed | general-purpose |

Not every task needs all roles. Scale the team to the task — two agents for a focused change, four for a cross-cutting feature.

## Workflow

1. **Analyze the task** — Identify which layers are involved and what agents are needed.
2. **Create the team** — Use TeamCreate with a descriptive name.
3. **Create tasks** — Break the work into layer-specific tasks using TaskCreate. Set dependencies so internals complete before surface work begins.
4. **Spawn agents** — Launch agents via the Task tool with `team_name` set. Give each agent a clear prompt that includes:
   - Their role and layer ownership
   - The philosophy above (internals-out, no hacks, context-aware)
   - Specific files/modules they own
   - What to read first before making any changes
5. **Coordinate** — Assign tasks, manage dependencies, unblock agents as layers complete.
6. **Verify** — Once all agents finish, run a verification pass to confirm the pieces integrate correctly.
7. **Shut down** — Send shutdown requests to all agents and clean up with TeamDelete.
