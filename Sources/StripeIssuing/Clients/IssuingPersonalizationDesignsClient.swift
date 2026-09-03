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

/// Operations on Stripe.Issuing.PersonalizationDesign.
///
/// A protocol so tests can substitute a double; ``IssuingPersonalizationDesignsClient`` is the implementation that
/// talks to Stripe.
public protocol IssuingPersonalizationDesignsAPI: Sendable {
    func activate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Activate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Activate.Response
    func create(
        _ request: Stripe.Issuing.PersonalizationDesign.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Create.Response
    func deactivate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Deactivate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Deactivate.Response
    func list(_ request: Stripe.Issuing.PersonalizationDesign.List.Request) async throws -> Stripe.Issuing.PersonalizationDesign.List.Response
    func reject(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Reject.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Reject.Response
    func retrieve(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Retrieve.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Retrieve.Response
    func update(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Update.Response
}

public struct IssuingPersonalizationDesignsClient: IssuingPersonalizationDesignsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func activate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Activate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Activate.Response {
        try await api.send(.POST, "v1/test_helpers/issuing/personalization_designs/\(id)/activate", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Issuing.PersonalizationDesign.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Create.Response {
        try await api.send(.POST, "v1/issuing/personalization_designs", body: request, idempotencyKey: idempotencyKey)
    }

    public func deactivate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Deactivate.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Deactivate.Response {
        try await api.send(.POST, "v1/test_helpers/issuing/personalization_designs/\(id)/deactivate", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Issuing.PersonalizationDesign.List.Request) async throws -> Stripe.Issuing.PersonalizationDesign.List.Response
    {
        try await api.list("v1/issuing/personalization_designs", parameters: request)
    }

    public func reject(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Reject.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Reject.Response {
        try await api.send(.POST, "v1/test_helpers/issuing/personalization_designs/\(id)/reject", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Retrieve.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Retrieve.Response {
        try await api.list("v1/issuing/personalization_designs/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Update.Response {
        try await api.send(.POST, "v1/issuing/personalization_designs/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension IssuingPersonalizationDesignsAPI {
    public func activate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Activate.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Activate.Response {
        try await activate(id: id, request, idempotencyKey: nil)
    }

    public func activate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Activate.Response {
        try await activate(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Issuing.PersonalizationDesign.Create.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func deactivate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Deactivate.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Deactivate.Response {
        try await deactivate(id: id, request, idempotencyKey: nil)
    }

    public func deactivate(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Deactivate.Response {
        try await deactivate(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Issuing.PersonalizationDesign.List.Response {
        try await list(.init())
    }

    public func reject(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Reject.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Reject.Response {
        try await reject(id: id, request, idempotencyKey: nil)
    }

    public func retrieve(id: Stripe.Issuing.PersonalizationDesign.ID) async throws -> Stripe.Issuing.PersonalizationDesign.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        _ request: Stripe.Issuing.PersonalizationDesign.Update.Request
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Issuing.PersonalizationDesign.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Issuing.PersonalizationDesign.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
