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

/// Operations on Stripe.Billing.MeterEventSummary.
///
/// A protocol so tests can substitute a double; ``BillingMeterEventSummariesClient`` is the implementation that
/// talks to Stripe.
public protocol BillingMeterEventSummariesAPI: Sendable {
    func list(
        id: Stripe.Billing.MeterEventSummary.ID,
        _ request: Stripe.Billing.MeterEventSummary.List.Request
    ) async throws -> Stripe.Billing.MeterEventSummary.List.Response
}

public struct BillingMeterEventSummariesClient: BillingMeterEventSummariesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        id: Stripe.Billing.MeterEventSummary.ID,
        _ request: Stripe.Billing.MeterEventSummary.List.Request
    ) async throws -> Stripe.Billing.MeterEventSummary.List.Response {
        try await api.list("v1/billing/meters/\(id)/event_summaries", parameters: request)
    }
}
