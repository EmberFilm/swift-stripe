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
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Billing.Customer.Balance.Transaction.
///
/// A protocol so tests can substitute a double; ``CustomerBalanceTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol CustomerBalanceTransactionsAPI: Sendable {
    func create(
        customer: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Create.Response
    func list(
        customer: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.List.Request
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.List.Response
    func retrieve(
        customer: String,
        transaction: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Retrieve.Request
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Retrieve.Response
    func update(
        customer: String,
        transaction: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Update.Response
}

public struct CustomerBalanceTransactionsClient: CustomerBalanceTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        customer: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Create.Response {
        try await api.send(.POST, "v1/customers/\(customer)/balance_transactions", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(
        customer: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.List.Request
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.List.Response {
        try await api.list("v1/customers/\(customer)/balance_transactions", parameters: request)
    }

    public func retrieve(
        customer: String,
        transaction: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Retrieve.Request
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Retrieve.Response {
        try await api.list("v1/customers/\(customer)/balance_transactions/\(transaction)", parameters: request)
    }

    public func update(
        customer: String,
        transaction: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Update.Response {
        try await api.send(.POST, "v1/customers/\(customer)/balance_transactions/\(transaction)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CustomerBalanceTransactionsAPI {
    public func create(
        customer: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Create.Request
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Create.Response {
        try await create(customer: customer, request, idempotencyKey: nil)
    }

    public func list(customer: String) async throws -> Stripe.Billing.Customer.Balance.Transaction.List.Response {
        try await list(customer: customer, .init())
    }

    public func retrieve(customer: String, transaction: String) async throws -> Stripe.Billing.Customer.Balance.Transaction.Retrieve.Response {
        try await retrieve(customer: customer, transaction: transaction, .init())
    }

    public func update(
        customer: String,
        transaction: String,
        _ request: Stripe.Billing.Customer.Balance.Transaction.Update.Request
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Update.Response {
        try await update(customer: customer, transaction: transaction, request, idempotencyKey: nil)
    }

    public func update(
        customer: String,
        transaction: String,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.Customer.Balance.Transaction.Update.Response {
        try await update(customer: customer, transaction: transaction, .init(), idempotencyKey: idempotencyKey)
    }
}
