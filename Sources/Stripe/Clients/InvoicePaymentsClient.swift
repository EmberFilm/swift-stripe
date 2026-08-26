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

/// Operations on Stripe.Billing.Invoice.Payment.
///
/// A protocol so tests can substitute a double; ``InvoicePaymentsClient`` is the implementation that
/// talks to Stripe.
public protocol InvoicePaymentsAPI: Sendable {
    func list(_ request: Stripe.Billing.Invoice.Payment.List.Request) async throws -> Stripe.Billing.Invoice.Payment.List.Response
    func retrieve(
        id: Stripe.Billing.Invoice.Payment.ID,
        _ request: Stripe.Billing.Invoice.Payment.Retrieve.Request
    ) async throws -> Stripe.Billing.Invoice.Payment.Retrieve.Response
}

public struct InvoicePaymentsClient: InvoicePaymentsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(_ request: Stripe.Billing.Invoice.Payment.List.Request) async throws -> Stripe.Billing.Invoice.Payment.List.Response {
        try await api.list("v1/invoice_payments", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Invoice.Payment.ID,
        _ request: Stripe.Billing.Invoice.Payment.Retrieve.Request
    ) async throws -> Stripe.Billing.Invoice.Payment.Retrieve.Response {
        try await api.list("v1/invoice_payments/\(id)", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension InvoicePaymentsAPI {
    public func list() async throws -> Stripe.Billing.Invoice.Payment.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.Invoice.Payment.ID) async throws -> Stripe.Billing.Invoice.Payment.Retrieve.Response {
        try await retrieve(id: id, .init())
    }
}
