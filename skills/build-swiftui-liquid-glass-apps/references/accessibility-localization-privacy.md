# Accessibility, Localization, and Privacy

## Accessibility Is an Input Constraint

Design and implement with assistive settings active, not as a last pass.

## VoiceOver

- Use native controls so role and action come for free.
- Give icon-only controls concise accessible labels.
- Hide decorative images.
- Group child elements according to meaning: combine a sentence-like row, contain meaningful
  subgroups, or provide a custom label for a visual composite.
- Expose value and state, including selection.
- Keep focus order aligned with the visible task.
- Announce asynchronous results when the visible state change is not otherwise discoverable.

Do not repeat the control type in the label; VoiceOver supplies the role.

## Dynamic Type

- Use semantic fonts.
- Avoid fixed text frames and one-line assumptions.
- Let control rows expand vertically.
- Change composition when needed using `ViewThatFits`.
- Scale related custom measurements.
- Test several accessibility categories, not just one.
- Ensure floating glass controls do not cover expanded content.

## Contrast and Transparency

Test:

- light and dark;
- Increase Contrast;
- Reduce Transparency;
- varied imagery behind glass;
- disabled and selected states.

Do not encode state using opacity or color alone. A custom glass control still needs semantic and
contrast validation even though system material adapts.

## Motion

Provide a Reduce Motion path. Avoid essential information conveyed only by spatial motion. See
`references/motion-haptics-and-interaction.md`.

## Touch, Keyboard, and Pointer

- Make interaction areas comfortable and forgiving.
- Avoid tightly packed controls.
- Support keyboard focus and shortcuts for repeated iPad actions when appropriate.
- Give hover/focus feedback without making it the only cue.
- Provide alternatives for drag/swipe/long press.

## Localization

- Put user-facing text in String Catalogs.
- Prefer localized resources and format styles.
- Add translator comments for ambiguous words and placeholders.
- Do not concatenate fragments whose grammar can change.
- Use locale-aware number/date/list formatting.
- Mirror layout and directional icons when semantically appropriate.
- Test long German-like strings, compact CJK text, and right-to-left layout.
- Keep symbols culturally and semantically appropriate.

## Privacy

- Request the minimum data and permission.
- Ask in context after explaining value.
- Keep core functionality useful without permission when possible.
- Clearly distinguish local, synced, and shared data.
- Avoid placing sensitive user data in logs, previews, screenshots, or fixtures.
- Use synthetic fixtures.
- Explain destructive and sharing consequences before commitment.
- Follow current platform privacy manifests and API requirements.

## Checklist

- [ ] Primary actions have correct labels, roles, values, and traits
- [ ] Reading/focus order matches the task
- [ ] Decorative content is hidden
- [ ] Accessibility text sizes do not clip or obscure controls
- [ ] Non-color state cues exist
- [ ] Reduce Motion and Reduce Transparency were exercised
- [ ] Custom glass stays legible with Increase Contrast
- [ ] Gestures have alternatives
- [ ] Strings are localized and resilient to expansion/RTL
- [ ] Dates/numbers use locale-aware formatting
- [ ] Permissions are contextual and recoverable
- [ ] Fixtures/logs contain no private data

## Evidence

Record the configurations and screens actually checked. "Uses native controls" is not sufficient
evidence for a complete accessible flow.
