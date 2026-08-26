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

/// Operations on Stripe.Issuing.Token.
///
/// A protocol so tests can substitute a double; ``IssuingTokensClient`` is the implementation that
/// talks to Stripe.
public protocol IssuingTokensAPI: Sendable {
    func list(_ request: Stripe.Issuing.Token.List.Request) async throws -> Stripe.Issuing.Token.List.Response
    func retrieve(
        id: Stripe.Issuing.Token.ID,
        _ request: Stripe.Issuing.Token.Retrieve.Request
    ) async throws -> Stripe.Issuing.Token.Retrieve.Response
    func update(
        id: Stripe.Issuing.Token.ID,
        _ request: Stripe.Issuing.Token.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.Token.Update.Response
}

public struct IssuingTokensClient: IssuingTokensAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Issuing.Token.List.Request) async throws -> Stripe.Issuing.Token.List.Response {
        try await api.list("v1/issuing/tokens", parameters: request)
    }

    public func retrieve(
        id: Stripe.Issuing.Token.ID,
        _ request: Stripe.Issuing.Token.Retrieve.Request
    ) async throws -> Stripe.Issuing.Token.Retrieve.Response {
        try await api.list("v1/issuing/tokens/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Issuing.Token.ID,
        _ request: Stripe.Issuing.Token.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.Token.Update.Response {
        try await api.send(.POST, "v1/issuing/tokens/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IssuingTokensAPI {
    public func retrieve(id: Stripe.Issuing.Token.ID) async throws -> Stripe.Issuing.Token.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Issuing.Token.ID,
        _ request: Stripe.Issuing.Token.Update.Request
    ) async throws -> Stripe.Issuing.Token.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }
}
