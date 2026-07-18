# Pattern: Responsive Continuity

## Problem

A layout must change across viewport, orientation, window size, text size, locale, or platform while
the person remains in the same conceptual place.

## Pattern

Preserve semantic identity and task state while changing spatial arrangement.

## Procedure

1. Identify persistent anchors: current destination, selected object, unsaved draft, filters,
   progress, and primary action.
2. Define the richest layout that is still useful, not merely the widest.
3. As space contracts, reflow content and stack controls.
4. Collapse secondary regions only after the primary layout no longer fits.
5. Provide a predictable way to reveal collapsed regions.
6. Preserve anchors through the transition.
7. Use restrained motion to explain where content moved; remove or simplify it under reduced motion.

## Example Mapping

| Context | Collection | Selection | Detail | Secondary controls |
|---|---|---|---|---|
| Wide Web | Left region | Highlighted item | Right region | Toolbar/inspector |
| Narrow Web | List route | Stored in URL/state | Detail route | Disclosure/menu |
| macOS | Sidebar/list | Native selection | Detail pane/window | Toolbar/inspector/menu bar |
| iPhone | List screen | Navigation state | Pushed detail | Toolbar/menu/sheet |

## Verification

- Resize or rotate mid-task; no draft, selection, or progress is lost.
- Browser Back and iPhone Back return to the expected list state.
- macOS window restoration returns to a useful configuration.
- Largest text reflows instead of clipping.
- Focus moves to the expected element after structural change.

## Anti-Patterns

- Recreating the whole view and resetting state at a breakpoint.
- Hiding the selected object when a column collapses.
- Moving the primary action unpredictably at every size.
- Changing terminology with the layout.
