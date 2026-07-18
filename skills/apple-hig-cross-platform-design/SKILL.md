---
name: apple-hig-cross-platform-design
description: "CRITICAL: Use when designing, implementing, reviewing, or adapting a product experience using Apple Human Interface Guidelines across responsive Web, native macOS desktop, and iPhone. Triggers on: Apple HIG, Human Interface Guidelines, Apple-like interface, cross-platform design, Web and native parity, macOS app design, iPhone app design, SwiftUI UI review, AppKit UI review, responsive product UI, platform adaptation, navigation choice, accessibility audit, interface component choice, interaction review, design-system review."
metadata:
  origin_title: "Human Interface Guidelines"
  origin_author: "Apple Inc."
  origin_url: "https://developer.apple.com/design/human-interface-guidelines"
  origin_note: "Authored expansion based on the source; not a verbatim copy. The Web route is an explicit adaptation because HIG does not define Web as an Apple platform."
---

# Apple HIG Cross-Platform Design

> Version: 1.0.0 | Last updated: 2026-07-18
>
> Origin credit: Based on Apple Inc.'s Human Interface Guidelines.

## Intent

Use this skill to produce an interface that preserves one product model while behaving naturally on
responsive Web, native macOS, and iPhone. Treat shared purpose, accessibility, privacy, hierarchy,
language, and recovery as invariants. Adapt navigation, density, input, command placement,
presentation, and state handling to each platform.

Do not make every surface visually identical. Cross-platform consistency means the same concepts,
data, terminology, and outcomes remain recognizable while each platform uses familiar behavior.

## First Response

1. Identify the target surfaces: Web, macOS, iPhone, or a combination.
2. State the primary user goal and the irreversible or privacy-sensitive actions.
3. Read `architecture.md` and the relevant platform route.
4. If reviewing an existing interface, use `workflows/full-design-review.md`.
5. If creating or changing an interface, use `workflows/implementation-workflow.md`.
6. Verify with the platform checklist and `checks/cross-platform-review.md`.

## Source Boundary

- iPhone maps to Apple's iOS guidance.
- Native desktop maps to Apple's macOS guidance.
- Web is an authored adaptation of shared HIG principles plus HIG pages that explicitly discuss
  web content or input. It is not an Apple-defined Web HIG.
- HIG does not replace WCAG, browser semantics, HTML behavior, or platform engineering docs.
- Do not imitate native-only materials or components in Web when their behavior is unavailable.

## Document Map

| File | Purpose |
|---|---|
| `source.md` | Provenance, research method, scope, and adaptation notes |
| `source-map.md` | Inventory of all 172 traversed HIG pages and depth markers |
| `architecture.md` | Shared-core/platform-shell operating model |
| `workflows/full-design-review.md` | Evidence-first review and finding format |
| `workflows/implementation-workflow.md` | From task model to verified UI |
| `workflows/platform-adaptation-workflow.md` | Convert one product flow into three native expressions |
| `references/shared/principles-and-priorities.md` | Purpose, agency, responsibility, familiarity, flexibility, simplicity, craft, delight |
| `references/shared/accessibility-and-inclusion.md` | Perception, mobility, cognition, language, and alternate input |
| `references/shared/layout-type-color.md` | Hierarchy, adaptability, typography, color, and appearance |
| `references/shared/motion-materials-content.md` | Feedback, motion, material boundaries, and writing |
| `references/shared/privacy-permissions-data.md` | Data minimization, permission timing, and sensitive operations |
| `references/platforms/web.md` | HIG-grounded responsive Web adaptation |
| `references/platforms/macos.md` | Native macOS windows, commands, precision input, and deep work |
| `references/platforms/iphone.md` | Touch-first, reach-aware, interruption-tolerant iPhone design |
| `references/components/navigation-and-structure.md` | Navigation model and structural component decisions |
| `references/components/actions-input-feedback.md` | Buttons, fields, gestures, keyboard, pointer, progress, and status |
| `references/components/presentation-state-recovery.md` | Alerts, sheets, popovers, modality, empty/error states, undo |
| `patterns/responsive-continuity.md` | Preserve context while the layout and platform change |
| `patterns/progressive-disclosure.md` | Keep the primary task clear without hiding necessary capability |
| `patterns/reversible-and-safe-actions.md` | Undo, confirmation, destructive roles, and recovery |
| `patterns/native-command-placement.md` | Place a shared command in the expected location per platform |
| `checks/cross-platform-review.md` | Shared quality gate |
| `checks/web-review.md` | Responsive Web quality gate |
| `checks/macos-review.md` | Native macOS quality gate |
| `checks/iphone-review.md` | iPhone quality gate |
| `examples/cross-platform-task-manager.md` | Worked three-surface adaptation |
| `evals/evals.json` | Scenario prompts and observable assertions |

## Routing

| User signal | Read first | Then read |
|---|---|---|
| Broad cross-platform design or parity | `architecture.md` | `workflows/platform-adaptation-workflow.md` |
| Existing interface review | `workflows/full-design-review.md` | Relevant file in `checks/` |
| New feature or redesign | `workflows/implementation-workflow.md` | Relevant platform and component references |
| Responsive Web | `references/platforms/web.md` | `checks/web-review.md` |
| Native desktop, Mac, AppKit, macOS SwiftUI | `references/platforms/macos.md` | `checks/macos-review.md` |
| Phone, iPhone, iOS, UIKit, iOS SwiftUI | `references/platforms/iphone.md` | `checks/iphone-review.md` |
| Accessibility, Dynamic Type, contrast, alternate input | `references/shared/accessibility-and-inclusion.md` | Platform checklist |
| Layout, hierarchy, typography, color, Dark Mode | `references/shared/layout-type-color.md` | Relevant platform reference |
| Animation, feedback, copy, material | `references/shared/motion-materials-content.md` | `references/components/actions-input-feedback.md` |
| Permission, identity, privacy, destructive data | `references/shared/privacy-permissions-data.md` | `patterns/reversible-and-safe-actions.md` |
| Navigation, tabs, sidebar, window structure | `references/components/navigation-and-structure.md` | `patterns/native-command-placement.md` |
| Form, button, gesture, pointer, keyboard, loading | `references/components/actions-input-feedback.md` | Relevant platform checklist |
| Alert, sheet, popover, empty/error state, undo | `references/components/presentation-state-recovery.md` | `patterns/reversible-and-safe-actions.md` |
| One flow must adapt across all surfaces | `patterns/responsive-continuity.md` | `examples/cross-platform-task-manager.md` |

## Full Application Route

1. Read `source.md` and `architecture.md`.
2. Read `references/shared/principles-and-priorities.md`.
3. Read the applicable workflow.
4. Read each targeted platform file.
5. Read the component references used by the feature.
6. Apply relevant patterns.
7. Run `checks/cross-platform-review.md` and each targeted platform check.
8. Report verified evidence, unresolved risks, and source-boundary caveats.

## Priority Order

When guidance competes, resolve it in this order:

1. Safety, privacy, accessibility, and preservation of user work.
2. Primary user purpose and direct completion of the task.
3. Platform familiarity, clear feedback, and recoverability.
4. Adaptability across size, appearance, locale, and input.
5. Visual polish, brand expression, and delight.

Delight never excuses obstruction. Visual consistency never excuses nonnative behavior.

## Required Outputs

For implementation work, produce:

- a short task and platform model;
- the implemented UI or concrete specification;
- a platform-delta table for any multi-surface feature;
- accessibility, privacy, recovery, and state behavior;
- verification evidence for target sizes, inputs, appearances, and locales.

For review work, produce findings ordered by consequence. Each finding must identify the surface,
observable evidence, affected user outcome, source-derived rule, and smallest viable correction.
