# Workflow: From Brief to Running App

## Goal

Convert a concept, image, wireframe, or product brief into a small but coherent native app that
builds and runs.

## Inputs

Accept any combination of:

- a sentence describing the product;
- a feature list or PRD;
- wireframes, screenshots, mood boards, or a Figma export;
- an existing Xcode project;
- sample data, brand assets, and copy;
- a required minimum iOS version.

Do not demand a complete specification. Mark assumptions by consequence:

| Consequence | Handling |
|---|---|
| Reversible visual choice | Choose a sensible system-first default |
| Reversible internal structure | Choose the smallest architecture that fits |
| Product scope or data/privacy change | Ask or clearly stop at a placeholder |
| Destructive/external action | Require explicit authorization |

## Phase 1: Inspect

1. Read repository instructions and nearby SwiftUI files.
2. Discover the project/workspace, schemes, deployment target, and active Xcode.
3. Identify existing design tokens, models, services, tests, fixtures, and navigation patterns.
4. Check whether the project already uses `@Observable`, SwiftData, a router, or a dependency
   container. Preserve coherent local conventions.
5. If no project exists, verify the requested app name, bundle identifier assumptions, platforms,
   and minimum supported OS before scaffolding.

Output a short environment note:

```text
Project:
Scheme:
Installed SDK:
Minimum OS:
Stable or beta APIs:
Existing architecture:
```

## Phase 2: Define the Product

Use `templates/designer-brief.md` and `references/product-definition.md`.

Produce:

- one primary person;
- one primary job;
- one sentence describing the success moment;
- top-level destinations;
- entity list;
- state matrix;
- first vertical slice;
- non-goals.

Reject screen inventories that have no task flow. Prefer:

```text
Launch -> understand current state -> take primary action -> see result -> recover or continue
```

## Phase 3: Choose the App Shell

Read `references/navigation-and-presentation.md` and
`references/layout-and-resizability.md`.

Decision:

| Need | Shell |
|---|---|
| One main flow with drill-down | `NavigationStack` |
| Peer sections with independent history | `TabView`, one stack per tab |
| Browsing hierarchy with persistent detail | `NavigationSplitView` |
| Search as dominant mode | Search destination plus `.searchable` |

Write the destination/state types before composing the root view. Keep navigation data driven.

## Phase 4: Plan Vertical Slices

Use `templates/implementation-plan.md`.

Each slice must:

- deliver one observable user outcome;
- include its loading/empty/error state when applicable;
- have a preview fixture;
- compile independently;
- have a focused verification step.

Preferred order:

1. App shell and fixture data.
2. Primary browse/list state.
3. Primary detail or editor.
4. Primary action and result.
5. Persistence or live service.
6. Secondary states and recovery.
7. Polish and custom Liquid Glass.

Never begin by creating a design-system abstraction or networking stack that no slice uses.

## Phase 5: Implement System-First

For each slice:

1. Model state and ownership using `references/state-and-data-flow.md`.
2. Add the feature files using `patterns/feature-slice.md`.
3. Build the content hierarchy with native controls.
4. Use semantic typography, colors, SF Symbols, roles, and labels.
5. Add the complete state branches using `patterns/state-driven-screen.md`.
6. Add realistic previews.
7. Build before adding custom effects.

The first successful render should already be usable without custom Liquid Glass.

## Phase 6: Apply Liquid Glass

Read:

- `references/liquid-glass-design.md`;
- `references/liquid-glass-api.md`;
- `patterns/functional-glass-layer.md`.

Procedure:

1. Rebuild with the current SDK and observe which system elements already adopt glass.
2. Remove custom bar, toolbar, sheet, or popover backgrounds that fight system appearance.
3. Mark the content layer and functional layer.
4. Add custom glass only to high-value floating controls that remain after the system audit.
5. Gate the custom code for the deployment target.
6. Test Reduce Transparency, Increase Contrast, Reduce Motion, light/dark appearances, and varied
   content behind the surface.

## Phase 7: Verify Every Slice

Follow `workflows/build-run-verify.md`.

Minimum:

- project builds;
- primary preview renders;
- changed path runs in Simulator;
- focused tests pass;
- empty/error/long-content states have been inspected;
- VoiceOver labels and large text have been checked.

When visual work is important, capture screenshots of the relevant states and compare them to the
brief. A screenshot is evidence of appearance, not evidence of interaction correctness.

## Phase 8: Review and Handoff

Run:

1. `checks/design-review.md`
2. `checks/liquid-glass-review.md`
3. `checks/implementation-review.md`
4. `checks/accessibility-review.md`
5. `checks/release-readiness.md`

Then use `workflows/review-and-handoff.md`.

## Failure Recovery

| Failure | Response |
|---|---|
| Build breaks after a slice | Stop, read the first causal error, repair, rebuild |
| Preview crashes | Replace live dependencies with fixtures and isolate the smallest failing view |
| UI looks generic | Return to product hierarchy, real content, brand restraint, and key moments |
| Glass overwhelms content | Remove custom glass until only the functional layer remains |
| Layout breaks on iPad | Remove device assumptions and design against available width |
| State changes do not render | Revisit state ownership and Observation tracking |
| Interaction feels wrong | Run it, record the exact transition, then tune with a small parameter surface |

## Completion Test

A designer should be able to answer yes to:

- Does this app express the intended product, not just the intended color palette?
- Can I see and try the primary job?
- Are the important edge states represented?
- Does it feel native without feeling anonymous?
- Does Liquid Glass clarify the functional layer?
- Can another agent continue from the architecture and verification report?
