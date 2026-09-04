# Example: Cross-Version Floating Action

## Goal

A map action floats above content on iOS 18 through iOS 26+, using native Liquid Glass when
available without pretending the legacy material is the same effect.

## Implementation

```swift
import SwiftUI

struct LocateMeAction: View {
    let action: () -> Void

    var body: some View {
        if #available(iOS 26.0, *) {
            button
                .buttonStyle(.glass)
        } else {
            button
                .buttonStyle(.plain)
                .padding(10)
                .background(.regularMaterial, in: Circle())
        }
    }

    private var button: some View {
        Button(action: action) {
            Image(systemName: "location.fill")
                .frame(width: 24, height: 24)
        }
        .accessibilityLabel("Show my location")
    }
}
```

## Why It Works

- Both branches preserve one `Button` action and label.
- The current system provides native glass behavior.
- The older system uses a standard material only for functional separation from map content.
- No claim of optical parity is made.

## Hardening

- Ensure the resulting target size is appropriate in both branches.
- Check location authorization/loading/disabled states.
- Test light/dark map styles and Reduce Transparency.
- For a shared iOS/macOS component, use a compound availability branch and adapt input/placement.

## Avoid

- A package dependency solely for this one branch.
- A tap gesture on a glass-looking `Circle`.
- Calling the fallback `liquidGlass` in API naming or analytics.
