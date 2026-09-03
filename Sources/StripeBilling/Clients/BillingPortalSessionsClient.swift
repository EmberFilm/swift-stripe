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

/// Operations on Stripe.Billing.Customer.Portal.Session.
///
/// A protocol so tests can substitute a double; ``BillingPortalSessionsClient`` is the implementation that
/// talks to Stripe.
public protocol BillingPortalSessionsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Customer.Portal.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Session.Create.Response
}

public struct BillingPortalSessionsClient: BillingPortalSessionsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Billing.Customer.Portal.Session.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Session.Create.Response {
        try await api.send(.POST, "v1/billing_portal/sessions", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BillingPortalSessionsAPI {
    public func create(
        _ request: Stripe.Billing.Customer.Portal.Session.Create.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Session.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Billing.Customer.Portal.Session.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }
}
