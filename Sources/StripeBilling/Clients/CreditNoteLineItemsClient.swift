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

/// Operations on Stripe.Billing.CreditNoteLineItem.
///
/// A protocol so tests can substitute a double; ``CreditNoteLineItemsClient`` is the implementation that
/// talks to Stripe.
public protocol CreditNoteLineItemsAPI: Sendable {
    func list(
        creditNote: String,
        _ request: Stripe.Billing.CreditNoteLineItem.List.Request
    ) async throws -> Stripe.Billing.CreditNoteLineItem.List.Response
}

public struct CreditNoteLineItemsClient: CreditNoteLineItemsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func list(
        creditNote: String,
        _ request: Stripe.Billing.CreditNoteLineItem.List.Request
    ) async throws -> Stripe.Billing.CreditNoteLineItem.List.Response {
        try await api.list("v1/credit_notes/\(creditNote)/lines", parameters: request)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CreditNoteLineItemsAPI {
    public func list(creditNote: String) async throws -> Stripe.Billing.CreditNoteLineItem.List.Response {
        try await list(creditNote: creditNote, .init())
    }
}
