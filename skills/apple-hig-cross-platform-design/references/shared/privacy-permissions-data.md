# Privacy, Permissions, and Data Safety

## Origin

Adapted from [Privacy](https://developer.apple.com/design/human-interface-guidelines/privacy),
[Design principles](https://developer.apple.com/design/human-interface-guidelines/design-principles),
and source pages on accounts, settings, and destructive presentation.

## Use When

A flow reads personal data, requests permission, authenticates, purchases, records, shares,
deletes, exports, or performs an operation that may surprise people.

## Responsibility Model

Collect and expose only what the primary capability needs. Explain purpose before access. Request
permission in context. Preserve data securely. Make consequences and recovery visible.

## Permission Procedure

1. Identify the feature that requires access and the minimum data needed.
2. Delay the request until the person initiates or encounters that feature.
3. Explain what capability becomes possible and why the data is necessary.
4. Trigger the system permission prompt.
5. If denied, keep unrelated functionality available.
6. Explain how to continue without access or provide a direct settings route when appropriate.
7. Never repeatedly pressure a person after denial.

## Data Decision Table

| Question | If yes | If no |
|---|---|---|
| Is this data essential to the requested capability? | Collect the minimum, in context | Do not collect it |
| Can the system provide a trusted mechanism? | Prefer it | Justify and review any custom mechanism |
| Can the operation be undone? | Offer visible undo | Use specific confirmation for serious consequences |
| Is authentication expired? | Preserve work, reauthenticate, then resume | Continue without interruption |
| Can denial degrade only one feature? | Keep the rest usable | Explain why the core capability cannot proceed |
| Will information leave the current context? | Preview recipient/scope and confirm as needed | Avoid extra ceremony |

## Destructive and Sensitive Actions

- State the object and consequence: "Delete 4 drafts" is stronger than "Delete."
- Do not style a destructive action as the preferred primary action.
- Separate destructive actions from routine commands.
- Prefer undo for frequent, easily reversible operations.
- Confirm only when consequences are hard to recover from, surprising, or high stakes.
- Preserve unsaved input through authentication, network, or validation failures.
- For shared or synced data, explain scope when deletion affects other devices or people.

## Authentication Rules

- Prefer trusted system authentication and credential mechanisms.
- Avoid inventing custom security schemes.
- Do not rely on password alone when stronger trusted options are available.
- Do not store secrets in plain text.
- On shared or multiuser systems, do not assume the currently visible person is always the same user.

## Verification

- [ ] Each data field maps to a necessary capability.
- [ ] Permission rationale precedes the system prompt and matches actual use.
- [ ] Denial and revocation paths work.
- [ ] Authentication interruption preserves the task.
- [ ] Destructive labels name the affected object and scope.
- [ ] Undo or recovery exists where technically possible.
- [ ] Sharing shows the destination and data scope.
- [ ] Logs, previews, notifications, and inactive windows do not expose sensitive content.

## Failure Modes

- Requesting every permission during onboarding.
- Describing organizational benefit instead of user-facing value.
- Blocking the whole product after denial of an optional capability.
- Repeated prompts designed to wear down refusal.
- Generic confirmation that fails to explain scope.
- Losing a completed form when sign-in expires.

## Output

For a sensitive feature, document data purpose, collection point, permission timing, denial path,
storage/transport boundary, destructive scope, and recovery behavior.
