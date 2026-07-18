# Native macOS Design

## Origin

Adapted from [Designing for macOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-macos)
and the HIG pages on windows, the menu bar, menus, toolbars, sidebars, split views, keyboards,
pointing devices, drag and drop, file management, settings, and undo.

## Platform Model

Mac use is commonly stationary, precise, multiwindow, and long-running. Displays are large and can
extend across monitors. People expect keyboard and pointer combinations, multiple apps, transitions
between active and inactive states, and sessions ranging from quick tasks to hours of concentration.

## Design Priorities

1. Use space to reduce unnecessary nesting and modality without overwhelming density.
2. Let people resize, move, hide, show, minimize, restore, and use windows full screen.
3. Put the app's full command set in the menu bar in familiar order.
4. Support standard and useful custom keyboard shortcuts.
5. Support precise pointer selection, direct manipulation, context menus, and drag and drop.
6. Preserve work and context across multiple windows, inactive states, and relaunch.
7. Allow meaningful personalization such as toolbar, view, window, color, or font choices.

## Structure Decisions

| Need | Prefer | Avoid |
|---|---|---|
| Independent document/work context | Separate restorable window | One giant window with deeply nested modes |
| Persistent hierarchy | Sidebar or split view | Mobile-style full-screen push for every level |
| Common contextual commands | Toolbar with clear grouping | Overloaded toolbar containing every command |
| Complete app command discovery | Standard menu bar structure | Commands available only as toolbar icons |
| Secondary transient choice | Menu or popover | Blocking dialog |
| Window-owned focused task | Sheet | Unrelated global window when ownership matters |
| App configuration | Settings window and standard command | Settings hidden inside a content view |
| Rich data | Lists/tables with selection and keyboard support | Oversized cards that waste desktop space |

## Menu Bar Contract

- Use the familiar order: app, File, Edit, Format where relevant, View, app-specific menus, Window,
  Help.
- Keep commands visible and disable unavailable items rather than unpredictably hiding them.
- Support standard names, roles, icons, and shortcuts for Copy, Cut, Paste, Save, Print, Undo, Redo,
  and similar commands.
- Use short menu titles and clear, action-oriented item labels.
- Place app-level settings in the app menu using the expected Settings command.
- Add custom shortcuts only when valuable and avoid overriding system conventions.

## Window and State Contract

- Support a useful range of window sizes and multiple displays.
- Preserve document, selection, navigation, inspector/sidebar, and window state when appropriate.
- Distinguish active and inactive selection and control states.
- Avoid placing the only critical control at the bottom edge, which may be offscreen.
- Define close versus quit versus document-close behavior intentionally.
- Avoid surprising modality across multiple windows.

## Input Contract

- Every major action is accessible by pointer and keyboard when practical.
- Focus order is logical and visible; Full Keyboard Access remains usable.
- Pointer regions match visible shapes and support expected precision.
- Drag and drop provides clear lift, valid-target, invalid-target, and completion feedback.
- Context menus supplement rather than replace menu-bar or visible access to essential commands.
- Destructive commands support undo or precise confirmation.

## Typography and Density

Apple references 13 pt as a macOS default custom type size and 10 pt as a minimum. Treat these as
legibility constraints, not encouragement to compress everything. macOS does not support Dynamic
Type; still test readable system sizing, zoom where applicable, contrast, and accessibility settings.

Use denser layouts only when relationships remain scannable, targets remain comfortable, and
essential labels are not replaced by ambiguous iconography.

## Procedure

1. Model documents, windows, global commands, contextual commands, and selection.
2. Choose window, sidebar/split, toolbar, inspector, and content structure.
3. Build the menu bar before treating commands as complete.
4. Add shortcuts, focus behavior, pointer states, context menus, and drag/drop as applicable.
5. Define inactive, multiwindow, close, restore, and conflict states.
6. Test minimum/maximum window sizes, multiple windows, keyboard-only use, pointer precision, Dark
   Mode, increased contrast, and relaunch restoration.

## Verification

Use `checks/macos-review.md` and verify with a real Mac when menu, shortcut, pointer, window,
appearance, or assistive behavior matters.

## Failure Modes

- A vertically stretched iPhone interface with one window and no menu strategy.
- Essential commands available only through unlabeled toolbar icons or context menus.
- Inconsistent standard shortcuts.
- Window resize that clips content, loses selection, or leaves unusable whitespace.
- Blocking modal dialogs for routine choices.
- Losing unsaved work or window state on authentication, close, inactive transition, or relaunch.
