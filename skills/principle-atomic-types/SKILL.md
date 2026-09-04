---
name: principle-atomic-types
description: "Apply when writing or reviewing TypeScript application functions, module APIs, dependency injection, services, use cases, controllers, or domain logic. Keep application types local and structural: never export type aliases, never declare interfaces, give every function only the smallest invariant-preserving values and capabilities required by its own work and its dependencies, and organize code as a pure functional core with explicit effects at the boundary."
metadata:
  origin_title: "Atomic TypeScript application boundaries"
  origin_author: "dakdevs; Microsoft TypeScript"
  origin_url: "https://www.typescriptlang.org/docs/handbook/type-compatibility"
  origin_note: "An opinionated application-code policy informed by TypeScript's structural typing, inference, function types, and type derivation; sources and adaptations are documented in source.md."
---

# Atomic TypeScript Types

## Prime directive

**Export behavior, not type declarations. Pass the smallest values and capabilities that perform the work. Keep the core pure and every dependency explicit.**

In authored TypeScript application code:

1. Never export a `type` declaration.
2. Never declare an `interface`.
3. Never pass a whole object, service, context, or dependency bag when the function and its callees need only part of it.
4. Prefer pure functions. Isolate unavoidable effects in thin boundary functions whose required capabilities are explicit inputs.

These are deliberate house rules, not claims that TypeScript requires this style.

## Vocabulary

- **Atomic input:** the smallest semantically meaningful, invariant-preserving value or capability needed by a function's own logic or forwarded to one of its dependencies. Atomic does not mean JavaScript primitive.
- **Capability:** a narrowly typed function that performs one required effect, such as loading one projection or sending one message.
- **Application type:** a type used to implement one deployable application. It is not a deliberately published package contract or third-party declaration.
- **Value API:** an exported function, constant, parser, or schema whose type travels with the value through inference.
- **Dependency bag:** a broad object such as `Services`, `Context`, `Deps`, a client container, or an application object that exposes more operations than a function uses.
- **Pure functional core:** deterministic transformations whose results depend only on their inputs and that do not mutate inputs or perform observable effects.
- **Effect boundary:** a thin adapter that performs I/O, time, randomness, persistence, environment access, or framework interaction using explicit values and capabilities.

## Non-negotiable type rules

### Do not export application types

Reject all authored application exports of type-only declarations, including:

```ts
export type CreateUserInput = { email: string };
export interface UserRepository { /* ... */ }
export { type User } from "./user";
```

Export runtime values instead and let TypeScript carry their types:

```ts
export const normalizeEmail = (email: string) => email.trim().toLowerCase();

export const createUser = async (
  email: string,
  insertUser: (email: string) => Promise<{ id: string; email: string }>,
) => insertUser(normalizeEmail(email));
```

When another module genuinely needs a name, derive a local alias from the value owner:

```ts
import { createUser } from "./create-user";

type CreatedUser = Awaited<ReturnType<typeof createUser>>;

const indexUser = (user: CreatedUser) => `${user.id}:${user.email}`;
```

Do not create a shared `types.ts`, DTO barrel, or type-only re-export to make the alias reusable. Prefer direct value imports, contextual typing, and local derivation with `typeof`, `Parameters`, `ReturnType`, `Awaited`, indexed access, or a schema library's inference utility.

### Do not use interfaces

Do not declare `interface` anywhere in authored code governed by this skill. Use, in priority order:

1. inference from an existing value;
2. an inline structural type at the function that consumes it;
3. a local, unexported `type` alias when the shape is recursive, repeated locally, or materially clearer when named.

```ts
const summarize = (user: { id: string; displayName: string }) => ({
  id: user.id,
  label: user.displayName.trim(),
});
```

Do not rewrite generated or third-party declarations merely because they contain interfaces. Consume their value and type APIs as external inputs; the prohibition applies to declarations authored under this policy.

## Atomic function boundaries

For every function, trace its body and every dependency it calls, then construct the smallest input boundary that satisfies that transitive work.

1. List values read directly by the function.
2. List values forwarded to dependencies.
3. List effects the function invokes.
4. Accept exactly those values and narrow capabilities—nothing else.
5. Remove every parameter or property the function can succeed without.

### Prefer precise data

```ts
// Avoid: the function can observe and become coupled to the entire object.
const greetingFor = (user: User) => `Hello, ${user.profile.displayName}`;

// Prefer: the complete dependency is one meaningful value.
const greetingFor = (displayName: string) => `Hello, ${displayName}`;
```

When several named values form one call boundary, an inline object is acceptable if it includes only required fields:

```ts
export const calculateTotal = ({
  lines,
  discountCents,
}: {
  lines: readonly { unitPriceCents: number; quantity: number }[];
  discountCents: number;
}) =>
  Math.max(
    0,
    lines.reduce(
      (total, line) => total + line.unitPriceCents * line.quantity,
      0,
    ) - discountCents,
  );
```

Do not mechanically split an invariant-bearing value into primitives. A validated URL, date interval, money value, parsed command, or discriminated union can be atomic when splitting it would discard meaning or permit invalid combinations. Atomicity is about dependency surface, not parameter count.

### Prefer precise capabilities

```ts
// Avoid: broad ambient authority.
const welcomeUser = async (user: User, services: Services) => {
  await services.mailer.send(user.email, "Welcome");
  await services.database.users.markWelcomed(user.id);
};

// Prefer: only the values and effects required by this use case.
export const welcomeUser = async (
  userId: string,
  email: string,
  sendEmail: (email: string, subject: string) => Promise<void>,
  markWelcomed: (userId: string) => Promise<void>,
) => {
  await sendEmail(email, "Welcome");
  await markWelcomed(userId);
};
```

Do not pass repositories, SDK clients, loggers, clocks, configuration objects, framework requests, or service containers into core functions when one projected value or narrow operation is sufficient.

## Pure functional organization

Separate decisions from effects:

```ts
const welcomeMessage = (displayName: string) => ({
  subject: "Welcome",
  body: `Hello ${displayName}`,
});

export const sendWelcome = async (
  email: string,
  displayName: string,
  sendEmail: (
    email: string,
    message: { subject: string; body: string },
  ) => Promise<void>,
) => sendEmail(email, welcomeMessage(displayName));
```

Apply these rules:

- Pure functions do not read environment variables, clocks, randomness, mutable module state, singletons, globals, or framework context. Pass the resulting value in.
- Pure functions do not mutate arguments. Return a new value.
- Model domain operations as functions and data, not stateful classes or methods that depend on `this`.
- Keep I/O orchestration thin. Move calculations, decisions, formatting, and state transitions into pure local functions.
- Inject an effect as the narrowest callable signature, not as a class, repository object, or generic container.
- Return useful values or explicit result data. Do not communicate through hidden mutation.
- Keep sequencing explicit. Parallelize effects only when ordering is not part of the behavior.

Pure does not mean every application function is synchronous or effect-free. It means effects are pushed to visible boundaries and the maximum practical amount of logic remains deterministic.

## Decision table

| Situation | Action |
|---|---|
| Application module wants to export a named input or result type | Export the value API; infer or derive a local type at the consumer |
| An object shape needs a name | Use a local unexported `type` only when naming adds real value |
| An interface seems convenient | Use inference, an inline structural type, or a local type alias |
| Function receives a domain entity but reads two fields | Pass the two meaningful values or an exact inline projection |
| Function receives `Context`, `Services`, or `Deps` | Replace it with the exact values and callable capabilities used transitively |
| Function reads time, randomness, configuration, or environment | Resolve it at the boundary and pass the value in |
| Function performs calculation and I/O | Extract the calculation into a pure function; leave thin effect orchestration |
| Several fields must remain valid together | Keep the validated/invariant-bearing value intact |
| External library exports an interface | Consume it; do not duplicate or rewrite the external declaration |
| Authored package intentionally publishes a public type contract | Treat it as a library API decision, not application code; do not silently apply the no-export rule across that boundary |

## Reject these patterns

- Any `export type`, exported interface, type-only re-export, or application types barrel.
- Any authored `interface` declaration.
- Shared `types.ts`, `models.ts`, or `dto.ts` files whose purpose is exporting application shapes.
- Whole entities passed to functions that consume only a projection.
- Generic `Context`, `Services`, `Dependencies`, `Options`, or repository objects passed for one or two operations.
- Dependency injection containers, service locators, singleton access, or ambient framework state inside domain logic.
- Classes used primarily to bundle functions with dependencies or mutable state.
- Functions that read hidden time, randomness, configuration, environment, or mutable module state.
- Mutating input objects and returning `void` when an explicit next value can be returned.
- Artificial primitive decomposition that destroys a validated invariant or couples callers to construction details.
- Creating exported types for tests. Exercise value APIs and derive local test-only types only when inference is insufficient.

## Review workflow

When reviewing TypeScript application code:

1. Find every exported type-only declaration and replace its consumers with inference or local derivation from an exported value.
2. Find every authored interface and replace it with inference, an inline structural type, or a local unexported alias.
3. For each function, mark every parameter property actually read or forwarded.
4. Shrink whole-object parameters to exact values or invariant-preserving projections.
5. Replace broad dependency objects with exact callable capabilities.
6. Trace hidden reads of state, time, randomness, environment, configuration, SDK singletons, and framework context.
7. Move deterministic logic into pure functions and leave a thin explicit effect boundary.
8. Confirm inputs are not mutated and outputs carry the result explicitly.
9. Run the repository's formatter, lint, tests, and TypeScript check.

## Verification questions

- Does any authored application module export a type alias, interface, or type-only re-export?
- Does any authored file declare an interface?
- Can a consumer obtain the needed type through inference or local derivation from a value API?
- Does each function accept exactly the data it reads and the data its dependencies require?
- Could any whole object become a scalar, exact projection, or invariant-bearing value?
- Could any service object become one or more narrow function capabilities?
- Are time, randomness, configuration, environment, and I/O visible at the boundary?
- Is deterministic logic separated from effect execution?
- Are inputs immutable and results returned explicitly?
- Did “atomic” accidentally become “primitive-only” and destroy a real invariant?

See `source.md` for the research basis and `evals/evals.json` for representative application cases.
