# Navigation and Presentation

## Contents

- [Model Information Structure First](#model-information-structure-first)
- [Container Selection](#container-selection)
- [Typed Stack](#typed-stack)
- [Tabs](#tabs)
- [Split Views and Adaptation](#split-views-and-adaptation)
- [Sheets](#sheets)
- [Alerts and Destructive Actions](#alerts-and-destructive-actions)
- [Deep Links](#deep-links)
- [Toolbars and Liquid Glass](#toolbars-and-liquid-glass)
- [Verification](#verification)

## Model Information Structure First

Navigation is persistent movement through the product. Presentation is a temporary task or
interruption. Do not use sheets to avoid designing hierarchy.

## Container Selection

| Need | API | Notes |
|---|---|---|
| Push/drill-down hierarchy | `NavigationStack` | Use typed destinations |
| Sidebar/list/detail | `NavigationSplitView` | Adapt column visibility |
| Peer top-level contexts | `TabView` | Preserve a stack per tab when history matters |
| Search within content | `.searchable` | Let the system position and style it |
| Temporary create/edit flow | `.sheet(item:)` | Give the sheet its own stack if it drills down |
| Important decision | `confirmationDialog` or `alert` | Use semantic roles |
| Supplemental contextual actions | `Menu` or context menu | Keep primary action visible |

## Typed Stack

```swift
enum Destination: Hashable {
    case entry(Entry.ID)
    case settings
}

struct HomeView: View {
    @State private var path: [Destination] = []

    var body: some View {
        NavigationStack(path: $path) {
            EntryList(onSelect: { path.append(.entry($0)) })
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .entry(let id):
                        EntryDetail(id: id)
                    case .settings:
                        SettingsView()
                    }
                }
        }
    }
}
```

Keep destination identity small. Resolve live models at the destination instead of placing
non-hashable service objects in the path.

## Tabs

- Use three to five stable peer destinations.
- Give each tab a clear label and SF Symbol.
- Preserve independent navigation history when people switch contexts.
- Do not use a tab for a one-time action; use a button.
- When search is a primary mode, use the current platform's search role/pattern rather than a
  hand-built toolbar field.
- Badges communicate meaningful status, not decoration.

## Split Views and Adaptation

Use `NavigationSplitView` for list/detail relationships that benefit from simultaneous context.
Decide selection and column visibility as data. Do not assume iPad always means multiple visible
columns; windows can be narrow.

## Sheets

Prefer item-driven presentation:

```swift
@State private var presentedEditor: EditorContext?

.sheet(item: $presentedEditor) { context in
    NavigationStack {
        EditorView(context: context)
    }
}
```

The presented view should dismiss itself through the environment after successful completion. Keep
cancel and destructive semantics explicit.

With current SDKs, system sheets may adopt Liquid Glass automatically. Remove custom
`presentationBackground` unless a deliberate content treatment requires it.

## Alerts and Destructive Actions

- Use `Button(role: .destructive)` for destructive choices.
- State the object and consequence.
- Keep Cancel available.
- Confirm only actions with meaningful, difficult-to-reverse consequences.
- Prefer Undo for frequent reversible operations.

## Deep Links

Map external input into the same typed destination model:

```text
URL -> validate -> resolve entity -> select top-level context -> append route -> present error
```

Handle missing/deleted entities and authentication/permission requirements. Do not build a parallel
navigation path only for deep links.

## Toolbars and Liquid Glass

- Attach toolbar items to the view that owns them.
- Use semantic placements and roles.
- Let the system group and style standard items.
- Use spacers/grouping APIs only when the interaction hierarchy needs separation.
- Keep icons mostly monochrome; use tint to communicate hierarchy or meaning.
- Do not place a custom `TextField` in a toolbar as a search replacement.
- Do not add custom backgrounds behind system toolbar glass.

## Verification

- Back behavior is predictable.
- Switching tabs preserves or intentionally resets state.
- Deep links reach the same destination as manual navigation.
- Sheets have a clear completion/cancel path.
- Destructive actions are scoped and recoverable.
- Search focus and dismissal work with the keyboard.
- Toolbars remain legible over scrolling content.
- Navigation works at narrow and wide sizes.
