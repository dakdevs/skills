# Pattern: Native Command Placement

## Problem

The same command must remain recognizable across Web, macOS, and iPhone while each platform expects
different discovery and acceleration mechanisms.

## Pattern

Keep the command's name, semantic role, availability rule, consequence, and recovery stable. Adapt
its primary location and accelerators.

## Mapping

| Command kind | Web | macOS | iPhone |
|---|---|---|---|
| Primary current-view action | Visible button | Toolbar/content button plus menu command when appropriate | Reachable button or toolbar item |
| Standard edit command | Semantic UI and standard shortcut when appropriate | Edit menu and standard shortcut | Edit menu/contextual control |
| View configuration | View control/route/settings | View menu, toolbar, inspector, or Settings | Menu, sheet, or Settings |
| Object-context command | Inline/menu/context menu | Context menu plus menu/toolbar access if essential | Menu, row action, or detail toolbar |
| Destructive command | Separated action with undo/confirmation | Menu/context command with destructive handling | Destructive role, separated placement, undo/confirmation |
| Search | Search field/route and focus shortcut if expected | Toolbar/content search and shortcut | Search integrated into collection/navigation |

## Procedure

1. Write the canonical command name, object, role, availability, result, and undo behavior.
2. Place the primary route in the platform's expected location.
3. Add standard accelerators or alternate routes without changing semantics.
4. Keep disabled/unavailable behavior understandable.
5. Verify the command from keyboard, pointer, touch, and assistive paths as applicable.

## Verification

- The same command name means the same thing everywhere.
- macOS exposes expected commands through the menu bar.
- Web does not sacrifice link/history semantics to resemble native navigation.
- iPhone keeps frequent commands reachable and secondary commands discoverable.
- Destructive semantics and recovery remain identical.

## Anti-Patterns

- Copying the same toolbar to every platform.
- Hiding a Mac command because it does not fit in the toolbar.
- Renaming an action per platform without a semantic reason.
- Making a swipe or context menu the only place for an essential action.
