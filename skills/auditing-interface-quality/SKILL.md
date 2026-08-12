---
name: auditing-interface-quality
description: Use when reviewing frontend source for design quality and UI/component architecture, including visual hierarchy, composition, typography, color, spacing, density, design-system coherence, component boundaries, APIs, variants, state ownership, reuse, responsive behavior, interaction quality, accessibility, or stability, and the user wants prioritized remediation guidance without implementation.
---

# Auditing Interface Quality

## Overview

Audit two inseparable qualities: whether the interface expresses a clear, coherent design and whether its component architecture can preserve that quality as the product evolves.

**Core principle:** A polished screen built on weak components will drift, while tidy components without visual intent produce generic UI. Evaluate design decisions and the architecture that carries them together.

## Boundaries

- Keep the audit read-only. Do not edit application source, install dependencies, or apply remediation.
- Use source, project documentation, configuration, stories, and existing tests only. Do not require or use a browser in this workflow.
- Do not consult external library documentation, web sources, design guidelines, or standards to fill source gaps. If higher-priority instructions require external context, disclose it and never use it as evidence of project behavior.
- Report declarations, structure, and control flow as **facts**. Label final visual or runtime outcomes as **source-inferred risks** and name the check needed to confirm them.
- Do not substitute personal taste for product intent. Preserve deliberate brand, marketing, editorial, platform, and feature-specific exceptions.
- Do not reduce design quality to token compliance, accessibility, or motion polish. Assess hierarchy, composition, clarity, character, and component architecture explicitly.

## Required Workflow

### 1. Establish the evidence boundary

Identify the project root, frontend areas reviewed, excluded surfaces, design documentation, stories/examples, and available tests. State the source-only limitation before findings.

### 2. Infer product and design intent

Inspect, in order:

1. product, brand, design-system, content, and accessibility documentation;
2. representative pages or feature compositions, especially primary workflows;
3. typography, color, spacing, density, radius, elevation, layer, breakpoint, and motion foundations;
4. shared UI primitives, components, stories, examples, and tests.

Describe the intended audience, task hierarchy, visual character, information density, and interaction posture. Separate documented intent from recurring implementation conventions.

### 3. Map the UI architecture

Trace representative UI through these layers:

1. **Foundations:** tokens, themes, type scale, spacing, breakpoints, motion, icons.
2. **Primitives:** semantic controls and low-level layout or overlay behavior.
3. **Components:** reusable product-aware elements with bounded responsibilities.
4. **Compositions:** repeated page sections and workflow patterns.
5. **Features/pages:** domain state, content, data, and routing.
6. **Governance:** stories, tests, documentation, lint rules, and review gates.

Record ownership leaks, duplicated decisions, unclear boundaries, prop/variant complexity, and consumer overrides. Follow shared components to representative consumers before judging their architecture.

### 4. Audit all ten quality systems

Read [references/audit-rubric.md](references/audit-rubric.md), then evaluate:

1. product intent and visual direction;
2. hierarchy, composition, and content clarity;
3. typography, color, spacing, density, and surface quality;
4. design-system coherence and token architecture;
5. component boundaries and layer ownership;
6. component APIs, variants, slots, and composition;
7. state, behavior, and data ownership;
8. responsive layout, interaction, motion, and stability;
9. semantics, accessibility, and inclusive states;
10. documentation, stories, tests, and design governance.

Mark a category **no material finding** when evidence does not support a problem. Do not manufacture coverage findings.

### 5. Build a design-and-architecture evidence ledger

For every candidate finding, capture:

- exact `file:line` evidence;
- **Fact** or **Source-inferred risk**;
- intended design rule or inferred convention;
- design consequence: hierarchy, clarity, coherence, density, character, or feedback;
- architecture consequence: ownership, reuse, API complexity, drift, or change cost;
- affected layers, components, and known consumers;
- causal mechanism and runtime confirmation, if needed.

For absence findings, cite the nearest manifest, implementation, or configuration line and state the search scope.

### 6. Synthesize causes across both lenses

Do not publish a style-literal inventory or component-by-component critique. Group symptoms under causes, then name:

- **design problem** — the user-facing loss of hierarchy, clarity, coherence, identity, or quality;
- **architecture cause** — the misplaced decision, missing abstraction, overloaded API, leaky boundary, or absent governance;
- **ownership layer** — foundation, primitive, component, composition, feature/page, or governance;
- **blast radius** — isolated, trend, or shared implementation with known consumers.

Call something a **trend** only with two independent occurrences. One shared implementation with several consumers is a **shared-component risk**, not multiple findings.

### 7. Prioritize high-leverage remediation

Use [references/report-template.md](references/report-template.md) for severity and confidence. Prioritize work that improves visible design quality and removes the architectural cause. Do not recommend a design-system expansion when a local composition is the correct owner, or a local restyle when the primitive/API guarantees recurring drift.

Build remediation cards with [references/remediation-patterns.md](references/remediation-patterns.md). Each card must define a target design outcome, target architecture, primary owner, ordered steps, migration risks, verification, and measurable **Done when** conditions.

### 8. Produce the report

Follow [references/report-template.md](references/report-template.md). Read [references/worked-example.md](references/worked-example.md) when design symptoms and architectural causes are difficult to separate.

Scale depth to scope. A small audit normally needs at most three causal groups; a repository-scale representative audit normally needs three to five. Additional high-severity findings take precedence. Remove repeated evidence and low-value symptom detail before removing required fields.

## Evidence Rules

- Cite every material finding with exact `file:line` evidence.
- Cite representative pages and consumers, not only token or primitive definitions.
- Judge design quality against inferred product intent and internal relationships, not generic aesthetic preferences.
- Distinguish visual symptoms from their architectural cause.
- Distinguish architecture quality from file size, abstraction count, or component count.
- Treat reuse as valuable only when consumers share meaning, behavior, and change cadence.
- Keep facts and inferences visibly separate.
- Preserve deliberate exceptions and local opt-outs with clear ownership.
- Prefer the smallest claim and narrowest ownership layer the evidence proves.

## Reference Routing

- Read [references/audit-rubric.md](references/audit-rubric.md) before collecting findings.
- Read [references/remediation-patterns.md](references/remediation-patterns.md) before designing the target architecture.
- Read [references/report-template.md](references/report-template.md) before writing the report.
- Read [references/worked-example.md](references/worked-example.md) when calibrating synthesis depth.

## Completion Gate

Confirm all of the following before returning the audit:

- Product intent and visual direction are described before critique.
- Design quality and component architecture each receive an explicit assessment.
- The architecture map traces foundations through pages and governance.
- Every finding has exact evidence and a fact/inference label.
- Every finding names both its design consequence and architecture cause.
- Every trend meets the occurrence threshold.
- One primary ownership layer is named per remediation.
- Ordered steps improve the system without erasing intentional character.
- Component/API changes include consumer and migration implications.
- Verification covers visible quality and architectural enforcement.
- `Done when` conditions are observable and specific.
- No application source was modified or runtime result presented as observed.
- No undisclosed external evidence informed the audit.

## Quick Reference

| Question                         | Required answer                               |
| -------------------------------- | --------------------------------------------- |
| What should this UI communicate? | Product intent and hierarchy                  |
| Does it communicate that well?   | Design-quality assessment with evidence       |
| What carries the design?         | Foundation-to-page architecture map           |
| Why will the issue recur?        | Architecture cause and ownership leak         |
| Where should it change?          | One primary ownership layer                   |
| What should replace it?          | Target design outcome and target architecture |
| When is it complete?             | Visual and structural pass/fail conditions    |

## Common Mistakes

- Treating design quality as a list of raw values or accessibility violations.
- Praising consistency when the consistent result is visually weak or generic.
- Reviewing primitives without tracing the page compositions they produce.
- Calling any repeated markup a component opportunity without shared semantics.
- Creating a universal component for feature-specific content or behavior.
- Letting a generic component accumulate boolean props for unrelated use cases.
- Recommending page-level overrides for primitive or foundation defects.
- Focusing on motion and stability while ignoring hierarchy, composition, and content.
- Calling a plausible rendered result an observed fact.
- Ending with “improve the component system” without a target ownership model.
