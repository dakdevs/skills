# Manual Route Evaluation

## Scope

This evaluation checks whether the skill routes representative designer and implementation prompts
to the local guidance needed for a good response. It was completed on 2026-07-23 against the eight
cases in `evals.json`.

This is a document-tree evaluation, not a claim that eight apps were compiled. Runtime outcomes
still depend on the project, installed Xcode and SDK, simulator destination, and artifacts supplied
with a future request.

## Results

| Eval | Required route | Coverage found | Result |
|---|---|---|---|
| 1. New habit tracker | Full application route | Product model, state matrix, adaptive shell, vertical slices, sparse glass, previews, and runtime evidence | Pass |
| 2. Glass everywhere | Liquid Glass design route | Functional/content layer distinction, placement test, clear-glass constraints, and safer expressive alternatives | Pass |
| 3. iOS 17 migration | Adoption route | Baseline, automatic adoption, interference removal, isolated availability, semantic fallback, and old-runtime verification | Pass |
| 4. Four design directions | Prototype route | Controlled dimensions, shared behavior, lived-in fixtures, comparison, remix, cleanup, and state/layout matrix | Pass |
| 5. Scrolling stutter | Performance route | Reproduction, grouping and invalidation review, code-first diagnosis, Instruments escalation, and before/after evidence | Pass |
| 6. Beta production conflict | Availability route | Local toolchain discovery, stable default, explicit beta authorization, version separation, and release-risk reporting | Pass |
| 7. Accessibility review | Accessibility route | Semantics, VoiceOver, scaling, contrast, transparency, motion, input target, localization, and evidence checks | Pass |
| 8. Final handoff | Verification route | Scheme discovery, build, previews, runtime paths, tests, review gates, skipped-check disclosure, and handoff template | Pass |

## Tree-Level Assertions

- `SKILL.md` supplies both focused routes and a complete-application route.
- `source.md` identifies organizations, authors, URLs, access date, adaptation scope, and source
  credit.
- Every routed local document exists.
- Workflows turn source ideas into ordered implementation and verification actions.
- Three realistic examples connect product decisions to SwiftUI and Liquid Glass decisions.
- Verification is broader than compilation and requires runtime, state, accessibility, and
  availability evidence.
- Community skills and repositories are treated as pattern sources; Apple remains authoritative.
- The tree links to sources instead of reproducing substantial source passages or code.

## Benchmark Boundary

A full model-in-the-loop comparison and Xcode build benchmark were not run because no target app,
design artifact, or Xcode project belongs to this skill package. Use the prompts in `evals.json`
against a representative fixture project when changing the trigger description, routing, or core
implementation guidance.
