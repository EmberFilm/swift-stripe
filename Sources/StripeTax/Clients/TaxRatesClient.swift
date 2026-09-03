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
import StripeCore
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Tax.Rate.
///
/// A protocol so tests can substitute a double; ``TaxRatesClient`` is the implementation that
/// talks to Stripe.
public protocol TaxRatesAPI: Sendable {
    func create(_ request: Stripe.Tax.Rate.Create.Request, idempotencyKey: String?) async throws -> Stripe.Tax.Rate.Create.Response
    func list(_ request: Stripe.Tax.Rate.List.Request) async throws -> Stripe.Tax.Rate.List.Response
    func retrieve(id: Stripe.Tax.Rate.ID, _ request: Stripe.Tax.Rate.Retrieve.Request) async throws -> Stripe.Tax.Rate.Retrieve.Response
    func update(
        id: Stripe.Tax.Rate.ID,
        _ request: Stripe.Tax.Rate.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Rate.Update.Response
}

public struct TaxRatesClient: TaxRatesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Stripe.Tax.Rate.Create.Request, idempotencyKey: String?) async throws -> Stripe.Tax.Rate.Create.Response {
        try await api.send(.POST, "v1/tax_rates", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Tax.Rate.List.Request) async throws -> Stripe.Tax.Rate.List.Response {
        try await api.list("v1/tax_rates", parameters: request)
    }

    public func retrieve(id: Stripe.Tax.Rate.ID, _ request: Stripe.Tax.Rate.Retrieve.Request) async throws -> Stripe.Tax.Rate.Retrieve.Response {
        try await api.list("v1/tax_rates/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Tax.Rate.ID,
        _ request: Stripe.Tax.Rate.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Rate.Update.Response {
        try await api.send(.POST, "v1/tax_rates/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TaxRatesAPI {
    public func create(_ request: Stripe.Tax.Rate.Create.Request) async throws -> Stripe.Tax.Rate.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Tax.Rate.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Tax.Rate.ID) async throws -> Stripe.Tax.Rate.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(id: Stripe.Tax.Rate.ID, _ request: Stripe.Tax.Rate.Update.Request) async throws -> Stripe.Tax.Rate.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Tax.Rate.ID, idempotencyKey: String? = nil) async throws -> Stripe.Tax.Rate.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
