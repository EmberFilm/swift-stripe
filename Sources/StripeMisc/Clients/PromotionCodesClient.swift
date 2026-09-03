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

/// Operations on Promotion.Code.
///
/// A protocol so tests can substitute a double; ``PromotionCodesClient`` is the implementation that
/// talks to Stripe.
public protocol PromotionCodesAPI: Sendable {
    func create(_ request: Promotion.Code.Create.Request, idempotencyKey: String?) async throws -> Promotion.Code.Create.Response
    func list(_ request: Promotion.Code.List.Request) async throws -> Promotion.Code.List.Response
    func retrieve(id: Promotion.Code.ID, _ request: Promotion.Code.Retrieve.Request) async throws -> Promotion.Code.Retrieve.Response
    func update(
        id: Promotion.Code.ID,
        _ request: Promotion.Code.Update.Request,
        idempotencyKey: String?
    ) async throws -> Promotion.Code.Update.Response
}

public struct PromotionCodesClient: PromotionCodesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(_ request: Promotion.Code.Create.Request, idempotencyKey: String?) async throws -> Promotion.Code.Create.Response {
        try await api.send(.POST, "v1/promotion_codes", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Promotion.Code.List.Request) async throws -> Promotion.Code.List.Response {
        try await api.list("v1/promotion_codes", parameters: request)
    }

    public func retrieve(id: Promotion.Code.ID, _ request: Promotion.Code.Retrieve.Request) async throws -> Promotion.Code.Retrieve.Response {
        try await api.list("v1/promotion_codes/\(id)", parameters: request)
    }

    public func update(
        id: Promotion.Code.ID,
        _ request: Promotion.Code.Update.Request,
        idempotencyKey: String?
    ) async throws -> Promotion.Code.Update.Response {
        try await api.send(.POST, "v1/promotion_codes/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PromotionCodesAPI {
    public func create(_ request: Promotion.Code.Create.Request) async throws -> Promotion.Code.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Promotion.Code.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Promotion.Code.ID) async throws -> Promotion.Code.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(id: Promotion.Code.ID, _ request: Promotion.Code.Update.Request) async throws -> Promotion.Code.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Promotion.Code.ID, idempotencyKey: String? = nil) async throws -> Promotion.Code.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
