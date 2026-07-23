# Workflow: Adopt Liquid Glass in an Existing App

## Goal

Modernize the interface without erasing product identity, breaking older deployment targets, or
turning content into a wall of translucent effects.

## Phase 1: Establish the Baseline

Record:

- current Xcode and SDK;
- minimum OS;
- target platforms;
- screenshots of primary flows before migration;
- custom navigation/bar/sheet backgrounds;
- existing `Material`, blur, visual-effect, and translucency code;
- accessibility settings that affect the current UI.

Build and run before changing code. A migration without a stable baseline cannot distinguish new
problems from existing ones.

## Phase 2: Observe Automatic Adoption

Build with the newer SDK and inspect:

- `TabView`;
- `NavigationStack` and `NavigationSplitView`;
- toolbars and search;
- sheets, alerts, popovers, menus;
- buttons, toggles, sliders, and segmented controls;
- scroll edges under floating chrome.

System components may change appearance without source changes. Do not add custom glass to elements
that already have it.

## Phase 3: Remove Interference

Search for:

- custom toolbar and navigation backgrounds;
- `presentationBackground`;
- custom blur wrappers;
- opaque overlays behind bar items;
- hard-coded corner radii that fight container geometry;
- custom search fields positioned in toolbars;
- decorative materials on content cards.

Remove or isolate interference one category at a time, rebuilding after each change.

## Phase 4: Draw the Layer Boundary

For each surface classify:

| Surface | Layer | Default treatment |
|---|---|---|
| Article, row, card, form, chart, media | Content | No Liquid Glass; semantic fill/material only if needed |
| Tab bar, sidebar, toolbar, search chrome | System functional | Let the system style it |
| Custom floating primary control | Custom functional | Candidate for glass |
| Temporary active control such as a slider thumb | Functional state | Prefer system control |
| Decorative badge or texture | Content/decorative | No glass unless it is truly an interactive control |

Fail the design if independent glass layers overlap in the same plane.

## Phase 5: Add Custom Glass Deliberately

For each candidate, answer:

1. What function does the floating layer communicate?
2. Why is a system control insufficient?
3. Is regular glass legible over all underlying states?
4. If clear glass is proposed, is the background visually rich and is content still legible?
5. Does the control need `.interactive()`?
6. Are nearby shapes grouped in `GlassEffectContainer`?
7. Does a morph preserve continuity or merely decorate the transition?

Implement using `references/liquid-glass-api.md`.

## Phase 6: Availability and Fallback

Use `references/availability-and-fallbacks.md`.

- Keep shared content in one view where possible.
- Branch at the styling or component boundary.
- Make the fallback behaviorally equivalent, not a pixel imitation.
- Do not refer to `Glass` types in declarations compiled for older SDKs.
- Treat an app-wide compatibility switch as a temporary migration tool, not a substitute for audit.

## Phase 7: Verify

Run `checks/liquid-glass-review.md`.

At minimum inspect:

- light and dark appearances;
- bright, dark, busy, and flat content behind glass;
- Reduce Transparency;
- Increase Contrast;
- Reduce Motion;
- larger text;
- fast scrolling;
- navigation transitions and interrupted animations;
- supported older OS fallback;
- actual device rendering for high-stakes polish.

Profile only when symptoms or complexity justify it. If scrolling hitches or updates are excessive,
use `references/performance.md`.

## Output

Produce an adoption table:

| Area | Automatic change | Custom change | Fallback | Verification |
|---|---|---|---|---|

Also report removed interference, remaining legacy material, and any surface intentionally left
without glass.

## Anti-Patterns

- Adding `.glassEffect()` to every existing `Material`.
- Rebuilding system tab bars or search to control their appearance.
- Using clear glass because it appears more transparent in one screenshot.
- Tinting every action and destroying hierarchy.
- Claiming accessibility is automatic for a custom control.
- Shipping only the latest-OS branch without testing the fallback.
