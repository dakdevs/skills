# State and Data Flow

## Contents

- [First Decision: Ownership](#first-decision-ownership)
- [Observation Example](#observation-example)
- [Explicit Screen State](#explicit-screen-state)
- [Async Lifecycle](#async-lifecycle)
- [Identity](#identity)
- [Binding Rules](#binding-rules)
- [Environment Rules](#environment-rules)
- [Xcode 27 Note](#xcode-27-note)
- [Performance Rules](#performance-rules)
- [Verification](#verification)

## First Decision: Ownership

Choose where state lives before choosing a property wrapper.

| Situation | Preferred tool |
|---|---|
| Local transient value owned by one view | private `@State` |
| Child edits a parent-owned value | `@Binding` |
| Long-lived reference model on iOS 17+ | `@Observable`, owned with `@State` |
| Injected observable needs binding projections | `@Bindable` |
| Shared app service/model | typed `@Environment` |
| View-local focus | private `@FocusState` |
| Pre-iOS-17 reference observation | `@StateObject` owner, `@ObservedObject` child |
| Scene restoration of small values | `@SceneStorage` |
| Durable domain data | persistence/service layer |

Passed data is not `@State`. State means the view owns the lifetime and mutation.

## Observation Example

```swift
@Observable
@MainActor
final class Library {
    private(set) var entries: [Entry] = []
    var phase: LoadPhase = .idle

    func load() async {
        phase = .loading
        do {
            entries = try await fetchEntries()
            phase = entries.isEmpty ? .empty : .loaded
        } catch {
            phase = .failed(error.localizedDescription)
        }
    }
}

struct LibraryView: View {
    @State private var library = Library()

    var body: some View {
        LibraryContent(phase: library.phase, entries: library.entries)
            .task { await library.load() }
    }
}
```

If the model comes from the app environment, the feature does not create another owner.

## Explicit Screen State

Use a state enum when branches are mutually exclusive:

```swift
enum LoadPhase: Equatable {
    case idle
    case loading
    case empty
    case loaded
    case failed(String)
}
```

Avoid several booleans such as `isLoading`, `hasError`, `isEmpty` that can represent impossible
combinations.

## Async Lifecycle

Use `.task` for work tied to view presence:

```swift
.task {
    await model.loadIfNeeded()
}
```

Use `.task(id:)` when work must restart and cancel as an input changes:

```swift
.task(id: query) {
    await model.search(query)
}
```

Rules:

- preserve cancellation;
- debounce only when needed;
- keep loading/error state explicit;
- do not launch side effects from `body`;
- do not repeatedly reload stable data on every appearance without a policy.

## Identity

`ForEach` identity must outlive a render and remain stable:

```swift
ForEach(entries) { entry in
    EntryRow(entry: entry)
}
```

Avoid indices or mutable content as identity when insertion, deletion, sorting, or editing can
occur. Unstable identity causes incorrect animations, state reuse, and excessive updates.

## Binding Rules

Use binding only for actual child mutation:

```swift
struct FilterPicker: View {
    @Binding var selection: Filter
}
```

Prefer intent callbacks for actions with domain meaning:

```swift
EntryRow(entry: entry, onArchive: { archive(entry) })
```

Avoid broad `Binding(get:set:)` closures in `body` when a stable stored value and `onChange` or an
intent method communicates ownership more clearly.

## Environment Rules

- Inject shared services at a clear root.
- Read only the environment values the view uses.
- Avoid storing action closures in global environment keys.
- Use stable default values for custom environment entries.
- Pass feature data explicitly; the environment is not a universal parameter bag.

## Xcode 27 Note

Xcode 27 changes `@State` implementation and source compatibility in some edge cases. If a project
starts failing when built with Xcode 27:

1. read the compiler diagnostic and Apple's current compatibility technote;
2. make the `@State` type explicit when inference fails;
3. avoid depending on wrapper-internal projected-value initialization tricks;
4. do not add an OS availability check for a toolchain-only source change.

See `references/apple-documentation-index.md` for the current technote link.

## Performance Rules

- Pass only data a child needs.
- Keep frequently changing state near the smallest affected subtree.
- Avoid constructing formatters, images, models, and services in `body`.
- Precompute expensive transforms in models/services.
- Avoid redundant assignments to observed properties.
- Profile before adding `Equatable` or other optimization machinery.

## Verification

- One owner exists for each mutable state.
- No impossible state combinations exist.
- Tasks cancel or restart correctly.
- Error and empty states are distinct.
- Lists keep identity across reorder/insert/delete.
- Preview fixtures can select each state directly.
- State changes update only the intended region in runtime observation.
