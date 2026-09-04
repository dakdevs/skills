# Implementation Review Gate

## Scope and Intent

- [ ] Target platforms, deployment targets, and build SDK are documented.
- [ ] Primary user tasks and information architecture are understood.
- [ ] Every glass surface has a functional reason.
- [ ] Content that should remain non-glass is explicitly identified.
- [ ] Apple guidance, not visual fashion, determines the adaptation.

## System-First Adoption

- [ ] Standard navigation, tabs, toolbars, search, sheets, menus, and controls were evaluated first.
- [ ] Legacy custom backgrounds that interfere with system behavior were removed or justified.
- [ ] Semantic roles and familiar action placement are preserved.
- [ ] Platform structure adapts rather than forcing one layout everywhere.
- [ ] Compatibility mode, if present, has an owner and removal condition.

## Custom Glass Correctness

- [ ] Native public APIs are used on supported platforms.
- [ ] `.glassEffect()` follows modifiers that establish appearance and bounds.
- [ ] Regular/clear choice matches the background and legibility requirements.
- [ ] Shape matches the control role and hit region.
- [ ] Tint conveys meaning and is not the only state cue.
- [ ] `.interactive()` appears only on interactive/focusable surfaces.
- [ ] A standard glass button style is used where sufficient.

## Composition and Morphing

- [ ] Multiple related effects share one purposeful `GlassEffectContainer`.
- [ ] Unrelated effects are not captured by the same container.
- [ ] Container spacing produces intended interaction at rest and in motion.
- [ ] Union IDs are used only for a shared material surface.
- [ ] Transition identities are stable and distinct where effects are distinct.
- [ ] Appearing/disappearing views change hierarchy inside an animated transaction.
- [ ] Transition choice communicates a real relationship.
- [ ] Navigation transitions are not confused with glass-effect transitions.

## Compatibility and Risk

- [ ] Every native-only call is correctly availability-gated.
- [ ] Fallback preserves semantics, state, hit area, hierarchy, and contrast.
- [ ] Fallback is not described as native optical parity.
- [ ] Current SDK metadata supports every claimed platform.
- [ ] No private API, internal hierarchy manipulation, or false semantic role is hidden.
- [ ] Third-party dependencies have verified license and maintenance status.

## Accessibility and Inputs

- [ ] VoiceOver labels, values, traits, order, and presentation focus are correct.
- [ ] Icon-only controls have meaningful labels.
- [ ] Decorative duplicates are hidden from accessibility.
- [ ] Reduce Motion, Reduce Transparency, and Increase Contrast are tested.
- [ ] Dynamic Type does not clip or cause accidental glass merging.
- [ ] Touch, pointer, keyboard, and focus behavior match target platforms.

## Visual and Performance Evidence

- [ ] Light/dark and worst-case real backgrounds are tested.
- [ ] Pressed, focused, selected, disabled, and transition states are legible.
- [ ] Simulator/device differences are documented.
- [ ] High-risk interactions have representative device testing.
- [ ] Performance claims cite a scenario and measurement.
- [ ] Unmeasured performance risk is disclosed.

## Pass Criteria

All applicable items pass, or each exception has a documented user need, risk, owner, and follow-up.
Visual preference alone cannot waive semantics or accessibility.
