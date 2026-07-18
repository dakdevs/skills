# Accessibility and Inclusion

## Origin

Adapted from Apple's HIG pages on [Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility),
[Inclusion](https://developer.apple.com/design/human-interface-guidelines/inclusion),
[Typography](https://developer.apple.com/design/human-interface-guidelines/typography), and
[Right to left](https://developer.apple.com/design/human-interface-guidelines/right-to-left).

## Use When

Defining structure, components, content, animation, input, localization, or review criteria. This is
not a final polish pass.

## Four Required Qualities

| Quality | Required behavior |
|---|---|
| Intuitive | Familiar and consistent interactions make tasks straightforward |
| Perceivable | Meaning survives loss of sight, color, sound, motion, or touch |
| Adaptable | Interface responds to personal settings, inputs, size, and context |
| Inclusive | Language, imagery, assumptions, and defaults welcome diverse people |

## Decision Rules

### Vision and legibility

- Support text enlargement; Apple recommends making text or icons enlargable by about 200% where
  possible. On iPhone use Dynamic Type. macOS has no Dynamic Type, so provide readable defaults and
  honor relevant system/accessibility settings through native behavior.
- Treat Apple's iOS 17 pt default/11 pt minimum and macOS 13 pt default/10 pt minimum custom type
  references as floors for review, not goals for dense body copy.
- Avoid light weights at small sizes. Preserve hierarchy as type grows.
- Reflow and stack before truncating. Keep important information toward the beginning.
- Meet appropriate contrast standards in light, dark, and increased-contrast conditions.
- Never use color alone for state, status, focus, or interactivity.

### Mobility and input

- Design to Apple's default control-size references: 44x44 pt for iPhone and 28x28 pt for macOS.
  Apple's minimum references are 28x28 pt and 20x20 pt respectively. Prefer the defaults.
- Provide spacing that prevents accidental activation.
- Use simple gestures for common actions and always provide a visible alternative to a gesture.
- Support keyboard-only operation where a keyboard can be present.
- Label custom controls so assistive technology communicates role, name, state, and value.

### Hearing and speech

- Pair audio cues with visual information; use haptics where the platform and context support them.
- Provide captions, transcripts, or equivalent content for meaningful audio.
- Do not require speech as the only way to complete a core task.

### Cognition and motion

- Keep actions and navigation consistent and easy to remember.
- Avoid unnecessary timers and auto-dismiss behavior.
- Respect reduced-motion and flashing-light preferences.
- Replace excessive zoom, scale, depth, bounce, and peripheral motion with gentler transitions.
- Break complex flows into focused steps without trapping experienced people in mandatory teaching.

### Language and inclusion

- Use plain, gender-neutral language and avoid stereotypes.
- Do not infer identity, relationships, capability, or culture when the task does not require it.
- Test text expansion, long names, mixed scripts, and right-to-left layout.
- Flip navigation/progress direction in RTL, but do not flip logos, universal marks, digits inside a
  number, photographs, or objects whose physical direction matters.
- Localize text in icons or replace it with a culturally neutral symbol.

## Procedure

1. Write the semantic reading and focus order before styling.
2. Choose native or semantic components with built-in roles and states.
3. Add visible labels and alternate paths for custom or gesture interactions.
4. Exercise largest supported text, increased contrast, dark appearance, reduced motion, and RTL.
5. Test keyboard, pointer, touch, and screen reader behavior as applicable.
6. Revisit errors, time limits, authentication, and destructive actions with assistive use in mind.

## Verification Matrix

| Test | Web | macOS | iPhone |
|---|---|---|---|
| Reading/focus order | DOM and keyboard order | Full Keyboard Access/VoiceOver | VoiceOver order and rotor |
| Text enlargement | Browser zoom and reflow | Readable native sizing and zoom where provided | Dynamic Type through accessibility sizes |
| Input alternative | Keyboard, pointer, touch where supported | Keyboard and pointer without hidden-only commands | Visible control for every essential gesture |
| Appearance | Light, dark, forced/high contrast where supported | Light, Dark, Increase Contrast | Light, Dark, Increase Contrast |
| Motion | Reduced-motion preference | Reduce Motion | Reduce Motion |
| Direction | RTL DOM/layout | RTL localization | RTL localization |

## Failure Modes

- Treating the minimum size as the recommended size everywhere.
- Scaling text while fixed containers clip, overlap, or hide actions.
- Adding an accessibility label that conflicts with visible text or state.
- Using red/green alone to communicate pass/fail.
- Making a swipe, hover, right-click, or drag the only path to a core action.
- Assuming accessibility is handled because standard components were used.

## Output

Document supported settings and inputs, test evidence, failures, and concrete corrections. Do not
claim WCAG conformance from HIG review alone.
