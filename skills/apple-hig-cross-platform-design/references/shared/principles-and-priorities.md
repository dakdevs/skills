# Principles and Priorities

## Origin

Adapted from [Design principles](https://developer.apple.com/design/human-interface-guidelines/design-principles).

## Use When

Choosing among competing requirements, reviewing a concept, or deciding whether visual novelty
improves the product.

## The Eight-Lens Model

| Lens | Decision question | Observable evidence |
|---|---|---|
| Purpose | Does this help with what matters most? | Primary task is direct and emphasized |
| Agency | Can people choose, exit, explore, and recover? | Skippable guidance, undo, preserved work |
| Responsibility | Is this in people's best interest? | Clear rationale, data minimization, safe defaults |
| Familiarity | Does it build on known concepts and patterns? | Consistent terminology, native behavior, clear feedback |
| Flexibility | Does it adapt to people and context? | Multiple inputs, accessibility, size and locale support |
| Simplicity | Has every element earned its place? | Clear hierarchy, concise labels, restrained controls |
| Craft | Is behavior as refined as appearance? | Smooth states, accurate language, durable performance |
| Delight | Does the whole experience feel appropriately human? | Character supports the task rather than delaying it |

## Decision Procedure

1. Name the user outcome in one sentence.
2. List the alternatives under consideration.
3. Eliminate alternatives that weaken responsibility, accessibility, privacy, or recovery.
4. Prefer the alternative that makes the primary task clearer and more direct.
5. Prefer familiar platform behavior unless novelty delivers a measurable task benefit.
6. Verify adaptability to input, size, appearance, locale, and interruption.
7. Add brand and delight only after the outcome remains unobstructed.

## Conflict Rules

- Simplicity is focused usefulness, not the smallest number of visible elements. A hidden essential
  action is not simple.
- Familiarity does not require visual cloning across platforms. It requires familiar local behavior.
- Agency can justify optional customization, but defaults still need to work well.
- Delight is cumulative. A flourish that harms speed, clarity, comfort, or accessibility subtracts
  from delight.
- Craft includes maintenance. Keep current with platform capabilities rather than freezing an old
  visual language.

## Review Checklist

- [ ] The design states who benefits and how.
- [ ] The primary capability is excellent before secondary breadth is added.
- [ ] Guided flows can be skipped or exited when guidance is not essential.
- [ ] Mistakes are reversible or safely confirmed.
- [ ] Data use and permissions are transparent.
- [ ] Known patterns remain consistent within the product.
- [ ] The product works across supported inputs and configurations.
- [ ] Copy and visual hierarchy are concise and direct.
- [ ] Visual character supports the intended emotion and task.
- [ ] Real-world iteration and ongoing maintenance are planned.

## Failure Modes

- Scoring principles as equal checkboxes instead of resolving safety first.
- Calling a sparse interface simple when essential capability is undiscoverable.
- Calling identical screenshots consistent when behavior feels wrong on a platform.
- Adding whimsical delays to routine or high-stakes actions.
- Using a permission explanation after the system prompt has already appeared.

## Output

When using this document for a decision, return the selected option, the two or three principles
that drove it, the tradeoff accepted, and how the choice will be verified.
