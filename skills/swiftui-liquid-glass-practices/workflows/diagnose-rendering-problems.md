# Workflow: Diagnose Liquid Glass Rendering Problems

## Use When

Glass appears opaque, flat, duplicated, clipped, incorrectly merged, visually discontinuous, or
janky; morphing pops; shadows reappear; or behavior differs between Simulator and device.

## Preserve Evidence

Record:

- Device model, OS point release, Xcode/SDK, build configuration.
- Simulator versus physical-device result.
- Light/dark appearance and accessibility settings.
- Static versus moving background.
- Exact view state and interaction sequence.
- Screen recording and Instruments trace when relevant.

## Diagnostic Ladder

### 1. Confirm the effect belongs here

If the surface is content or decorative, removal may be the correct fix.

### 2. Reduce to one native effect

Temporarily isolate one public `.glassEffect()` with no tint, animation, overlay, or custom
background. If the defect remains, record an SDK/OS reproduction. If it disappears, reintroduce
layers one at a time.

### 3. Inspect modifier order and bounds

- Is padding before `.glassEffect()`?
- Are frames, clipping, masks, transforms, or offsets applied after capture unexpectedly?
- Does an overlay add a second material?
- Does the glass shape match the hit region?

### 4. Inspect sampling and composition

- Are nearby effects inside one purposeful `GlassEffectContainer`?
- Are unrelated effects accidentally inside the same container?
- Is container spacing causing at-rest merging?
- Is glass sampling another glass surface?
- Does a union contain compatible shapes and variants?

### 5. Inspect transition identity

- Are IDs stable and unique for independent effects?
- Is a shared ID intended for a union rather than copied from morphing advice?
- Does the view enter/leave the hierarchy inside `withAnimation`?
- Is `.materialize` more appropriate for a distant element?

### 6. Inspect system customizations

Remove legacy bar, sheet, scroll-edge, or presentation backgrounds. Verify the uncustomized system
component before adding anything back.

### 7. Inspect availability and fallback

Confirm which branch actually runs. A material fallback can be mistaken for failed native glass if
the runtime availability condition or build SDK is not what the author assumed.

### 8. Reproduce on device and current patch level

Rendering bugs can be device-only. Test the current supported OS, then the oldest supported
platform-26 point release if available. Do not permanently encode a workaround until its scope is
known.

### 9. Profile

If the symptom is timing-dependent, use the SwiftUI instrument, animation hitches, Core Animation,
and Time Profiler. Correlate the trace to interaction signposts or recordings.

## Repair Preference

1. Remove unjustified glass.
2. Restore system component behavior.
3. Correct modifier order or container scope.
4. Simplify transition/effects.
5. Add a narrowly scoped version workaround with an issue reference and removal condition.
6. Use a custom renderer only after public-native options are proven insufficient and risks are
   accepted.

## Diagnostic Output

```markdown
## Reproduction
- Environment:
- Steps:
- Expected/actual:

## Isolation result
- Minimal native case:
- First modifier/configuration that reintroduces the defect:

## Root cause
- Evidence:

## Repair
- Change:
- Version scope:
- Removal condition:

## Verification
- Device/OS matrix:
- Accessibility settings:
- Performance evidence:
```
