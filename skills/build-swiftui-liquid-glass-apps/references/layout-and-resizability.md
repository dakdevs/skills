# Layout and Resizability

## Contents

- [Core Rule](#core-rule)
- [Tool Selection](#tool-selection)
- [Context-Agnostic Views](#context-agnostic-views)
- [Adaptive Composition](#adaptive-composition)
- [Grid](#grid)
- [Safe Areas and Floating Controls](#safe-areas-and-floating-controls)
- [iPad](#ipad)
- [Xcode 27 and 2027 Releases](#xcode-27-and-2027-releases)
- [Verification Matrix](#verification-matrix)

## Core Rule

Respond to the space a container offers. Device type, orientation, and size class are context, not
proof of available geometry.

This matters increasingly with iPad multitasking, Stage Manager, iPhone Mirroring, iPhone apps on
iPad, and resizable windows in newer platform releases.

## Tool Selection

Choose the least powerful tool that solves the constraint:

| Need | Prefer |
|---|---|
| Linear content | `VStack`, `HStack`, `ZStack` |
| Long scrolling collection | `List`, `LazyVStack`, `LazyVGrid` |
| Grid with adaptive cells | adaptive `GridItem` |
| Swap composition based on fit | `ViewThatFits` |
| Change stack axis | `AnyLayout` |
| Align related content | `Grid`, alignment guides |
| Read container size for a real calculation | container-relative APIs or scoped geometry |
| Custom repeated layout algorithm | `Layout` protocol |
| List/detail adaptation | `NavigationSplitView` |

Avoid reaching first for `UIScreen.main.bounds`, device-name checks, or a full-screen
`GeometryReader`.

## Context-Agnostic Views

A reusable view should:

- accept content/data, not screen width;
- use flexible frames only where parent expansion is intended;
- avoid hard-coded heights for text;
- allow text wrapping and Dynamic Type;
- expose layout decisions to its container;
- preview in narrow and wide frames.

## Adaptive Composition

```swift
ViewThatFits {
    HStack(spacing: 16) {
        SummaryMetrics()
        PrimaryAction()
    }

    VStack(alignment: .leading, spacing: 12) {
        SummaryMetrics()
        PrimaryAction()
    }
}
```

The alternatives must preserve the same content and action, not become two different products.

## Grid

```swift
let columns = [
    GridItem(.adaptive(minimum: 160, maximum: 260), spacing: 16)
]

LazyVGrid(columns: columns, spacing: 16) {
    ForEach(items) { item in
        ItemCard(item: item)
    }
}
```

Test the minimum with long text and accessibility sizes. A card width chosen for placeholder content
is not a robust constraint.

## Safe Areas and Floating Controls

- Keep content available beneath system bars when the platform expects it.
- Use `safeAreaInset` for content-affecting custom controls.
- Use overlays for transient controls that do not need to reserve space.
- Confirm the last scroll item is not hidden behind a floating glass cluster.
- Let scroll edge effects and system bars handle legibility before adding gradients.

## iPad

Check:

- narrow Split View;
- wide full-screen;
- pointer and keyboard;
- multi-column navigation;
- sheets/popovers appropriate to the larger context;
- drag and drop when central to the task;
- state preservation while resizing.

Do not stretch a phone layout into unused space. Increase information relationship or context, not
just margins.

## Xcode 27 and 2027 Releases

Current platform releases add more resizable situations and Live Preview resize controls. When
using Xcode 27:

- drag preview resize handles through intermediate widths;
- do not assume `.phone` means narrow;
- use current Apple guidance for geometry and orientation;
- gate new toolbar, reorder, or presentation APIs by OS availability;
- preserve usable behavior on the stable minimum OS.

## Failure Modes

- Fixed text heights.
- Absolute x/y positioning for normal interface layout.
- Branching only on `UIDevice.current.userInterfaceIdiom`.
- A compact size class assumed to have one width.
- `GeometryReader` expanding a child unexpectedly.
- Glass controls obscuring scroll content.
- Landscape-only fixes that fail in resizable portrait windows.

## Verification Matrix

At minimum:

| Axis | Values |
|---|---|
| Width | narrow phone, wide phone/window, iPad split, iPad wide |
| Text | default, accessibility large |
| Appearance | light, dark |
| Direction | LTR, RTL |
| Content | short, long, empty, dense |
| Input | touch; keyboard/pointer when iPad matters |

Watch for truncation, overlap, unreachable actions, excessive empty space, unstable navigation, and
glass that loses separation over changed content.
