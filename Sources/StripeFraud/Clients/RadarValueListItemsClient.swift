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

/// Operations on Stripe.Fraud.ValueListItems.ValueListItem.
///
/// A protocol so tests can substitute a double; ``RadarValueListItemsClient`` is the implementation that
/// talks to Stripe.
public protocol RadarValueListItemsAPI: Sendable {
    func create(
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Create.Response
    func delete(item: String, idempotencyKey: String?) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Delete.Response
    func list(
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.List.Request
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.List.Response
    func retrieve(
        item: String,
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.Retrieve.Request
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Retrieve.Response
}

public struct RadarValueListItemsClient: RadarValueListItemsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Create.Response {
        try await api.send(.POST, "v1/radar/value_list_items", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(item: String, idempotencyKey: String?) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Delete.Response {
        try await api.send(.DELETE, "v1/radar/value_list_items/\(item)", idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.List.Request
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.List.Response {
        try await api.list("v1/radar/value_list_items", parameters: request)
    }

    public func retrieve(
        item: String,
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.Retrieve.Request
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Retrieve.Response {
        try await api.list("v1/radar/value_list_items/\(item)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension RadarValueListItemsAPI {
    public func create(
        _ request: Stripe.Fraud.ValueListItems.ValueListItem.Create.Request
    ) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(item: String) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Delete.Response {
        try await delete(item: item, idempotencyKey: nil)
    }

    public func retrieve(item: String) async throws -> Stripe.Fraud.ValueListItems.ValueListItem.Retrieve.Response {
        try await retrieve(item: item, .init())
    }
}
