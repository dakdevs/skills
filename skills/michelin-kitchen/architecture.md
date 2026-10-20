# Architecture

`SKILL.md` owns invocation, repository selection, explicit overrides, and execution versus handoff routing. `references/workflow.md` is the complete operational workflow and sole owner of the detailed execution, evidence, review, publication, and monitoring rules. `evals/cases.md` exercises scope and completion boundaries.

Run investigation and baseline capture before implementation, then verification, independent review, consolidation, draft publication, and Claude review. Any implementation change after review returns to verification and all required reviewers. Completion requires every stage to cover the final revision. Missing prerequisites leave the task incomplete with an explicit blocker.

Avoid treating the workflow as prompt generation by default, assuming a particular repository or toolchain, substituting reviewer models silently, or treating a stale review as approval of new code.
