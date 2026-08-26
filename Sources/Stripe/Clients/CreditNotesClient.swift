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

/// Operations on Stripe.Billing.Credit.Note.
///
/// A protocol so tests can substitute a double; ``CreditNotesClient`` is the implementation that
/// talks to Stripe.
public protocol CreditNotesAPI: Sendable {
    func create(
        _ request: Stripe.Billing.Credit.Note.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Note.Create.Response
    func list(_ request: Stripe.Billing.Credit.Note.List.Request) async throws -> Stripe.Billing.Credit.Note.List.Response
    func preview(_ request: Stripe.Billing.Credit.Note.Preview.Request) async throws -> Stripe.Billing.Credit.Note.Preview.Response
    func previewLines(_ request: Stripe.Billing.Credit.Note.PreviewLines.Request) async throws -> Stripe.Billing.Credit.Note.PreviewLines.Response
    func retrieve(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Note.Retrieve.Response
    func update(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Note.Update.Response
    func voidCreditNote(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.VoidCreditNote.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Note.VoidCreditNote.Response
}

public struct CreditNotesClient: CreditNotesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func create(
        _ request: Stripe.Billing.Credit.Note.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Note.Create.Response {
        try await api.send(.POST, "v1/credit_notes", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Billing.Credit.Note.List.Request) async throws -> Stripe.Billing.Credit.Note.List.Response {
        try await api.list("v1/credit_notes", parameters: request)
    }

    public func preview(_ request: Stripe.Billing.Credit.Note.Preview.Request) async throws -> Stripe.Billing.Credit.Note.Preview.Response {
        try await api.list("v1/credit_notes/preview", parameters: request)
    }

    public func previewLines(
        _ request: Stripe.Billing.Credit.Note.PreviewLines.Request
    ) async throws -> Stripe.Billing.Credit.Note.PreviewLines.Response {
        try await api.list("v1/credit_notes/preview/lines", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.Retrieve.Request
    ) async throws -> Stripe.Billing.Credit.Note.Retrieve.Response {
        try await api.list("v1/credit_notes/\(id)", parameters: request)
    }

    public func update(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Note.Update.Response {
        try await api.send(.POST, "v1/credit_notes/\(id)", body: request, idempotencyKey: idempotencyKey)
    }

    public func voidCreditNote(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.VoidCreditNote.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.Credit.Note.VoidCreditNote.Response {
        try await api.send(.POST, "v1/credit_notes/\(id)/void", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension CreditNotesAPI {
    public func create(_ request: Stripe.Billing.Credit.Note.Create.Request) async throws -> Stripe.Billing.Credit.Note.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Billing.Credit.Note.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.Credit.Note.ID) async throws -> Stripe.Billing.Credit.Note.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.Update.Request
    ) async throws -> Stripe.Billing.Credit.Note.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(id: Stripe.Billing.Credit.Note.ID, idempotencyKey: String? = nil) async throws -> Stripe.Billing.Credit.Note.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func voidCreditNote(
        id: Stripe.Billing.Credit.Note.ID,
        _ request: Stripe.Billing.Credit.Note.VoidCreditNote.Request
    ) async throws -> Stripe.Billing.Credit.Note.VoidCreditNote.Response {
        try await voidCreditNote(id: id, request, idempotencyKey: nil)
    }

    public func voidCreditNote(
        id: Stripe.Billing.Credit.Note.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.Credit.Note.VoidCreditNote.Response {
        try await voidCreditNote(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
