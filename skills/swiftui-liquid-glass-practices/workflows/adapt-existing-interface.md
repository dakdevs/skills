# Workflow: Adapt an Existing SwiftUI Interface

## Use When

The request is to modernize an existing app, screen, or feature for Liquid Glass, or to make an
interface feel native on platform version 26 or later.

## Required Inputs

- Target platforms and minimum deployment versions.
- Current Xcode/SDK and build settings.
- Relevant SwiftUI source, screenshots, or a runnable app.
- Primary user tasks and navigation model.
- Known customizations to bars, controls, sheets, lists, or backgrounds.

If these are discoverable from the project, inspect them instead of asking the user.

## Phase 1: Establish the Baseline

1. Build with the current SDK without styling changes.
2. Capture representative screens in light and dark appearances.
3. Exercise navigation, scrolling, search, sheets, menus, and primary controls.
4. Record target OS behavior separately from older-system behavior.
5. Identify compile-time compatibility switches or legacy appearance opt-outs.

Output: a baseline inventory, not implementation.

## Phase 2: Classify the Interface

Tag each visible surface:

| Classification | Examples | Default action |
|---|---|---|
| Content | Documents, feeds, images, cards, tables, data | Keep non-glass; use standard materials only when structure needs separation |
| System functional UI | Tab bars, sidebars, toolbars, search, sheets, menus | Use semantic SwiftUI component and allow automatic adoption |
| Custom functional UI | Floating transport control, map control cluster, transient tool palette | Consider explicit glass after justification |
| Decorative chrome | Gradient frames, fake toolbars, ornamental capsules | Remove or move into content identity without glass |

Create a **keep/remove/change map**. Include a “keep non-glass” entry so restraint is visible.

## Phase 3: Repair Structure Before Styling

1. Replace custom navigation replicas with `NavigationStack`, `NavigationSplitView`, or `TabView`
   where behavior permits.
2. Restore semantic `Button`, `Toggle`, `Slider`, `Picker`, `Menu`, and `searchable` usage.
3. Move actions into appropriate toolbar placements and group related actions.
4. Use native sheets, popovers, confirmation dialogs, and menus.
5. Verify safe areas and allow content to extend beneath appropriate system functional UI.
6. Preserve platform conventions rather than forcing identical placement everywhere.

Stop here and reassess. Many interfaces need no explicit glass effect after this pass.

## Phase 4: Remove Conflicts

Search for and justify each of:

- Custom navigation or toolbar backgrounds.
- `presentationBackground` overrides.
- Extra blur/dimming behind system bars.
- Fixed control heights, corner radii, and padding that fight current metrics.
- Homegrown tab bars or search fields.
- Overlay hit regions that obscure system controls.
- Custom control styles that prevent automatic design adoption.

Remove only conflicts whose previous purpose is now supplied by the system. Preserve functional
requirements such as brand distinction, selected state, or content grouping.

## Phase 5: Adapt Navigation and Presentations

- Group related toolbar actions; separate unrelated actions with semantic toolbar spacing.
- Use icons for familiar actions and accessibility labels for icon-only controls.
- Let scroll edge effects maintain control legibility; do not stack redundant backgrounds.
- Use semantic search placement and a search tab only when the tab is genuinely search.
- Evaluate tab minimization based on content and task frequency.
- Let partial-height sheets adopt their system appearance; inspect content near rounded edges.
- Add source-destination presentation morphing only when it clarifies where the presentation came
  from.

Read `references/navigation-toolbars-sheets.md` for detail.

## Phase 6: Add Custom Glass Only Where Justified

For each remaining custom functional element, write one sentence:

> This element uses Liquid Glass because it is [functional role] floating above [content], and the
> effect communicates [interaction, prominence, grouping, or transition relationship].

If this sentence cannot be completed without aesthetic language, keep the element non-glass.

Then apply `workflows/implement-custom-glass.md`.

## Phase 7: Verify the Adaptation

Run:

1. `checks/implementation-review.md`
2. `checks/accessibility-visual-matrix.md`
3. `checks/performance-profile.md` when custom or numerous effects exist

Compare before and after using the same content, device, orientation, appearance, and state.

## Deliverable Template

```markdown
## UI diagnosis
- User tasks:
- Target platforms/versions:
- Current structural conflicts:

## Keep / remove / change
| Element | Layer | Decision | Rationale |

## System-first adaptations
- ...

## Custom glass exceptions
- Element:
- Functional reason:
- Composition and transition:

## Verification evidence
- Visual:
- Accessibility:
- Interaction:
- Performance:

## Residual risks
- ...
```

## Failure Conditions

- The proposal starts with a list of `.glassEffect()` call sites.
- Content cards are converted to glass without a functional role.
- A custom bar survives solely to preserve pixel-level legacy appearance.
- A search role is assigned to a non-search action.
- The result is judged from a single simulator screenshot.
