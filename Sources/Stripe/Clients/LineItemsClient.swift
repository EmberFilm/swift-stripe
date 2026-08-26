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

/// Operations on Stripe.Billing.Invoice.LineItem.
///
/// A protocol so tests can substitute a double; ``LineItemsClient`` is the implementation that
/// talks to Stripe.
public protocol LineItemsAPI: Sendable {
    func list(invoice: String, _ request: Stripe.Billing.Invoice.LineItem.List.Request) async throws -> Stripe.Billing.Invoice.LineItem.List.Response
    func update(
        invoice: String,
        lineItemId: String,
        _ request: Stripe.Billing.Invoice.LineItem.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Invoice.LineItem.Update.Response
}

public struct LineItemsClient: LineItemsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        invoice: String,
        _ request: Stripe.Billing.Invoice.LineItem.List.Request
    ) async throws -> Stripe.Billing.Invoice.LineItem.List.Response {
        try await api.list("v1/invoices/\(invoice)/lines", parameters: request)
    }

    public func update(
        invoice: String,
        lineItemId: String,
        _ request: Stripe.Billing.Invoice.LineItem.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Invoice.LineItem.Update.Response {
        try await api.send(.POST, "v1/invoices/\(invoice)/lines/\(lineItemId)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension LineItemsAPI {
    public func list(invoice: String) async throws -> Stripe.Billing.Invoice.LineItem.List.Response {
        try await list(invoice: invoice, .init())
    }

    public func update(
        invoice: String,
        lineItemId: String,
        _ request: Stripe.Billing.Invoice.LineItem.Update.Request
    ) async throws -> Stripe.Billing.Invoice.LineItem.Update.Response {
        try await update(invoice: invoice, lineItemId: lineItemId, request, idempotencyKey: nil)
    }

    public func update(
        invoice: String,
        lineItemId: String,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.Invoice.LineItem.Update.Response {
        try await update(invoice: invoice, lineItemId: lineItemId, .init(), idempotencyKey: idempotencyKey)
    }
}
