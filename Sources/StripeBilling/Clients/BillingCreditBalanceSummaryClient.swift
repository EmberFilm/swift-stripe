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

/// Operations on Stripe.Billing.Credit.Balance.Summary.
///
/// A protocol so tests can substitute a double; ``BillingCreditBalanceSummaryClient`` is the implementation that
/// talks to Stripe.
public protocol BillingCreditBalanceSummaryAPI: Sendable {
    func retrieve(
        _ request: Stripe.Billing.Credit.Balance.Summary.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Balance.Summary.Retrieve.Response
}

public struct BillingCreditBalanceSummaryClient: BillingCreditBalanceSummaryAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func retrieve(
        _ request: Stripe.Billing.Credit.Balance.Summary.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Balance.Summary.Retrieve.Response {
        try await api.list("v1/billing/credit_balance_summary", parameters: request)
    }
}
