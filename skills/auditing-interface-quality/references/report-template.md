# Audit Report Contract

Use these nine sections in order. Keep evidence concise and prioritize causal groups over exhaustive symptom inventories.

## 1. Executive verdict

State in three to six sentences:

- the overall design-quality posture;
- the overall UI/component-architecture posture;
- the strongest qualities worth preserving;
- the two or three highest-leverage causes;
- whether any high-confidence finding should block release or component reuse.

Design quality and architecture must both appear here. Do not lead with accessibility, testing, or motion unless they are genuinely the dominant product issue.

## 2. Evidence boundaries

Include:

- project and source roots reviewed;
- representative pages, workflows, components, and layers traced;
- design/product documentation, stories, examples, and tests inspected;
- excluded surfaces and unavailable visual/runtime evidence;
- explicit statement that no browser/runtime observation occurred;
- explicit statement that no external source informed findings, or a disclosure if higher-priority instructions required one;
- search scope for absence claims.

Use:

- **Fact:** directly established by source.
- **Source-inferred risk:** a likely final visual or runtime outcome requiring confirmation.

## 3. Intended design direction and strengths

Describe the audience, primary tasks, information hierarchy, visual character, density, and interaction posture inferred from the project.

| Design dimension   | Evidence         | Intended or inferred direction           | Status                            |
| ------------------ | ---------------- | ---------------------------------------- | --------------------------------- |
| Example: hierarchy | `path/file:line` | Primary task leads; metadata stays quiet | Documented / inferred / exception |

Then list source-backed design and architecture strengths that remediation must preserve. Call out bounded product, brand, marketing, editorial, or platform exceptions.

## 4. Design-quality assessment

Assess the visible design decisions separately from implementation cleanliness.

| Dimension                       | Assessment                           | Evidence                             | Consequence                                    |
| ------------------------------- | ------------------------------------ | ------------------------------------ | ---------------------------------------------- |
| Hierarchy and composition       | Strong / mixed / weak / inconclusive | Representative `file:line` citations | Effect on scanning, grouping, or task priority |
| Typography and content          | ...                                  | ...                                  | ...                                            |
| Color, surfaces, and emphasis   | ...                                  | ...                                  | ...                                            |
| Spacing, density, and rhythm    | ...                                  | ...                                  | ...                                            |
| Interaction feedback and motion | ...                                  | ...                                  | ...                                            |
| Responsive and inclusive states | ...                                  | ...                                  | ...                                            |

Use **inconclusive** where source cannot establish the final result. Do not replace assessment with a token inventory.

## 5. UI and component architecture map

Show where decisions live and whether each layer has a coherent role.

| Layer          | Observed responsibility               | Evidence and consumers | Architecture assessment                          |
| -------------- | ------------------------------------- | ---------------------- | ------------------------------------------------ |
| Foundations    | Tokens, theme, type, spacing, motion  | `path/file:line`       | Clear / missing concept / duplicated / overbuilt |
| Primitives     | Semantics and low-level mechanics     | ...                    | ...                                              |
| Components     | Reusable product anatomy              | ...                    | ...                                              |
| Compositions   | Repeated sections/workflows           | ...                    | ...                                              |
| Features/pages | Domain content, state, task hierarchy | ...                    | ...                                              |
| Governance     | Docs, stories, tests, review gates    | ...                    | ...                                              |

Explicitly assess boundaries, APIs/variants, state ownership, reuse, consumer overrides, and change impact. A layer may legitimately be absent in a small project.

## 6. Prioritized causal findings

### Severity

- **P0 — Blocking:** A core task is source-proven inoperable, destructive, or irrecoverable, or a shared primitive deterministically exports a severe failure.
- **P1 — High:** Design hierarchy, comprehension, component reuse, or interaction quality is materially harmed across a primary surface or shared layer.
- **P2 — Medium:** A bounded design or architecture defect degrades clarity, coherence, resilience, or change cost without blocking the task.
- **P3 — Low:** Limited polish or prevention work.

### Confidence

- **High:** The design mismatch or architecture cause follows directly from source and representative consumers were traced.
- **Medium:** The cause is evidenced, but visible impact or reach depends on rendering, content, environment, or uninspected consumers.
- **Low:** Evidence is incomplete. Put it in evidence gaps unless potential impact is exceptional.

### Pattern map

| ID    | Severity | Confidence | Design problem           | Architecture cause                | Blast radius                             | Evidence                       | Primary owner | Runtime confirmation        |
| ----- | -------- | ---------- | ------------------------ | --------------------------------- | ---------------------------------------- | ------------------------------ | ------------- | --------------------------- |
| IQ-01 | P1       | High       | User-facing quality loss | Misplaced/missing system decision | Isolated / trend / shared-component risk | `path/file:line` and consumers | One layer     | Exact check or not required |

Rules:

- Group symptoms that share a cause and owner.
- Separate causes when target ownership differs.
- Use **trend** only for two independent occurrences.
- Do not make tests, tokens, or abstraction the design problem; state the user-facing consequence first.

## 7. Remediation cards

Create one card per finding in this field order.

### IQ-01 — Outcome-oriented title

**Target design outcome:** Describe the intended hierarchy, clarity, coherence, character, density, or feedback.

**Target architecture:** Describe the desired layer ownership, boundary, API, composition, or governance shape.

**Root cause:** Connect the current architectural decision to the design consequence.

**Evidence and reach:** Cite decisive `file:line` evidence, representative consumers, occurrence type, and fact/inference labels.

**Why it matters:** Tie the issue to a primary task, design quality, component reuse, or cost of change.

**Primary ownership layer:** Choose one: foundation, primitive, component, composition, feature/page, or governance.

**Affected files and consumers:** Name implementation targets and known consumers. Mark unverified consumers as search targets.

**Apply in this order:**

1. Establish or preserve the intended design decision.
2. Move enforcement to the correct owner.
3. Define the target API, composition, state, or token contract.
4. Migrate representative consumers and remove parallel decisions.
5. Add focused governance for the restored quality.

Use project-compatible steps. Do not prescribe a framework rewrite or universal component without evidence.

**Migration and design risks:** Name likely visual regressions, API breakage, consumer drift, over-abstraction, content problems, focus/state changes, or exception loss.

**Verification:** Specify realistic content, pages, states, viewports, interactions, architecture/source checks, and expected result.

**Done when:** Give observable design and structural predicates. “Looks better,” “uses components,” or “uses tokens” is insufficient.

## 8. Target architecture and roadmap

Describe the target system before listing phases. A compact target map is preferred:

```text
foundations → primitives → components → compositions → pages
                         ↘ governance protects each material contract
```

Then order work by design leverage and dependency:

1. clarify design intent and semantic foundations;
2. correct primitive/component boundaries and APIs;
3. establish shared compositions and migrate pages;
4. align state, responsive behavior, motion, and accessibility;
5. protect the quality bar with stories, tests, and review gates.

Delete irrelevant phases and explain why. Identify safe parallel work and migration sequence.

## 9. Verification plan and evidence gaps

| Quality or architecture invariant | Representative scenario                         | Check type                      | Pass condition                                                | Findings |
| --------------------------------- | ----------------------------------------------- | ------------------------------- | ------------------------------------------------------------- | -------- |
| Primary hierarchy is consistent   | Realistic page with long content and all states | Source + rendered design review | Reading/action order remains clear; semantic roles are reused | IQ-01    |

End with:

- visual/runtime questions that source cannot answer;
- unreviewed pages, consumers, themes, states, or platforms;
- limits on accessibility, contrast, performance, and cross-browser claims;
- evidenced project commands the implementing team should run after remediation.

Do not imply those runtime checks were executed during the source-only audit.
