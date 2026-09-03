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
import StripeIssuing
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Tax.Registration.
///
/// A protocol so tests can substitute a double; ``TaxRegistrationsClient`` is the implementation that
/// talks to Stripe.
public protocol TaxRegistrationsAPI: Sendable {
    func create(_ request: Stripe.Tax.Registration.Create.Request, idempotencyKey: String?) async throws -> Stripe.Tax.Registration.Create.Response
    func list(_ request: Stripe.Tax.Registration.List.Request) async throws -> Stripe.Tax.Registration.List.Response
    func retrieve(
        id: Stripe.Tax.Registration.ID,
        _ request: Stripe.Tax.Registration.Retrieve.Request
    ) async throws -> Stripe.Tax.Registration.Retrieve.Response
    func update(
        id: Stripe.Tax.Registration.ID,
        _ request: Stripe.Tax.Registration.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Registration.Update.Response
}

public struct TaxRegistrationsClient: TaxRegistrationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Tax.Registration.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Registration.Create.Response {
        try await api.send(.POST, "v1/tax/registrations", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Tax.Registration.List.Request) async throws -> Stripe.Tax.Registration.List.Response {
        try await api.list("v1/tax/registrations", parameters: request)
    }

    public func retrieve(
        id: Stripe.Tax.Registration.ID,
        _ request: Stripe.Tax.Registration.Retrieve.Request
    ) async throws -> Stripe.Tax.Registration.Retrieve.Response {
        try await api.list("v1/tax/registrations/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Tax.Registration.ID,
        _ request: Stripe.Tax.Registration.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Tax.Registration.Update.Response {
        try await api.send(.POST, "v1/tax/registrations/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TaxRegistrationsAPI {
    public func create(_ request: Stripe.Tax.Registration.Create.Request) async throws -> Stripe.Tax.Registration.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Tax.Registration.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Tax.Registration.ID) async throws -> Stripe.Tax.Registration.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Tax.Registration.ID,
        _ request: Stripe.Tax.Registration.Update.Request
    ) async throws -> Stripe.Tax.Registration.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Tax.Registration.ID, idempotencyKey: String? = nil) async throws -> Stripe.Tax.Registration.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
