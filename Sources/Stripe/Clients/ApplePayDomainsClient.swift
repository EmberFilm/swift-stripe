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

/// Operations on Stripe.ApplePayDomain.
///
/// A protocol so tests can substitute a double; ``ApplePayDomainsClient`` is the implementation that
/// talks to Stripe.
public protocol ApplePayDomainsAPI: Sendable {
    func create(_ request: Stripe.ApplePayDomain.Create.Request, idempotencyKey: String?) async throws -> Stripe.ApplePayDomain.Create.Response
    func delete(id: Stripe.ApplePayDomain.ID, idempotencyKey: String?) async throws -> Stripe.ApplePayDomain.Delete.Response
    func list(_ request: Stripe.ApplePayDomain.List.Request) async throws -> Stripe.ApplePayDomain.List.Response
    func retrieve(
        id: Stripe.ApplePayDomain.ID,
        _ request: Stripe.ApplePayDomain.Retrieve.Request
    ) async throws -> Stripe.ApplePayDomain.Retrieve.Response
}

public struct ApplePayDomainsClient: ApplePayDomainsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Stripe.ApplePayDomain.Create.Request, idempotencyKey: String?) async throws -> Stripe.ApplePayDomain.Create.Response
    {
        try await api.send(.POST, "v1/apple_pay/domains", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.ApplePayDomain.ID, idempotencyKey: String?) async throws -> Stripe.ApplePayDomain.Delete.Response {
        try await api.send(.DELETE, "v1/apple_pay/domains/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.ApplePayDomain.List.Request) async throws -> Stripe.ApplePayDomain.List.Response {
        try await api.list("v1/apple_pay/domains", parameters: request)
    }

    public func retrieve(
        id: Stripe.ApplePayDomain.ID,
        _ request: Stripe.ApplePayDomain.Retrieve.Request
    ) async throws -> Stripe.ApplePayDomain.Retrieve.Response {
        try await api.list("v1/apple_pay/domains/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ApplePayDomainsAPI {
    public func create(_ request: Stripe.ApplePayDomain.Create.Request) async throws -> Stripe.ApplePayDomain.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.ApplePayDomain.ID) async throws -> Stripe.ApplePayDomain.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.ApplePayDomain.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.ApplePayDomain.ID) async throws -> Stripe.ApplePayDomain.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
