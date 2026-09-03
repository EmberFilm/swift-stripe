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

/// Operations on Stripe.Billing.Credit.Balance.Transaction.
///
/// A protocol so tests can substitute a double; ``BillingCreditBalanceTransactionsClient`` is the implementation that
/// talks to Stripe.
public protocol BillingCreditBalanceTransactionsAPI: Sendable {
    func list(
        _ request: Stripe.Billing.Credit.Balance.Transaction.List.Request
    ) async throws -> Stripe.Billing.Credit.Balance.Transaction.List.Response
    func retrieve(
        id: Stripe.Billing.Credit.Balance.Transaction.ID,
        _ request: Stripe.Billing.Credit.Balance.Transaction.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Balance.Transaction.Retrieve.Response
}

public struct BillingCreditBalanceTransactionsClient: BillingCreditBalanceTransactionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        _ request: Stripe.Billing.Credit.Balance.Transaction.List.Request
    ) async throws -> Stripe.Billing.Credit.Balance.Transaction.List.Response {
        try await api.list("v1/billing/credit_balance_transactions", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Credit.Balance.Transaction.ID,
        _ request: Stripe.Billing.Credit.Balance.Transaction.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Balance.Transaction.Retrieve.Response {
        try await api.list("v1/billing/credit_balance_transactions/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BillingCreditBalanceTransactionsAPI {
    public func list() async throws -> Stripe.Billing.Credit.Balance.Transaction.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.Credit.Balance.Transaction.ID) async throws -> Stripe.Billing.Credit.Balance.Transaction.Retrieve.Response
    {
        try await retrieve(id: id, .init())
    }
}
