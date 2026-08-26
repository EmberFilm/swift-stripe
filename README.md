# swift-stripe

[![CI](https://github.com/EmberFilm/swift-stripe/actions/workflows/ci.yml/badge.svg)](https://github.com/EmberFilm/swift-stripe/actions/workflows/ci.yml)
[![Swift 6.3](https://img.shields.io/badge/swift-6.3-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Stripe API 2026-07-29.dahlia](https://img.shields.io/badge/Stripe%20API-2026--07--29.dahlia-635bff.svg)](https://docs.stripe.com/api/versioning)

A Stripe API client for server-side Swift. Every resource, request type and client is
generated from Stripe's OpenAPI specification — currently API version **2026-07-29.dahlia** —
and checked against it in CI, so the types on your side match the bytes on the wire. Built on
[AsyncHTTPClient](https://github.com/swift-server/async-http-client), `FoundationEssentials`,
and strict Swift 6 concurrency.

```swift
import Stripe

let stripe = StripeClient(configuration: .init(secretKey: secretKey))

let customer = try await stripe.customers.create(
    .init(email: "ada@example.com", name: "Ada Lovelace")
)

let session = try await stripe.checkoutSessions.create(
    .init(
        customer: customer.id,
        lineItems: [.init(price: "price_123", quantity: 1)],
        mode: .subscription,
        successUrl: "https://example.com/welcome"
    )
)
```

## Features

- **The whole API, typed.** One client per resource — `stripe.customers`, `stripe.invoices`,
  `stripe.checkoutSessions`, `stripe.billingPortalSessions`, … — with one method per
  operation: 131 resources, 536 operations.
- **Models that match the wire.** Every field the specification describes, every enum case,
  nothing transcribed by hand. Polymorphic objects are Swift enums:
  `charge.paymentMethodDetails?.details.card?.brand`, `event.data?.object` as
  `.checkoutSession(session)`. A value the package does not know decodes as `.unknown`
  instead of failing the request.
- **Correct by construction.** Requests send the API version the models were generated from;
  writes take idempotency keys and are retried only when they carry one; `metadata: .clear`
  unsets a field the way Stripe expects.
- **Built for servers.** `Sendable` value types, a shared `HTTPClient`, no Foundation beyond
  `FoundationEssentials`, Linux and static Linux (musl) builds.
- **Webhooks, Connect, uploads.** Constant-time signature verification with replay
  protection, `Stripe-Account` on behalf of connected accounts, multipart file uploads.

## Getting started

### Requirements

- Swift 6.3
- macOS 26 or Linux

### Adding the dependency

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/EmberFilm/swift-stripe.git", from: "0.12.0"),
],
targets: [
    .target(name: "App", dependencies: [
        .product(name: "Stripe", package: "swift-stripe"),
    ]),
]
```

### Creating a client

```swift
import Stripe

let stripe = StripeClient(configuration: StripeConfiguration(secretKey: secretKey))
```

`StripeClient` is a `Sendable` value: create one at startup and share it across tasks. It
uses `HTTPClient.shared` unless you pass your own, in which case you own its lifetime:

```swift
let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
let stripe = StripeClient(configuration: configuration, httpClient: httpClient)
// …
try await httpClient.shutdown()
```

`StripeConfiguration` can also be read from a
[swift-configuration](https://github.com/apple/swift-configuration) `ConfigReader`.

## Usage

### Requests and responses

Each operation's request type lives under its resource, with every parameter Stripe
documents and an enum for each enumerated one:

```swift
let intent = try await stripe.paymentIntents.create(
    .init(amount: 2_000, currency: .usd, customer: customer.id, metadata: ["order_id": "ord_123"])
)

let updated = try await stripe.customers.update(id: customer.id, .init(name: "Ada King"))

let invoice = try await stripe.invoices.retrieve(id: "in_123", .init(expand: ["parent.subscription_details.subscription"]))
if let subscription = invoice.parent?.subscriptionDetails?.$subscription {
    print(subscription.status)
}
```

Expandable references decode as the ID, or as the object when the request expanded it: the
property holds the ID and its `$` projection the object.

Operations on a child collection are methods on the owner, named as in Stripe's own SDKs:

```swift
try await stripe.customers.createTaxId(id: customer.id, .init(type: .euVat, value: "DE123456789"))
try await stripe.customers.listPaymentMethods(id: customer.id)
```

### Pagination

List responses are `Stripe.Page<Resource>` with `data` and `hasMore`; page with the cursor:

```swift
var startingAfter: String?
repeat {
    let page = try await stripe.customers.list(.init(limit: 100, startingAfter: startingAfter))
    process(page.data)
    startingAfter = page.hasMore ? page.data.last?.id : nil
} while startingAfter != nil
```

Search endpoints return `Stripe.SearchPage`, which paginates by `nextPage` token.

### Clearing a field

Stripe unsets a parameter that is posted empty. Parameters that allow it are
`Stripe.Clearable`: leave the property `nil` to leave the field alone, set it as usual, or
pass `.clear`.

```swift
try await stripe.customers.update(id: customer.id, .init(metadata: .clear, shipping: .clear))
```

### Errors

Failures are `StripeClientError`:

| Case | Meaning |
|---|---|
| `.api(status:error:requestID:)` | Stripe returned an error — card declined, invalid parameter, … |
| `.unexpectedStatus(status:body:requestID:)` | A non-2xx response that was not a Stripe error |
| `.decoding(underlying:body:)` | A 2xx body that did not decode |
| `.invalidURL(_:)` | The request could not be built |

```swift
do {
    try await stripe.paymentIntents.confirm(id: intent.id)
} catch StripeClientError.api(_, let error, let requestID) {
    logger.error("Stripe: \(error.message ?? "")", metadata: ["request_id": "\(requestID ?? "-")"])
}
```

Every case carries Stripe's `Request-Id` when the response had one.

### Idempotency and retries

Every write takes an idempotency key. Stripe replays the original response for a repeated
key, so a retried create returns the object it created the first time:

```swift
let customer = try await stripe.customers.create(
    .init(email: "ada@example.com"),
    idempotencyKey: "customer-\(userID)"
)
```

Requests are retried on `429` and `5xx` with exponential backoff (`maxRetries`, default 2).
Reads are always retried; a write is retried only when it carries a key, so an unkeyed write
that fails surfaces the error rather than risking a second charge. `timeout` (default 60 s)
applies per attempt.

### Stripe Connect

Set `connectedAccount` to act on behalf of a connected account; it is sent as
`Stripe-Account` on every request. `StripeConfiguration` is a value, so a per-account client
is a cheap copy sharing the same `HTTPClient`:

```swift
var configuration = platformConfiguration
configuration.connectedAccount = "acct_123"
let connected = StripeClient(configuration: configuration, httpClient: httpClient)
```

### Webhooks

Verify against the raw request body — re-encoding the JSON changes the bytes:

```swift
let event = try StripeWebhook.constructEvent(
    payload: rawBody,
    signatureHeader: request.headers["Stripe-Signature"].first ?? "",
    secret: webhookSecret
)

switch event.data?.object {
case .checkoutSession(let session): try await fulfil(session)
case .subscription(let subscription): try await reconcile(subscription)
default: break
}
```

Signatures are compared in constant time, timestamps are checked against a five-minute
tolerance (`tolerance:`), and multiple `v1` signatures are accepted so secrets can rotate.
`Event.Type` and `Event.Object` cover every event and object Stripe documents; a newer one
decodes as `type == nil` (with `rawType` set) or `.unknown(type:)` rather than rejecting the
delivery.

### File uploads

```swift
let file = try await stripe.files.create(
    .init(purpose: .disputeEvidence),
    file: .init(data: receipt, filename: "receipt.pdf", contentType: "application/pdf")
)
let pdf: Data = try await stripe.quotes.pdf(id: "qt_123")
```

Uploads and downloads go to `files.stripe.com` (`filesBaseURL`).

### Testing

Every resource client is a protocol, so a test double needs no network:

```swift
struct StubCustomers: CustomersAPI {
    func create(
        _ request: Stripe.Customers.Customer.Create.Request, idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer {
        .init(id: "cus_stub", object: "customer")
    }
    // …
}
```

To exercise the real stack, point a client at a local server and assert on the bytes it
receives; `Tests/StripeTests/TestHTTPServer.swift` is a small NIO server that records
requests and replays scripted responses.

## How the package is built

The models, request types and clients are generated from Stripe's
[OpenAPI specification](https://github.com/stripe/openapi) — one spec commit, pinned in CI:

```bash
Scripts/generate-models.py spec3.sdk.json      # Sources/Stripe/Models
Scripts/generate-requests.py spec3.sdk.json    # Sources/Stripe/Requests and Sources/Stripe/Clients
```

CI regenerates and fails if anything on disk differs, measures each model against the spec
field by field, and decodes a fixture with every field populated for every resource.
Requests send that version — `2026-07-29.dahlia`, available as `Stripe.generatedAPIVersion` — as
`Stripe-Version`, so a field Stripe has moved between versions is where the model expects it
whatever the account's default; pass `apiVersion:` to override it.

Hand-written code is confined to the request engine (`Core/`), webhook verification
(`Webhooks/`), the property wrappers and shared types (`Shared/`), and `Event`'s lenient
decoding. Anything Stripe adds to the specification is a regenerate away.

## Development

```bash
swift build
swift test
Scripts/generate-models.py spec3.sdk.json --check
Scripts/generate-requests.py spec3.sdk.json --check
```

[CLAUDE.md](CLAUDE.md) describes the architecture, the generator's rules, and the conventions
contributions follow.

## License

Apache 2.0 — see [LICENSE](LICENSE). The model types originated in
[swift-stripe-standard](https://github.com/swift-standards/swift-stripe-standard) and
[stripe-kit](https://github.com/vapor-community/stripe-kit); see [NOTICE](NOTICE).
