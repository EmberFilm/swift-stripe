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
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.EphemeralKey.
///
/// A protocol so tests can substitute a double; ``EphemeralKeysClient`` is the implementation that
/// talks to Stripe.
public protocol EphemeralKeysAPI: Sendable {
    func create(_ request: Stripe.EphemeralKey.Create.Request, idempotencyKey: String?) async throws -> Stripe.EphemeralKey.Create.Response
    func delete(
        id: Stripe.EphemeralKey.ID,
        _ request: Stripe.EphemeralKey.Delete.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.EphemeralKey.Delete.Response
}

public struct EphemeralKeysClient: EphemeralKeysAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Stripe.EphemeralKey.Create.Request, idempotencyKey: String?) async throws -> Stripe.EphemeralKey.Create.Response {
        try await api.send(.POST, "v1/ephemeral_keys", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(
        id: Stripe.EphemeralKey.ID,
        _ request: Stripe.EphemeralKey.Delete.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.EphemeralKey.Delete.Response {
        try await api.send(.DELETE, "v1/ephemeral_keys/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension EphemeralKeysAPI {
    public func create(_ request: Stripe.EphemeralKey.Create.Request) async throws -> Stripe.EphemeralKey.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.EphemeralKey.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.EphemeralKey.ID, _ request: Stripe.EphemeralKey.Delete.Request) async throws -> Stripe.EphemeralKey.Delete.Response
    {
        try await delete(id: id, request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.EphemeralKey.ID, idempotencyKey: String? = nil) async throws -> Stripe.EphemeralKey.Delete.Response {
        try await delete(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
