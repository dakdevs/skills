# Pattern: Adaptive App Shell

## Problem

An app needs stable top-level structure on iPhone and iPad without duplicating navigation or
assuming a device guarantees a width.

## Pattern

1. Define top-level destinations as data.
2. Give each destination its own navigation history when appropriate.
3. Use `TabView` for peer contexts and `NavigationSplitView` for hierarchical context/detail.
4. Let containers adapt to available space.
5. Keep sheets and deep links mapped into the same destination model.

## Shape

```swift
enum AppTab: Hashable {
    case home
    case library
    case search
}

struct AppShell: View {
    @State private var selection: AppTab = .home

    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: .home) {
                HomeStack()
            }
            Tab("Library", systemImage: "books.vertical", value: .library) {
                LibraryStack()
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search) {
                SearchStack()
            }
        }
    }
}
```

Use the current tab APIs supported by the deployment target.

## Rules

- Top-level destinations are stable nouns, not transient actions.
- Each stack owns typed destinations.
- Search uses system search behavior.
- Wide layouts reveal useful context; they do not merely add margins.
- The shell injects shared dependencies once.
- System navigation owns Liquid Glass.

## Verification

- Switch tabs after drilling down and verify intended history.
- Open a deep link from a cold and warm launch.
- Resize across narrow/wide widths.
- Test state restoration.
- Confirm toolbars do not duplicate or leave empty glass groups.

## Avoid

- One global `NavigationPath` for unrelated tabs.
- Device-model branching.
- A custom bottom bar made only to force glass.
- Sheets for primary destinations.
