# Adversarial ownership and agreement

Use this protocol before implementation, during execution at the relevant stages, and on the final revision. The coordinator owns integration and the task ledger. Model owners own a principle's application and proof, not unrestricted write access to the repository.

## Ownership matrix

For every principle in the frozen inventory, assign two independent child tasks: GPT-6 Astra at Medium effort and Opus 5.5 at Medium effort. An explicit user override replaces the default model roster and effort settings consistently for principle ownership and general reviews. If the user specifies only one model, retain two independent owner tasks using that model and label the result same-model agreement, never cross-model agreement. Reduce the owner count only when explicitly requested; then all required owners must accept, and the report must disclose the reduced independence. Discover actual provider/model IDs and effort settings from the live catalog. Do not substitute models, use two instances of one model as cross-model agreement, or let the coordinator stand in for a missing owner. If required access is unavailable, report it and continue independent authorized work.

One skill per child task per model per stage. Use isolated read-only ownership tasks; the coordinator or separately assigned implementation workers perform agreed changes. Workers must have disjoint file or module ownership, know they are not alone, and preserve others' edits. Principle owners cannot recursively launch reviewers or edit the reviewed artifacts. Independent artifacts get separate output paths; only the coordinator writes the consolidated ledger.

With N principles and M required owner slots, each complete principle stage has N×M assignments. Final verification also has 2×M general review assignments: each owner slot independently performs each of the two general review lenses in the workflow. Derive all counts from the frozen inventory and chosen roster. References to pairs, both acceptances, or four general reviews elsewhere describe the default M=2; apply the explicit override consistently. Queue tasks within actual concurrency limits; do not weaken coverage to fit a batch limit. Progress reports include completed, queued, and blocked assignments.

## Before implementation

1. Give each owner the task, scope, baseline, its full selected skill instructions, relevant code and artifacts, and the common conflict-resolution rules. Keep first responses independent.
2. Each owner determines applicability, proposes concrete execution obligations, identifies a failure mode, and defines an independently checkable verification method. Process principles assess orchestration artifacts as well as product code. Non-applicability needs specific evidence, not a missing test or an inconvenient requirement.
3. Exchange both responses. Each owner challenges the other's applicability judgment, proposed approach, scope, and proof method. Use a concrete counterexample or cheaper adequate alternative; do not invent objections to meet a quota. Then each responds to the challenge.
4. The coordinator reconciles cross-principle conflicts and returns the proposed shared plan to the affected owners. Both owners explicitly accept the same obligations and checks, or record an unresolved objection. Start dependent implementation only after that skill's obligations are agreed; independent authorized work can proceed meanwhile.

## During execution

Apply each principle at its mapped stage, rather than saving it for a final audit. Before a design decision, migration, test, or verification unit depends on a principle, consult its agreed obligations. Have the pair assess new counterexamples or material deviations and update the shared plan. An implementation worker's claim is not owner acceptance: owners inspect the actual artifacts.

The coordinator integrates agreed work in checked units. Return new recurring failures, scope conflicts, changed applicability, or revised design assumptions to the relevant pairs. Preserve the trace from each obligation to its implementation and evidence. Do not force an inapplicable principle to create unnecessary product changes.

## Final verification and agreement

Freeze an exact revision or working-tree content snapshot and evidence set. Both owners independently assess their principle against this same snapshot, including execution records, runtime evidence, and claimed non-applicability. General reviewers assess the same snapshot. No editing during a review round.

After independent reports, exchange findings and the coordinator's proposed dispositions. Each pair must challenge and answer the other's claims, inspect the cited artifacts, and explicitly accept the same final disposition. General review pairs follow the same evidence and agreement protocol for their respective lenses. The coordinator validates every finding; model agreement alone is not proof.

Agreement means all required owners accept the same applicability decision, fulfilled execution obligations, verification artifacts, and disposition for every finding on the exact reviewed revision. Acceptable final statuses are `satisfied` or `not-applicable`, with evidence and both acceptances. `pending`, `disputed`, `blocked`, a missing response, or a failed check cannot pass. There is no majority vote, automatic tie-break, or silent waiver.

For disagreements, identify the falsifiable claim and run or inspect the smallest discriminating test. Share its result with both owners and request revised conclusions. After three exchanges without new discriminating evidence, record the unresolved objection and missing evidence or decision as a blocker; continue unrelated authorized work. Never manufacture consensus or silently loop forever. Resume when new evidence or an explicit user decision changes the disputed premise; record that decision without claiming the models agreed when they did not.

After any implementation change, rerun affected verification and the entire final ownership matrix plus all four general reviews on the new snapshot, including rechecking non-applicability. Reuse prior artifacts as context, never prior sign-offs as current approval. Revisit execution-stage agreement when the change alters its plan or applicability. Metadata-only PR prose edits do not require another implementation review, but claims and evidence must still match.

## Ledger and handoffs

Keep task state outside the product checkout unless the repository requires checked-in evidence. Record inventory sources/content hashes, model/effort, task IDs, stage and round, base and reviewed snapshot, applicability, execution obligation, implementation artifact, verification command/result, findings and severity, counterarguments, dispositions, both explicit acceptances, and unresolved blockers. Use bounded summaries in the coordinator and links to full artifacts; never rely solely on agent summaries.

A child brief includes the complete task, repository boundary, its full skill instructions, relevant artifacts, exact snapshot, its stage, the expected output fields above, and read-only/no-recursion constraints. Subsequent rounds also include prior findings, counterarguments, dispositions, and unresolved objections. Keep unrelated raw skill payloads out of each child's context.

Use child tasks, not new top-level conversations. In T3, discover `orchestrator_capabilities`; prefer native subagents when they support the selected model and use `delegate_task` otherwise. Every T3 follow-up review or agreement round gets new `delegate_task` calls and distinct stable `clientRequestId` values. Retain task IDs and use `task_status` or `task_cancel`; never continue rounds by sending to backing child threads. Persist completed work across host wakeups and do not duplicate pending tasks.
