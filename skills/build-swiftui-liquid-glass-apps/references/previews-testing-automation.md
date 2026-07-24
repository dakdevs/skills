# Previews, Testing, and UI Automation

## Contents

- [Preview Matrix](#preview-matrix)
- [Fixture Rules](#fixture-rules)
- [`#Preview`](#preview)
- [Test Pyramid](#test-pyramid)
- [UI Automation](#ui-automation)
- [Visual Comparison](#visual-comparison)
- [Liquid Glass Test Matrix](#liquid-glass-test-matrix)
- [Verification Report](#verification-report)

## Preview Matrix

Previews accelerate design only when they expose variation.

Create fixtures for:

- initial/first-use;
- loading;
- empty;
- representative populated;
- dense populated;
- error/offline;
- permission denied;
- long localized content.

Render relevant combinations of:

- compact/wide;
- light/dark;
- default/accessibility text;
- LTR/RTL;
- reduced motion/transparency where preview tooling supports it.

## Fixture Rules

- Deterministic.
- Synthetic.
- No production credentials or network.
- No writes to shared production storage.
- Plausible variety and relationships.
- Easy to select directly.

Keep fixture builders close to tests/previews or in a dedicated development-support module.

## `#Preview`

Use multiple named previews:

```swift
#Preview("Populated") {
    HomeView(model: .previewPopulated)
}

#Preview("Empty - Dark") {
    HomeView(model: .previewEmpty)
        .preferredColorScheme(.dark)
}
```

Use current preview traits and `@Previewable` when the active toolchain and deployment target
support them. Otherwise wrap interactive state in a small preview host.

## Test Pyramid

| Layer | Test |
|---|---|
| Domain | pure rules and formatting |
| Service | success/failure/cancellation with fakes |
| State model | user intent -> state transition |
| Integration | persistence or API boundary |
| UI | critical end-to-end path and accessibility identity |
| Visual | established screenshot workflow for high-value stable surfaces |

Avoid slow UI tests for logic that a unit test proves more reliably.

## UI Automation

- Use accessibility labels/identifiers for stable product concepts.
- Wait for observable UI state rather than sleeping.
- Seed deterministic data.
- Start from a known launch state.
- Exercise the same route a person uses.
- Assert the outcome, not pixel coordinates.
- Capture screenshot/artifact on failure.
- Keep critical flows short.

Xcode 27 agent tools can build, render previews, run tests, and interact with apps where enabled.
Use those capabilities as a validation loop, not merely a final command.

## Visual Comparison

When comparing to a design:

1. Match content and state.
2. Match container size, appearance, locale, and text size.
3. Compare hierarchy before individual pixels.
4. Inspect safe areas, scrolling, and keyboard states.
5. Run the interaction after the still comparison.

Do not chase screenshots by breaking Dynamic Type or native control behavior.

## Liquid Glass Test Matrix

Include:

- regular and any justified clear surfaces;
- bright/dark/busy/flat backgrounds;
- active/pressed/disabled/selected;
- Reduce Transparency;
- Increase Contrast;
- Reduce Motion;
- older OS fallback;
- fast scroll and interrupted morph.

## Verification Report

For each claim name:

- tool;
- destination;
- state;
- result;
- artifact if available.

Use `templates/verification-report.md`.

## Failure Modes

- One preview with toy data.
- Preview-only logic in production types.
- Tests that call live services.
- UI tests with arbitrary sleeps.
- Screenshot comparison across different states.
- Accessibility identifiers coupled to view layout.
- Skipping runtime because previews render.
