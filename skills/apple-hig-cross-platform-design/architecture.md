# Architecture: Shared Core, Platform Shell

## Core Model

The product has one semantic core and three behavioral shells.

The core contains user goals, concepts, data, terminology, permissions, state transitions, safety
rules, and recovery. A platform shell decides how those concepts appear and respond to Web,
macOS, or iPhone conventions.

```text
intent and trust
    -> information and task model
        -> shared states and recovery
            -> platform navigation and commands
                -> platform components and input
                    -> visual craft and delight
```

Do not begin with component matching. Establish what people are trying to accomplish and what must
remain safe, understandable, and recoverable first.

## Layers

| Layer | Shared invariant | Platform-variable expression |
|---|---|---|
| Purpose | Primary outcome and value | Session length and task entry point |
| Trust | Privacy, transparency, safe defaults | Permission and authentication mechanism |
| Information | Concepts, hierarchy, terminology | Density, columns, disclosure, viewport use |
| State | Loading, empty, error, success, selection | Presentation and persistence behavior |
| Navigation | Places and relationships | URL/history, windows/sidebar/menu bar, stack/tab bar |
| Commands | Action meaning and availability | Links/buttons, menu commands/shortcuts, touch controls |
| Input | Same outcome for supported methods | Keyboard/pointer, touch, assistive technology |
| Presentation | Clear content/control separation | Browser surfaces, macOS windows, iPhone sheets/stacks |
| Craft | Legibility, consistency, feedback | Platform typography, material, motion, hit regions |

## Platform Profiles

| Attribute | Web | Native macOS | iPhone |
|---|---|---|---|
| Source status | Authored HIG adaptation | Direct HIG platform route | Direct HIG platform route |
| Typical context | Variable viewport and input | Stationary, multiwindow, deep work | Handheld, mobile, interruption-prone |
| Primary input | Keyboard, pointer, touch varies | Keyboard plus precise pointer | Multi-Touch plus virtual keyboard and voice |
| Navigation expectation | URLs, history, visible location | Windows, sidebar, toolbar, menu bar | Navigation stack, tab bar, gestures |
| Density | Responsive and content-dependent | Higher, but still comfortable | Focused, fewer simultaneous controls |
| Recovery | Back/history, preserved drafts, undo | Undo/redo, document state, window restoration | Back, swipe, undo, saved progress |
| Special caution | Do not fake unavailable native behavior | Do not ship a stretched mobile interface | Do not compress desktop density into a phone |

## Dependency Order

1. Define purpose, audience, risk, and core task.
2. Define shared entities, states, and recovery.
3. Establish accessibility, inclusion, privacy, and language behavior.
4. Choose each platform's structure and navigation.
5. Map actions and inputs to platform components.
6. Apply hierarchy, typography, color, material, and motion.
7. Verify each platform independently and then compare semantic continuity.

## Invariants

- The primary task is obvious and reachable without unnecessary gates.
- People retain agency: they can explore, exit guided flows, and recover from mistakes.
- Collection and use of data are necessary, explained, and permissioned in context.
- Meaning does not depend on color, sound, motion, or gesture alone.
- Important controls have clear labels, states, feedback, and adequate interactive regions.
- Layout survives target sizes, text enlargement, locale changes, appearance changes, and input modes.
- Destructive actions are visually and semantically distinct from preferred actions.
- Loading, empty, error, success, offline, inactive, and restored states are intentional.
- A familiar product concept keeps the same name and outcome across surfaces.
- Platform-specific components preserve native expectations instead of visual sameness.

## Failure Modes

- Pixel parity: forcing one layout and component set onto every surface.
- Mobile inflation: stretching an iPhone screen into a desktop window.
- Desktop compression: placing dense menus, tables, and persistent controls on a phone.
- Native cosplay on Web: recreating system materials without the system behavior.
- Happy-path design: omitting progress, errors, empty states, permissions, and recovery.
- Accessibility as a final audit rather than an input to the structure.
- Decorative delight that delays or obscures the primary task.
- Generic confirmation for every action instead of undo for routine recoverable actions.
- Hidden Mac commands that should be discoverable in the menu bar.
- Gesture-only iPhone actions without visible alternatives.

## Output Goal

Correct application produces one coherent product with three intentionally different interfaces.
People recognize the product model everywhere, but each surface feels expected for its device,
input, windowing, and session context.
