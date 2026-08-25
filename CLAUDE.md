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

## Documentation

README.md documents the public API, including the configuration key table and
the retry/webhook semantics. Its code snippets are **not** compile-checked by
the test suite — when changing public API, update the README by hand and verify
the snippets still type-check.

## Attribution

Model types derive from swift-stripe-standard (Apache 2.0) and, before it,
stripe-kit (MIT). Keep `NOTICE` accurate when vendored sources change; it is
part of the Apache 2.0 obligations.
