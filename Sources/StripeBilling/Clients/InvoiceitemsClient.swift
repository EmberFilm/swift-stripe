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
import StripeProducts

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Operations on Stripe.Billing.Invoice.Item.
///
/// A protocol so tests can substitute a double; ``InvoiceitemsClient`` is the implementation that
/// talks to Stripe.
public protocol InvoiceitemsAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Invoice.Item.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Invoice.Item.Create.Response
    func delete(id: Stripe.Billing.Invoice.Item.ID, idempotencyKey: String?) async throws -> Stripe.Billing.Invoice.Item.Delete.Response
    func list(_ request: Stripe.Billing.Invoice.Item.List.Request) async throws -> Stripe.Billing.Invoice.Item.List.Response
    func retrieve(
        id: Stripe.Billing.Invoice.Item.ID,
        _ request: Stripe.Billing.Invoice.Item.Retrieve.Request
    ) async throws -> Stripe.Billing.Invoice.Item.Retrieve.Response
    func update(
        id: Stripe.Billing.Invoice.Item.ID,
        _ request: Stripe.Billing.Invoice.Item.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Invoice.Item.Update.Response
}

public struct InvoiceitemsClient: InvoiceitemsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Billing.Invoice.Item.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Invoice.Item.Create.Response {
        try await api.send(.POST, "v1/invoiceitems", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Billing.Invoice.Item.ID, idempotencyKey: String?) async throws -> Stripe.Billing.Invoice.Item.Delete.Response {
        try await api.send(.DELETE, "v1/invoiceitems/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.Invoice.Item.List.Request) async throws -> Stripe.Billing.Invoice.Item.List.Response {
        try await api.list("v1/invoiceitems", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Invoice.Item.ID,
        _ request: Stripe.Billing.Invoice.Item.Retrieve.Request
    ) async throws -> Stripe.Billing.Invoice.Item.Retrieve.Response {
        try await api.list("v1/invoiceitems/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Invoice.Item.ID,
        _ request: Stripe.Billing.Invoice.Item.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Invoice.Item.Update.Response {
        try await api.send(.POST, "v1/invoiceitems/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension InvoiceitemsAPI {
    public func create(_ request: Stripe.Billing.Invoice.Item.Create.Request) async throws -> Stripe.Billing.Invoice.Item.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Billing.Invoice.Item.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Billing.Invoice.Item.ID) async throws -> Stripe.Billing.Invoice.Item.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Billing.Invoice.Item.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.Invoice.Item.ID) async throws -> Stripe.Billing.Invoice.Item.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.Invoice.Item.ID,
        _ request: Stripe.Billing.Invoice.Item.Update.Request
    ) async throws -> Stripe.Billing.Invoice.Item.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Billing.Invoice.Item.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Invoice.Item.Update.Response
    {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
