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

/// Operations on Stripe.PaymentMethods.PaymentMethod.
///
/// A protocol so tests can substitute a double; ``PaymentMethodsClient`` is the implementation that
/// talks to Stripe.
public protocol PaymentMethodsAPI: Sendable {
    func attach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Attach.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Attach.Response
    func create(
        _ request: Stripe.PaymentMethods.PaymentMethod.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Create.Response
    func detach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Detach.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Detach.Response
    func list(_ request: Stripe.PaymentMethods.PaymentMethod.List.Request) async throws -> Stripe.PaymentMethods.PaymentMethod.List.Response
    func retrieve(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Retrieve.Request
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Retrieve.Response
    func update(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Update.Response
}

public struct PaymentMethodsClient: PaymentMethodsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func attach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Attach.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Attach.Response {
        try await api.send(.POST, "v1/payment_methods/\(id)/attach", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.PaymentMethods.PaymentMethod.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Create.Response {
        try await api.send(.POST, "v1/payment_methods", body: request, idempotencyKey: idempotencyKey)
    }

    public func detach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Detach.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Detach.Response {
        try await api.send(.POST, "v1/payment_methods/\(id)/detach", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.PaymentMethods.PaymentMethod.List.Request) async throws -> Stripe.PaymentMethods.PaymentMethod.List.Response {
        try await api.list("v1/payment_methods", parameters: request)
    }

    public func retrieve(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Retrieve.Request
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Retrieve.Response {
        try await api.list("v1/payment_methods/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Update.Response {
        try await api.send(.POST, "v1/payment_methods/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentMethodsAPI {
    public func attach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Attach.Request
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Attach.Response {
        try await attach(id: id, request, idempotencyKey: nil)
    }

    public func attach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Attach.Response {
        try await attach(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.PaymentMethods.PaymentMethod.Create.Request
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.PaymentMethods.PaymentMethod.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func detach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Detach.Request
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Detach.Response {
        try await detach(id: id, request, idempotencyKey: nil)
    }

    public func detach(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Detach.Response {
        try await detach(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.PaymentMethods.PaymentMethod.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.PaymentMethods.PaymentMethod.ID) async throws -> Stripe.PaymentMethods.PaymentMethod.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        _ request: Stripe.PaymentMethods.PaymentMethod.Update.Request
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.PaymentMethods.PaymentMethod.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentMethods.PaymentMethod.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
