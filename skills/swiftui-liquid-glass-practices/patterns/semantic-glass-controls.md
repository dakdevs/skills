# Pattern: Semantic Glass Controls

## Problem Shape

A functional control floats above content and should participate in the current Apple design without
losing semantics or platform behavior.

## Core Idea

Choose the semantic control first and let its native style supply glass. Use a raw glass effect only
when the functional surface is not expressible by a standard style.

## Procedure

1. Name the action or value in user terms.
2. Choose `Button`, `Toggle`, `Slider`, `Picker`, `Menu`, or another semantic control.
3. Place it in a system toolbar, tab, sheet, safe-area bar, or custom floating group as appropriate.
4. Apply `.glass` or `.glassProminent` to standard buttons on supported systems.
5. Use labels and symbols consistently; add accessibility labels for icon-only presentation.
6. Use tint for a primary/status meaning only.
7. Add a custom glass shape only when the default control style cannot represent the design.

## Example

```swift
Button {
    startRecording()
} label: {
    Label("Record", systemImage: "mic.fill")
}
.buttonStyle(.glassProminent)
.tint(.red)
```

The red tint communicates the recording action. The root remains a `Button`, so keyboard, focus,
disabled state, accessibility, and platform behavior remain available.

## Custom Composite Control

For a custom control, preserve one semantic root:

```swift
Button(action: togglePlayback) {
    HStack(spacing: 10) {
        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
        Text(isPlaying ? "Pause" : "Play")
    }
    .font(.headline)
    .padding(.horizontal, 18)
    .padding(.vertical, 12)
}
.buttonStyle(.plain)
.glassEffect(.regular.interactive(), in: .capsule)
.accessibilityValue(isPlaying ? "Playing" : "Paused")
```

Use this only when the system glass button style cannot express the required composition.

## Review Questions

- Is the element genuinely functional and above content?
- Could it live in a system toolbar or presentation instead?
- Does the root control expose its role and state?
- Does tint add meaning?
- Does the glass shape match the hit region?
- Does the fallback remain the same kind of control?

## Verification

- Activate with touch, pointer, keyboard, and focus as applicable.
- Check enabled, disabled, pressed, selected, and loading states.
- Run VoiceOver and Voice Control.
- Test over worst-case content and with contrast/transparency settings.
- Confirm visual feedback does not imply actions on static neighboring content.
