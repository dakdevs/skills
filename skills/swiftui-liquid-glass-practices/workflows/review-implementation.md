# Workflow: Review a Liquid Glass Implementation

## Use When

Reviewing a pull request, screen, component, or migration for correctness and Apple design fit.

## Review Order

### 1. Establish constraints

- Target platforms and deployment versions.
- SDK used to build.
- Whether the feature is system-provided or custom.
- Background/content conditions.
- Accessibility and input requirements.

### 2. Review intent before syntax

For every glass surface, identify its functional role. Flag content-layer or decorative use before
discussing exact modifiers.

### 3. Review system adoption

- Could this be a standard control, toolbar item, tab, sheet, menu, or search placement?
- Are custom backgrounds blocking automatic behavior?
- Are semantic roles and familiar placements preserved?

### 4. Review native custom effects

- Correct availability branch.
- `.glassEffect()` after appearance/layout modifiers.
- Correct variant, shape, tint, and interactivity.
- Purposeful container scope and spacing.
- Correct union versus transition identity.
- Animated hierarchy change for morphing.

### 5. Review adaptation

- Light/dark and varied background legibility.
- Reduce Transparency, Increase Contrast, Reduce Motion, Dynamic Type, and VoiceOver.
- Touch, pointer, keyboard, and focus behavior as applicable.
- Platform-specific structure and placement.
- Honest older-OS fallback.

### 6. Review performance evidence

- Count simultaneous effects and containers in the affected state.
- Identify continuously changing sampled backgrounds.
- Ask for Instruments/device evidence when risk is nontrivial.
- Do not accept “looks smooth in Simulator” as the only evidence.

## Finding Format

```markdown
[Priority] Short title

The implementation [specific behavior] in [location/state]. This violates [design/API invariant]
and causes [user-visible impact]. Prefer [smallest native repair]. Verify by [specific check].
```

Prioritize:

1. Broken interaction, semantics, or accessibility.
2. Content/functional-layer confusion and legibility.
3. Incorrect composition or transition behavior.
4. Platform/version breakage.
5. Demonstrated performance regression.
6. Cosmetic inconsistency with a concrete user impact.

## Do Not Report

- Personal aesthetic preference without an Apple principle or user impact.
- Hypothetical performance problems with no plausible mechanism.
- Star count or community popularity as proof.
- Beta-era defects without confirming the current target OS.
- A demand for custom glass when system adoption already satisfies the design.

## Completion

Run all files under `checks/`. If no actionable findings remain, state the tested configurations
and any untested risk rather than declaring universal correctness.
