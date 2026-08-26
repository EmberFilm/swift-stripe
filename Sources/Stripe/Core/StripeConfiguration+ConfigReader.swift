//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Configuration

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// Follows the swift-configuration guidance for libraries: the configuration
// type stays plain, and a `ConfigReader` initializer reads its values.
//
// Keys are read unscoped, on purpose. The caller decides whether this package's
// configuration lives at the root or under a namespace:
//
//     StripeConfiguration(config: config.scoped(to: "stripe"))
//
// which, with `EnvironmentVariablesProvider`, reads `STRIPE_SECRET_KEY` and
// friends. Scoping inside the library would deny callers that choice.

extension StripeConfiguration {

    /// Creates a Stripe configuration from a configuration reader.
    ///
    /// ## Configuration keys
    ///
    /// - `secretKey` (string, **required**, secret): Stripe secret API key
    ///   (`sk_live_…` / `sk_test_…`). Marked secret, so access reporters such as
    ///   `AccessLogger` redact it.
    /// - `baseURL` (string, optional, default `"https://api.stripe.com"`): Base
    ///   URL of the Stripe REST API. Override to point at a proxy or a mock.
    ///   Converted with `URL(string:)`, which is lenient — a value with no
    ///   scheme is accepted here and fails later, when a request is sent.
    /// - `apiVersion` (string, optional, default none): Pinned Stripe API
    ///   version, sent as `Stripe-Version`. Leaving it unset uses the account
    ///   default, which lets Stripe change response shapes under you.
    /// - `connectedAccount` (string, optional, default none): Connected account
    ///   to act on behalf of, sent as `Stripe-Account`.
    /// - `maxRetries` (int, optional, default `2`): Retry attempts for
    ///   rate-limited and 5xx responses.
    /// - `timeoutSeconds` (int, optional, default `60`): Per-request timeout, in
    ///   whole seconds.
    ///
    /// Values are taken as given: nothing here is range-checked, and a value the
    /// reader cannot convert to the expected type falls back to the default
    /// rather than raising. A fractional `timeoutSeconds` such as `12.5` is not
    /// an int, so it reads back as `60`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let config = ConfigReader(provider: EnvironmentVariablesProvider())
    /// let stripe = StripeClient(
    ///     configuration: try StripeConfiguration(config: config.scoped(to: "stripe"))
    /// )
    /// ```
    ///
    /// - Parameter config: Reader to take configuration values from.
    /// - Throws: The reader's own error when `secretKey` is absent.
    public init(config: ConfigReader) throws {
        let secretKey = try config.requiredString(forKey: "secretKey", isSecret: true)
        let baseURL = config.string(
            forKey: "baseURL",
            as: URL.self,
            default: URL(string: "https://api.stripe.com")!,
        )
        let maxRetries = config.int(forKey: "maxRetries", default: 2)
        let timeoutSeconds = config.int(forKey: "timeoutSeconds", default: 60)
        self.init(
            secretKey: secretKey,
            baseURL: baseURL,
            apiVersion: config.string(forKey: "apiVersion", default: Stripe.generatedAPIVersion),
            filesBaseURL: config.string(
                forKey: "filesBaseURL",
                as: URL.self,
                default: URL(string: "https://files.stripe.com")!,
            ),
            connectedAccount: config.string(forKey: "connectedAccount"),
            maxRetries: maxRetries,
            timeout: .seconds(timeoutSeconds)
        )
    }
}
