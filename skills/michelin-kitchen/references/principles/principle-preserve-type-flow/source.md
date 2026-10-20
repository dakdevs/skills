# Research basis

Accessed 2026-09-03. This skill is an authored synthesis, not a reproduction of any source.

## Primary sources

| Source | Author | Contribution to the skill |
|---|---|---|
| [Type Inference](https://www.typescriptlang.org/docs/handbook/type-inference.html) | Microsoft TypeScript | Establishes contextual typing and inference from expression location. |
| [Generics](https://www.typescriptlang.org/docs/handbook/2/generics.html) | Microsoft TypeScript | Shows type argument inference carrying input type information through generic APIs. |
| [Creating Types from Types](https://www.typescriptlang.org/docs/handbook/2/types-from-types.html) | Microsoft TypeScript | Supports deriving types from existing types and values instead of duplicating shapes. |
| [TypeScript 4.9: `satisfies`](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-9.html) | Microsoft TypeScript | Defines compatibility checking that preserves the expression's resulting type. |
| [TypeScript 3.4: `const` assertions](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-4.html#const-assertions) | Microsoft TypeScript | Defines `as const` as preventing literal widening and producing readonly object properties or readonly tuples from literal values. |
| [Narrowing](https://www.typescriptlang.org/docs/handbook/2/narrowing.html) | Microsoft TypeScript | Documents control-flow analysis, discriminated unions, and user-defined type predicates. |
| [Zod basics](https://zod.dev/basics) | Zod | Documents parsing unknown data into typed output and deriving static types from schemas. |
| [Parse, don't validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/) | Alexis King | Supplies the distinction between checking a weak value and producing a more structured value at a boundary. |
| [The Hidden Side of Type Predicates](https://effectivetypescript.com/2024/02/27/type-guards/) | Dan Vanderkam | Explains why an incorrect user-defined type predicate can make TypeScript's false branch unsound. |

## Vocabulary choice

No single source uses **preserve type flow** as a formal TypeScript term. The phrase is used here as an operable umbrella for several established mechanisms:

- contextual typing;
- type argument and return-type inference;
- deriving types from types or values;
- control-flow narrowing;
- schema-derived types; and
- parsing at trust boundaries.

**Inference-first, boundary-parsed** is a compact alternative description. **Parse, don't validate** precisely names the boundary behavior but does not by itself capture the priority placed on preserving upstream TypeScript inference, so it is a supporting rule rather than the skill name.

## Adaptation notes

The sources permit user-defined type guards and runtime validation in broader circumstances. This skill deliberately adopts a narrower house rule:

1. Prefer authoritative upstream inference.
2. Treat ordinary `as Type` assertions as harmful because they override compiler evidence without checking or transforming the runtime value.
3. Allow `as const` because it preserves narrower literal information derived from the value itself; TypeScript documents its effects as preventing literal widening and producing readonly properties or tuples.
4. Use Zod only where runtime uncertainty enters and no upstream parser already establishes the guarantee.
5. Avoid bespoke functions whose purpose is checking TypeScript types.

That stronger policy reflects the user's requested engineering preference rather than a claim that TypeScript or Zod universally requires it.
