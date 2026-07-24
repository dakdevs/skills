# Product Definition

## Contents

- [Four-Part Product Model](#four-part-product-model)
- [Scope Ladder](#scope-ladder)
- [Information Architecture](#information-architecture)
- [State Inventory](#state-inventory)
- [Prioritization](#prioritization)
- [Visual Brief Translation](#visual-brief-translation)
- [Verification](#verification)

## When to Read

Read before choosing screens, navigation containers, or visual treatments for a new app or major
feature.

## Four-Part Product Model

Define:

1. **Person** - one primary person in a concrete situation.
2. **Job** - the progress they want, written as a verb.
3. **Object** - the data or content they act on.
4. **Success** - the observable moment the job is complete.

Example:

```text
Person: A student leaving class.
Job: Capture one useful thought before it is forgotten.
Object: A short note, optional photo, and course.
Success: The note is saved and visible in the course timeline.
```

This yields a stronger app than "a beautiful note app with glass."

## Scope Ladder

| Level | Question | Output |
|---|---|---|
| Promise | Why should the app exist? | One sentence |
| Primary loop | What repeats? | Trigger -> action -> feedback -> next state |
| Destinations | What persistent contexts exist? | Three to five top-level areas |
| Features | What capabilities support the loop? | Prioritized list |
| States | What can the person observe? | State matrix |
| Edge cases | What breaks or becomes sensitive? | Recovery and permission rules |

Do not promote every feature to a destination. A destination is a stable context people return to.

## Information Architecture

Create a noun/verb map:

| Entity (noun) | Core attributes | Actions (verbs) | Relationships |
|---|---|---|---|

Then create a route map:

```text
Destination
  -> list/overview
      -> detail
          -> edit/action
              -> result/recovery
```

Prefer shallow, predictable paths. Modal presentation is for a focused temporary task, not a
replacement for information architecture.

## State Inventory

For every data-dependent feature, decide:

| State | User question | Required response |
|---|---|---|
| Initial | What is this? | Context and clear first action |
| Loading | Is something happening? | Progress without layout chaos |
| Empty | Why is there nothing? | Explanation and next action |
| Populated | What matters now? | Hierarchy and primary task |
| Partial | What is available? | Useful subset and status |
| Error | What failed? | Plain explanation and retry/recovery |
| Offline | What still works? | Cached/local behavior and sync status |
| Permission denied | Why is this limited? | Value, privacy, settings route if useful |
| Destructive pending | What will be lost? | Scope, consequence, cancel |
| Success | Did it work? | State change, confirmation, next action |

## Prioritization

Use consequence rather than excitement:

1. Required to complete the primary job.
2. Required to trust and recover.
3. Required for accessibility and privacy.
4. Required for realistic repeated use.
5. Useful enhancement.
6. Delight.

## Visual Brief Translation

Translate adjectives into observable rules:

| Adjective | Possible operational meaning |
|---|---|
| Calm | one primary action, restrained motion, generous but adaptive spacing |
| Premium | excellent type hierarchy, precise copy, coherent imagery, no arbitrary effects |
| Playful | responsive feedback, friendly motion, expressive but legible color |
| Technical | dense but scannable data, alignment, precise status, keyboard/pointer support |
| Immersive | content extends behind sparse floating controls |

Ask what the quality should change in behavior or hierarchy. Do not convert every adjective into a
custom material.

## Output Template

```markdown
## Product model
- Person:
- Job:
- Object:
- Success:

## Primary loop

## Destinations

## Entities

## State matrix

## First vertical slice

## Non-goals and assumptions
```

## Verification

- Can the primary job be described without naming a screen?
- Does every destination support that job or a necessary repeated context?
- Are empty/error/permission states designed?
- Is the first slice useful without secondary features?
- Are privacy and destructive operations explicit?
- Would the app still make sense with all custom styling removed?
