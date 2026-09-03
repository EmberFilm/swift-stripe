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

/// Operations on Stripe.Billing.Customer.Portal.Configuration.
///
/// A protocol so tests can substitute a double; ``BillingPortalConfigurationsClient`` is the implementation that
/// talks to Stripe.
public protocol BillingPortalConfigurationsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Customer.Portal.Configuration.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Create.Response
    func list(
        _ request: Stripe.Billing.Customer.Portal.Configuration.List.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.List.Response
    func retrieve(
        id: Stripe.Billing.Customer.Portal.Configuration.ID,
        _ request: Stripe.Billing.Customer.Portal.Configuration.Retrieve.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Retrieve.Response
    func update(
        id: Stripe.Billing.Customer.Portal.Configuration.ID,
        _ request: Stripe.Billing.Customer.Portal.Configuration.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Update.Response
}

public struct BillingPortalConfigurationsClient: BillingPortalConfigurationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Billing.Customer.Portal.Configuration.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Create.Response {
        try await api.send(.POST, "v1/billing_portal/configurations", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.Billing.Customer.Portal.Configuration.List.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.List.Response {
        try await api.list("v1/billing_portal/configurations", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Customer.Portal.Configuration.ID,
        _ request: Stripe.Billing.Customer.Portal.Configuration.Retrieve.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Retrieve.Response {
        try await api.list("v1/billing_portal/configurations/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Customer.Portal.Configuration.ID,
        _ request: Stripe.Billing.Customer.Portal.Configuration.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Update.Response {
        try await api.send(.POST, "v1/billing_portal/configurations/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BillingPortalConfigurationsAPI {
    public func create(
        _ request: Stripe.Billing.Customer.Portal.Configuration.Create.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Billing.Customer.Portal.Configuration.List.Response {
        try await list(.init())
    }

    public func retrieve(
        id: Stripe.Billing.Customer.Portal.Configuration.ID
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.Customer.Portal.Configuration.ID,
        _ request: Stripe.Billing.Customer.Portal.Configuration.Update.Request
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Billing.Customer.Portal.Configuration.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.Customer.Portal.Configuration.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
