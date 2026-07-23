# Project Architecture

## Contents

- [Default: Feature-Oriented, Native, Small](#default-feature-oriented-native-small)
- [Responsibility Boundaries](#responsibility-boundaries)
- [Dependency Strategy](#dependency-strategy)
- [Feature Slice Pattern](#feature-slice-pattern)
- [View Structure](#view-structure)
- [Architecture Decision Table](#architecture-decision-table)
- [Concurrency](#concurrency)
- [Tests](#tests)
- [Verification](#verification)

## When to Read

Read when creating a project, adding a feature, or deciding where SwiftUI state, services, and files
belong.

## Default: Feature-Oriented, Native, Small

Start with:

```text
App/
  AppNameApp.swift
  AppDependencies.swift
Features/
  Home/
    HomeView.swift
    HomeState.swift
    HomeService.swift
    Components/
  Detail/
    DetailView.swift
    Components/
Models/
Services/
Design/
  AppTheme.swift
  Motion.swift
Resources/
Tests/
```

Adapt to the repository. Do not reorganize an existing app merely to match this example.

## Responsibility Boundaries

| Layer | Owns | Must not own |
|---|---|---|
| App shell | root scenes, global dependencies, top-level navigation | feature business logic |
| Feature view | layout, local interaction state, task orchestration | networking and persistence implementation |
| Domain model | meaningful data and invariants | view hierarchy |
| Service | external side effects and reusable operations | presentation state |
| Preview fixture | deterministic sample states | live credentials or production storage |

## Dependency Strategy

Use the narrowest scope:

1. Plain value passed into a view.
2. Binding when the child must mutate parent-owned value state.
3. Explicit service/model parameter for feature-local dependencies.
4. `@Environment(Type.self)` for long-lived shared services or models.
5. Legacy `ObservableObject`/`@EnvironmentObject` only when deployment target or existing code
   requires it.

The app root should make live dependencies obvious:

```swift
@main
struct JournalApp: App {
    @State private var library = EntryLibrary()

    var body: some Scene {
        WindowGroup {
            AppShell()
                .environment(library)
        }
    }
}
```

For previews, inject a fixture library rather than teaching the live type to detect preview mode.

## Feature Slice Pattern

A feature starts with a runnable path:

```text
Route -> View -> State -> Service boundary -> Fixture -> Test
```

Avoid horizontal infrastructure phases such as "build all networking" before any feature consumes
it. Add a protocol when it enables a live/fake boundary or a second implementation, not by default.

## View Structure

- Keep one primary type per file when it improves discovery.
- Keep tiny private subviews near their only caller.
- Extract meaningful sections into dedicated `View` types when they have state, branching, async
  work, reuse, or deserve previews.
- Make `body` read as hierarchy and orchestration.
- Move non-trivial actions into small methods; move domain work into models/services.
- Avoid `AnyView` and type erasure as routine composition tools.
- Preserve stable identity. Localize conditional branches rather than swapping unrelated root trees.

## Architecture Decision Table

| Question | Default | Escalate when |
|---|---|---|
| MV or MVVM? | SwiftUI view + domain/service model | Existing architecture or complex presentation behavior needs a dedicated model |
| One router? | Destination enums close to the shell | Deep links or multi-feature coordination require a shared route model |
| Repository layer? | Direct service boundary | Multiple data sources/caches need reconciliation |
| Third-party state framework? | No | Existing app uses it or measured complexity justifies it |
| SwiftData? | For suitable local persistent models | Migration, sharing, or query requirements exceed it |
| UIKit bridge? | No | Missing SwiftUI capability or legacy integration |

## Concurrency

- Keep UI-observed models on the main actor where appropriate.
- Use structured `async` functions and `.task`/`.task(id:)`.
- Let tasks cancel when views or identifiers change.
- Move CPU-heavy work away from the main actor only when the work is actually expensive.
- Do not hide unstructured `Task` creation throughout view bodies.
- Make service methods express failure rather than swallowing it.

## Tests

Test:

- domain rules;
- state transitions;
- service behavior through fakes;
- persistence migrations/round trips;
- critical navigation outcomes;
- high-value UI flows.

Do not unit-test SwiftUI layout internals. Use previews, screenshots where established, and runtime
UI tests for visible behavior.

## Failure Modes

- One giant app model that invalidates every feature.
- A view model that mirrors every `@State` property.
- Global singletons hidden inside views.
- Services constructed inside `body`.
- Feature folders that are only cosmetic while all logic remains global.
- Protocols and generic abstractions created before a second use.
- Preview-only flags in production code.

## Verification

- Can a new agent find the owner of every mutable state?
- Can each feature render with a fake dependency?
- Can the primary feature build before optional infrastructure exists?
- Are side effects outside view rendering?
- Does architecture match project scale rather than an aspirational template?
