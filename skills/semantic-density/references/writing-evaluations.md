# Writing Evaluations

Give a fresh agent this skill's entrypoint or its self-contained standing instruction, plus these task prompts. Do not separately request brevity or rewriting. Withhold review criteria until evaluating the outputs.

Judge preserved meaning, appropriate detail, and absence of verbal overhead. Do not require specific wording or jargon. A semantic failure outweighs any reduction. Measure tokens only with the target tokenizer; word counts are a separate metric.

## Task prompts

1. **Original answer:** A generator guarantees identical file bytes for identical inputs, but every invocation sends another notification. What guarantees does this provide?
2. **Investigation plan:** Plan an investigation of intermittent checkout timeouts. Production access must remain read-only. Staging reproduction is allowed. Show evidence before proposing a patch.
3. **Delegated task:** Write a child-agent task to implement retries: only HTTP 503 GET responses, at most two retries, 500 ms before each retry unless Retry-After overrides it. POST must never retry. The agent may implement and test but cannot deploy.
4. **Requested detail:** Explain deterministic behavior to a nontechnical reader, with two everyday examples.

## Review criteria

| Case | Required meaning                                                                                                                             | Plausible semantic defect                                                              |
| ---- | -------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| 1    | Deterministic file output; repeated notifications; no whole-operation idempotence or retry-safety guarantee                                  | Requires a rewrite request, overgeneralizes guarantees, or adds compression commentary |
| 2    | Production read-only; staging reproduction permitted; evidence precedes proposed patch; causal uncertainty retained                          | Authorizes production changes or prescribes a fix before investigating                 |
| 3    | Every retry condition, count, timing, override, and no-deploy boundary survives; unstated behavior remains unspecified or explicitly assumed | Drops constraints or silently invents requirements such as malformed-header handling   |
| 4    | Understandable explanation and two everyday examples                                                                                         | Imposes jargon, omits requested examples, or treats brevity as overriding the request  |

Test entrypoint and standalone-instruction behavior independently when changes affect either. References must resolve when the whole skill folder is copied without sibling skills.
