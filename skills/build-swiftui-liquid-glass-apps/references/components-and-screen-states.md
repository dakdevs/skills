# Components and Screen States

## Contents

- [System-First Selection](#system-first-selection)
- [State-Driven Composition](#state-driven-composition)
- [Loading](#loading)
- [Empty](#empty)
- [Error](#error)
- [Offline and Partial](#offline-and-partial)
- [Permission](#permission)
- [Forms](#forms)
- [Lists and Grids](#lists-and-grids)
- [Verification](#verification)

## System-First Selection

Choose components by behavior, not appearance:

| Need | Prefer |
|---|---|
| Repeated browsable data | `List`, lazy grid/stack, `Table` where platform appropriate |
| Settings or structured input | `Form`, `Section`, native controls |
| One-of-many compact choice | `Picker` with appropriate style |
| Immediate boolean change | `Toggle` |
| Range | `Slider` or `Stepper` |
| Primary command | `Button` with clear verb |
| Supplemental actions | `Menu`, context menu, swipe action |
| Progress | `ProgressView` plus meaningful status when needed |
| Search | `.searchable` |
| Destructive choice | role-based Button in dialog/alert |

Use custom controls only when the product interaction cannot be expressed with a system control.

## State-Driven Composition

Keep the screen shell stable and swap the content region:

```swift
struct LibraryScreen: View {
    let state: LibraryState
    let retry: () -> Void

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Library")
        }
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .loading:
            ProgressView("Loading library")
        case .empty:
            ContentUnavailableView(
                "No entries",
                systemImage: "books.vertical",
                description: Text("Create an entry to start your library.")
            )
        case .loaded(let entries):
            EntryList(entries: entries)
        case .failed(let message):
            ErrorState(message: message, retry: retry)
        }
    }
}
```

Use current platform APIs that fit the deployment target. Provide an authored fallback for newer
state components when needed.

## Loading

- Preserve the eventual layout when possible.
- Use indeterminate progress when duration is unknown.
- Use determinate progress only with real progress.
- Avoid a full-screen spinner for background refresh when existing content remains useful.
- Announce long operations accessibly.

## Empty

Explain:

1. what is empty;
2. why it may be empty;
3. the most useful next action.

Distinguish first-use empty from no search results and filtered empty.

## Error

- Use plain language.
- Preserve user input.
- State whether retry is safe.
- Offer a relevant recovery.
- Do not expose raw server or framework errors as primary copy.
- Log diagnostic detail separately.

## Offline and Partial

If cached/local content exists, show it with status rather than replacing the whole screen. Make
queued/syncing/failed changes distinguishable. Avoid presenting stale data as current.

## Permission

Ask at the moment of value, after context:

- explain what feature needs the permission;
- allow a meaningful path without it when possible;
- do not shame or repeatedly nag;
- provide a settings link only when it helps recovery.

## Forms

- Use labels that remain visible.
- Choose keyboard/content types.
- Validate close to the field and again on submit.
- Keep Save disabled only when the reason is understandable.
- Preserve edits across recoverable errors.
- Use focus order and submit labels.
- Confirm abandoning meaningful unsaved work.

## Lists and Grids

- Use stable identity.
- Keep rows semantically grouped.
- Make the entire expected row target interactive without hiding its label.
- Support long content.
- Avoid heavy work per row.
- Use lazy containers for large scroll content.
- Use swipe/context actions as supplements, not the only way to access essential commands.

## Destructive and Success Feedback

- Prefer visible state change over redundant toast.
- Use haptics sparingly for meaningful confirmation/error.
- Offer Undo for frequent reversible deletion.
- Confirm high-consequence destructive actions with the object and consequence.

## Verification

Preview each important state with the same screen shell. Check:

- layout stability between states;
- primary action visibility;
- useful empty copy;
- preserved input on error;
- offline and stale status;
- permission recovery;
- VoiceOver reading order;
- large text and long strings;
- no custom glass on content-state containers.
