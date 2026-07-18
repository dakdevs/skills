# iPhone Design

## Origin

Adapted from [Designing for iOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-ios)
and the HIG pages on layout, gestures, keyboards, tab bars, navigation, sheets, action presentation,
status, loading, launching, privacy, and accessibility.

## Platform Model

iPhone is handheld, viewed at short distance, operated mainly by touch, and used while moving or
switching context. Sessions may be a minute or much longer, but interruption and app switching are
normal. The medium-size high-resolution display rewards focus and progressive disclosure.

## Design Priorities

1. Put the primary task and content ahead of secondary controls.
2. Keep necessary controls discoverable with minimal interaction.
3. Adapt to orientation, Dark Mode, Dynamic Type, locale, and system features.
4. Place frequent actions where they are comfortable to reach, often the middle or lower region.
5. Use system capabilities with permission to reduce unnecessary data entry.
6. Preserve state through interruptions, backgrounding, and authentication.
7. Support gesture convenience without gesture dependence.

## Structure Decisions

| Need | Prefer | Avoid |
|---|---|---|
| Peer top-level destinations | Small, stable tab set | Many tabs or changing tab meaning |
| Drill into a hierarchy | Navigation stack with clear back path | Deep custom modal nesting |
| Focused short task | Sheet with explicit completion/cancel behavior | Replacing the entire app context unnecessarily |
| Contextual actions | Visible primary action plus menu/row actions | Desktop toolbar density |
| Destructive choice | Destructive role, separated placement, undo/confirmation | Prominent default styling |
| Large collection | Search, filters, progressive detail | Showing every control simultaneously |
| Data entry | Appropriate keyboard, labels, inline validation, saved draft | Long unbroken form that loses progress |

## Touch and Reach Contract

- Prefer at least 44x44 pt interactive regions; Apple's accessibility page lists 28x28 pt as a
  minimum, not the target for routine controls.
- Leave enough separation to prevent accidental taps.
- Put common actions within comfortable reach without making the top of the screen useless.
- Use familiar system gestures and provide visible alternatives for core actions.
- Make custom controls show pressed, disabled, selected, progress, and error states.
- Avoid full-width buttons by default when they ignore system margins and hardware curvature.

## Navigation and Presentation Contract

- Keep the navigation hierarchy shallow enough to understand and preserve a predictable back path.
- Use tabs for peer areas, not for steps in a linear flow.
- Keep the current task and selection when orientation or text size changes.
- Use sheets for focused work that belongs to the current context; define dismissal and unsaved-work
  behavior.
- Reserve alerts for important information that requires attention or a decision.
- Keep the status bar unless hiding it meaningfully improves immersive media or gameplay.

## Data Entry and Interruption

- Request only necessary fields; use available device/system data with permission when it reduces
  work and clearly benefits the person.
- Match keyboard and input configuration to the field.
- Keep field labels visible and errors corrective.
- Save drafts or restore in-progress tasks after backgrounding, calls, authentication, or network
  failure.
- Avoid permission prompts at launch unless the first user-initiated task genuinely requires them.

## Adaptability

- Aim to support portrait and landscape unless the experience genuinely requires one.
- Respect safe areas, Dynamic Island, camera housing, corner radius, and overlaying controls.
- Support Dynamic Type through accessibility sizes; stack or reflow rather than truncate.
- Test smallest supported width, both landscape directions if landscape is supported, and real
  reach/touch behavior on device.

## Procedure

1. Identify the fastest primary task and interruption points.
2. Choose tabs and navigation stacks before choosing visual chrome.
3. Place primary and secondary actions by frequency, reach, and consequence.
4. Add visible alternatives to gestures and appropriate keyboards to fields.
5. Define loading, empty, error, permission-denied, background, and restore states.
6. Test touch targets, orientation, Dynamic Type, VoiceOver, Reduce Motion, appearance, and
   interruption on a real iPhone where practical.

## Verification

Use `checks/iphone-review.md`.

## Failure Modes

- Desktop controls compressed into a phone toolbar.
- A hidden swipe as the only delete, archive, or reveal action.
- Essential action at an uncomfortable reach location with no alternative.
- Multiple nested sheets that obscure location and recovery.
- Rotation or Dynamic Type resetting the current task.
- A launch sequence dominated by branding, tutorials, and permission prompts.
- Unsaved form data lost when the app backgrounds or authentication expires.
