---
name: auditing-interface-quality
description: Use when reviewing frontend source for UI consistency, design-system drift, unstable layout or state changes, inconsistent interaction behavior, motion quality, responsive defects, or accessibility patterns, and the user wants prioritized remediation guidance without implementation.
---

# Auditing Interface Quality

## Overview

Audit frontend source for the systems that make an interface feel coherent, predictable, and physically stable. Infer the project's own interface language first, then produce evidence-backed remediation guidance without editing the application.

**Core principle:** Stable UI is not motionless UI. It preserves geometry, identity, state continuity, input behavior, and feedback locality while change occurs.

## Boundaries

- Keep the audit read-only. Do not edit application source, install dependencies, or apply remediation.
- Use source, project documentation, configuration, and existing tests only. Do not require or use a browser in this workflow.
- Do not consult external library documentation, web sources, design guidelines, or standards to fill source gaps. If a higher-priority instruction explicitly requires external context, disclose it under evidence boundaries and never use it as evidence of project behavior.
- Report source facts as facts. Label rendering-dependent behavior as a **source-inferred risk** and name the runtime check needed to confirm it.
- Do not claim visual appearance, accessibility conformance, performance, layout-shift magnitude, or cross-browser behavior from source alone.
- Preserve documented product-specific exceptions. Audit consistency with the project's language, not conformity to a preferred aesthetic.

## Required Workflow

### 1. Establish the evidence boundary

Identify the project root, source areas reviewed, excluded areas, available design documentation, and whether tests exist. State that the result is source-only before presenting findings.

### 2. Infer the project's interface language

Inspect, in this order:

1. design-system, brand, accessibility, and contribution documentation;
2. global tokens, theme files, typography, spacing, radii, elevation, layers, breakpoints, and motion constants;
3. shared primitives and composition patterns;
4. representative consumers, routes, stateful surfaces, and tests.

Record intended rules separately from implementation conventions. Treat recurring, coherent implementation as an inferred convention only when documentation is silent.

### 3. Inventory interactive surfaces and state changes

Map representative controls, navigation, replacement content, overlays, asynchronous feedback, loading/empty/error states, responsive rearrangements, and focus transitions. Follow shared components to their consumers so one defect is not misreported as many unrelated defects.

### 4. Audit all nine quality systems

Read [references/audit-rubric.md](references/audit-rubric.md), then evaluate:

1. visual-system consistency;
2. layout and geometry stability;
3. state and content continuity;
4. interaction and input behavior;
5. motion behavior;
6. responsive layout and overflow;
7. accessibility and focus;
8. rendering, measurement, and first paint;
9. UI regression protection.

Mark a category **no material finding** when evidence does not support a problem. Do not manufacture one finding per category.

### 5. Build an evidence ledger

For every candidate finding, capture:

- exact `file:line` evidence;
- **Fact** or **Source-inferred risk**;
- affected components and known consumers;
- the documented rule or inferred convention involved;
- the likely causal mechanism;
- the runtime check needed, if any.

For absence findings, cite the closest manifest, configuration, or implementation line and state the directories and filename patterns searched.

### 6. Synthesize symptoms into patterns

Do not publish the evidence ledger as a flat bug list. Group symptoms that share a cause, then separate:

- **root cause** — the missing invariant, abstraction, policy, or state contract;
- **symptoms** — visible or behavioral consequences;
- **ownership layer** — foundation/token, primitive, shared component, feature consumer, or regression test.

Call something a **trend** only when there are at least two independent occurrences, or one shared implementation with multiple known consumers. Otherwise call it an isolated finding or shared-component risk.

### 7. Prioritize remediation

Use the severity and confidence predicates in [references/report-template.md](references/report-template.md). Prefer foundation-first fixes that remove several symptoms, but do not recommend broad abstraction when evidence supports only one local defect.

For each material finding, create a remediation card using [references/remediation-patterns.md](references/remediation-patterns.md). Every card must name the root cause, ownership layer, ordered application steps, implementation risks, verification method, and a measurable **Done when** condition.

### 8. Produce the report

Follow [references/report-template.md](references/report-template.md) exactly. Use [references/worked-example.md](references/worked-example.md) to calibrate synthesis depth, not as a source of project findings.

Scale depth to scope. For a representative audit of ten or fewer frontend files, publish at most three causal groups unless additional P0/P1 findings are evidenced, and target roughly 1,000–1,800 words. For a repository-scale representative audit, prefer three to five cross-cutting groups and roughly 2,000–3,500 words. Exceed those bounds only for additional high-severity findings or when the user explicitly requests exhaustive coverage. Never remove a required field to meet a length target; eliminate duplicated evidence prose and low-value symptom detail first.

## Evidence Rules

- Cite every material finding with at least one exact `file:line` reference.
- Cite the shared implementation and representative consumers when reporting shared blast radius.
- Keep facts and inferences visibly separate; do not hide uncertainty in confident prose.
- Prefer the smallest claim the evidence proves.
- Distinguish a policy violation from a missing policy.
- Distinguish intentional variation from accidental drift.
- Do not assign a severity above the evidenced user impact.
- Do not prescribe a library rewrite when the existing stack can enforce the invariant.

## Reference Routing

- Read [references/audit-rubric.md](references/audit-rubric.md) before collecting findings.
- Read [references/remediation-patterns.md](references/remediation-patterns.md) when forming remediation cards.
- Read [references/report-template.md](references/report-template.md) before writing the final report.
- Read [references/worked-example.md](references/worked-example.md) when symptoms, root causes, or ownership boundaries are unclear.

## Completion Gate

Before returning the audit, confirm all of the following:

- The evidence boundary and unverified runtime behavior are explicit.
- No undisclosed external documentation or web evidence informed the audit.
- The project's interface language and intentional exceptions are preserved.
- Every finding has exact evidence and a fact/inference label.
- Every trend meets the two-occurrence or shared-consumer threshold.
- Symptoms are grouped under root causes rather than duplicated as findings.
- Every remediation names one primary ownership layer.
- Application steps are ordered and do not silently broaden scope.
- Risks, verification, and a measurable `Done when` condition are present.
- The roadmap orders foundation, primitive, consumer, and test work coherently.
- No source was modified and no unsupported runtime claim is presented as observed.

## Quick Reference

| Question                  | Required answer                                                      |
| ------------------------- | -------------------------------------------------------------------- |
| What is true?             | Source fact with `file:line` evidence                                |
| What might happen?        | Source-inferred risk plus runtime confirmation                       |
| Is it a trend?            | Two occurrences or one shared implementation with multiple consumers |
| Where should it be fixed? | One named ownership layer                                            |
| How should it be fixed?   | Ordered, framework-compatible steps                                  |
| When is it complete?      | Observable `Done when` predicate                                     |

## Common Mistakes

- Listing every hard-coded value without first inferring whether the project uses tokens.
- Treating all motion as instability instead of checking geometry and state continuity.
- Reporting the same primitive defect once per consumer.
- Recommending local patches for a foundation-level invariant.
- Calling a plausible render outcome an observed defect.
- Importing external library behavior or design standards into a source-only conclusion.
- Treating one unusual instance as a systemic trend.
- Overriding a documented marketing or product exception with generic taste.
- Ending with “test this” instead of specifying scenario, observation, and pass condition.
