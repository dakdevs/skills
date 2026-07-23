# Example: Media Controls over Rich Content

## Scenario

A full-screen photo story needs compact playback controls. This is one of the few contexts where
clear glass may be appropriate because the control plane floats over visually rich media.

## Decision

| Question | Answer |
|---|---|
| Functional or content? | Functional controls |
| System control available? | Buttons exist; the grouped floating cluster is custom |
| Variant | Compare regular first; clear only if full image range remains legible |
| Grouping | One `GlassEffectContainer` |
| Primary action | Play/pause |
| Fallback | Standard material control cluster |

## Structure

```swift
struct StoryPlayer: View {
    var body: some View {
        StoryMedia()
            .overlay(alignment: .bottom) {
                PlaybackControlPlane()
                    .padding()
            }
    }
}
```

Ensure overlay controls do not hide captions or essential content.

## Available Implementation

```swift
@available(iOS 26.0, *)
private struct GlassPlaybackControls: View {
    var body: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                Button("Previous", systemImage: "backward.fill", action: previous)
                    .labelStyle(.iconOnly)
                    .padding(12)
                    .glassEffect(.clear.interactive(), in: .circle)

                Button("Play", systemImage: "play.fill", action: play)
                    .labelStyle(.iconOnly)
                    .padding(16)
                    .glassEffect(
                        .clear.tint(.white.opacity(0.12)).interactive(),
                        in: .circle
                    )

                Button("Next", systemImage: "forward.fill", action: next)
                    .labelStyle(.iconOnly)
                    .padding(12)
                    .glassEffect(.clear.interactive(), in: .circle)
            }
        }
    }

    private func previous() {}
    private func play() {}
    private func next() {}
}
```

This is a pattern sketch. Check current API availability and use system glass button styles when
they produce the correct design with less code.

## Fallback

Use the same three Buttons in a semantic material-backed capsule. Preserve labels, targets, state,
and actions. Do not recreate lensing.

## Test Content

- bright snow;
- dark concert;
- high-frequency city lights;
- flat illustrated scene;
- light/dark appearance;
- paused/playing/disabled;
- Reduce Transparency and Increase Contrast.

If clear glass fails any important background, use regular glass or add a product-appropriate
content treatment. Do not assume a fixed dark scrim is always correct.

## Accessibility

- Buttons retain accessible text labels despite icon-only visual style.
- Play changes to Pause with updated label/value.
- Controls are reachable without gestures.
- Captions remain unobscured.
- Reduce Motion removes nonessential control morphing.

## Failure Modes

- Clear glass chosen from one attractive hero image.
- Controls are `Image.onTapGesture`.
- Cluster overlaps captions.
- Every metadata chip also gets glass.
- Controls disappear in Increase Contrast or bright media.
