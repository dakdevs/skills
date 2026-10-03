# Semantic Thesaurus

Choose from the meaning column, then check the boundary. A term is usable only if the source supports its defining properties. Retain the surrounding subject, qualifiers, and relationships. Read the relevant section; use other established terms when they fit better.

## Reasoning and evidence

| Meaning to compress                                                    | Candidate                  | Boundary to preserve                                                       |
| ---------------------------------------------------------------------- | -------------------------- | -------------------------------------------------------------------------- |
| True under every possible truth assignment                             | Tautological               | Formal logic; distinguish rhetorical repetition                            |
| Assumes the conclusion in its supporting reasoning                     | Circular                   | Identify the dependency when material                                      |
| Adds no information to what is already stated                          | Redundant                  | Repetition may still serve a deliberate purpose                            |
| Expected test results are derived from the implementation being tested | Self-referential oracle    | Preserve this mechanism; not every shared fixture makes an oracle circular |
| Cannot be settled uniquely from the supplied evidence                  | Underdetermined            | Multiple possibilities remain; not necessarily unknowable                  |
| Supports more than one interpretation                                  | Ambiguous                  | Specify what is ambiguous if that affects action                           |
| Too little evidence to decide the stated question                      | Inconclusive               | Does not mean the alternatives are equally likely                          |
| Accepted for now, subject to revision                                  | Provisional                | Retain the condition for revision if specified                             |
| Supported by observation or experiment                                 | Empirical                  | Does not establish causation or generality                                 |
| Derived from premises rather than directly observed                    | Inferred                   | Retain the premises or evidence when material                              |
| Independently supports an existing finding                             | Independently corroborates | Corroboration alone does not establish evidential independence or proof    |
| Could be contradicted by some possible observation                     | Falsifiable                | Testability is not falsity                                                 |
| Reasoning selects the best explanation among alternatives              | Abductive                  | Does not establish deductive certainty                                     |
| Asks what would hold if a condition were different                     | Counterfactual             | Preserve the changed condition and assumptions                             |

## Conditions and scope

| Meaning to compress                                                                    | Candidate                  | Boundary to preserve                                            |
| -------------------------------------------------------------------------------------- | -------------------------- | --------------------------------------------------------------- |
| Required for an outcome, without guaranteeing it                                       | Necessary but insufficient | Do not reduce to necessary if insufficiency matters             |
| Guarantees an outcome, but other routes can also produce it                            | Sufficient but unnecessary | Keep the alternatives claim                                     |
| A holds exactly when B holds                                                           | A if and only if B         | Both directions must be supported                               |
| Cannot both hold in the stated context                                                 | Mutually exclusive         | Does not mean one must hold                                     |
| Together cover every possibility in the stated domain                                  | Exhaustive                 | Does not imply categories are disjoint                          |
| Categories do not overlap and cover the entire domain                                  | Partition                  | Retain the domain being partitioned                             |
| Depends on a stated condition                                                          | Conditional on             | Retain the condition; do not replace it with a vague adjective  |
| A rule may be overridden when exceptions apply                                         | Defeasible                 | Name exceptions when supplied                                   |
| Holds throughout specified operations or changes                                       | Invariant                  | State the scope; a current observation is not an invariant      |
| Independent along a specified dimension                                                | Orthogonal                 | Not merely different; name the dimension if unclear             |
| The whole's meaning or behavior is determined by its parts and their combination rules | Compositional              | Stronger than pieces merely being compatible or usable together |

## State and behavior

| Meaning to compress                                                  | Candidate           | Boundary to preserve                                                    |
| -------------------------------------------------------------------- | ------------------- | ----------------------------------------------------------------------- |
| Repeated application has the same effect as one application          | Idempotent          | State the operation and effect; unrelated side effects may still repeat |
| Same inputs and relevant initial state produce the same result       | Deterministic       | Does not imply correctness or identical environments                    |
| All specified changes occur or none occur                            | Atomic              | State the boundary; does not imply isolation or durability              |
| Cannot be modified after creation                                    | Immutable           | Not the same as access being read-only through one interface            |
| Can be restored to the prior state                                   | Reversible          | Retain limits, costs, and what is restored                              |
| Can be safely entered again before a prior invocation finishes       | Reentrant           | Not equivalent to thread-safe                                           |
| Progresses in only one direction under the stated ordering           | Monotonic           | Name the quantity and ordering when unclear                             |
| Parties or replicas approach an agreed state under stated conditions | Convergent          | Does not imply immediate agreement or a time bound                      |
| Exists temporarily                                                   | Ephemeral           | Retain any expiration condition; the term alone specifies no lifetime   |
| Retains no session state between requests                            | Stateless           | Does not mean no databases, configuration, or state anywhere            |
| Preserves the specified contract for existing consumers              | Backward compatible | Specify the contract and relevant versions                              |
| Stops or denies access when its check fails                          | Fail-closed         | Preserve which failures and which boundary trigger denial               |

## Structure and time

| Meaning to compress                                       | Candidate          | Boundary to preserve                                             |
| --------------------------------------------------------- | ------------------ | ---------------------------------------------------------------- |
| Contains no cycles                                        | Acyclic            | Specify the graph or dependency relation                         |
| Every member can reach every other by the stated relation | Strongly connected | Directed reachability; mere connectedness is weaker              |
| Determines which source prevails when sources disagree    | Authoritative      | Authority does not establish accuracy                            |
| Uses the designated standard representation               | Canonical          | Does not establish truth, recency, or uniqueness without context |
| Traceable to its origin and transformations               | Provenance         | Retain actual sources; the label alone supplies none             |
| More than one permitted interpretation has been resolved  | Disambiguated      | Preserve which interpretation was selected                       |
| Replaces an earlier rule or artifact as the current one   | Supersedes         | May retain the earlier artifact as history                       |
| Still available but discouraged, usually pending removal  | Deprecated         | Does not mean removed or unusable                                |
| No longer available                                       | Removed            | Do not soften removal to deprecation                             |
| Applies only within a defined boundary                    | Scoped to          | Name that boundary                                               |

## Dense verbs and relations

| Longer expression                                                | Candidate    | Boundary to preserve                                               |
| ---------------------------------------------------------------- | ------------ | ------------------------------------------------------------------ |
| Logically requires that a conclusion holds                       | Entails      | Stronger than suggests or correlates with                          |
| Makes the stated outcome impossible                              | Precludes    | Stronger than reduces its likelihood                               |
| Takes precedence over another rule in this case                  | Overrides    | Retain the condition and overridden rule                           |
| Includes every case covered by a narrower category               | Subsumes     | Requires actual inclusion, not overlap                             |
| Distinguishes concepts that were treated as the same             | Disentangles | Name the concepts and their difference                             |
| Treats distinct concepts as though they were identical           | Conflates    | Do not label an intentional abstraction a mistake without evidence |
| Brings divergent records into agreement                          | Reconciles   | Does not specify conflict policy; retain it if given               |
| Assigns responsibility for a decision or action to another actor | Delegates    | Name the recipient and scope; authority limits remain              |
| Transfers work and the context needed to continue it             | Hands off    | Retain owner, pending work, and blockers                           |
| Makes an assumed condition explicit                              | Articulates  | Does not validate the assumption                                   |
| States a claim with narrower limits or less certainty            | Qualifies    | Preserve the actual limits                                         |
| Sets a maximum or minimum on a quantity                          | Bounds       | Name direction, value, units, and conditions                       |

## Compression examples

### Argument

Before: “The explanation assumes the very claim it is supposed to establish, so it cannot provide independent support for that claim.”

After: “The argument is circular; it provides no independent support.”

### Operation boundary

Before: “Sending the same request more than once does not create additional invoices, but each request sends another email.”

After: “Invoice creation is idempotent; each request still sends an email.”

### Inference

Before: “The observed delay is consistent with lock contention, but the available traces do not distinguish that explanation from slow storage.”

After: “Cause underdetermined: traces fit both lock contention and slow storage.”

### Constraint

Before: “Passing the tests is required before release, but passing them does not remove the requirement for approval.”

After: “Release requires passing tests and approval.”

### Reader adaptation

Agent context: “The migration is reversible until legacy columns are dropped.”

General readership: “You can undo the migration until the old columns are deleted.”

### False economy

“The conjecture exhibits epistemic indeterminacy” is longer and less direct than “The evidence is inconclusive.” Prefer the latter when that is the intended meaning.
