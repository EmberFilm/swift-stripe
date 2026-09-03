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
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.PaymentMethodConfigurations.Configuration.
///
/// A protocol so tests can substitute a double; ``PaymentMethodConfigurationsClient`` is the implementation that
/// talks to Stripe.
public protocol PaymentMethodConfigurationsAPI: Sendable {
    func create(
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Create.Response
    func list(
        _ request: Stripe.PaymentMethodConfigurations.Configuration.List.Request
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.List.Response
    func retrieve(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID,
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Retrieve.Request
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Retrieve.Response
    func update(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID,
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Update.Response
}

public struct PaymentMethodConfigurationsClient: PaymentMethodConfigurationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Create.Response {
        try await api.send(.POST, "v1/payment_method_configurations", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.PaymentMethodConfigurations.Configuration.List.Request
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.List.Response {
        try await api.list("v1/payment_method_configurations", parameters: request)
    }

    public func retrieve(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID,
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Retrieve.Request
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Retrieve.Response {
        try await api.list("v1/payment_method_configurations/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID,
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Update.Response {
        try await api.send(.POST, "v1/payment_method_configurations/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentMethodConfigurationsAPI {
    public func create(
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Create.Request
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.PaymentMethodConfigurations.Configuration.List.Response {
        try await list(.init())
    }

    public func retrieve(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID,
        _ request: Stripe.PaymentMethodConfigurations.Configuration.Update.Request
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.PaymentMethodConfigurations.Configuration.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentMethodConfigurations.Configuration.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
