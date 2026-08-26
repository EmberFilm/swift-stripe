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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Tax.Transaction.
///
/// A protocol so tests can substitute a double; ``TaxTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol TaxTransactionsAPI: Sendable {
    func createFromCalculation(
        _ request: Stripe.Tax.Transaction.CreateFromCalculation.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Transaction.CreateFromCalculation.Response
    func createReversal(
        _ request: Stripe.Tax.Transaction.CreateReversal.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Transaction.CreateReversal.Response
    func listLineItems(
        id: Stripe.Tax.Transaction.ID,
        _ request: Stripe.Tax.Transaction.ListLineItems.Request
    ) async throws -> Stripe.Tax.Transaction.ListLineItems.Response
    func retrieve(
        id: Stripe.Tax.Transaction.ID,
        _ request: Stripe.Tax.Transaction.Retrieve.Request
    ) async throws -> Stripe.Tax.Transaction.Retrieve.Response
}

public struct TaxTransactionsClient: TaxTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func createFromCalculation(
        _ request: Stripe.Tax.Transaction.CreateFromCalculation.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Transaction.CreateFromCalculation.Response {
        try await api.send(.POST, "v1/tax/transactions/create_from_calculation", body: request, idempotencyKey: idempotencyKey)
    }

    public func createReversal(
        _ request: Stripe.Tax.Transaction.CreateReversal.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Transaction.CreateReversal.Response {
        try await api.send(.POST, "v1/tax/transactions/create_reversal", body: request, idempotencyKey: idempotencyKey)
    }

    public func listLineItems(
        id: Stripe.Tax.Transaction.ID,
        _ request: Stripe.Tax.Transaction.ListLineItems.Request
    ) async throws -> Stripe.Tax.Transaction.ListLineItems.Response {
        try await api.list("v1/tax/transactions/\(id)/line_items", parameters: request)
    }

    public func retrieve(
        id: Stripe.Tax.Transaction.ID,
        _ request: Stripe.Tax.Transaction.Retrieve.Request
    ) async throws -> Stripe.Tax.Transaction.Retrieve.Response {
        try await api.list("v1/tax/transactions/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TaxTransactionsAPI {
    public func createFromCalculation(
        _ request: Stripe.Tax.Transaction.CreateFromCalculation.Request
    ) async throws -> Stripe.Tax.Transaction.CreateFromCalculation.Response {
        try await createFromCalculation(request, idempotencyKey: nil)
    }

    public func createReversal(
        _ request: Stripe.Tax.Transaction.CreateReversal.Request
    ) async throws -> Stripe.Tax.Transaction.CreateReversal.Response {
        try await createReversal(request, idempotencyKey: nil)
    }

    public func listLineItems(id: Stripe.Tax.Transaction.ID) async throws -> Stripe.Tax.Transaction.ListLineItems.Response {
        try await listLineItems(id: id, .init())
    }

    public func retrieve(id: Stripe.Tax.Transaction.ID) async throws -> Stripe.Tax.Transaction.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
