# Platform Adaptation Workflow

## Goal

Translate one product flow into Web, native macOS, and iPhone without either cloning one interface
or fragmenting the product model.

## Step 1: Freeze semantics, not layout

Write the shared nouns, action names, selection rules, permissions, success criteria, and recovery.
These remain stable unless a platform genuinely lacks a capability.

## Step 2: Profile the session

For each surface, record:

- likely session duration and interruption frequency;
- display and window range;
- primary and alternate input methods;
- simultaneous content needs;
- expected navigation and command locations;
- background, inactive, reload, and restore behavior.

## Step 3: Choose information density

| Need | Web | macOS | iPhone |
|---|---|---|---|
| Overview plus detail | Responsive master/detail when width allows | Sidebars, split views, inspectors, windows | Push detail or sheet; preserve back path |
| Many commands | Grouped visible actions plus overflow | Menu bar plus toolbar/context menus | Primary action visible; secondary actions in menus or contextual controls |
| Multi-selection | Explicit modes and keyboard conventions | Pointer/keyboard selection and commands | Explicit edit/select mode with touch-sized controls |
| Long entry | Save drafts and tolerate reload | Keyboard-first, resizable document or panel | Focused steps, appropriate keyboard, interruption-safe draft |

## Step 4: Map navigation

- Web: every meaningful destination should have a stable location and predictable Back/Forward
  behavior when the product architecture permits it.
- macOS: use windows for separate work contexts, sidebars or split views for persistent hierarchy,
  and menu commands for full capability.
- iPhone: use a shallow tab model for peer destinations and a navigation stack for drill-in flows.

Read `references/components/navigation-and-structure.md` before finalizing.

## Step 5: Map commands

Use `patterns/native-command-placement.md`. Preserve the command name and outcome while adapting its
location, shortcut, gesture, or presentation. Keep destructive commands separated and recoverable.

## Step 6: Adapt presentation

Choose presentation based on interruption and scope:

| Scope | Web | macOS | iPhone |
|---|---|---|---|
| Brief contextual choice | Popover/menu when semantics allow | Menu/popover | Menu or compact sheet |
| Focused short task | Dialog only if focus must be constrained | Sheet/panel/dialog based on ownership | Sheet |
| Deep independent work | Page/workspace | Window/document | Full-screen flow only when necessary |
| Critical interruption | Reserved dialog | Alert | Alert |

## Step 7: Preserve context through change

When width, orientation, window size, appearance, locale, or text size changes:

- keep current content and selection when possible;
- keep important controls in predictable relative locations;
- reflow before truncating or hiding;
- use natural transitions that explain structural changes;
- never reset an in-progress task solely because presentation changed.

## Step 8: Verify equivalence

Test the same scenario on all surfaces. Confirm:

- same concept names and outcomes;
- intentional, documented differences;
- equivalent safety and recovery;
- platform-appropriate input and feedback;
- no platform is treated as a lesser port.

## Platform Delta Output

For each major difference, record:

```markdown
| Shared intent | Web expression | macOS expression | iPhone expression | Why |
|---|---|---|---|---|
```

The "Why" must cite device, input, windowing, session, or platform familiarity—not taste.
