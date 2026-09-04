# Performance Profile Gate

## Applicability

Run this gate when a screen has several simultaneous glass effects, morphing, continuously changing
background content, custom rendering, or a reported performance problem.

## Preflight Inventory

- [ ] Count simultaneous effects in each important state.
- [ ] Count containers and document their functional scopes.
- [ ] Identify video, map, camera, animation, or scrolling beneath effects.
- [ ] Identify concurrent layout, symbol, and glass transitions.
- [ ] Identify custom capture/shader update modes.

## Scenarios

- [ ] Screen appearance.
- [ ] Idle with maximum intended effects.
- [ ] Primary morph/interaction.
- [ ] Rapid repeated interaction.
- [ ] Scroll beneath functional UI.
- [ ] Worst-case moving background.
- [ ] Accessibility configuration that changes rendering.

## Capture

- [ ] Release-like build on representative hardware.
- [ ] SwiftUI instrument for updates/body work.
- [ ] Animation hitches/frame pacing.
- [ ] Core Animation or graphics signal appropriate to the defect.
- [ ] CPU/GPU/energy and memory where custom rendering exists.
- [ ] Recording/signposts that identify the interaction window.

## Analyze

- [ ] Correlate each hitch with view, layout, render, or application work.
- [ ] Compare before/after under identical scenario and content.
- [ ] Test whether removing unjustified effects fixes the issue.
- [ ] Test purposeful container consolidation.
- [ ] Test simplified simultaneous animations.
- [ ] Test on-demand/static update mode for custom renderer.

## Pass Criteria

- [ ] No repeatable visible hitch in primary interactions on target hardware.
- [ ] Idle state does not render continuously without purpose.
- [ ] No repeated transition causes unbounded memory/state growth.
- [ ] Interaction remains responsive during worst-case background activity.
- [ ] Device, OS, build, scenario, and remaining limitations are recorded.

If measurement is unavailable, do not claim a pass. Report structural risk reduction and the exact
measurement still required.
