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

/// Operations on Stripe.PaymentMethodDomain.
///
/// A protocol so tests can substitute a double; ``PaymentMethodDomainsClient`` is the implementation that
/// talks to Stripe.
public protocol PaymentMethodDomainsAPI: Sendable {
    func create(
        _ request: Stripe.PaymentMethodDomain.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodDomain.Create.Response
    func list(_ request: Stripe.PaymentMethodDomain.List.Request) async throws -> Stripe.PaymentMethodDomain.List.Response
    func retrieve(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Retrieve.Request
    ) async throws -> Stripe.PaymentMethodDomain.Retrieve.Response
    func update(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodDomain.Update.Response
    func validate(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Validate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodDomain.Validate.Response
}

public struct PaymentMethodDomainsClient: PaymentMethodDomainsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.PaymentMethodDomain.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodDomain.Create.Response {
        try await api.send(.POST, "v1/payment_method_domains", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.PaymentMethodDomain.List.Request) async throws -> Stripe.PaymentMethodDomain.List.Response {
        try await api.list("v1/payment_method_domains", parameters: request)
    }

    public func retrieve(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Retrieve.Request
    ) async throws -> Stripe.PaymentMethodDomain.Retrieve.Response {
        try await api.list("v1/payment_method_domains/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodDomain.Update.Response {
        try await api.send(.POST, "v1/payment_method_domains/\(id)", body: request, idempotencyKey: idempotencyKey)
    }

    public func validate(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Validate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentMethodDomain.Validate.Response {
        try await api.send(.POST, "v1/payment_method_domains/\(id)/validate", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentMethodDomainsAPI {
    public func create(_ request: Stripe.PaymentMethodDomain.Create.Request) async throws -> Stripe.PaymentMethodDomain.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.PaymentMethodDomain.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.PaymentMethodDomain.ID) async throws -> Stripe.PaymentMethodDomain.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Update.Request
    ) async throws -> Stripe.PaymentMethodDomain.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.PaymentMethodDomain.ID, idempotencyKey: String? = nil) async throws -> Stripe.PaymentMethodDomain.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func validate(
        id: Stripe.PaymentMethodDomain.ID,
        _ request: Stripe.PaymentMethodDomain.Validate.Request
    ) async throws -> Stripe.PaymentMethodDomain.Validate.Response {
        try await validate(id: id, request, idempotencyKey: nil)
    }

    public func validate(
        id: Stripe.PaymentMethodDomain.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentMethodDomain.Validate.Response {
        try await validate(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
