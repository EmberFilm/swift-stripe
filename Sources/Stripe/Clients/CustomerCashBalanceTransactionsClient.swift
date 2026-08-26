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

/// Operations on Stripe.Customers.CashBalanceTransaction.
///
/// A protocol so tests can substitute a double; ``CustomerCashBalanceTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol CustomerCashBalanceTransactionsAPI: Sendable {
    func list(
        customer: String,
        _ request: Stripe.Customers.CashBalanceTransaction.List.Request
    ) async throws -> Stripe.Customers.CashBalanceTransaction.List.Response
    func retrieve(
        customer: String,
        transaction: String,
        _ request: Stripe.Customers.CashBalanceTransaction.Retrieve.Request
    ) async throws -> Stripe.Customers.CashBalanceTransaction.Retrieve.Response
}

public struct CustomerCashBalanceTransactionsClient: CustomerCashBalanceTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        customer: String,
        _ request: Stripe.Customers.CashBalanceTransaction.List.Request
    ) async throws -> Stripe.Customers.CashBalanceTransaction.List.Response {
        try await api.list("v1/customers/\(customer)/cash_balance_transactions", parameters: request)
    }

    public func retrieve(
        customer: String,
        transaction: String,
        _ request: Stripe.Customers.CashBalanceTransaction.Retrieve.Request
    ) async throws -> Stripe.Customers.CashBalanceTransaction.Retrieve.Response {
        try await api.list("v1/customers/\(customer)/cash_balance_transactions/\(transaction)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CustomerCashBalanceTransactionsAPI {
    public func list(customer: String) async throws -> Stripe.Customers.CashBalanceTransaction.List.Response {
        try await list(customer: customer, .init())
    }

    public func retrieve(customer: String, transaction: String) async throws -> Stripe.Customers.CashBalanceTransaction.Retrieve.Response {
        try await retrieve(customer: customer, transaction: transaction, .init())
    }
}
