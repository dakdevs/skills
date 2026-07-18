# Responsive Web Review Gate

## Source Boundary

- [ ] The work is described as a HIG-grounded Web adaptation, not an Apple Web HIG.
- [ ] Required Web standards and WCAG/browser checks run separately.

## Navigation and Semantics

- [ ] Meaningful destinations have stable URLs where appropriate.
- [ ] Back, Forward, refresh, deep link, and new-tab behavior are correct.
- [ ] Links navigate and buttons act.
- [ ] Landmarks, headings, labels, reading order, and focus order remain coherent.
- [ ] Responsive visual reordering does not create DOM or keyboard confusion.

## Responsive Behavior

- [ ] Narrow and wide layouts preserve the same primary task and terminology.
- [ ] Reflow occurs before truncation or hiding.
- [ ] Essential actions remain discoverable at every target width.
- [ ] Browser zoom and text enlargement do not cause loss or two-dimensional scrolling for primary UI.
- [ ] Selection, draft, scroll, and focus survive responsive transitions where appropriate.

## Input and State

- [ ] Keyboard and pointer operation are complete; touch is supported where expected.
- [ ] Nothing essential is hover-only, drag-only, right-click-only, or gesture-only.
- [ ] Visible focus and modal focus management are correct.
- [ ] Forms have persistent labels, corrective errors, and preserved input.
- [ ] Reload, offline, stale, partial, expired-auth, and retry states are handled.

## Appearance and Motion

- [ ] Light/dark preference, contrast, reduced motion, and RTL are tested as required.
- [ ] Translucency remains legible over real content.
- [ ] Native-only material is not imitated in a way that loses Web behavior.
- [ ] Color and animation are never the only state signal.

## Evidence

Record browser/engine, viewport range, zoom levels, input methods, assistive technology, appearance,
locale, network states, and results.
