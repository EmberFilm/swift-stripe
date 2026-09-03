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

/// Operations on Stripe.Terminal.Locations.Location.
///
/// A protocol so tests can substitute a double; ``TerminalLocationsClient`` is the implementation that
/// talks to Stripe.
public protocol TerminalLocationsAPI: Sendable {
    func create(
        _ request: Stripe.Terminal.Locations.Location.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Locations.Location.Create.Response
    func delete(id: Stripe.Terminal.Locations.Location.ID, idempotencyKey: String?) async throws -> Stripe.Terminal.Locations.Location.Delete.Response
    func list(_ request: Stripe.Terminal.Locations.Location.List.Request) async throws -> Stripe.Terminal.Locations.Location.List.Response
    func retrieve(
        id: Stripe.Terminal.Locations.Location.ID,
        _ request: Stripe.Terminal.Locations.Location.Retrieve.Request
    ) async throws -> Stripe.Terminal.Locations.Location.Retrieve.Response
    func update(
        id: Stripe.Terminal.Locations.Location.ID,
        _ request: Stripe.Terminal.Locations.Location.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Locations.Location.Update.Response
}

public struct TerminalLocationsClient: TerminalLocationsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Terminal.Locations.Location.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Locations.Location.Create.Response {
        try await api.send(.POST, "v1/terminal/locations", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(
        id: Stripe.Terminal.Locations.Location.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Locations.Location.Delete.Response {
        try await api.send(.DELETE, "v1/terminal/locations/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Terminal.Locations.Location.List.Request) async throws -> Stripe.Terminal.Locations.Location.List.Response {
        try await api.list("v1/terminal/locations", parameters: request)
    }

    public func retrieve(
        id: Stripe.Terminal.Locations.Location.ID,
        _ request: Stripe.Terminal.Locations.Location.Retrieve.Request
    ) async throws -> Stripe.Terminal.Locations.Location.Retrieve.Response {
        try await api.list("v1/terminal/locations/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Terminal.Locations.Location.ID,
        _ request: Stripe.Terminal.Locations.Location.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Locations.Location.Update.Response {
        try await api.send(.POST, "v1/terminal/locations/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TerminalLocationsAPI {
    public func create(
        _ request: Stripe.Terminal.Locations.Location.Create.Request
    ) async throws -> Stripe.Terminal.Locations.Location.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Terminal.Locations.Location.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Terminal.Locations.Location.ID) async throws -> Stripe.Terminal.Locations.Location.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Terminal.Locations.Location.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Terminal.Locations.Location.ID) async throws -> Stripe.Terminal.Locations.Location.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Terminal.Locations.Location.ID,
        _ request: Stripe.Terminal.Locations.Location.Update.Request
    ) async throws -> Stripe.Terminal.Locations.Location.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Terminal.Locations.Location.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Locations.Location.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
