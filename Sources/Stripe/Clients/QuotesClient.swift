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

/// Operations on Stripe.Billing.Quote.
///
/// A protocol so tests can substitute a double; ``QuotesClient`` is the implementation that
/// talks to Stripe.
public protocol QuotesAPI: Sendable {
    func accept(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Accept.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.Accept.Response
    func cancel(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.Cancel.Response
    func create(_ request: Stripe.Billing.Quote.Create.Request, idempotencyKey: String?) async throws -> Stripe.Billing.Quote.Create.Response
    func finalizeQuote(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.FinalizeQuote.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.FinalizeQuote.Response
    func list(_ request: Stripe.Billing.Quote.List.Request) async throws -> Stripe.Billing.Quote.List.Response
    func listComputedUpfrontLineItems(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.ListComputedUpfrontLineItems.Request
    ) async throws -> Stripe.Billing.Quote.ListComputedUpfrontLineItems.Response
    func listLineItems(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.ListLineItems.Request
    ) async throws -> Stripe.Billing.Quote.ListLineItems.Response
    func pdf(id: Stripe.Billing.Quote.ID, _ request: Stripe.Billing.Quote.Pdf.Request) async throws -> Stripe.Billing.Quote.Pdf.Response
    func retrieve(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Retrieve.Request
    ) async throws -> Stripe.Billing.Quote.Retrieve.Response
    func update(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.Update.Response
}

public struct QuotesClient: QuotesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func accept(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Accept.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.Accept.Response {
        try await api.send(.POST, "v1/quotes/\(id)/accept", body: request, idempotencyKey: idempotencyKey)
    }

    public func cancel(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.Cancel.Response {
        try await api.send(.POST, "v1/quotes/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Billing.Quote.Create.Request, idempotencyKey: String?) async throws -> Stripe.Billing.Quote.Create.Response {
        try await api.send(.POST, "v1/quotes", body: request, idempotencyKey: idempotencyKey)
    }

    public func finalizeQuote(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.FinalizeQuote.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.FinalizeQuote.Response {
        try await api.send(.POST, "v1/quotes/\(id)/finalize", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.Quote.List.Request) async throws -> Stripe.Billing.Quote.List.Response {
        try await api.list("v1/quotes", parameters: request)
    }

    public func listComputedUpfrontLineItems(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.ListComputedUpfrontLineItems.Request
    ) async throws -> Stripe.Billing.Quote.ListComputedUpfrontLineItems.Response {
        try await api.list("v1/quotes/\(id)/computed_upfront_line_items", parameters: request)
    }

    public func listLineItems(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.ListLineItems.Request
    ) async throws -> Stripe.Billing.Quote.ListLineItems.Response {
        try await api.list("v1/quotes/\(id)/line_items", parameters: request)
    }

    public func pdf(id: Stripe.Billing.Quote.ID, _ request: Stripe.Billing.Quote.Pdf.Request) async throws -> Stripe.Billing.Quote.Pdf.Response {
        try await api.download("v1/quotes/\(id)/pdf", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Retrieve.Request
    ) async throws -> Stripe.Billing.Quote.Retrieve.Response {
        try await api.list("v1/quotes/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Quote.Update.Response {
        try await api.send(.POST, "v1/quotes/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension QuotesAPI {
    public func accept(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Accept.Request
    ) async throws -> Stripe.Billing.Quote.Accept.Response {
        try await accept(id: id, request, idempotencyKey: nil)
    }

    public func accept(id: Stripe.Billing.Quote.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Quote.Accept.Response {
        try await accept(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func cancel(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Cancel.Request
    ) async throws -> Stripe.Billing.Quote.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(id: Stripe.Billing.Quote.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Quote.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(_ request: Stripe.Billing.Quote.Create.Request) async throws -> Stripe.Billing.Quote.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func create(idempotencyKey: String? = nil) async throws -> Stripe.Billing.Quote.Create.Response {
        try await create(.init(), idempotencyKey: idempotencyKey)
    }

    public func finalizeQuote(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.FinalizeQuote.Request
    ) async throws -> Stripe.Billing.Quote.FinalizeQuote.Response {
        try await finalizeQuote(id: id, request, idempotencyKey: nil)
    }

    public func finalizeQuote(id: Stripe.Billing.Quote.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Quote.FinalizeQuote.Response
    {
        try await finalizeQuote(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Billing.Quote.List.Response {
        try await list(.init())
    }

    public func listComputedUpfrontLineItems(id: Stripe.Billing.Quote.ID) async throws -> Stripe.Billing.Quote.ListComputedUpfrontLineItems.Response {
        try await listComputedUpfrontLineItems(id: id, .init())
    }

    public func listLineItems(id: Stripe.Billing.Quote.ID) async throws -> Stripe.Billing.Quote.ListLineItems.Response {
        try await listLineItems(id: id, .init())
    }

    public func pdf(id: Stripe.Billing.Quote.ID) async throws -> Stripe.Billing.Quote.Pdf.Response {
        try await pdf(id: id, .init())
    }

    public func retrieve(id: Stripe.Billing.Quote.ID) async throws -> Stripe.Billing.Quote.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.Quote.ID,
        _ request: Stripe.Billing.Quote.Update.Request
    ) async throws -> Stripe.Billing.Quote.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Billing.Quote.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Quote.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
