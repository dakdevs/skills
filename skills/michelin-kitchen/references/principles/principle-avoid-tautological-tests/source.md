# Research basis

Accessed 2026-09-03. This skill is an authored synthesis, not a reproduction of any source.

## Primary sources

| Source | Author | Contribution to the skill |
|---|---|---|
| [Test Oracle](https://istqb-glossary.page/test-oracle/) | ISTQB Glossary | Defines a test oracle as the source of expected results and explicitly distinguishes it from the code under test. |
| [What is mutation testing?](https://stryker-mutator.io/docs/) | Stryker Mutator team | Provides the defect-sensitivity check: mutate production code and expect effective tests to fail; also explains why coverage alone does not establish effectiveness. |
| [Test Behavior, Not Implementation](https://testing.googleblog.com/2013/08/testing-on-toilet-test-behavior-not.html) | Andrew Trenk, Google Testing Blog | Supports asserting stable externally visible behavior rather than internal implementation steps. |
| [Don't Put Logic in Tests](https://testing.googleblog.com/2014/07/testing-on-toilet-dont-put-logic-in.html) | Erik Kuefler, Google Testing Blog | Warns that complex expected-value logic can reproduce bugs and obscure what a test establishes. |
| [Guiding Principles](https://testing-library.com/docs/guiding-principles/) | Testing Library | Connects test confidence to exercising software in the way it is intended to be used. |
| [Testing Implementation Details](https://kentcdodds.com/blog/testing-implementation-details) | Kent C. Dodds | Distinguishes production-user behavior from test-only implementation details and discusses false confidence caused by the latter. |
| [Mocks Aren't Stubs](https://martinfowler.com/articles/mocksArentStubs.html) | Martin Fowler | Explains behavior versus state verification, implementation coupling, and the risk of incorrect mock expectations allowing green tests to mask errors. |

## Vocabulary choice

**Tautological test** is used here for a test that confirms itself because its assertion restates something made true by arrangement or by the actual result. Related phrases include **self-confirming test** and **testing the mock**. Reimplementing production logic in a test is described more precisely as an **oracle-coupled test**: it is not always a strict tautology, but it risks common-mode failure and similar false confidence.

The established testing concept that makes the rule precise is **test oracle**. The skill therefore states the principle operationally as:

> Every test needs an independent oracle and a credible way to fail.

**Defect-sensitive** is used as a practical description of mutation testing's central question: does the suite fail when production behavior is plausibly changed?

## Adaptation notes

The source material supports several adjacent principles, but this skill deliberately keeps their boundaries clear:

1. Tautological tests are always harmful because they cannot independently establish correctness.
2. Correct tests and implementations share a specification; oracle independence forbids circular or shared executable derivation, not a shared contract.
3. Oracle-coupled tests may not be strict tautologies, but duplicated logic can create common-mode failures.
4. Implementation-coupled tests may detect defects but are brittle; they are related, not identical.
5. Assertion-free, happy-path-only, or low-value tests may be weak without being tautological.
6. Computed expectations, mocks, snapshots, property tests, and reference implementations remain valid when their oracle is independently justified.
7. Mutation testing is evidence for defect sensitivity, not a mandatory tool for every change.

These distinctions avoid replacing one simplistic rule with another. The target is independent evidence, not a blanket ban on particular test techniques.
