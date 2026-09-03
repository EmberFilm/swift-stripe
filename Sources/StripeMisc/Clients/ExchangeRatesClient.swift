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

import NIOHTTP1
import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.ExchangeRate.
///
/// A protocol so tests can substitute a double; ``ExchangeRatesClient`` is the implementation that
/// talks to Stripe.
public protocol ExchangeRatesAPI: Sendable {
    func list(_ request: Stripe.ExchangeRate.List.Request) async throws -> Stripe.ExchangeRate.List.Response
    func retrieve(id: Stripe.ExchangeRate.ID, _ request: Stripe.ExchangeRate.Retrieve.Request) async throws -> Stripe.ExchangeRate.Retrieve.Response
}

public struct ExchangeRatesClient: ExchangeRatesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.ExchangeRate.List.Request) async throws -> Stripe.ExchangeRate.List.Response {
        try await api.list("v1/exchange_rates", parameters: request)
    }

    public func retrieve(
        id: Stripe.ExchangeRate.ID,
        _ request: Stripe.ExchangeRate.Retrieve.Request
    ) async throws -> Stripe.ExchangeRate.Retrieve.Response {
        try await api.list("v1/exchange_rates/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ExchangeRatesAPI {
    public func list() async throws -> Stripe.ExchangeRate.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.ExchangeRate.ID) async throws -> Stripe.ExchangeRate.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
