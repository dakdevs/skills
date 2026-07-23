# Architecture: Designer Intent to Verified Native App

## Core Model

The skill uses seven connected layers:

```text
Designer intent
    -> Product and state model
        -> Adaptive app shell
            -> Feature slices and data flow
                -> Content layer + functional glass layer
                    -> Preview and runtime loop
                        -> Evidence-based handoff
```

Each layer answers a different question. Skipping one pushes ambiguity into code, where it becomes
harder and more expensive to correct.

## Layer 1: Designer Intent

Capture:

- who the app is for;
- the primary job and success moment;
- essential content and actions;
- desired feeling and brand signals;
- reference imagery or interfaces;
- constraints, non-goals, and sensitive data.

Do not translate adjectives directly into effects. "Premium" might mean calm hierarchy, excellent
copy, responsive transitions, and careful spacing; it does not automatically mean more glass.

## Layer 2: Product and State Model

Before drawing screens, define:

- entities and their relationships;
- top-level destinations;
- the primary path through the product;
- all observable states;
- permissions and destructive actions;
- data ownership and persistence needs.

The state model is the contract between design and implementation. A screen that only exists in a
populated state is not designed.

## Layer 3: Adaptive App Shell

Choose system containers by information structure:

| Product shape | Default shell |
|---|---|
| One linear hierarchy | `NavigationStack` |
| Three to five peer destinations | `TabView` with a stack per tab |
| Sidebar and detail relationship | `NavigationSplitView` |
| Search is a primary destination | Search role/tab or `.searchable` according to target SDK |
| Focused, temporary subtask | Sheet containing its own `NavigationStack` when needed |

The shell owns global navigation and dependency injection. Feature views own feature state and local
presentation. Respond to available space; do not assume device model, orientation, or idiom proves a
specific width.

## Layer 4: Feature Slices and Data Flow

Organize code by user-facing feature. A feature normally contains:

- a screen or flow entry view;
- small child views;
- a domain model or state enum;
- a service protocol when external work exists;
- a live implementation and preview/test fake;
- focused tests.

Use value state until shared identity or lifecycle requires an observable reference. Place
long-lived shared services in the environment at the app shell. Pass feature-local dependencies
explicitly. Avoid a universal router, base view model, or design abstraction before repeated need is
demonstrated.

## Layer 5: Content and Functional Glass

Maintain two visual layers:

1. **Content layer** - lists, text, media, forms, charts, and reading surfaces. Use semantic colors
   and standard materials when depth is needed.
2. **Functional layer** - navigation and high-value controls floating above content. Standard
   system containers adopt Liquid Glass automatically. Add custom glass sparingly.

One surface must have one clear role. Glass-on-glass and glass content cards collapse hierarchy.

## Layer 6: Preview and Runtime Loop

Use previews as a design matrix, not a screenshot:

- representative states;
- narrow and wide sizes;
- light and dark appearance;
- small and accessibility text sizes;
- right-to-left and long strings;
- Reduce Motion/Transparency and Increased Contrast when available.

Then run the real interaction. Previews expose composition problems; runtime exposes navigation,
focus, keyboard, animation, performance, persistence, and lifecycle problems.

## Layer 7: Evidence-Based Handoff

Completion evidence includes:

- what was built and which states are covered;
- target SDK and deployment assumptions;
- build result;
- preview or screenshot evidence;
- tests run and results;
- accessibility and localization checks;
- known gaps and next decisions.

Use `templates/verification-report.md`.

## Dependency Order

1. Product definition precedes navigation.
2. Navigation and state ownership precede component styling.
3. System component behavior precedes custom Liquid Glass.
4. Static previews precede motion tuning.
5. Focused runtime verification precedes broad polish.
6. Accessibility and performance are checked throughout, then gated again at the end.

## Invariants

- The primary task remains obvious in every state.
- Every piece of mutable state has one clear owner.
- Navigation state represents destinations, not view implementation details.
- Views are deterministic functions of state and cheap to recompute.
- System behavior is preserved unless a product requirement justifies replacing it.
- Liquid Glass remains a sparse functional layer above content.
- Important flows are previewable, runnable, and testable without live services.
- No beta API enters a production path accidentally.
- The agent reports evidence rather than confidence language.

## Failure Modes

| Failure | Consequence | Correction |
|---|---|---|
| Styling before product modeling | Attractive but incoherent screens | Complete the brief and state inventory |
| One giant `ContentView` | Coupled state, poor previews, slow iteration | Split by feature and meaningful subview |
| View model for every view | Mirrored state and unnecessary indirection | Start with local state and services |
| Device checks drive layout | Breaks in multitasking and resizable windows | Respond to container geometry |
| Glass on every card | Content/navigation hierarchy disappears | Restore a single functional layer |
| Custom blur behind system bars | Fights automatic Liquid Glass and edge effects | Remove custom chrome first |
| Only happy-path fixtures | Empty, error, long-text, and offline bugs ship | Use lived-in preview matrices |
| Screenshot-only approval | Navigation, focus, and performance remain unknown | Run and exercise the app |
| Ungated new API | Older deployment targets fail | Add availability branch and fallback |
| "Build succeeded" as full verification | Visual and behavioral regressions remain | Run checks and report evidence |

## Output Goal

A correct application of this model produces a native SwiftUI app that feels intentional rather
than generated: clear product structure, system-familiar behavior, restrained Liquid Glass,
complete states, accessible content, adaptive layout, maintainable feature slices, and verified
runtime behavior.
