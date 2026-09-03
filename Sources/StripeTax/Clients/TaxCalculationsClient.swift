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

/// Operations on Stripe.Tax.Calculation.
///
/// A protocol so tests can substitute a double; ``TaxCalculationsClient`` is the implementation that
/// talks to Stripe.
public protocol TaxCalculationsAPI: Sendable {
    func create(_ request: Stripe.Tax.Calculation.Create.Request, idempotencyKey: String?) async throws -> Stripe.Tax.Calculation.Create.Response
    func listLineItems(
        id: Stripe.Tax.Calculation.ID,
        _ request: Stripe.Tax.Calculation.ListLineItems.Request
    ) async throws -> Stripe.Tax.Calculation.ListLineItems.Response
    func retrieve(
        id: Stripe.Tax.Calculation.ID,
        _ request: Stripe.Tax.Calculation.Retrieve.Request
    ) async throws -> Stripe.Tax.Calculation.Retrieve.Response
}

public struct TaxCalculationsClient: TaxCalculationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Tax.Calculation.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Calculation.Create.Response {
        try await api.send(.POST, "v1/tax/calculations", body: request, idempotencyKey: idempotencyKey)
    }

    public func listLineItems(
        id: Stripe.Tax.Calculation.ID,
        _ request: Stripe.Tax.Calculation.ListLineItems.Request
    ) async throws -> Stripe.Tax.Calculation.ListLineItems.Response {
        try await api.list("v1/tax/calculations/\(id)/line_items", parameters: request)
    }

    public func retrieve(
        id: Stripe.Tax.Calculation.ID,
        _ request: Stripe.Tax.Calculation.Retrieve.Request
    ) async throws -> Stripe.Tax.Calculation.Retrieve.Response {
        try await api.list("v1/tax/calculations/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TaxCalculationsAPI {
    public func create(_ request: Stripe.Tax.Calculation.Create.Request) async throws -> Stripe.Tax.Calculation.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func listLineItems(id: Stripe.Tax.Calculation.ID) async throws -> Stripe.Tax.Calculation.ListLineItems.Response {
        try await listLineItems(id: id, .init())
    }

    public func retrieve(id: Stripe.Tax.Calculation.ID) async throws -> Stripe.Tax.Calculation.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
