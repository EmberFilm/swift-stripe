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

/// Operations on Stripe.Billing.Credit.Grant.
///
/// A protocol so tests can substitute a double; ``BillingCreditGrantsClient`` is the implementation that
/// talks to Stripe.
public protocol BillingCreditGrantsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Credit.Grant.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.Create.Response
    func expire(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Expire.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.Expire.Response
    func list(_ request: Stripe.Billing.Credit.Grant.List.Request) async throws -> Stripe.Billing.Credit.Grant.List.Response
    func retrieve(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Grant.Retrieve.Response
    func update(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.Update.Response
    func voidGrant(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.VoidGrant.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.VoidGrant.Response
}

public struct BillingCreditGrantsClient: BillingCreditGrantsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Billing.Credit.Grant.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.Create.Response {
        try await api.send(.POST, "v1/billing/credit_grants", body: request, idempotencyKey: idempotencyKey)
    }

    public func expire(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Expire.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.Expire.Response {
        try await api.send(.POST, "v1/billing/credit_grants/\(id)/expire", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.Credit.Grant.List.Request) async throws -> Stripe.Billing.Credit.Grant.List.Response {
        try await api.list("v1/billing/credit_grants", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Grant.Retrieve.Response {
        try await api.list("v1/billing/credit_grants/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.Update.Response {
        try await api.send(.POST, "v1/billing/credit_grants/\(id)", body: request, idempotencyKey: idempotencyKey)
    }

    public func voidGrant(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.VoidGrant.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Grant.VoidGrant.Response {
        try await api.send(.POST, "v1/billing/credit_grants/\(id)/void", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension BillingCreditGrantsAPI {
    public func create(_ request: Stripe.Billing.Credit.Grant.Create.Request) async throws -> Stripe.Billing.Credit.Grant.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func expire(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Expire.Request
    ) async throws -> Stripe.Billing.Credit.Grant.Expire.Response {
        try await expire(id: id, request, idempotencyKey: nil)
    }

    public func expire(id: Stripe.Billing.Credit.Grant.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Credit.Grant.Expire.Response
    {
        try await expire(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Billing.Credit.Grant.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.Credit.Grant.ID) async throws -> Stripe.Billing.Credit.Grant.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.Update.Request
    ) async throws -> Stripe.Billing.Credit.Grant.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Billing.Credit.Grant.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Credit.Grant.Update.Response
    {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func voidGrant(
        id: Stripe.Billing.Credit.Grant.ID,
        _ request: Stripe.Billing.Credit.Grant.VoidGrant.Request
    ) async throws -> Stripe.Billing.Credit.Grant.VoidGrant.Response {
        try await voidGrant(id: id, request, idempotencyKey: nil)
    }

    public func voidGrant(
        id: Stripe.Billing.Credit.Grant.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.Credit.Grant.VoidGrant.Response {
        try await voidGrant(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
