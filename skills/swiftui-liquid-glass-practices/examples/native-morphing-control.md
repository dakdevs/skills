# Example: Native Expanding Glass Control

## Goal

A compact “more” button expands into related share and favorite actions above a photo. The morph
communicates that the actions came from the compact control.

## Implementation

```swift
import SwiftUI

@available(iOS 26.0, macOS 26.0, *)
struct ExpandingPhotoActions: View {
    @State private var isExpanded = false
    @Namespace private var glassNamespace

    var body: some View {
        GlassEffectContainer(spacing: 18) {
            HStack(spacing: 12) {
                actionButton(
                    systemImage: isExpanded ? "xmark" : "ellipsis",
                    accessibilityLabel: isExpanded ? "Hide photo actions" : "Show photo actions"
                ) {
                    withAnimation(.smooth) {
                        isExpanded.toggle()
                    }
                }
                .glassEffectID("photo-actions-toggle", in: glassNamespace)

                if isExpanded {
                    actionButton(systemImage: "heart", accessibilityLabel: "Favorite") {
                        favorite()
                    }
                    .glassEffectID("favorite", in: glassNamespace)
                    .glassEffectTransition(.matchedGeometry)

                    actionButton(
                        systemImage: "square.and.arrow.up",
                        accessibilityLabel: "Share"
                    ) {
                        share()
                    }
                    .glassEffectID("share", in: glassNamespace)
                    .glassEffectTransition(.matchedGeometry)
                }
            }
        }
    }

    private func actionButton(
        systemImage: String,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(.glass)
        .accessibilityLabel(accessibilityLabel)
    }

    private func favorite() {}
    private func share() {}
}
```

## Why It Follows the Model

- The surface is functional UI floating above photo content.
- Standard `Button` and glass button style preserve semantics.
- One container scopes the related action group.
- Each effect has a distinct stable identity.
- Optional controls enter and leave the hierarchy inside `withAnimation`.
- The transition communicates expansion from the control cluster.

## Production Additions

- Expose expanded state and focus order appropriately.
- Provide a lower-motion state change when testing shows default behavior remains excessive.
- Close the cluster on relevant context changes.
- Test localization, Dynamic Type, rapid toggling, and device rendering.

## Anti-Example

Do not give all three controls `glassEffectID("actions", ...)`. That does not express three stable
transition identities. A shared ID belongs to a deliberate union if one material surface is the
goal.
