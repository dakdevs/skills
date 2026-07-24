---
name: build-swiftui-liquid-glass-apps
description: "Build, prototype, implement, review, and iterate native iPhone and iPad apps from designer briefs using SwiftUI and Apple's Liquid Glass. Use when an agent must turn a mobile app concept, wireframe, screenshot, interaction spec, product brief, or existing iOS project into a working SwiftUI app; choose navigation, state, and feature architecture; use iOS 26+ Liquid Glass APIs intentionally; account for Xcode 27 and iOS 27 behavior; create previews and realistic states; add accessibility and localization; or build, run, test, and visually verify an app in Simulator."
metadata:
  origin_title: "SwiftUI and Liquid Glass primary documentation plus leading community SwiftUI agent skills"
  origin_author: "Apple Inc.; AvdLee; Dimillian; Charles Wiltgen; Paul Hudson; wshobson; John Rogers; open-source app authors"
  origin_url: "https://developer.apple.com/documentation/swiftui"
  origin_note: "Authored synthesis and expansion based on the credited sources in source.md; not a verbatim copy."
---

# Build SwiftUI Liquid Glass Apps

> Version: 1.0.0 | Last updated: 2026-07-23
>
> Origin credit: Synthesized from Apple's current SwiftUI, HIG, Liquid Glass, Xcode, and
> WWDC guidance; leading skills indexed by skills.sh; and inspected open-source implementations.

## Intent

Turn a designer's intent into a coherent, running native app. Preserve the product idea while making
the thousands of small platform decisions a designer should not need to specify: state ownership,
navigation, safe areas, content states, Dynamic Type, VoiceOver, data flow, availability, previews,
tests, and build verification.

Treat Liquid Glass as the functional layer above content, not as a decorative skin. Start with
system components because they automatically adopt the current design. Add custom glass only when a
high-value control or transition needs it.

## First Response

1. Inspect repository instructions, project structure, deployment targets, and the installed Xcode
   and SDK before proposing architecture.
2. Restate the primary person, task, data, and success moment in four short bullets. Record important
   unknowns, but proceed with reversible assumptions when they do not change product scope.
3. Select a route from the table below and read `architecture.md`.
4. For a new product, convert the idea into the brief in `templates/designer-brief.md`, then make an
   implementation plan before editing code.
5. For an existing app, preserve its working architecture and visual language unless the user asks
   for a redesign.
6. Build, render previews or run the app, exercise the changed flow, and test. Do not stop at code
   that merely looks plausible.

## Platform Baseline

- Liquid Glass was introduced with iOS 26 and the Xcode 26 SDK.
- Xcode 27 and the 2027 platform releases refresh the material and add SwiftUI behavior. They may be
  prerelease depending on the date and installed toolchain.
- Default a new production app to the newest stable SDK available locally. Use beta-only APIs only
  when the user opts into the beta or the existing project already depends on it.
- Read the actual project deployment target. Gate APIs newer than that target and provide a
  behaviorally equivalent fallback.
- Prefer native SwiftUI. Bridge to UIKit only for a capability SwiftUI cannot supply or to preserve
  an existing integration.

## Non-Negotiables

1. Model the product before styling it.
2. Build every important state: loading, empty, populated, error, offline, permission denied, and
   destructive confirmation where applicable.
3. Use system navigation, controls, typography, semantic colors, and SF Symbols unless a measured
   product need justifies custom behavior.
4. Keep content and functional chrome as separate visual layers. Do not put Liquid Glass on list
   rows, article cards, or decorative content.
5. Use `.interactive()` only for interactive custom glass.
6. Group nearby custom glass with `GlassEffectContainer`; do not layer independent glass surfaces
   on top of each other.
7. Make the UI work with VoiceOver, Dynamic Type, Reduce Motion, Reduce Transparency, Increase
   Contrast, Dark Mode, right-to-left layout, long localized strings, and constrained widths.
8. Keep view bodies cheap and state ownership explicit. Never perform network or disk work from
   `body`.
9. Use realistic preview fixtures and verify the app at runtime.
10. Do not claim success without build or test evidence, or a precise explanation of what blocked it.

## Document Map

| File | Purpose |
|---|---|
| `source.md` | Provenance, research method, ranked skills.sh sources, and adaptation scope |
| `source-map.md` | Full source inventory with direct documentation and repository links |
| `architecture.md` | Designer-intent-to-verified-app operating model |
| `workflows/from-brief-to-running-app.md` | End-to-end new-app workflow |
| `workflows/prototype-and-iterate.md` | Generate variations, add realistic states, and tune key moments |
| `workflows/adopt-liquid-glass.md` | Existing-app migration and audit workflow |
| `workflows/build-run-verify.md` | Xcode discovery, build, preview, simulator, test, and evidence loop |
| `workflows/review-and-handoff.md` | Structured design/code review and final handoff |
| `references/product-definition.md` | Product model, scope, information architecture, and state inventory |
| `references/project-architecture.md` | Feature slices, dependency graph, data/services, and file layout |
| `references/state-and-data-flow.md` | Observation, state ownership, async work, persistence, and identity |
| `references/navigation-and-presentation.md` | Tabs, stacks, split views, search, sheets, alerts, and deep links |
| `references/layout-and-resizability.md` | Container-driven layout for iPhone, iPad, and resizable windows |
| `references/liquid-glass-design.md` | Material intent, layers, variants, hierarchy, and failure modes |
| `references/liquid-glass-api.md` | SwiftUI APIs, modifier order, grouping, morphing, and code patterns |
| `references/availability-and-fallbacks.md` | Stable/beta SDK policy and pre-iOS-26 equivalents |
| `references/components-and-screen-states.md` | System-first components and complete state design |
| `references/visual-language.md` | Tokens, type, color, symbols, imagery, content, and brand restraint |
| `references/motion-haptics-and-interaction.md` | Motion purpose, gestures, feedback, and adjustable tuning |
| `references/accessibility-localization-privacy.md` | Inclusive design and privacy checks |
| `references/performance.md` | Code-first performance rules and Instruments escalation |
| `references/previews-testing-automation.md` | Preview matrices, tests, UI automation, and visual comparison |
| `references/apple-documentation-index.md` | Large, categorized Apple documentation and WWDC link index |
| `references/open-source-implementation-index.md` | Inspected real-world SwiftUI/Liquid Glass repositories |
| `patterns/adaptive-app-shell.md` | Tabs, stacks, split views, and search that adapt by available space |
| `patterns/functional-glass-layer.md` | Keep a single, intentional Liquid Glass control plane |
| `patterns/feature-slice.md` | Small feature-oriented architecture without speculative layers |
| `patterns/state-driven-screen.md` | Make all UI states explicit and previewable |
| `patterns/lived-in-prototype.md` | Realistic fixtures that expose design problems |
| `patterns/tuning-panel.md` | Tune motion and layout parameters in previews |
| `checks/design-review.md` | Product, hierarchy, navigation, content, and interaction gate |
| `checks/liquid-glass-review.md` | Material placement, API, accessibility, and performance gate |
| `checks/implementation-review.md` | SwiftUI correctness, architecture, state, and availability gate |
| `checks/accessibility-review.md` | VoiceOver, scaling, contrast, motion, input, and localization gate |
| `checks/release-readiness.md` | Build, tests, runtime, privacy, and handoff gate |
| `examples/habit-tracker-walkthrough.md` | Full brief-to-verified-app example |
| `examples/media-controls-glass.md` | Rich-background custom glass example |
| `examples/existing-app-migration.md` | Incremental adoption example |
| `templates/designer-brief.md` | Input contract for a designer and agent |
| `templates/implementation-plan.md` | Small, testable vertical-slice plan |
| `templates/verification-report.md` | Evidence-based completion report |
| `evals/evals.json` | Realistic prompts and observable assertions |
| `evals/manual-evaluation.md` | Route-level evaluation results and benchmark boundary |

## Routing

| User signal | Read first | Then read |
|---|---|---|
| "Build this app", concept, PRD, sketch, or wireframe | `workflows/from-brief-to-running-app.md` | `references/product-definition.md` |
| Explore several UI directions | `workflows/prototype-and-iterate.md` | `patterns/lived-in-prototype.md` |
| Existing project or feature implementation | `architecture.md` | `references/project-architecture.md` |
| Liquid Glass, glass effect, iOS 26 design | `references/liquid-glass-design.md` | `references/liquid-glass-api.md` |
| Migrate an existing app to Liquid Glass | `workflows/adopt-liquid-glass.md` | `references/availability-and-fallbacks.md` |
| State, `@Observable`, binding, async loading | `references/state-and-data-flow.md` | `patterns/state-driven-screen.md` |
| Tabs, navigation, search, sheet, deep link | `references/navigation-and-presentation.md` | `patterns/adaptive-app-shell.md` |
| iPad, rotation, window resize, compact layout | `references/layout-and-resizability.md` | `checks/design-review.md` |
| Typography, color, SF Symbols, brand | `references/visual-language.md` | `checks/design-review.md` |
| Gesture, animation, haptics, microinteraction | `references/motion-haptics-and-interaction.md` | `patterns/tuning-panel.md` |
| VoiceOver, Dynamic Type, localization, privacy | `references/accessibility-localization-privacy.md` | `checks/accessibility-review.md` |
| Jank, excessive updates, slow scroll | `references/performance.md` | `checks/implementation-review.md` |
| Preview, simulator, test, build failure | `workflows/build-run-verify.md` | `references/previews-testing-automation.md` |
| Review or final polish | `workflows/review-and-handoff.md` | Relevant files in `checks/` |
| Find the current Apple API or sample | `references/apple-documentation-index.md` | `source-map.md` |
| Find a real implementation | `references/open-source-implementation-index.md` | `source.md` |

## Full Application Route

1. Read `architecture.md`.
2. Use `templates/designer-brief.md` and `references/product-definition.md`.
3. Read `workflows/from-brief-to-running-app.md`.
4. Read project, state, navigation, layout, visual language, accessibility, and Liquid Glass
   references as the feature requires.
5. Apply `patterns/feature-slice.md`, `patterns/state-driven-screen.md`, and
   `patterns/functional-glass-layer.md`.
6. Follow `workflows/build-run-verify.md` after every vertical slice.
7. Run all files in `checks/`.
8. Finish with `workflows/review-and-handoff.md` and `templates/verification-report.md`.

## Work Loop

For every meaningful change:

1. **Frame** - name the user outcome and affected states.
2. **Inspect** - read local conventions and current APIs.
3. **Plan** - choose the smallest vertical slice that can run.
4. **Implement** - keep the app buildable.
5. **Render** - use previews for fast state and layout comparison.
6. **Run** - exercise the interaction in Simulator or on device.
7. **Test** - run focused tests, then the relevant suite.
8. **Critique** - compare the result to the brief, HIG, and the checks.
9. **Refine** - fix the highest-consequence gap and repeat.

## Decision Priorities

Resolve tradeoffs in this order:

1. User safety, privacy, accessibility, and preservation of work.
2. Correct task completion and understandable information hierarchy.
3. Native behavior and predictable state transitions.
4. Adaptability, localization, and performance.
5. Brand expression, Liquid Glass flourish, and delight.

Visual novelty never outranks legibility or task completion.

## Required Output

For build work, return or create:

- the task and state model;
- the implemented vertical slices;
- previews or fixtures for important states;
- accessibility and availability behavior;
- build, runtime, and test evidence;
- remaining assumptions and risks.

For review work, report findings by consequence. Include file and line evidence where possible,
affected users or states, the violated rule, and the smallest viable correction.

## Source Boundary

This tree paraphrases and operationalizes its sources. Reopen Apple documentation before relying on
new or beta APIs. Treat community skills and repositories as evidence and pattern sources, not as
normative authority. Do not copy third-party code without checking its license and the user's intent.
