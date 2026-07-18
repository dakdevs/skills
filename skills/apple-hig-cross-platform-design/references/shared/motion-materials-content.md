# Motion, Materials, Feedback, and Content

## Origin

Adapted from Apple's HIG pages on [Motion](https://developer.apple.com/design/human-interface-guidelines/motion),
[Materials](https://developer.apple.com/design/human-interface-guidelines/materials),
[Feedback](https://developer.apple.com/design/human-interface-guidelines/feedback), and
[Writing](https://developer.apple.com/design/human-interface-guidelines/writing).

## Use When

Adding animation, material, system feedback, labels, onboarding copy, empty states, or errors.

## Motion Decision Rules

Use motion to:

- explain cause and effect;
- preserve context during a structural change;
- confirm direct manipulation;
- communicate progress or state transition;
- add restrained character after usability is secure.

Do not use motion to delay routine work, disguise latency, force attention repeatedly, or make a
core task inaccessible. Respect reduced-motion preferences and provide equivalent information when
motion is removed.

## Material Boundary

Apple's current native guidance uses Liquid Glass to distinguish controls from content on supported
Apple platforms. Apply the concept before the effect:

- keep the content layer primary;
- keep controls legible over varying content;
- reserve color and strong material treatment for true emphasis;
- use system-provided material rather than hand-building a visual imitation;
- avoid stacking many translucent layers that muddy hierarchy.

On Web, do not claim a CSS blur or translucent panel is Liquid Glass. Reproduce the hierarchy and
legibility goal using semantic Web controls and robust contrast.

## Feedback Rules

| Event | Required feedback |
|---|---|
| Press/activation | Immediate visual state; optional platform-appropriate sound/haptic |
| Delayed action | Progress or activity that explains the delay |
| Direct manipulation | Content tracks the input and settles predictably |
| Success | Confirmation proportional to importance; avoid unnecessary interruption |
| Failure | Nearby explanation, preserved work, and corrective next step |
| Disabled action | Stable unavailable state when discoverability matters |
| Background/inactive | Clear state preservation and correct restoration |

Never rely on sound or haptics alone.

## Writing Procedure

1. Define a consistent product voice.
2. Adjust tone to the situation; keep high-stakes messages direct.
3. Put the screen's purpose and most important information first.
4. Label actions with clear verbs. Avoid cute or vague calls to action.
5. Use stable terms through multi-step flows; make completion explicit.
6. Write for the device: say "tap" for touch, "click" for pointer, or use input-neutral wording.
7. Give empty states a useful next step.
8. Place errors near the problem, avoid blame, and explain how to correct it.
9. Use practical setting labels and link directly to a setting where possible.
10. Test localization, screen readers, truncation, and real data.

## Copy Patterns

| Context | Pattern | Avoid |
|---|---|---|
| Primary action | Verb plus object when needed: "Save Report" | "Let's do it" |
| Empty state | What this area contains + next available action | Crucial guidance that disappears later |
| Field error | Requirement and correction: "Use at least 8 characters" | "Invalid input" |
| Load failure | What failed + retry/offline path | Blame, jokes, or loss of entered data |
| Destructive action | Specific object and consequence | Generic "Are you sure?" |
| Multi-step flow | Stable Next/Continue pattern; explicit Done | Changing verbs without meaning |

## Verification

- [ ] Every custom control has pressed, focused, disabled, and progress states as applicable.
- [ ] Removing motion does not remove meaning or completion.
- [ ] Material improves separation and legibility in every appearance.
- [ ] The Web surface does not fake a native-only material contract.
- [ ] Empty and error states give concrete next steps.
- [ ] Labels remain clear out of visual context for assistive technology.
- [ ] Tone matches urgency and consequence.
- [ ] Feedback appears soon enough to connect action and result.

## Failure Modes

- Animation as a substitute for information architecture.
- Excessive bounce, zoom, blur, or peripheral motion under Reduce Motion.
- Colored translucent controls over similarly colored content.
- Placeholder-only fields without persistent labels.
- Error messages that describe failure but not recovery.
- Celebratory interruption after every routine action.
