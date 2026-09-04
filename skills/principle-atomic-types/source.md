# Research basis

Accessed 2026-09-04. This skill is an authored, opinionated application-code policy, not a reproduction of any source.

## Primary sources

| Source | Author | Contribution to the skill |
|---|---|---|
| [Type Compatibility](https://www.typescriptlang.org/docs/handbook/type-compatibility) | Microsoft TypeScript | Establishes that TypeScript compatibility is structural and based on members, supporting narrow consumer-owned structural inputs. |
| [Type Inference](https://www.typescriptlang.org/docs/handbook/type-inference) | Microsoft TypeScript | Documents inference and contextual typing, supporting value APIs that carry types without separately exported declarations. |
| [More on Functions](https://www.typescriptlang.org/docs/handbook/2/functions.html) | Microsoft TypeScript | Documents inline function type expressions, parameter typing, return inference, and parameter destructuring. |
| [Object Types](https://www.typescriptlang.org/docs/handbook/2/objects.html) | Microsoft TypeScript | Documents anonymous object types, type aliases, interfaces, and the declaration-merging behavior unique to interfaces. |
| [Utility Types](https://www.typescriptlang.org/docs/handbook/utility-types.html) | Microsoft TypeScript | Documents `Parameters` and `ReturnType`, which let consumers derive local types from exported function values. |

## Deliberate house policy

TypeScript supports both interfaces and exported type aliases. The sources do not require applications to avoid either construct. This skill intentionally adopts stricter rules requested by dakdevs:

1. Authored application code exports runtime values, never type declarations.
2. Authored code never declares interfaces.
3. Named types remain local and are derived from authoritative value owners when possible.
4. Function boundaries expose only the smallest invariant-preserving data and callable capabilities needed for their transitive work.
5. Deterministic logic is written as pure functions; unavoidable effects are isolated behind explicit boundary inputs.

These constraints are architectural choices intended to reduce coupling and ambient authority. They must be presented as policy, not as universal TypeScript best practice.

## Scope notes

- **Atomic is a project term.** It means minimal and semantically complete, not necessarily primitive. A value that preserves a domain invariant can be one atomic input even when represented by an object or union.
- **The no-export rule is application-scoped.** A package designed for third-party consumers may need an intentionally published type contract. Identify that as a library API decision instead of silently breaking it.
- **The no-interface rule applies to authored declarations.** Generated and third-party `.d.ts` files are external contracts and should not be rewritten solely to satisfy this policy.
- **Pure functional is an organization strategy.** Real applications still perform effects. The skill separates deterministic decisions from thin effectful adapters rather than pretending I/O is pure.
