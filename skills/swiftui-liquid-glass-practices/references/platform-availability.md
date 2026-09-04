# Platform and Availability Reference

## Use When

Choosing deployment behavior, reviewing `#available` checks, planning a migration, or resolving a
claim that an API works on every Apple platform.

## Verified Native Availability

The 2026 Apple documentation metadata for `glassEffect`, `GlassEffectContainer`, `glassEffectID`,
`glassEffectUnion`, and `glassEffectTransition` lists:

- iOS 26+
- iPadOS 26+
- macOS 26+
- Mac Catalyst 26+
- tvOS 26+
- watchOS 26+

The inspected symbol metadata does **not** list visionOS. Do not infer visionOS support from “Apple
platforms,” repository README text, or the visual ancestry of Liquid Glass. Verify the current SDK
before changing this rule.

## Build SDK Versus Deployment Target

Keep three questions separate:

1. **Which SDK compiles the source?** The compiler must know the symbols.
2. **Which OS runs the native branch?** Runtime availability controls execution.
3. **What does an older build look like on a newer OS?** Apple documented that apps built with the
   previous SDK could retain the earlier appearance even on platform version 26.

A project can compile with Xcode 26 while continuing to deploy to older systems. New APIs must be
inside an availability boundary the compiler can prove.

## Adoption Behavior

- Rebuilding with the current SDK allows standard SwiftUI controls and structures to adopt the
  current design.
- Apps that heavily customize system components may not receive the intended result automatically.
- Apple provides a compatibility mechanism for temporarily shipping with the previous design while
  updating against the newer SDK. Treat it as migration debt, not a permanent theme switch.
- Recheck compatibility keys and deadlines in current Apple documentation before recommending them.

## Availability Decision Table

| Project situation | Action |
|---|---|
| Minimum target is platform 26+ | Use native APIs directly; still verify cross-platform differences |
| Minimum target predates 26 | Runtime-gate native UI and provide semantic fallback |
| Shared SwiftUI source targets several platforms | Use compound availability and platform-specific structure where needed |
| Package API exposes glass types publicly | Availability-annotate the public declaration, not only its body |
| A generic modifier wrapper fails to compile | Move the availability boundary to an `@ViewBuilder` branch or availability-annotated helper |
| visionOS target is included | Do not call these APIs until the active SDK confirms support |
| Compatibility mode is enabled | Document why, owner, expiry/removal condition, and test both modes |

## Platform Adaptation Notes

### iPhone and iPad

- Tab/search placement and minimization can differ by size class and device.
- Partial sheets, safe areas, and content beneath floating controls need device-specific review.
- Pointer behavior matters on iPad when supported.

### macOS

- Preserve density where appropriate; control sizing and window resizing differ from touch UI.
- Test arbitrary window sizes, keyboard focus, toolbar grouping, sidebars, and inspectors.
- Do not force iPhone bottom controls into a Mac window.

### tvOS

- Focus is the primary interaction. Standard focus APIs are part of the visual behavior.
- Some navigation transitions have platform limitations; verify the actual transition API.
- Test at viewing distance and with media backgrounds.

### watchOS

- Prefer standard controls and toolbars; screen area and glanceability dominate.
- Avoid dense custom effect groups.

### Mac Catalyst

- Verify pointer, keyboard, toolbar, and window behavior independently from iPadOS.

## Verification

- Inspect the active SDK declaration or current Apple symbol page.
- Compile every conditional branch for its intended target.
- Run the oldest supported OS and a current OS.
- Test at least one representative input method per platform.
- Report untested platform branches explicitly.

## Failure Modes

- `#available(iOS 26, *)` used in a shared macOS/tvOS/watchOS source without reasoning.
- API availability inferred from a blog or package README.
- A fallback silently changes a `Button` into `onTapGesture`.
- Compatibility mode ships without a removal plan.
- A single visual implementation is forced across every device class.
