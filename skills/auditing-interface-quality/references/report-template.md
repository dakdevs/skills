# Audit Report Contract

Use these nine sections in order. Omit empty finding rows, not required sections. Prefer concise synthesis over a long inventory.

For representative audits, state each decisive citation once in the findings table and add detail in its remediation card only when needed to explain reach or causality. Do not restate the full evidence ledger in the verdict, strengths, pattern map, and card. Small scopes normally need no more than three cards; repository-scale representative audits normally need three to five. Additional P0/P1 findings always take precedence over the default size guidance.

## 1. Executive verdict

State in three to six sentences:

- the overall consistency and interaction-stability posture;
- the strongest foundations worth preserving;
- the two or three root causes with the largest user or system impact;
- whether any P0 or high-confidence P1 finding should block reuse or release.

Do not introduce evidence that is absent from later sections.

## 2. Evidence boundaries

Include:

- project and source roots reviewed;
- representative surfaces and shared layers traced;
- documentation, configuration, and test areas inspected;
- exclusions and unavailable evidence;
- explicit statement that no browser/runtime observation occurred;
- explicit statement that no external library documentation, web source, or external standard informed project findings, or a disclosure if higher-priority instructions required it;
- search scope for any absence claim.

Use this wording distinction consistently:

- **Fact:** directly established by source.
- **Source-inferred risk:** a plausible rendered or interaction outcome requiring the named runtime confirmation.

## 3. Inferred interface language

Describe the project's intended visual and behavioral system before criticizing deviations.

| System                  | Source evidence  | Intended or inferred rule            | Status                            |
| ----------------------- | ---------------- | ------------------------------------ | --------------------------------- |
| Example: control timing | `path/file:line` | Repeated feedback uses the fast tier | Documented / inferred / exception |

Call out documented exceptions with their scope. Do not recast an exception as drift unless its implementation exceeds that scope.

## 4. Strengths to preserve

List only source-backed strengths that should survive remediation. Cite exact `file:line` evidence. Prefer systemic strengths—tokens, primitives, state contracts, stable-slot patterns, motion policy, tests—over aesthetic praise.

## 5. Pattern map

Synthesize evidence before listing findings.

| Root cause                  | Symptoms grouped under it                     | Blast radius                                              | Primary ownership layer                                                |
| --------------------------- | --------------------------------------------- | --------------------------------------------------------- | ---------------------------------------------------------------------- |
| Missing or broken invariant | Concrete consequences, not duplicate findings | Isolated / trend / shared-component risk; known consumers | Foundation / primitive / shared component / consumer / regression test |

Rules:

- Use **trend** only for two independent occurrences.
- Use **shared-component risk** for one implementation with multiple known consumers.
- Use **isolated** for one occurrence without demonstrated shared reach.
- Split entries when remediation ownership differs, even if symptoms look similar.

## 6. Prioritized findings

### Severity predicates

- **P0 — Blocking:** Source proves a core task is inoperable for an input/user group, state can trigger destructive or irrecoverable behavior, or a shared primitive deterministically exports a severe interaction failure. Do not assign P0 for polish or unmeasured discomfort.
- **P1 — High:** A shared or repeated defect materially harms continuity, accessibility, responsive reachability, or interaction predictability, but a viable path remains.
- **P2 — Medium:** A localized inconsistency or risk degrades clarity, efficiency, resilience, or maintainability without blocking the task.
- **P3 — Low:** Bounded polish or prevention work with limited immediate user impact.

### Confidence predicates

- **High:** The behavior or policy mismatch follows deterministically from source, and the relevant abstraction/consumer trace is complete.
- **Medium:** The causal mechanism is evidenced, but visible impact depends on rendering, content, environment, or an uninspected abstraction.
- **Low:** Evidence is incomplete or mainly speculative. Put this in verification gaps rather than prioritized remediation unless potential impact is exceptional.

### Findings table

| ID    | Severity | Confidence | Evidence type | Root cause               | User/system impact                  | Evidence                                           | Ownership         | Runtime confirmation         |
| ----- | -------- | ---------- | ------------- | ------------------------ | ----------------------------------- | -------------------------------------------------- | ----------------- | ---------------------------- |
| IQ-01 | P1       | High       | Fact          | Concise causal statement | Specific affected task or invariant | `path/file:line`; representative consumer evidence | One primary layer | Not required, or exact check |

Every row must map to one pattern-map root cause and one remediation card. Do not create separate rows for symptoms with the same cause and owner.

## 7. Remediation cards

Create one card per finding using this exact field order.

### IQ-01 — Outcome-oriented title

**Target outcome:** State the user-observable invariant to restore.

**Root cause:** Name the missing or broken system contract, not the visible symptom.

**Evidence and reach:** Cite every decisive `file:line`, identify independent occurrences or shared consumers, and label facts versus source-inferred risks.

**Why it matters:** Connect the cause to a specific task, user group, consistency rule, or regression surface. Keep severity separate from confidence.

**Primary ownership layer:** Choose exactly one: foundation/token, primitive, shared component, feature consumer, or regression test.

**Affected files and consumers:** Name likely implementation targets and known downstream surfaces. Mark unverified consumers as search targets, not facts.

**Apply in this order:**

1. Start at the owning layer.
2. Migrate or adapt consumers only as required.
3. Preserve documented exceptions and public behavior.
4. Add protection for the restored invariant.

Use concrete project-compatible steps. Do not prescribe a framework rewrite unless the current stack cannot express the invariant and the evidence proves that limitation.

**Implementation risks:** Name likely regressions, migration hazards, state/focus changes, responsive tradeoffs, or abstraction overreach.

**Verification:** Specify scenario, input/environment, observation, and expected result. Separate source/unit/component/E2E/manual checks when useful.

**Done when:** Give one or more observable pass/fail predicates. “Looks consistent,” “tested,” or “uses tokens” is insufficient.

## 8. Phased roadmap

Order work by dependency and blast radius, not by file order.

1. **Foundation:** reconcile tokens, policies, ownership, and intentional exceptions.
2. **Primitives:** restore semantics, state contracts, geometry, measurement, and motion behavior.
3. **Shared components and consumers:** migrate affected compositions; avoid parallel local fixes.
4. **Regression protection:** add component, E2E, accessibility, geometry, or visual checks for the actual invariants.

For each phase, list finding IDs, dependencies, safe parallel work, and the reason for the order. Delete phases that truly do not apply, but explain why.

## 9. Verification plan and evidence gaps

Use a matrix that turns uncertainty into follow-up work.

| Invariant               | Scenario/input                      | Check type               | Pass condition                                                         | Covers findings |
| ----------------------- | ----------------------------------- | ------------------------ | ---------------------------------------------------------------------- | --------------- |
| Stable replacement slot | Rapid switching with unequal panels | Component + rendered E2E | No two normal-flow panels; downstream geometry follows declared policy | IQ-02           |

End with:

- source-inferred risks still requiring runtime confirmation;
- surfaces not reviewed;
- limits on accessibility, contrast, performance, and cross-browser conclusions;
- existing commands the implementing team should run after remediation, if evidenced in project configuration.

Do not imply that executing those checks was part of the source-only audit.
