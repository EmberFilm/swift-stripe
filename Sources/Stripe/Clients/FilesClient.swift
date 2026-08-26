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

/// Operations on Stripe.Files.File.
///
/// A protocol so tests can substitute a double; ``FilesClient`` is the implementation that
/// talks to Stripe.
public protocol FilesAPI: Sendable {
    func create(
        _ request: Stripe.Files.File.Create.Request,
        file: Stripe.Upload,
        idempotencyKey: String?
    ) async throws -> Stripe.Files.File.Create.Response
    func list(_ request: Stripe.Files.File.List.Request) async throws -> Stripe.Files.File.List.Response
    func retrieve(id: Stripe.Files.File.ID, _ request: Stripe.Files.File.Retrieve.Request) async throws -> Stripe.Files.File.Retrieve.Response
}

public struct FilesClient: FilesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Files.File.Create.Request,
        file: Stripe.Upload,
        idempotencyKey: String?
    ) async throws -> Stripe.Files.File.Create.Response {
        try await api.upload("v1/files", fields: request, file: file, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Files.File.List.Request) async throws -> Stripe.Files.File.List.Response {
        try await api.list("v1/files", parameters: request)
    }

    public func retrieve(id: Stripe.Files.File.ID, _ request: Stripe.Files.File.Retrieve.Request) async throws -> Stripe.Files.File.Retrieve.Response
    {
        try await api.list("v1/files/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension FilesAPI {
    public func create(_ request: Stripe.Files.File.Create.Request, file: Stripe.Upload) async throws -> Stripe.Files.File.Create.Response {
        try await create(request, file: file, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Files.File.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Files.File.ID) async throws -> Stripe.Files.File.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
