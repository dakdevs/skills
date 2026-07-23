# Motion, Haptics, and Interaction

## Contents

- [Motion Has a Job](#motion-has-a-job)
- [Choose the Smallest Mechanism](#choose-the-smallest-mechanism)
- [Reduced Motion](#reduced-motion)
- [Haptics](#haptics)
- [Gestures](#gestures)
- [Glass Interaction](#glass-interaction)
- [Tuning](#tuning)
- [Performance](#performance)
- [Verification](#verification)

## Motion Has a Job

Use motion to:

- acknowledge input;
- explain spatial or state change;
- preserve object continuity;
- direct attention to a result;
- communicate hierarchy.

Do not animate merely because a property changed.

## Choose the Smallest Mechanism

| Need | Prefer |
|---|---|
| Animate one value change | `.animation(_:value:)` |
| Animate an explicit action | `withAnimation` |
| Insert/remove a view | transition plus explicit animation |
| Ordered multi-step states | phase animation where supported |
| Precisely timed stages | keyframes where supported |
| Related custom glass states | `glassEffectID` in one container |
| Continuous gesture | gesture state driving a value, then settle |

Always include the value in implicit animation. Avoid the broad deprecated form that animates
unrelated changes.

## Reduced Motion

Read:

```swift
@Environment(\.accessibilityReduceMotion) private var reduceMotion
```

Then:

- remove large travel, parallax, or elastic morphing;
- preserve state feedback with opacity or immediate change;
- never remove information or success confirmation;
- test interruption in both modes.

## Haptics

Use system sensory feedback for:

- committed selection;
- meaningful success;
- warning/error;
- boundary/impact when it communicates physical interaction.

Avoid feedback on every scroll tick, decorative animation, or routine navigation. Haptic feedback
supplements visible and accessible state; it is never the only signal.

## Gestures

- Prefer `Button`, `Toggle`, `Slider`, `ScrollView`, swipe actions, and drag/drop APIs.
- Add custom gestures only when the interaction model requires them.
- Define hit area with `contentShape` when the expected target is larger than visible content.
- Resolve gesture competition with scrolling before combining gestures.
- Provide an accessible alternative to drag, swipe, or multi-touch.
- Avoid using `onTapGesture` as a button substitute.

## Glass Interaction

- `.interactive()` belongs on a control that actually responds.
- Group controls that flex or morph together.
- Avoid interactive glass on draggable content without testing gesture conflicts.
- Test glass motion over changing/scrolling content.
- Preserve conceptual identity across a morph.

## Tuning

Tune a named parameter surface:

```swift
struct MotionTuning {
    var response: Double
    var damping: Double
    var scale: Double
}
```

Use a temporary preview control panel. Compare small ranges; record why the chosen values support
the moment. Remove production tuning UI and centralize final values.

## Performance

- Animate transforms and opacity before expensive layout.
- Do not animate high-cost blur/effect stacks unnecessarily.
- Avoid broad state changes that invalidate a large tree every frame.
- Test on device for high-stakes glass/motion.
- Profile a reproduced hitch; do not guess.

## Verification

- Motion purpose can be stated in one sentence.
- State remains clear without motion.
- Animations can be interrupted safely.
- Repeated taps do not corrupt state.
- Reduce Motion path works.
- VoiceOver focus remains coherent.
- Gesture has a non-gesture alternative where needed.
- Haptic is meaningful and not noisy.
- Custom glass motion remains smooth over varied content.
