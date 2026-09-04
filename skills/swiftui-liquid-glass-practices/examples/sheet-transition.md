# Example: Adapt a Settings Sheet

## Goal

A toolbar settings button presents a partial-height sheet that feels connected to its source and
allows the system to provide the current material.

## Legacy Implementation Problems

- `.presentationBackground(.ultraThinMaterial)` masks current system sheet behavior.
- The toolbar has a custom blur background.
- The sheet form's background hides the partial-height material.

## Adapted Pattern

```swift
import SwiftUI

@available(iOS 26.0, *)
struct LibraryView: View {
    @State private var showsSettings = false
    @State private var detent: PresentationDetent = .medium
    @Namespace private var settingsTransition

    var body: some View {
        NavigationStack {
            List {
                Text("Library content")
            }
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gear") {
                        showsSettings = true
                    }
                }
                .matchedTransitionSource(id: "settings", in: settingsTransition)
            }
            .sheet(isPresented: $showsSettings) {
                NavigationStack {
                    Form {
                        Toggle("Automatic downloads", isOn: .constant(true))
                    }
                    .scrollContentBackground(detent == .large ? .automatic : .hidden)
                    .navigationTitle("Settings")
                }
                .presentationDetents([.medium, .large], selection: $detent)
                .navigationTransition(
                    .zoom(sourceID: "settings", in: settingsTransition)
                )
            }
        }
    }
}
```

## Reasoning

- The system owns toolbar and sheet glass; no explicit `.glassEffect()` is needed.
- A partial detent exposes the floating sheet treatment.
- Background visibility changes with detent so the full-height form remains readable.
- The source and destination IDs connect one presentation relationship.

## Verification

- Confirm the exact API availability in the target SDK.
- Test medium/large transitions in light and dark appearances.
- Test a pushed navigation destination inside the sheet.
- Verify VoiceOver focus enters and returns correctly.
- Test Reduce Motion and interactive dismissal.
- Recheck whether the conditional form-background customization is still necessary on the target OS
  point release before keeping it.
