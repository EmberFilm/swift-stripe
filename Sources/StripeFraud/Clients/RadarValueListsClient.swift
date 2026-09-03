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

/// Operations on Stripe.Fraud.ValueLists.ValueList.
///
/// A protocol so tests can substitute a double; ``RadarValueListsClient`` is the implementation that
/// talks to Stripe.
public protocol RadarValueListsAPI: Sendable {
    func create(
        _ request: Stripe.Fraud.ValueLists.ValueList.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Create.Response
    func delete(id: Stripe.Fraud.ValueLists.ValueList.ID, idempotencyKey: String?) async throws -> Stripe.Fraud.ValueLists.ValueList.Delete.Response
    func list(_ request: Stripe.Fraud.ValueLists.ValueList.List.Request) async throws -> Stripe.Fraud.ValueLists.ValueList.List.Response
    func retrieve(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        _ request: Stripe.Fraud.ValueLists.ValueList.Retrieve.Request
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Retrieve.Response
    func update(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        _ request: Stripe.Fraud.ValueLists.ValueList.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Update.Response
}

public struct RadarValueListsClient: RadarValueListsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Fraud.ValueLists.ValueList.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Create.Response {
        try await api.send(.POST, "v1/radar/value_lists", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Delete.Response {
        try await api.send(.DELETE, "v1/radar/value_lists/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Fraud.ValueLists.ValueList.List.Request) async throws -> Stripe.Fraud.ValueLists.ValueList.List.Response {
        try await api.list("v1/radar/value_lists", parameters: request)
    }

    public func retrieve(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        _ request: Stripe.Fraud.ValueLists.ValueList.Retrieve.Request
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Retrieve.Response {
        try await api.list("v1/radar/value_lists/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        _ request: Stripe.Fraud.ValueLists.ValueList.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Update.Response {
        try await api.send(.POST, "v1/radar/value_lists/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension RadarValueListsAPI {
    public func create(_ request: Stripe.Fraud.ValueLists.ValueList.Create.Request) async throws -> Stripe.Fraud.ValueLists.ValueList.Create.Response
    {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.Fraud.ValueLists.ValueList.ID) async throws -> Stripe.Fraud.ValueLists.ValueList.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Fraud.ValueLists.ValueList.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Fraud.ValueLists.ValueList.ID) async throws -> Stripe.Fraud.ValueLists.ValueList.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        _ request: Stripe.Fraud.ValueLists.ValueList.Update.Request
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Fraud.ValueLists.ValueList.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Fraud.ValueLists.ValueList.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
