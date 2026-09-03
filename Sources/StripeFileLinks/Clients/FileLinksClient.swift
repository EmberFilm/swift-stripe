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

/// Operations on Stripe.FileLinks.FileLink.
///
/// A protocol so tests can substitute a double; ``FileLinksClient`` is the implementation that
/// talks to Stripe.
public protocol FileLinksAPI: Sendable {
    func create(
        _ request: Stripe.FileLinks.FileLink.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.FileLinks.FileLink.Create.Response
    func list(_ request: Stripe.FileLinks.FileLink.List.Request) async throws -> Stripe.FileLinks.FileLink.List.Response
    func retrieve(
        id: Stripe.FileLinks.FileLink.ID,
        _ request: Stripe.FileLinks.FileLink.Retrieve.Request
    ) async throws -> Stripe.FileLinks.FileLink.Retrieve.Response
    func update(
        id: Stripe.FileLinks.FileLink.ID,
        _ request: Stripe.FileLinks.FileLink.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.FileLinks.FileLink.Update.Response
}

public struct FileLinksClient: FileLinksAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.FileLinks.FileLink.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.FileLinks.FileLink.Create.Response {
        try await api.send(.POST, "v1/file_links", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.FileLinks.FileLink.List.Request) async throws -> Stripe.FileLinks.FileLink.List.Response {
        try await api.list("v1/file_links", parameters: request)
    }

    public func retrieve(
        id: Stripe.FileLinks.FileLink.ID,
        _ request: Stripe.FileLinks.FileLink.Retrieve.Request
    ) async throws -> Stripe.FileLinks.FileLink.Retrieve.Response {
        try await api.list("v1/file_links/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.FileLinks.FileLink.ID,
        _ request: Stripe.FileLinks.FileLink.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.FileLinks.FileLink.Update.Response {
        try await api.send(.POST, "v1/file_links/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension FileLinksAPI {
    public func create(_ request: Stripe.FileLinks.FileLink.Create.Request) async throws -> Stripe.FileLinks.FileLink.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.FileLinks.FileLink.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.FileLinks.FileLink.ID) async throws -> Stripe.FileLinks.FileLink.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.FileLinks.FileLink.ID,
        _ request: Stripe.FileLinks.FileLink.Update.Request
    ) async throws -> Stripe.FileLinks.FileLink.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.FileLinks.FileLink.ID, idempotencyKey: String? = nil) async throws -> Stripe.FileLinks.FileLink.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
