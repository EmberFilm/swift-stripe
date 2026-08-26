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

/// Operations on Stripe.PaymentSource.
///
/// A protocol so tests can substitute a double; ``PaymentSourcesClient`` is the implementation that
/// talks to Stripe.
public protocol PaymentSourcesAPI: Sendable {
    func create(
        customer: String,
        _ request: Stripe.PaymentSource.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentSource.Create.Response
    func list(customer: String, _ request: Stripe.PaymentSource.List.Request) async throws -> Stripe.PaymentSource.List.Response
    func retrieve(
        customer: String,
        id: String,
        _ request: Stripe.PaymentSource.Retrieve.Request
    ) async throws -> Stripe.PaymentSource.Retrieve.Response
}

public struct PaymentSourcesClient: PaymentSourcesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        customer: String,
        _ request: Stripe.PaymentSource.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentSource.Create.Response {
        try await api.send(.POST, "v1/customers/\(customer)/sources", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(customer: String, _ request: Stripe.PaymentSource.List.Request) async throws -> Stripe.PaymentSource.List.Response {
        try await api.list("v1/customers/\(customer)/sources", parameters: request)
    }

    public func retrieve(
        customer: String,
        id: String,
        _ request: Stripe.PaymentSource.Retrieve.Request
    ) async throws -> Stripe.PaymentSource.Retrieve.Response {
        try await api.list("v1/customers/\(customer)/sources/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentSourcesAPI {
    public func create(customer: String, _ request: Stripe.PaymentSource.Create.Request) async throws -> Stripe.PaymentSource.Create.Response {
        try await create(customer: customer, request, idempotencyKey: nil)
    }

    public func list(customer: String) async throws -> Stripe.PaymentSource.List.Response {
        try await list(customer: customer, .init())
    }

    public func retrieve(customer: String, id: String) async throws -> Stripe.PaymentSource.Retrieve.Response {
        try await retrieve(customer: customer, id: id, .init())
    }
}
