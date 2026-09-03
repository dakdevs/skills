---
name: principle-preserve-type-flow
description: "Apply when writing or reviewing TypeScript that introduces type annotations, `as` casts, validation, Zod schemas, controllers, API boundaries, type guards, assertion helpers, or duplicated domain types. Preserve type information inferred from authoritative upstream producers; reject `as Type` assertions that override compiler evidence while allowing `as const` to retain value-derived literal types; parse externally supplied raw data once at the entrypoint with Zod when no trusted typed source exists; avoid functions whose purpose is checking a value's TypeScript type."
globs: ["**/*.ts", "**/*.tsx", "**/*.mts", "**/*.cts"]
metadata:
  origin_title: "TypeScript inference and boundary parsing guidance"
  origin_author: "Microsoft TypeScript; Zod; Alexis King; Dan Vanderkam"
  origin_url: "https://www.typescriptlang.org/docs/handbook/type-inference.html"
  origin_note: "Authored synthesis of the sources documented in source.md; not a verbatim copy."
---

# Preserve Type Flow

## Prime directive

**Infer from trusted producers. Parse untrusted inputs at boundaries. Do not recreate type knowledge with handwritten checking functions.**

Optimize for the type information available to downstream TypeScript code. Every manual type, schema, cast, or type guard risks creating a second source of truth.

## Vocabulary

Use these terms when explaining the principle:

- **Type flow:** type information moving from an authoritative producer through consumers without being widened, duplicated, or reconstructed.
- **Inference-first:** allowing contextual typing, generic inference, return-type inference, and control-flow analysis to preserve that information.
- **Authoritative upstream producer:** code that already owns the static type, such as a typed function, generated client, ORM, framework adapter, or schema parser.
- **Trust boundary:** the point where runtime data enters from outside the typed program, such as an HTTP body, webhook, environment, CLI, file, queue, or untyped third-party response.
- **Boundary parsing:** converting `unknown` external input into a trusted typed value. This is often called controller-level validation, but "parsing" better describes the typed result it produces.
- **Schema-derived type:** a TypeScript type obtained from the runtime schema rather than maintained beside it.

## Decision procedure

Follow this order before adding any type-related code:

1. **Find the owner.** Identify where the value and its most precise type originate.
2. **Preserve upstream inference.** If TypeScript already knows the type, consume it directly. Do not restate the shape, cast it, or wrap it in a checker.
3. **Derive when a named type is necessary.** Derive from the owner with `typeof`, `ReturnType`, `Awaited`, indexed access, or the library's exported types. Do not hand-copy the shape.
4. **Reject `as Type` assertions.** They do not prove or validate anything at runtime; they tell the compiler to trust a claim that may contradict the available evidence. Fix the producer, preserve inference, narrow with control flow, or parse the boundary instead.
5. **Allow `as const` for value-derived precision.** A const assertion does not invent an unrelated target type. It keeps literal values from widening and derives readonly properties or a readonly tuple from the expression itself.
6. **Constrain without widening.** For local literals that must meet a contract while retaining precise inference, prefer `satisfies`; combine it with `as const` when both literal precision and contract checking are needed.
7. **Locate runtime uncertainty.** A TypeScript annotation does not make external runtime data trustworthy. If raw data crosses a trust boundary and no upstream runtime parser owns it, accept it as `unknown` and parse it there.
8. **Use Zod at that boundary.** Define one schema, parse once, and derive downstream types with `z.infer`, `z.input`, or `z.output` as appropriate.
9. **Trust the parsed result downstream.** Services and domain logic receive typed values and do not revalidate their shape.
10. **Do not add type-checking functions.** Avoid `isFoo`, `checkFoo`, `validateFoo`, and `assertFoo` helpers whose job is to convince TypeScript of a type.

## Decision table

| Situation | Action |
|---|---|
| Typed callback parameter or function result | Let TypeScript infer it |
| Named type needed for an upstream result | Derive it from the producer |
| Tempted to write `value as SomeType` | Stop; assertions override evidence rather than establish it |
| Literal values should retain their narrowest types | Use `as const` |
| Literal must conform without losing specificity | Use `satisfies`, optionally with `as const` |
| Known union inside typed code | Use direct control-flow narrowing, usually on a discriminant |
| Raw request, webhook, config, CLI, file, or queue payload | Accept as `unknown`; parse at the entrypoint |
| Zod schema owns runtime parsing | Derive its TypeScript input/output type |
| Framework already parses and types the value | Reuse that result; do not add a second schema |
| Need a reusable `value is Foo` function | Reconsider the data flow; derive upstream or parse at the boundary |
| Business rule such as eligibility or permissions | A boolean domain predicate is fine; do not present it as a type proof |

## Preferred patterns

### Preserve an upstream type

```ts
const users = await client.users.list();

const activeNames = users
  .filter((user) => user.status === "active")
  .map((user) => user.name);
```

Do not duplicate the client-owned shape or cast its result:

```ts
// Avoid: parallel type plus assertion can drift from the client.
type User = { id: string; name: string; status: string };
const users = (await client.users.list()) as User[];
```

If a stable name is genuinely needed, derive it:

```ts
type ListedUser = Awaited<ReturnType<typeof client.users.list>>[number];
```

Prefer a library's intentional exported type over `ReturnType` when that public type is the actual contract.

### Constrain while retaining inference

```ts
const handlers = {
  created: handleCreated,
  deleted: handleDeleted,
} satisfies Record<EventName, EventHandler>;
```

`satisfies` checks compatibility without replacing the expression's more specific inferred type.

### Treat assertions as harmful, with one value-derived exception

Ordinary `as Type` casting is harmful. TypeScript calls these constructs type assertions because they do not cast, check, or transform the runtime value. Expressions such as `value as User`, `value as unknown as User`, and angle-bracket assertions suppress disagreement between the program's evidence and the programmer's claim. This breaks type flow and can move an error from the assertion site into distant downstream code.

```ts
// Avoid: this neither checks nor transforms the response.
const user = response as User;

// Prefer: retain a trusted producer's type.
const user = await client.users.get(id);

// Or parse unknown external data at its boundary.
const user = UserSchema.parse(response);
```

`as const` is allowed because it works in the opposite direction: it derives a stronger, narrower type from the literal values already present. It prevents literal widening, makes object properties readonly, and turns array literals into readonly tuples; it does not assert that the value has some unrelated domain type.

```ts
const statuses = ["draft", "published"] as const;
// readonly ["draft", "published"]

type Status = (typeof statuses)[number];
// "draft" | "published"

const routes = {
  home: "/",
  settings: "/settings",
} as const satisfies Record<RouteName, `/${string}`>;
```

So the rule is precise: **avoid `as Type`; allow `as const`.**

### Parse external input once

```ts
import * as z from "zod";

const CreateUserInputSchema = z.object({
  email: z.email(),
  displayName: z.string().min(1),
});

type CreateUserInput = z.output<typeof CreateUserInputSchema>;

export async function createUserController(request: Request) {
  const raw: unknown = await request.json();
  const input = CreateUserInputSchema.parse(raw);

  return createUser(input);
}

function createUser(input: CreateUserInput) {
  // No shape checks here. The boundary already established the type.
}
```

Use `safeParse` when the entrypoint must map parse failures into an explicit response. Keep the error translation at the same boundary.

### Narrow typed unions directly

```ts
function messageFor(result: Result) {
  if (result.kind === "failure") {
    return result.error.message;
  }

  return result.value;
}
```

Do not extract a one-use `isFailure(result): result is Failure` helper. Direct narrowing gives TypeScript the evidence without adding an unchecked type claim.

## Reject these patterns

- A Zod schema for data already typed and trusted by an upstream producer.
- An interface that manually mirrors a generated client, schema, ORM model, or function result.
- Any `as Type` assertion used to force compatibility, including double assertions such as `as unknown as Foo`. These bypass evidence instead of creating it.
- A blanket ban on `as` that incorrectly includes `as const`. Const assertions preserve value-derived literal information and are compatible with this principle.
- `isFoo(value): value is Foo` implemented with property checks.
- `asserts value is Foo` used to silence uncertainty.
- Revalidating parsed input in services, repositories, or domain functions.
- Annotating callback parameters that already receive contextual types.
- Returning `boolean` from boundary validation and continuing to carry the original weak type.

Handwritten type predicates are especially risky because TypeScript trusts the declared predicate and cannot generally prove that both its true and false branches are sound.

## Important distinctions

- **Annotations are not assertions.** An annotation asks TypeScript to check an expression against a declared contract; `as Type` asks TypeScript to accept the programmer's claim. Use annotations for intentional public contracts, recursive definitions, overloads, or when inference cannot express the API, but avoid annotations that merely repeat available information.
- **`as const` is the exception, not a loophole.** It may preserve the literal information already present in a value. It must not be replaced with a domain assertion such as `as User`, and it does not validate runtime input.
- **Zod is not the default type system.** It is a runtime parser for trust boundaries. Inside typed code, TypeScript remains the source of truth.
- **External origin and static typing are separate questions.** A generated client type describes a compile-time contract; it does not necessarily validate bytes at runtime. Add Zod only when this application owns the untrusted boundary and no upstream parser establishes the runtime guarantee.
- **Business predicates are not type checkers.** `canPublish(article, actor)` may encode policy. It should return a boolean, not claim `article is PublishableArticle` unless that type relation is genuinely total and required.

## Review workflow

When reviewing TypeScript changes:

1. Trace each new type, schema, cast, and predicate to the value's producer.
2. Reject every ordinary `as Type` assertion; retain `as const` only where it derives useful literal precision from the value.
3. Remove duplicated shapes and preserve or derive the producer's type.
4. Confirm every Zod schema sits at a real trust boundary.
5. Confirm raw external values enter as `unknown` and parsed values leave with schema-derived types.
6. Confirm parsing happens once and downstream code trusts the result.
7. Inline or delete functions created only to check TypeScript types.
8. Run the repository's formatter, tests, and TypeScript check.

## Verification questions

- Could TypeScript infer this from an argument, callback context, return value, or generic relationship?
- Is this named type derived from its authoritative owner?
- Would `satisfies` retain more useful downstream information than this annotation?
- Is this `as` usage the allowed value-derived `as const`, or a harmful claim that the value has some target type?
- Is this actually a runtime trust boundary, or am I validating already-typed internal data?
- Does the parser return a stronger typed value, or only a boolean about the old value?
- After the boundary, can all shape checks disappear?
- Did I introduce a function whose primary purpose is checking a TypeScript type?

See `source.md` for the research basis and `evals/evals.json` for representative application cases.
