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

/// Operations on Stripe.Forwarding.Request.
///
/// A protocol so tests can substitute a double; ``ForwardingRequestsClient`` is the implementation that
/// talks to Stripe.
public protocol ForwardingRequestsAPI: Sendable {
    func create(
        _ request: Stripe.Forwarding.Request.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Forwarding.Request.Create.Response
    func list(_ request: Stripe.Forwarding.Request.List.Request) async throws -> Stripe.Forwarding.Request.List.Response
    func retrieve(
        id: Stripe.Forwarding.Request.ID,
        _ request: Stripe.Forwarding.Request.Retrieve.Request
    ) async throws -> Stripe.Forwarding.Request.Retrieve.Response
}

public struct ForwardingRequestsClient: ForwardingRequestsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Forwarding.Request.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Forwarding.Request.Create.Response {
        try await api.send(.POST, "v1/forwarding/requests", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Forwarding.Request.List.Request) async throws -> Stripe.Forwarding.Request.List.Response {
        try await api.list("v1/forwarding/requests", parameters: request)
    }

    public func retrieve(
        id: Stripe.Forwarding.Request.ID,
        _ request: Stripe.Forwarding.Request.Retrieve.Request
    ) async throws -> Stripe.Forwarding.Request.Retrieve.Response {
        try await api.list("v1/forwarding/requests/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension ForwardingRequestsAPI {
    public func create(_ request: Stripe.Forwarding.Request.Create.Request) async throws -> Stripe.Forwarding.Request.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Forwarding.Request.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Forwarding.Request.ID) async throws -> Stripe.Forwarding.Request.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
