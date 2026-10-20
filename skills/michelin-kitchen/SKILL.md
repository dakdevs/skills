---
name: michelin-kitchen
description: Execute a supplied implementation task or issue through investigation, implementation, before/after evidence, paired cross-model ownership of every installed principle skill, a draft PR, and completed Claude review of the final revision. Use when the user requests the michelin-kitchen workflow for a task.
metadata:
  source: Adapted from Dak's handoff-prompt workflow with product-specific assumptions removed.
---

# Michelin kitchen

Run the complete workflow for the supplied task. An invocation such as `$michelin-kitchen fix the CSV export` or `$michelin-kitchen <issue URL>` is an instruction to do the work and deliver the verified result, not merely produce an implementation prompt. Creating, installing, or discussing this skill does not launch its workflow.

## Start

Read [the full workflow](references/workflow.md) before executing. Also read [the principle inventory](references/principles.md) and [the ownership protocol](references/ownership.md). The package bundles a 2026-10-20 snapshot of 23 principle skills; reconcile these with the host's installed `principle-` skills on each invocation. Every skill gets independent model ownership under the ownership protocol across execution and verification, followed by evidence-backed agreement. The two general review lenses, evidence rules, PR workflow, and completion conditions remain in the workflow.

Extract the task, issue URL or ID, authorized repositories, and explicit overrides from the request and conversation. Use the current task repository unless the user names another. If no task or target repository can be identified, ask for the missing information before editing. A supplied issue URL is sufficient to begin fetching context, but is not permission to edit every linked repository. Do not infer acceptance criteria from its slug.

Execute the workflow directly. Discover repository instructions, commands, contracts, and available tools. Preserve explicit user overrides consistently throughout the workflow, including owner models, assignments, and derived re-review counts. Do not silently replace unavailable reviewer models. Follow the host's supported orchestration and PR watching mechanisms; T3-specific instructions apply only in T3.

## Completion

Deliver the implemented result, draft PR URL, actual verification results, before/after evidence, the full ownership matrix, both models' agreement records, all general review outcomes, and Claude's review of the final revision. Every valid required finding must be resolved and verification must cover the final implementation. A created PR, stale review, missing screenshot, or silent reviewer is not completion. When blocked, report the precise prerequisite and remaining work, continue independent authorized work, and retain resumable state without claiming success.

If the user explicitly requests only a handoff prompt, resolve the workflow with the complete task, repository scope, ticket title rule, and task-specific verification. Embed the resolved inventory, full selected principle instructions, ownership protocol, and workflow in the self-contained handoff. Include required supporting references in full; use an attached exact-text artifact if too large for chat. Never substitute skill names or local paths for the instructions, omit skills to shorten the handoff, or leave unresolved placeholders. Do not execute the task in this mode.

For provenance and file ownership, see [source](source.md) and [architecture](architecture.md). When changing the skill, use [behavioral cases](evals/cases.md); do not launch real tasks, publish PRs, or start watchers merely to test installation.
