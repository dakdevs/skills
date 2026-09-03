---
name: principle-avoid-tautological-tests
description: "Apply when writing or reviewing automated tests, regression tests, expected values, fixtures, mocks, snapshots, property tests, or coverage-driven test additions. Tautological tests are harmful: require an independent test oracle and a credible way for each test to fail under a plausible defect; reject assertions that merely restate production logic, fixture setup, mock configuration, or the value under test."
globs: ["**/*test*", "**/*spec*", "**/tests/**", "**/__tests__/**"]
metadata:
  origin_title: "Independent test oracles and defect-sensitive testing guidance"
  origin_author: "ISTQB; Stryker Mutator; Google Testing Blog; Martin Fowler; Testing Library; Kent C. Dodds"
  origin_url: "https://istqb-glossary.page/test-oracle/"
  origin_note: "Authored synthesis of the sources documented in source.md; not a verbatim copy."
---

# Avoid Tautological Tests

## Prime directive

**Every test needs an independent oracle and a credible way to fail.**

Tautological tests are harmful because they manufacture confidence without independently checking behavior. Do not create assertions that are true by construction because the expected result merely restates the actual result, fixture setup, mock configuration, or production execution. Also reject oracle-coupled tests that reproduce the production algorithm so closely that both sides can make the same mistake.

## Vocabulary

Use these terms when explaining the principle:

- **Test oracle:** the source that determines what the correct result should be.
- **Independent oracle:** an expected result derived independently of the implementation under test, such as from a specification, worked example, invariant, externally maintained reference, or domain fact.
- **Tautological test:** a self-confirming test whose assertion restates something made true by its own arrangement or by the actual result itself.
- **Oracle-coupled test:** a test whose expected side reproduces or invokes the production derivation closely enough to share its defects. It may not be a strict tautology, but it creates similar false confidence.
- **Defect-sensitive test:** a test that fails when a plausible defect is introduced into the behavior it claims to protect.
- **Common-mode failure:** the implementation and its oracle make the same mistake, allowing the test to remain green. This is a risk indicator, not the definition of tautology.
- **Observable behavior:** an output, state transition, emitted event, persisted effect, or required interaction visible through the supported boundary.

Oracle independence is about derivation, not file location. Correct production code and its tests should share the same specification. They should not share the same executable implementation, unverified observation, or circular derivation. Copying production logic into a test file does not make it independent. Conversely, a compact calculation in a test can be independent when it directly expresses a separately established rule.

## Decision procedure

Before adding or approving a test:

1. **State the protected behavior.** Describe the contract in terms of observable effects, not internal steps.
2. **Name a plausible defect.** Identify a realistic wrong implementation the test should catch.
3. **Identify the oracle.** Say where the expected result comes from: specification, worked example, invariant, protocol, approved artifact, or independent reference.
4. **Trace both derivations.** Sharing a specification is desirable; sharing the subject's execution, production helper, copied algorithm, post-execution mutable input, mock response path, or unreviewed generated output is not.
5. **Make the example discriminating.** Choose inputs and expectations that distinguish correct behavior from the plausible defect, especially boundaries and negative cases.
6. **Prefer explicit expectations.** Use small literals or tables of input and expected output when they communicate the rule more directly than recomputing it.
7. **Prove the test can fail.** For a regression, observe it fail against the buggy behavior before the fix. Otherwise use a focused mutation or perturbation when practical.
8. **Keep only useful assertions.** If an assertion verifies setup, a test framework, or a value that the test itself assigned without exercising owned behavior, delete it.

## Fast diagnostic

Ask this question:

> If the production behavior were wrong in the most likely way, could the expected side be wrong in exactly the same way?

If yes, the test lacks an independent oracle. Redesign it before adding more assertions.

## Decision table

| Situation | Action |
|---|---|
| Expected value calls the function under test | Replace it with an independent expected result |
| Test duplicates the production algorithm | Use worked examples, invariants, or an independent reference |
| Assertion only repeats fixture or mock setup | Delete it or exercise owned behavior between arrange and assert |
| Test imports a production helper to build expected output | Establish expected output without that helper |
| Claimed regression test passes on the known-buggy version | It does not guard that defect; strengthen it before claiming regression coverage |
| Interaction is itself the contract | Verify the meaningful command, destination, and cardinality |
| Snapshot represents reviewed observable output | Keep it if changes receive deliberate semantic review |
| Property test checks independent invariants | Keep it; invariants are valid oracles |
| Independent simple reference checks optimized code | Differential testing is valid if failures are not shared |
| Test only executes code for coverage | Add a behavioral oracle or remove the test |

## Harmful patterns

### Calling the subject on both sides

```ts
const actual = calculateTotal(order);
const expected = calculateTotal(order);

expect(actual).toBe(expected);
```

For this numeric example, the assertion checks repeatability, not correctness. Similar repeated-call comparisons may expose statefulness, mutation, or identity differences, but they still need a separate oracle to establish the claimed result.

Use an expectation grounded in a worked example:

```ts
const order = {
  items: [{ priceCents: 1_000, quantity: 2 }],
  discountCents: 250,
};

expect(calculateTotal(order)).toBe(1_750);
```

The literal is not arbitrary: it encodes the independently reviewed example `2 × 1000 - 250`.

### Reimplementing the algorithm in the test

```ts
const expected = order.items.reduce(
  (sum, item) => sum + item.priceCents * item.quantity,
  0,
) - order.discountCents;

expect(calculateTotal(order)).toBe(expected);
```

If the production code copied the same misunderstood rule, both sides agree and the defect survives. Prefer a small table of specification-derived examples:

```ts
it.each([
  { subtotal: 2_000, discount: 250, expected: 1_750 },
  { subtotal: 500, discount: 800, expected: 0 },
])("never returns a negative total", ({ subtotal, discount, expected }) => {
  expect(applyDiscount(subtotal, discount)).toBe(expected);
});
```

### Testing arrangement instead of behavior

```ts
const user = { id: "u1", role: "admin" };

expect(user.role).toBe("admin");
```

The assertion only proves that the fixture contains the literal assigned one line earlier. No production behavior ran.

Exercise behavior that consumes the fixture:

```ts
expect(canDeleteProject(user)).toBe(true);
```

The expected permission must come from the authorization rule, not from `canDeleteProject` or a duplicate of its implementation.

### Testing a configured mock against itself

```ts
const gateway = vi.fn().mockResolvedValue({ id: "p1" });

expect(await gateway()).toEqual({ id: "p1" });
```

This verifies the mocking library and the arrangement. It says nothing about application behavior.

Use the double through the supported unit boundary:

```ts
const gateway = { charge: vi.fn().mockResolvedValue({ id: "p1" }) };

await checkout({ cart, gateway });

expect(gateway.charge).toHaveBeenCalledWith({
  amountCents: 2_500,
  currency: "USD",
});
```

This is valid only if issuing that charge command is part of `checkout`'s contract. Do not assert incidental call order or private collaboration details.

### Reusing production helpers as the oracle

```ts
const expected = serializeOrder(buildOrderFixture());
const actual = exportOrder(buildOrderFixture());

expect(actual).toBe(expected);
```

If `exportOrder` delegates to `serializeOrder`, the test merely confirms the implementation structure. Use protocol-defined output or a separately reviewed fixture instead.

## Preferred oracle patterns

### Specification examples

Write concrete input/output examples whose expected values can be checked without executing production code. Include boundaries, invalid inputs, and negative cases.

### Invariants and metamorphic properties

Properties can provide independent oracles without hard-coded outputs:

```ts
const original = [...input];
const result = sortNumbers([...input]);

expect(result).toHaveLength(original.length);
for (const value of new Set(original)) {
  expect(result.filter((item) => item === value)).toHaveLength(
    original.filter((item) => item === value).length,
  );
}
expect(result.every((value, index) => index === 0 || result[index - 1] <= value)).toBe(true);
```

These assertions express permutation and ordering properties rather than invoking another copy of `sortNumbers`.

### Differential tests

A simple, slow, independently designed reference implementation can test an optimized implementation across many cases. It is useful only when it is easier to inspect and unlikely to share the same defect. A copy, wrapper, or refactor of production logic is not independent.

### Reviewed snapshots and golden files

A snapshot can serve as an oracle when it captures supported observable behavior and reviewers compare it against an external contract or domain knowledge. Approval alone does not establish correctness. Blindly generating or updating a snapshot from current output makes the process self-confirming. A reviewed snapshot of private structure may be non-tautological yet still brittle and implementation-coupled. Keep snapshots focused enough to understand and review semantically.

### Contract interactions

An interaction assertion is legitimate when the outbound interaction is the observable contract: publishing an event, issuing a payment command, persisting a record, or calling a protocol boundary. Assert the meaningful payload and occurrence, not every internal call made along the way.

## Important distinctions

- **Tautological is not synonymous with simple.** A literal assertion can strongly discriminate correct from incorrect behavior.
- **Tautological is not synonymous with implementation-coupled.** A private-state assertion may still catch defects, but it is brittle and should usually be replaced with an observable assertion.
- **Weak is not always tautological.** A smoke test, assertion-free test, or happy-path-only test may be inadequate without deriving expected and actual from the same source.
- **Computed expectations are not automatically tautological.** They are valid when the computation directly expresses an independent rule and does not share the production algorithm's likely mistakes.
- **Mocks are not automatically tautological.** Testing a mock's configured return is tautological; verifying a required boundary interaction can be valuable.
- **Snapshots are not automatically tautological.** They become useful oracles when meaningful review checks observable output against an external contract or domain knowledge. Approval without that comparison is insufficient, and snapshots of private structure remain brittle.
- **Reference implementations are not automatically independent.** Independence requires separate reasoning and a different failure mode, not merely a second function.
- **Testing framework or language guarantees is usually low value.** Test behavior owned by the codebase unless an integration or regression demonstrates that the guarantee is uncertain in context.

## Review workflow

When reviewing tests:

1. Map each assertion to the behavior it protects.
2. Trace every expected value to its oracle.
3. Reject expected values derived from the subject, its helpers, or duplicated implementation logic.
4. Delete assertions that merely replay setup or mock configuration.
5. Replace private implementation checks with supported observable behavior where possible.
6. Check boundary, negative, and state-transition cases for discriminating inputs.
7. Confirm a claimed regression test fails without the fix; if it stays green, it may protect something else but does not guard that regression.
8. Use mutation testing or a focused manual perturbation when the test's sensitivity is unclear.
9. Run the focused test, then the relevant suite.

## Verification questions

- What specific defect will this test catch?
- Where did the expected result come from?
- Would the same bug affect both actual and expected paths?
- Does the assertion observe owned behavior, or only repeat arrangement?
- If a mock is involved, am I testing the application contract or the mock configuration?
- Would a refactor that preserves behavior keep this test meaningful?
- Did the claimed regression test fail on the buggy behavior before the fix?
- Can a small mutation survive while this test remains green?

See `source.md` for the research basis and `evals/evals.json` for representative application cases.
