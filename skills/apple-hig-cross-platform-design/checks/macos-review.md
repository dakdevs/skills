# Native macOS Review Gate

## Windows and Structure

- [ ] Window roles, ownership, close/quit behavior, minimum/maximum size, and restoration are defined.
- [ ] Multiple windows and displays preserve document and selection state.
- [ ] Resize reflows instead of clipping or stretching a mobile layout.
- [ ] Critical controls are not available only at a potentially offscreen bottom edge.
- [ ] Sidebars, split views, inspectors, and panels match persistent/contextual relationships.

## Commands

- [ ] The menu bar exposes the complete expected command set in familiar order.
- [ ] Standard names, roles, and shortcuts are preserved.
- [ ] Unavailable menu items are disabled when keeping them visible aids discovery.
- [ ] The toolbar contains frequent contextual actions, not every command.
- [ ] Settings, Help, Window, Edit, and document commands appear where Mac users expect.

## Input

- [ ] Keyboard-only operation and visible focus work.
- [ ] Pointer hit regions, hover/pressed states, and precision selection are correct.
- [ ] Context menus supplement rather than replace essential access.
- [ ] Drag-and-drop has valid/invalid-target and completion feedback.
- [ ] Undo/redo integrates with the command and document model.

## State and Appearance

- [ ] Active/inactive selection and control states are distinguishable.
- [ ] Unsaved work survives authentication, inactive transitions, and recoverable failures.
- [ ] Light, Dark, Increase Contrast, reduced motion, and VoiceOver/Full Keyboard Access are tested.
- [ ] Typography remains readable; native system metrics are not hard-coded unnecessarily.

## Evidence

Record macOS version, window sizes, displays, keyboard/pointer paths, menu/shortcut tests, appearance,
assistive technology, relaunch/restoration, and results.
