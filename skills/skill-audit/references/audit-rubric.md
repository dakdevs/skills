# Audit rubric

Use these questions where they fit the skill. They are an auditor's synthesis, not a lab-mandated checklist. Source IDs resolve in [sources.md](sources.md).

| Dimension               | Inspect                                                                                                           | Evidence and limits                                                     |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Activation              | Does the description identify the actual task? Could it trigger for adjacent work? Do neighboring skills compete? | OAI-SKILLS; evaluate both positive and negative requests.               |
| Context value           | Are repeated policies, generic advice, or unconditional reads consuming attention without changing a decision?    | OAI-SKILLS, ANT-CONTEXT; preserve necessary local knowledge.            |
| Resource routing        | Are optional resources linked with a clear use condition? Are paths valid and resources useful?                   | ANT-SKILLS; splitting is a means, not a quality metric.                 |
| Instruction precision   | Are outcomes, inputs, output constraints, and necessary sequences clear? Is a rigid recipe still justified?       | ANT-CONTEXT, OAI-SKILLS; smaller models may need different scaffolding. |
| Completion and autonomy | Does the workflow finish the requested job? Are stop conditions meaningful and permissions scoped?                | OAI-SKILLS; retain active user and environment requirements.            |
| Evidence and tools      | Are tool capabilities assumed? Can the skill report failed retrieval or verification accurately?                  | OAI-ASTRA §8.3, applied as a local testing hypothesis.                  |
| Trust boundaries        | Can audited files or retrieved documents redirect the agent? Are external actions tied to user intent?            | OAI-ASTRA §5.2, ANT-FABLE §5.2; relevant only to exposed workflows.     |
| Portability             | Are model and host requirements conflated? Are unavailable dependencies mandatory without a fallback?             | OAI-SKILLS, ANT-FABLE; exact host format checks need host docs.         |
| Demonstrated quality    | Do changes improve task outcomes without losing required behavior?                                                | ANT-EVALS; token reduction alone is insufficient.                       |

For each finding, state the path and line or heading, the problematic behavior, and a minimal revision. Cite the specific source section or direct local evidence. Label speculative changes as hypotheses and propose a test before presenting them as established improvements.

Example inference: a migration skill activates for every database question. Narrow its description to migration creation/review, then test a migration request and a read-only SQL explanation. Do not remove transaction ordering or rollback instructions to meet an arbitrary word budget.
