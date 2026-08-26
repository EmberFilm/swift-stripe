# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Overview

`swift-stripe` is a Stripe REST API client for server-side Swift. One product
(`Stripe`) containing the models, request/response payloads, and the client.
Swift 6.3 toolchain, language mode 6, macOS 26+ / Linux.

## Commands

```bash
swift build                          # build the library
swift build --build-tests            # build library + tests (fastest full check)
swift test                           # run everything (47 tests, 7 suites)
swift test --filter "Stripe webhook signatures"   # one suite, by its @Suite name
swift test --filter "a valid signature verifies"  # one test, by its @Test name
```

Tests are hermetic: no network, no Stripe credentials. CI runs the same two
commands on macOS 26 and in the `swift:6.3` Linux container
(`.github/workflows/ci.yml`).

## Architecture

A request flows:

```
StripeClient          value type, holds one client per resource
  → CustomersClient   (Clients/) typed methods, path strings, nothing else
    → StripeAPI       (Core/) build → sign → send → retry → decode
      → StripeFormEncoder   Encodable to Stripe's bracketed form encoding
      → AsyncHTTPClient     used directly; there is no transport protocol
      → JSONDecoder         .convertFromSnakeCase, .secondsSince1970
```

```
Sources/Stripe/
├── Core/        StripeClient, StripeAPI, StripeConfiguration,
│                StripeClientError, StripeFormEncoder
├── Clients/     one typed client per resource
├── Webhooks/    StripeWebhook signature verification
├── Models/      Stripe object types           (125 files)
├── Requests/    request & response payloads    (98 files)
└── Shared/      the Stripe namespace, Expandable, Interval
```

Key invariants:

- **`StripeAPI` does not own its `HTTPClient`.** It defaults to
  `HTTPClient.shared` and never shuts one down. Keep it that way; lifetime is
  the caller's.
- **`makeRequest` and `decode` are pure and internal.** They exist so
  request-building and every status-code path are testable without I/O. Don't
  fold them back into `perform`.
- **Everything is `Sendable`** and builds under strict concurrency. No
  `@unchecked`.

## Conventions

### Coding keys and the decoder

Models declare plain camelCase properties and rely on
`JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase`. **Do not add snake_case
`CodingKeys` raw values** (`case invoicePrefix = "invoice_prefix"`) — the
strategy already handles them, and the redundant pairs were deliberately removed.
`CodingKeys` enums *without* raw values are fine and still exist where a type has
a custom `init(from:)`.

The encode side mirrors this: `StripeFormEncoder` snake-cases keys itself, so
request payloads follow the same rule.

If a field decodes to `nil` unexpectedly, check the property spelling against
Stripe's wire name — three such defects were inherited from the vendored sources
and corrected (see the Wire format section of README.md).

### File naming

Model and request files are named after the namespace path of their principal
type: `Stripe.Billing.Subscription.swift`,
`Stripe.Customers.API.swift`. Follow that when adding files under `Models/` or
`Requests/`.

### Imports

Every file opens with the conditional Foundation import:

```swift
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
```

### Identifiers

Resource IDs are `String` typealiases (`Stripe.Customers.Customer.ID`). Don't
reintroduce wrapper types.

### Adding a resource client

1. Add `Sources/Stripe/Clients/<Resource>Client.swift` with a
   `public protocol <Resource>API: Sendable` and a `struct <Resource>Client`
   holding a `StripeAPI`.
2. Wire it into `StripeClient`: a `public let` property plus a line in `init`.
3. Reuse the modelled request/response types from `Requests/`; add them there if
   the endpoint isn't covered yet.
4. Use `api.send(_:_:body:)` for writes and `api.list(_:parameters:)` for list
   endpoints — Stripe wants list filters in the query string, not the body.
5. Give each write an `idempotencyKey: String?` parameter, forward it to
   `api.send`, and add the unkeyed overload to the protocol extension at the
   foot of the file.

The protocol is the mocking seam. There is no transport abstraction to stub.

### Tests

swift-testing (`@Suite` / `@Test` / `#expect` / `#require`), not XCTest.
`@testable import Stripe`.

`Tests/StripeTests/TestHTTPServer.swift` is a local NIO server that records
requests and replays scripted responses; `IntegrationTests.withServer` wires a
client to it. Use it when the assertion is about bytes on the wire. For pure
logic, call `StripeAPI.makeRequest` / `StripeAPI.decode` directly.

Retry tests really sleep through the backoff — keep `maxRetries: 0` in tests
that aren't about retrying.

## Portability

Every file imports `FoundationEssentials` when it is available and `Foundation`
otherwise. **FoundationEssentials is a strict subset**, and a consumer
cross-compiling with the static Linux SDK gets it — so anything Foundation-only
compiles on macOS and fails there. Already hit once each:

- no `CharacterSet` (percent-encoding and validation are written over UTF-8
  bytes / `Character` instead);
- `pow` resolves to the `Decimal` overload, which `Duration.seconds` rejects;
- `ByteBuffer(data:)` needs `NIOFoundationCompat`; `ByteBuffer(bytes:)` is
  NIOCore and takes `Data` directly. Prefer it.

The `musl` CI job builds with the static SDK and is the only thing that catches
this. Run it locally with
`swift build --swift-sdk aarch64-swift-linux-musl`.

### Stack frames

`Stripe.Events.Event.Object` is an `indirect` enum whose decode is split across small
`@inline(never)` `decodeGroupN` helpers. After the generated Charge (spec-complete, larger than
the hand one) a full `charge.succeeded` decodes within 128 KiB on aarch64-musl but not 64 KiB,
so the margin is real but not generous; re-measure if a payload type grows.

A direct enum with 54 large payloads made the compiler reserve one frame sized for all of
them: `init(from:)` was 47 KB in release (311 KB in debug) and `==` was 473 KB. musl gives a
pthread a **128 KiB** stack and NIO runs channel handlers on those threads, so a
statically-linked Linux build segfaulted — exit 139, no Swift error — on any webhook event
carrying a `data.object`. glibc and Darwin give 8 MiB and never showed it, tests included.

Measured on aarch64-musl release, decoding one event on a thread of the given stack size:

| | 128 KiB | 64 KiB |
|---|---|---|
| neither | segfault | segfault |
| **`indirect` only** | **ok** | segfault |
| split only | segfault | segfault |
| both | ok | ok |

**`indirect` is the fix**; the split on its own does nothing. The split is kept because
`indirect` alone clears 128 KiB with no headroom, and the real call chain sits deeper than a
bare decode — Hummingbird and NIO frames are already on the stack under it.

To re-measure, build a small executable that decodes an event on a `Thread` with an explicit
`stackSize` and run it on the target. Per-symbol frames come from disassembling the release
build and summing `sub sp, sp, #N` (including `, lsl #12`).

`encode(to:)` is still ~41 KB — fine for the encode path, which nothing hot uses, but do not
let the decode path regress to match it.

## Behaviour worth knowing before changing it

- **Retries**: `429` and `5xx` except `501`, exponential backoff (0.5s, 1s, 2s,
  … capped at 8s), `maxRetries` attempts *after* the first — but only for
  requests `StripeAPI.isSafeToRetry` accepts: reads, and writes carrying an
  `Idempotency-Key`. An unkeyed write is never retried; don't loosen that
  without a reason, it is what stops a retried `POST` creating a second charge.
- **Idempotency keys** are an optional trailing `idempotencyKey: String?` on
  every write. It is a *protocol requirement*; the previous unkeyed arity lives
  on as a protocol extension that passes `nil`. Conforming doubles implement the
  keyed form.
- **`timeout` is per attempt**, not per call.
- **Webhooks verify against raw bytes.** Never decode-and-re-encode a payload
  before verification. Signature comparison is constant-time; multiple `v1`
  signatures are accepted for secret rotation.
- **Configuration is taken as given** — no range checking, and an unconvertible
  value falls back to the default rather than throwing. This is deliberate
  (commit `deb8c27`); don't add validation back without asking.
- **Config keys are read unscoped** (`secretKey`, not `stripe.secretKey`) so the
  caller chooses the namespace. Don't scope inside the library.

## Generated models

131 of the spec's 137 root resources are generated from Stripe's OpenAPI spec; do not edit the
files under `Sources/Stripe/Models/Generated/` by hand — regenerate them. Generated files carry a
`Generated.` prefix because SwiftPM requires unique basenames per target and a request file
(`Stripe.ConfirmationToken.swift`) can share a model's name:

```bash
curl -sSLO https://raw.githubusercontent.com/stripe/openapi/<pinned commit>/openapi/spec3.sdk.json
Scripts/generate-models.py spec3.sdk.json          # all generated resources
Scripts/generate-models.py spec3.sdk.json --only price --keep   # one, leaving the rest
```

Each resource's former hand file survives as `*.Retained.swift`, holding only the nested types
the request layer still names and the generator spells differently (`Price.Tier`,
`Subscription.PaymentBehavior`, `Session.PaymentMethod.Options`). A nested type that exists in
both is the generated one; the retained file must not redeclare it.

To cut a further resource over: add it to `RESOURCES` and `RESOURCE_TYPES`, generate it with
`--only … --keep`, run `Scripts/cutover.py <hand file> <struct> <namespace> <generated file>`,
then `Scripts/cutover.py --sweep <namespace> <generated file>` for sibling files that extend a
nested type the generator now declares, and fix the request layer's references the compiler
reports. `Scripts/batch-cutover.py spec --max-refs N` does all of that for every hand resource
the request layer references at most N times. The collision set is computed, not listed.

Still hand-written: `event` (lenient union decoding the generator does not express) and
`payment_source` (a union). Everything else is generated.

## Generated requests

Every API operation's request type is generated too, by `Scripts/generate-requests.py`, into
`Sources/Stripe/Requests/Generated/`. Operations hang off the resource's Swift type, named by
the spec's `x-stripeOperations`: `Stripe.Customers.Customer.Create.Request`,
`Stripe.Checkout.Session.Create.Request`, `Stripe.Billing.Invoice.FinalizeInvoice.Request`.
Path parameters are not in the request — they are the client method's arguments. Each
operation also has a `Response` typealias: the resource, `DeletedObject<Resource>`, or
`Stripe.Page<Resource>` / `Stripe.SearchPage<Resource>` for list and search endpoints.

An operation on a child collection is named on its owner the way Stripe's own SDKs name it:
`Customer.CreateTaxId`, `Customer.ListBalanceTransactions`, `Account.RetrieveCapability`.
A resource with the same operation on two paths keeps the parameterised one and names the
account-level one `RetrieveCurrent` (`/v1/account`).

Parameter rules that are not obvious from the types: `integer | "now"`-style unions become a
nested enum with `.value(_:)` and the keyword cases; `created`-style filters are
`Stripe.RangeQuery` (`.exactly(_:)` or `.range(gt:gte:lt:lte:)`); the empty-string "unset"
alternative Stripe accepts is not modelled; an object-or-ID parameter is the ID; a `number`
is `Decimal`, which `StripeFormEncoder` renders as decimal text. The timezone list on report
runs is a `String`, not a 600-case enum.

There is no hand-written request layer left except `Requests/WebElements/`, which describes
Stripe.js element options rather than an API surface.

## Generated clients

The same generator emits one client per resource into `Sources/Stripe/Clients/Generated/`:
a `<Resources>API` protocol (so tests can substitute a double) and a `<Resources>Client`
struct over the shared `StripeAPI`, reachable from `StripeClient` as a computed property —
`stripe.customers`, `stripe.checkoutSessions`, `stripe.billingPortalSessions`, `stripe.balance`.
Method names come from `x-stripeOperations` (`create`, `retrieve`, `listTaxIds`,
`finalizeInvoice`); path parameters are arguments — `id:` when there is one,
`(customer:id:)` when nested; a write takes `idempotencyKey:` with a no-key convenience, and an
operation whose request has no required parameter has a request-less convenience
(`stripe.balance.retrieve()`, `stripe.checkoutSessions.expire(id:)`). Three operations are
not on any client: the quote PDF (binary), the file upload (multipart), and
`POST /v1/customers/{customer}/sources/{id}` (a union response).

The client name is the resource name pluralised (`CheckoutSessions`, `TaxIds`); a resource with
neither `create` nor `list` nor a path parameter stays singular (`Balance`, `TaxSettings`).
`StripeClient` itself is hand-written and holds only the `api`; `portalSessions` is a deprecated
alias of `billingPortalSessions`.

Rules the generator enforces, and why:

- `format: currency` is `Stripe.Currency`; callers rely on the enum.
- A `$ref` with a `type: string` alternative is `@Expandable`; Stripe's `x-expandableFields`
  lists every object-valued property, so membership alone is not the signal.
- A full resource embedded in another is `@Boxed` — `PaymentIntent → ApiErrors → PaymentIntent`
  is a cycle a struct cannot contain.
- A root resource always gets `typealias ID`, but `id` is optional where the spec says so; an
  upcoming-invoice preview has none.
- Mapped hand types are named as they resolve from inside `Stripe`; there is no
  module-qualified spelling, because inside the module the root enum shadows the module name.
  A nested namespace that shadows a top-level name (`Stripe.Customers.CashBalance`) is handled
  by mapping to a type that lives under the enum.
- `event` is retained by hand; see README.

`Tests/StripeTests/FixtureDecodingTests.swift` decodes every generated resource from a fixture
with every spec field populated (`Scripts/spec-fixture.py`). A hand type the generated ones
reference that rejects a spec-valid value fails there — regenerate the enum's cases from the
spec rather than adding the one value that failed.

## Measuring model drift

The models are a vendored snapshot, not a mirror. `Scripts/model-drift.py` compares them against
Stripe's OpenAPI spec and prints, per resource, how many fields are missing (dropped on decode)
and how many are stale (always nil):

```bash
curl -sSLO https://raw.githubusercontent.com/stripe/openapi/master/openapi/spec3.sdk.json
Scripts/model-drift.py spec3.sdk.json
```

Use `spec3.sdk.json`, not `spec3.json`: it carries `x-expandableFields` (which `@ExpandableOf`
encodes by hand), `x-stripeResource`/`x-stripeOperations`, and expresses union fields such as
`charge.payment_method_details` as `anyOf`.

Run it before adding a field by hand — the answer is often that several neighbouring fields are
missing too.

CI runs it as a gate against a spec pinned by commit (`STRIPE_OPENAPI_COMMIT` in
`.github/workflows/ci.yml`). To take a newer spec: bump the pin, run the tool, model or
acknowledge every gap it reports, and land all of that in one change. Adding a field is not
done until it is decoded in `Tests/StripeTests/AddedFieldDecodingTests.swift` — see the
blind spot noted in the script.

## Documentation

README.md documents the public API, including the configuration key table and
the retry/webhook semantics. Its code snippets are **not** compile-checked by
the test suite — when changing public API, update the README by hand and verify
the snippets still type-check.

## Attribution

Model types derive from swift-stripe-standard (Apache 2.0) and, before it,
stripe-kit (MIT). Keep `NOTICE` accurate when vendored sources change; it is
part of the Apache 2.0 obligations.
