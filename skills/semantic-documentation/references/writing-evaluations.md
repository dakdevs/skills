# Writing Evaluations

Give an independent agent this skill's entrypoint and the relevant passages or artifact tasks. For cases 1–15, request compressed text for the stated audience. For cases 16–18, use the task as written. Withhold review criteria until evaluating outputs.

Judge semantic preservation, contract completeness, and executable invariance, not matching strings or mandatory jargon. A lost constraint outweighs any word reduction. Treat word counts separately from tokenizer measurements.

## Source passages

1. **Expert documentation:** Running the import again with the same input creates no additional database rows. However, every execution sends another notification, so repeating the entire import is not safe without handling notifications separately.
2. **Expert documentation:** A passing test suite is required before deployment. The release owner must also approve deployment, and only staging has been tested so far. Production has not been verified.
3. **Agent handoff:** A stale cache may explain the failures, but current evidence also fits replica lag. We have not isolated the cause. Inspect request traces before changing either subsystem.
4. **Agent instructions:** Retry HTTP 503 responses at most twice, and only for GET requests. Never retry POST requests. Wait 500 ms before each retry unless the server supplies a Retry-After value, in which case use that value.
5. **Code review:** The test obtains its expected total by calling the same pricing helper used by the production path. A mistake in that helper could therefore change both values while leaving the test green.
6. **General readership:** You can undo this change until you permanently delete the original files. After that deletion, you cannot recover the files through this tool.
7. **Expert documentation:** Each transaction applies all account updates or none. Concurrent transactions can still observe intermediate states in a separate reporting system. We have not measured crash durability.
8. **Agent handoff:** Version 2 works with version 1 clients when compression is disabled. Clients that enable compression must upgrade first. The legacy endpoint is discouraged but remains available until 2027-03-01.
9. **Editorial rewrite:** The logical formula is true under every truth assignment. The accompanying prose repeats the same definition twice. The justification assumes the conclusion it claims to establish.
10. **Exact instruction:** Preserve this command exactly: `deploy --env staging --timeout 30`. Do not run it; document it. The timeout is in seconds.
11. **Agent handoff:** The published report calls the model “thoughtological,” without defining that term. Keep the report's uncertainty visible; do not infer a technical property from the label.
12. **Budget conflict:** Rewrite case 4 in at most five words while preserving every operational constraint. If impossible, state the conflict and give the shortest faithful version you can.
13. **Research note:** A second experiment independently supports the original finding. Both experiments remain limited to the same population, so we cannot yet generalize the finding beyond it.
14. **Expert documentation:** The preview exists temporarily and is deleted when its owning session ends, even if a user is still viewing it. Exported copies are retained.
15. **Architecture note:** These two plugins can be used together. We have not established whether the combined behavior can be determined solely from each plugin's behavior and the rules connecting them.

## Artifact tasks

### 16. API contract

Write concise API documentation from these authoritative facts: omitting `expiry` selects the default of 24 hours; explicit `null` disables expiration. Reusing an identical request key within 24 hours suppresses duplicate record creation, but each retry incurs another provider charge. HTTP 429 responses include `Retry-After`. Do not invent guarantees or examples that imply additional behavior.

### 17. Comment cleanup

Improve comments only in the following fixture. Return the complete snippet; preserve all executable tokens and tool directives.

```ts
// SPDX-License-Identifier: MIT
// Set retries to two.
const retries = 2;
// Wait 500 ms because firmware 1.x needs this long to acknowledge.
// Remove this delay after firmware 1.x support ends; see issue #42.
const delayMs = 500;
// @ts-expect-error -- Firmware 1.x exposes an undocumented argument.
send(command, legacyFlag);
const cached = /* @__PURE__ */ createCache();
```

### 18. Factual correction

The implementation is authoritative. Improve documentation and comments only. Current prose: “The client makes at most five attempts, waiting between attempts because firmware 1.x needs 500 ms to acknowledge.” The runnable example is `client.send({ maxAttempts: 3, delayMs: 500 })`. Implementation constants are `maxAttempts = 3` and `delayMs = 500`. Return corrected prose, the example, and any material discrepancy.

## Review criteria

| Case | Required meaning                                                                                                                 | Plausible semantic defect                                                                          |
| ---- | -------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| 1    | Identical-input retries create no additional rows; notifications repeat; whole-operation retries need separate handling          | Calls all row effects or the whole import idempotent, or implies retry safety                      |
| 2    | Tests and owner approval required; only staging tested; production unverified                                                    | Treats tests as sufficient or implies production readiness                                         |
| 3    | Two plausible causes; neither isolated; traces precede changes                                                                   | States the stale cache is the cause or drops the next action                                       |
| 4    | Only HTTP 503 GET responses; maximum two retries; POST excluded; 500 ms default; Retry-After overrides                           | Loses status, method, bound, units, negation, or exception                                         |
| 5    | Expected values and production share the pricing helper; a helper defect can escape detection                                    | Uses “tautological” alone and erases the defect mechanism                                          |
| 6    | Undo before permanent deletion; this tool cannot recover afterward                                                               | Claims all recovery is universally impossible or obscures the cutoff                               |
| 7    | Account update atomicity; reporting can expose intermediate states; crash durability unmeasured                                  | Claims full isolation, durability, or general ACID compliance                                      |
| 8    | Compatibility conditional on disabled compression; upgrade order; discouraged endpoint remains until exact date                  | Claims unconditional compatibility or says endpoint is already removed                             |
| 9    | Formal tautology, redundant prose, and circular justification distinguished                                                      | Treats all three as interchangeable properties                                                     |
| 10   | Exact command, document-only instruction, and seconds retained                                                                   | Changes a literal, runs the command, or drops the unit                                             |
| 11   | Report attribution, quoted undefined word, and uncertainty survive                                                               | Invents a definition or silently replaces the quoted label                                         |
| 12   | Acknowledges infeasibility and preserves the case 4 constraints in the alternative                                               | Meets the word limit by silently deleting operational meaning                                      |
| 13   | Independent support; shared population limit; generalization not established                                                     | Drops independence or overstates generality                                                        |
| 14   | Temporary preview; deletion at owning-session end even during viewing; exports retained                                          | Uses ephemeral alone and loses the expiry condition or exception                                   |
| 15   | Plugins usable together; compositionality not established                                                                        | Claims compositionality merely from compatibility                                                  |
| 16   | Default, explicit null, both 24-hour scopes, deduplication boundary, repeated charges, and 429 header survive                    | Claims unconditional idempotence, confuses lifetime with deduplication window, or invents behavior |
| 17   | Executable tokens, license, directives and their placement unchanged; rationale, removal condition, and issue reference retained | Deletes significant comments, repositions directives, changes code, or erases rationale            |
| 18   | Three-attempt bound, firmware rationale, 500 ms, and runnable example preserved; stale five-attempt claim identified             | Changes implementation/example behavior, retains false claim, or removes causal rationale          |

Copy the skill folder alone to test portability: every required reference must resolve without the general writing skill or machine-specific paths.
