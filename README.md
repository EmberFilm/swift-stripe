# swift-stripe

[![CI](https://github.com/EmberFilm/swift-stripe/actions/workflows/ci.yml/badge.svg)](https://github.com/EmberFilm/swift-stripe/actions/workflows/ci.yml)
[![Swift 6.3](https://img.shields.io/badge/swift-6.3-orange.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

A Stripe API client for server-side Swift, built on `AsyncHTTPClient` and strict
Swift 6 concurrency.

```swift
let stripe = StripeClient(
    configuration: StripeConfiguration(secretKey: secret, apiVersion: "2024-06-20")
)

let customer = try await stripe.customers.create(
    .init(email: "ada@example.com", name: "Ada Lovelace")
)
```

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick start](#quick-start)
- [Configuration](#configuration)
- [Resource clients](#resource-clients)
- [Error handling](#error-handling)
- [Idempotency](#idempotency)
- [Retries and timeouts](#retries-and-timeouts)
- [Stripe Connect](#stripe-connect)
- [Webhooks](#webhooks)
- [Testing](#testing)
- [Project layout](#project-layout)
- [Wire format](#wire-format)
- [Operational guidance](#operational-guidance)
- [Status](#status)
- [License](#license)

## Requirements

| | |
|---|---|
| Toolchain | Swift 6.3 (`swift-tools-version: 6.3`, language mode 6) |
| Platforms | macOS 26+, Linux |
| Runtime | A Stripe account and a secret API key |

Direct dependencies are `swift-server/async-http-client`, `apple/swift-crypto`,
and `apple/swift-configuration`. Resolving the package clones 22 repositories in
total, all of them `apple/*` or `swift-server/*` and all tagged — a Vapor or
Hummingbird application already links most of them.

## Installation

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/EmberFilm/swift-stripe", from: "0.1.0")
]

.target(
    name: "App",
    dependencies: [
        .product(name: "Stripe", package: "swift-stripe")
    ]
)
```

The package vends a single product, `Stripe`, containing the models, the
request/response payloads, and the client.

## Quick start

```swift
import Stripe

let stripe = StripeClient(
    configuration: StripeConfiguration(
        secretKey: ProcessInfo.processInfo.environment["STRIPE_SECRET_KEY"]!,
        apiVersion: "2024-06-20"
    )
)

let intent = try await stripe.paymentIntents.create(
    .init(
        amount: 2_000,
        currency: .usd,
        customer: customer.id,
        metadata: ["order_id": "ord_123"]
    )
)
```

### HTTP client lifetime

`StripeClient` neither owns nor shuts down its `HTTPClient`. It defaults to
`HTTPClient.shared`, which lives for the process. Pass your own to share a
connection pool with the rest of the application, and shut that one down
yourself:

```swift
let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
let stripe = StripeClient(configuration: configuration, httpClient: httpClient)
// ...
try await httpClient.shutdown()
```

`StripeClient` is a `Sendable` value type — construct one at application start
and share it freely across tasks.

## Configuration

`StripeConfiguration` can be built directly or read from a
[swift-configuration](https://github.com/apple/swift-configuration) `ConfigReader`.

```swift
import Configuration

let config = ConfigReader(provider: EnvironmentVariablesProvider())
let stripe = StripeClient(
    configuration: try StripeConfiguration(config: config.scoped(to: "stripe"))
)
```

Keys are read **unscoped** — `secretKey`, not `stripe.secretKey` — following
swift-configuration's guidance for libraries: the caller chooses the namespace,
so this package composes with others reading from the same reader. Scoping to
`stripe`, as above, is what turns `secretKey` into `STRIPE_SECRET_KEY` under the
environment provider.

| Key | Environment variable | Type | Required | Default |
|---|---|---|---|---|
| `secretKey` | `STRIPE_SECRET_KEY` | string (secret) | yes | — |
| `baseURL` | `STRIPE_BASE_URL` | string | no | `https://api.stripe.com` |
| `apiVersion` | `STRIPE_API_VERSION` | string | no | account default |
| `connectedAccount` | `STRIPE_CONNECTED_ACCOUNT` | string | no | none |
| `maxRetries` | `STRIPE_MAX_RETRIES` | int | no | `2` |
| `timeoutSeconds` | `STRIPE_TIMEOUT_SECONDS` | int | no | `60` |

`secretKey` is read with `isSecret: true`, so access reporters such as
`AccessLogger` redact it.

Values are taken as given: nothing is range-checked, and a value the reader
cannot convert to the expected type falls back to the default rather than
raising. Two consequences worth knowing:

- a fractional `timeoutSeconds` such as `12.5` is not an `Int`, so it reads back
  as `60`;
- `baseURL` goes through `URL(string:)`, which accepts a value with no scheme
  and fails later, when a request is sent.

The memberwise initializer takes every value explicitly, so swift-configuration
is optional in practice even though it is a package dependency.

## Resource clients

Typed clients hang off `StripeClient`, one property per resource:

```swift
stripe.customers        // any CustomersAPI
stripe.paymentIntents   // any PaymentIntentsAPI
stripe.checkoutSessions // any CheckoutSessionsAPI
stripe.products         // any ProductsAPI
stripe.prices           // any PricesAPI
stripe.subscriptions    // any SubscriptionsAPI
stripe.portalSessions   // any PortalSessionsAPI
```

Each is a protocol, which is also the seam for test doubles — see
[Testing](#testing).

### Endpoints without a typed client

Every other Stripe endpoint is reachable through `stripe.api`, using the request
and response types the package already models:

```swift
let payouts: Stripe.Payouts.List.Response = try await stripe.api.list(
    "v1/payouts",
    parameters: Stripe.Payouts.List.Request(limit: 10)
)

let payout: Stripe.Payouts.Payout = try await stripe.api.send(
    .POST,
    "v1/payouts",
    body: Stripe.Payouts.Create.Request(amount: 5_000, currency: .usd)
)
```

`send` form-encodes into the request body; `list` form-encodes into the query
string, which is what Stripe's list endpoints expect.

### Pagination

List responses expose `hasMore` and `data`. Page with the cursor parameters:

```swift
var startingAfter: String?
repeat {
    let page = try await stripe.customers.list(.init(limit: 100, startingAfter: startingAfter))
    process(page.data)
    startingAfter = page.hasMore ? page.data.last?.id : nil
} while startingAfter != nil
```

## Error handling

Failures surface as `StripeClientError`:

| Case | Meaning |
|---|---|
| `.api(status:error:requestID:)` | Non-2xx with a decodable Stripe error body |
| `.unexpectedStatus(status:body:requestID:)` | Non-2xx whose body was not a Stripe error |
| `.decoding(underlying:body:)` | A 2xx body that did not decode into the expected type |
| `.invalidURL(_:)` | The request could not be built from the given path |

```swift
do {
    let intent = try await stripe.paymentIntents.create(request)
} catch let error as StripeClientError {
    switch error {
    case .api(let status, let stripeError, let requestID):
        logger.error("Stripe \(status): \(stripeError.message ?? "")", metadata: [
            "request_id": .string(requestID ?? "none"),
            "code": .string(stripeError.code?.rawValue ?? "none"),
        ])
    default:
        logger.error("\(error)")
    }
}
```

Every case carries Stripe's `Request-Id` where the response had one — quote it
when contacting Stripe support. `StripeClientError` conforms to
`CustomStringConvertible`, and its description truncates response bodies to 500
characters so log lines stay bounded.

## Idempotency

Every write takes an optional idempotency key. Stripe stores the first response
under that key for 24 hours and replays it for any repeat, so a retried create
returns the original object instead of making a second one:

```swift
let customer = try await stripe.customers.create(
    .init(email: "ada@example.com"),
    idempotencyKey: "customer-\(userID)"
)
```

Derive the key from the thing being created, not from the attempt — the point is
that two attempts at the same operation collide. A UUID generated per call keys
nothing and is the same as passing none.

The key reaches `Idempotency-Key` on the request. Endpoints without a typed
client take it too:

```swift
try await stripe.api.send(
    .POST, "v1/billing_portal/sessions", body: request, idempotencyKey: key
)
```

Omitting it leaves the header off, which is what every call did before this
existed.

## Retries and timeouts

Requests are retried on `429` and on `5xx` other than `501`, with exponential
backoff (0.5s, 1s, 2s, … capped at 8s). `maxRetries` defaults to `2`, i.e. three
attempts in total; set it to `0` to disable.

**Only requests that are safe to repeat are retried**: reads always, and writes
only when they carry an idempotency key. An unkeyed write that fails with a
`429` or `5xx` surfaces the error on the first attempt rather than risking a
second charge, customer, or subscription — losing the error is the lesser
problem. Key your writes and they retry like everything else.

`timeout` is per attempt, not per call: the worst case is
`(maxRetries + 1) × timeout` plus backoff.

## Stripe Connect

Set `connectedAccount` to act on behalf of a connected account; it is sent as
the `Stripe-Account` header on every request.

```swift
var configuration = platformConfiguration
configuration.connectedAccount = "acct_123"
let onBehalf = StripeClient(configuration: configuration, httpClient: httpClient)
```

Because `StripeConfiguration` is a value type, deriving a per-account client is
cheap and thread-safe. Share one `HTTPClient` across them.

## Webhooks

Verify against the **raw** request body. Decoding and re-encoding the JSON
changes the bytes, and the signature will not match.

```swift
let event = try StripeWebhook.constructEvent(
    payload: rawBody,                                   // Data, exactly as received
    signatureHeader: headers["Stripe-Signature"] ?? "",
    secret: webhookSigningSecret                        // whsec_…
)

switch event.type {
case .paymentIntentSucceeded: try await fulfil(event)
default: break
}
```

- Signatures are compared in constant time.
- Timestamps are checked against a five-minute tolerance by default
  (`tolerance:` to change it, `0` to disable — do not disable in production).
- Multiple `v1` signatures are accepted, so secret rotation does not drop events.
- `StripeWebhook.verify(payload:signatureHeader:secret:)` verifies without
  decoding, for handlers that route on the raw payload.

Failures are typed as `StripeWebhook.Error`: `malformedSignatureHeader`,
`signatureMismatch`, `timestampOutsideTolerance(age:)`, `decodingFailed(_:)`.

## Testing

Each resource client is a protocol, so a double needs no network and no HTTP
stubbing:

```swift
struct StubCustomers: CustomersAPI {
    func create(
        _: Stripe.Customers.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Customers.Customer {
        .init(id: "cus_stub", object: "customer", created: .now, livemode: false)
    }
    // ...
}

let customers: any CustomersAPI = StubCustomers()
```

A double implements the keyed form of each write; the unkeyed overload is a
protocol extension that forwards to it, so `create(request)` still resolves.

To exercise the real stack — URL building, form encoding, decoding, retries —
point a client at a local server and assert on the bytes it received.
`Tests/StripeTests/TestHTTPServer.swift` is a small NIO server that records
requests and replays scripted responses:

```swift
let stripe = StripeClient(
    configuration: .init(
        secretKey: "sk_test_123",
        baseURL: URL(string: "http://127.0.0.1:\(server.port)")!
    ),
    httpClient: httpClient
)
```

Request construction and response handling are also reachable as pure functions
(`StripeAPI.makeRequest`, `StripeAPI.decode`), so status-code and error-payload
paths are covered without any I/O.

```bash
swift test
swift test --filter "Stripe webhook signatures"
```

## Project layout

```
Sources/Stripe/
├── Core/        StripeClient, StripeAPI, StripeConfiguration,
│                StripeClientError, StripeFormEncoder
├── Clients/     one typed client per resource
├── Webhooks/    signature verification
├── Models/      Stripe object types           (125 files)
├── Requests/    request & response payloads    (98 files)
└── Shared/      the Stripe namespace, Expandable, Interval
```

A request flows `StripeClient` → resource client → `StripeAPI` →
`StripeFormEncoder` → `AsyncHTTPClient` → `JSONDecoder`. There is no transport
abstraction: `StripeAPI` uses `AsyncHTTPClient` directly.

Resource identifiers are `String` typealiases (`Stripe.Customers.Customer.ID`),
so they interpolate into paths and cross API boundaries without conversion.

## Wire format

Stripe takes `application/x-www-form-urlencoded` bodies with bracket notation for
nesting, which `JSONEncoder` cannot produce. `StripeFormEncoder` is a direct
`Encoder` conformance that emits it:

```
items[0][price]=price_123&items[0][quantity]=2&metadata[order_id]=abc
```

Booleans render as `true`/`false`, dates as Unix timestamps, and `nil` values are
omitted entirely.

On the way back, responses decode with `.convertFromSnakeCase` and
`.secondsSince1970`, so models declare plain camelCase properties and carry no
redundant `CodingKeys` raw values.

### Metadata keys do not round-trip through camelCase

The encoder cannot tell a dictionary key from a field name, so it snake-cases
both: `metadata: ["userId": x]` goes out as `metadata[user_id]=x`.
`JSONDecoder.convertFromSnakeCase` deliberately does *not* touch dictionary
keys, so it comes back as `"user_id"`, not `"userId"` — writing and reading with
the same Swift constant silently misses.

**Keep metadata keys lowercase or `snake_case`**, matching Stripe's own
convention. Those pass through both directions unchanged.

### Event decoding is deliberately lenient

A webhook endpoint receives whatever event types are enabled on it, and Stripe
adds new ones over time. `Stripe.Events.Event` therefore never fails on an
unrecognised payload: an event type this package does not model leaves `type`
`nil` (with the wire string in `rawType`), and an object it does not model
decodes as `Event.Object.unknown(type:)`. Rejecting the delivery would just have
Stripe redeliver the same event until it gave up.

### Corrections to the vendored models

The model types were vendored from swift-stripe-standard and, before it,
stripe-kit (see [NOTICE](NOTICE)). Three field names disagreed with Stripe's wire
format and are corrected here:

| Type | Was | Now | Stripe field |
|---|---|---|---|
| `Checkout.Session` custom fields | `mininumLength` | `minimumLength` | `minimum_length` |
| `PaymentIntent` | `onBehalfOn` | `onBehalfOf` | `on_behalf_of` |
| `PaymentLink` … confirmation | `message` | `customMessage` | `custom_message` |
| `Billing.Invoice` | `subscriptionDetails: Subscription.Details` | `…: Invoice.SubscriptionDetails` | `subscription_details` |
| `Customers.Customer` | `preferredLocals` | `preferredLocales` | `preferred_locales` |
| `Checkout.Session` | `shipppingOptions` | `shippingOptions` | `shipping_options` |
| `Billing.Invoice` | `amountRemanining` | `amountRemaining` | `amount_remaining` |

`Billing.Invoice.subscriptionDetails` was typed as the subscription's
*cancellation* details, so `subscription` and `metadata` decoded to nothing. It
now has its own type. `Billing.Invoice.parent` was missing entirely: API version
`2025-03-31.basil` moved a subscription invoice's `subscription` from the top
level to `parent.subscription_details.subscription`, so on any modern version
that is the only place to read it.

Separately, the vendored decoder used `.useDefaultKeys` on the assumption that
every model declared explicit `CodingKeys`; roughly half did not, so multi-word
fields such as `invoice_prefix`, `tax_exempt` and `has_more` silently decoded to
`nil`. `Tests/StripeTests/DecodingTests.swift` covers both the fix and the
regression.

## Operational guidance

- **Pin `apiVersion`.** Leaving it `nil` uses whatever version the account
  defaults to, which lets Stripe change response shapes underneath a running
  deployment.
- **Keep secret keys out of source.** Read them from the environment or a secrets
  provider; `secretKey` is marked secret so swift-configuration's access
  reporters redact it.
- **Use a restricted key** where the workload does not need full account access.
- **Log `Request-Id`.** Every `StripeClientError` carries it when the response
  had one.
- **Size timeouts against Stripe's own.** The default 60s per attempt is
  deliberately generous; lower it for latency-sensitive request paths.

## Status

The request engine, form encoding, error handling, retries, idempotency keys,
and webhook verification are complete and covered by tests.

**Nearly every model is generated from Stripe's OpenAPI spec.** 131 of the 137 root resources
are emitted by `Scripts/generate-models.py` into `Sources/Stripe/Models/Generated/` from
`spec3.sdk.json`, pinned by commit in CI. Every field the spec describes is present, every enum
carries the spec's cases, and each struct's `CodingKeys` is emitted from the same list as its
properties. `Event` stays hand-written: it decodes an unknown event type without rejecting the
delivery and models `data.object` as a discriminated union, neither of which the generator
expresses yet. The remaining six are unions or ID-only references (`payment_source`, `external_account`,
`issuing.token`, `payment_record`) the generator does not express yet.

`Scripts/model-drift.py` measures every generated resource against the spec, and
`Tests/StripeTests/FixtureDecodingTests.swift` — which decodes a fixture with every spec
field populated per resource — catches a hand type a generated one references rejecting a
value Stripe has since added. The few it has caught and not yet fixed are listed in that test
by path; an entry there is an acknowledged defect in a hand type, and anything unlisted fails. Typed resource clients currently
cover Customers, PaymentIntents, Checkout Sessions, Products, Prices,
Subscriptions, and Billing Portal Sessions; every other endpoint is reachable
through `stripe.api` with the modelled request and response types.

Not yet implemented:

- `swift-log` / `swift-distributed-tracing` instrumentation;
- automatic pagination helpers (`AsyncSequence` over list endpoints);
- file uploads (`files.stripe.com` multipart).

## License

Apache 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE) for attribution — the
model types derive from swift-stripe-standard (Apache 2.0) and, before it,
stripe-kit (MIT).
