# Custom Renderers and Private API Boundaries

## Use When

A request proposes Metal shaders, background capture, a visual backport, custom tab/lens behavior,
private classes, or internal UIKit hierarchy manipulation.

## First Distinction

| Approach | What it is | How to describe it |
|---|---|---|
| Native SwiftUI glass API | System Liquid Glass | “Native Liquid Glass” |
| Standard `Material` fallback | Semantic translucent separation | “Material fallback” |
| Public-API Metal/custom renderer | App-owned optical approximation | “Custom glass effect” or “Liquid Glass-inspired” |
| Private/internal API or hierarchy manipulation | Unsupported system imitation | “Experimental unsupported implementation” |

Never collapse these categories in code comments, documentation, or user communication.

## When Custom Rendering May Be Justified

- The visual itself is app content, such as an art, graphics, or simulation feature.
- A very high element count makes individual native views unsuitable and measurement supports a
  batched renderer.
- An older-system approximation is a firm product requirement and standard material is inadequate.
- The effect needs public-API shader behavior that native glass intentionally does not expose.

Even then, preserve semantic controls above or alongside the renderer.

## Public-API Custom Renderer Checklist

- Background capture uses documented APIs.
- Rendering does not expose private classes or selectors.
- Update scheduling supports static/manual/on-demand modes, not unconditional continuous work.
- GPU, CPU, energy, memory, and latency are measured on target devices.
- Reduce Motion/Transparency and contrast behavior are implemented intentionally.
- The renderer degrades safely when capture or Metal capability is unavailable.
- App Review and privacy implications are documented.
- Visual claims say “inspired” or “approximation,” not “native parity.”

## Unsupported Technique Red Flags

- Class names beginning with underscore or runtime lookup of internal system classes.
- `CABackdropLayer` or other private capture mechanisms used without explicit review.
- Traversing and replacing subviews inside `UITabBar`, `UISegmentedControl`, or another system
  control based on undocumented structure.
- Assigning a false semantic role to obtain system artwork.
- Swizzling, selector guessing, or OS-build-specific view indices.
- “Pixel perfect” claims without accessibility, platform, and point-release evidence.

## Required Escalation

Before implementing an unsupported technique, present:

1. The unmet product requirement.
2. Public native alternatives attempted.
3. Semantic and accessibility impact.
4. App Review and maintenance risk.
5. Known OS/version scope.
6. A kill switch or fallback.
7. Ownership and removal criteria.

Do not infer approval from a request for “more customization.”

## Case-Study Lessons

- Custom Metal projects demonstrate that continuous capture/refraction has measurable GPU and
  energy cost; static/on-demand modes are valuable.
- A tab-bar recreation can preserve an action role better than abusing a search tab, yet still be
  brittle if it manipulates internal hierarchy.
- Private backdrop techniques may stop working in point releases and can create App Store risk.
- Native behavior often includes intricate interaction, focus, and accessibility adaptation that
  visual replicas omit.

## Preferred Alternatives

- Standard controls and roles.
- Public `.glassEffect()` on justified custom functional UI.
- Standard material fallback on older systems.
- A custom content renderer with semantic SwiftUI controls outside it.
- Product/design adjustment that works within supported API.

## Verification

- Search dependencies and app source for underscore-prefixed runtime class lookup, private backdrop
  layers, method swizzling, and undocumented subview traversal.
- Confirm the renderer's public/private API classification in writing.
- Exercise semantic controls with VoiceOver, keyboard, pointer, and focus independently of visuals.
- Profile static, interactive, and continuous update modes on representative hardware.
- Test at least two supported OS point releases when the implementation depends on system capture or
  control internals.
- Verify the kill switch and public fallback before accepting an experimental path.
