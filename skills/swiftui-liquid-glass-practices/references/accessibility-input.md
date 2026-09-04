# Accessibility and Input Reference

## Use When

Designing, implementing, or reviewing any Liquid Glass UI. Accessibility is part of material
correctness because system settings intentionally change transparency, contrast, and motion.

## Core Rule

The interface must remain understandable when the glass appearance is substantially altered. Do not
encode function, hierarchy, or state solely in translucency, lensing, color, or morphing.

## Environment and System Conditions

Test at minimum:

- Reduce Transparency on/off.
- Increase Contrast on/off.
- Reduce Motion on/off.
- Light and dark appearance.
- Default and largest practical Dynamic Type sizes.
- VoiceOver.
- Voice Control where icon-only or custom controls are used.
- Bold Text and differentiate-without-color when relevant.

Test important combinations, not only each setting separately. Reduce Transparency + Increase
Contrast + dark appearance often reveals assumptions hidden by the default rendering.

## Semantics

- Prefer semantic controls and labels.
- Every icon-only action needs a meaningful accessibility label.
- Add a hint only when the result of the action is not evident from the label.
- Expose selected, disabled, expanded, and value state.
- Mark decorative reflections, duplicate symbols, and mirrored content as hidden from accessibility.
- Keep accessibility identifiers stable, nonlocalized, and separate from spoken labels.
- Preserve logical focus order when controls visually merge or expand.

## Motion

- Morphing should communicate continuity; it must not be required to understand the state change.
- Under Reduce Motion, avoid unnecessary elastic travel, scaling, and repeated shimmer.
- Preserve immediate pressed/selected feedback through a calmer visual change.
- Avoid simultaneous layout, symbol, glass, and opacity animations that create excessive movement.

## Contrast and Legibility

- Test real background extremes and moving content.
- Prefer regular glass when foreground includes text or fine symbols.
- Use vibrant/system foreground styles that adapt to the material.
- Do not assume blur guarantees contrast.
- Use dimming with clear glass when documented conditions demand it.
- Keep labels stable and readable throughout transitions, not just at endpoints.

## Dynamic Type and Target Size

- Allow labels to grow without clipping or collapsing into ambiguous icons.
- Avoid fixed heights that fit only the default metrics.
- Ensure control targets remain appropriately sized after custom shape and overlay changes.
- Recheck container spacing: larger text can change geometry and cause unintended merging.

## Input Adaptation

### Touch

- Interactive glass and the semantic hit target should coincide.
- Test rapid taps and interrupted transitions.

### Pointer

- Verify hover and pointer effects do not duplicate `.interactive()` feedback.
- Preserve readable state without relying on hover.

### Keyboard

- Ensure focus visibility, activation, shortcuts, and traversal work for custom controls.
- Do not hide focus indicators behind clear glass or busy content.

### tvOS Focus

- Use standard focus APIs.
- Test scale, movement, and contrast from a viewing distance.
- Avoid stacking custom morphing on top of system focus motion.

## Automated and Manual Testing

- Use stable accessibility identifiers in UI tests.
- Run accessibility audits where supported.
- Capture screenshots/videos for important appearance/accessibility combinations.
- Manual VoiceOver and focus review remains necessary for meaning and sequence.

## Accessibility Finding Examples

High priority:

> The custom glass capsule is implemented as a tap gesture on an `HStack`, so VoiceOver does not
> announce it as a button and keyboard activation is absent. Preserve the layout but make the
> semantic root a `Button`, then apply the supported glass button style.

High priority:

> The selected tab is distinguished only by blue tint. Add the selected trait and a non-color visual
> indicator, then test Increase Contrast and differentiate-without-color.

## Verification Output

Report settings, device/platform, task performed, observed behavior, and pass/fail. “Supports
accessibility” without a matrix is not evidence.
