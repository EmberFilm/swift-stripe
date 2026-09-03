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

/// Operations on Stripe.Billing.InvoiceRenderingTemplate.
///
/// A protocol so tests can substitute a double; ``InvoiceRenderingTemplatesClient`` is the implementation that
/// talks to Stripe.
public protocol InvoiceRenderingTemplatesAPI: Sendable {
    func archive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Archive.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Archive.Response
    func list(_ request: Stripe.Billing.InvoiceRenderingTemplate.List.Request) async throws -> Stripe.Billing.InvoiceRenderingTemplate.List.Response
    func retrieve(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Retrieve.Request
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Retrieve.Response
    func unarchive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Response
}

public struct InvoiceRenderingTemplatesClient: InvoiceRenderingTemplatesAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func archive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Archive.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Archive.Response {
        try await api.send(.POST, "v1/invoice_rendering_templates/\(id)/archive", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(
        _ request: Stripe.Billing.InvoiceRenderingTemplate.List.Request
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.List.Response {
        try await api.list("v1/invoice_rendering_templates", parameters: request)
    }

    public func retrieve(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Retrieve.Request
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Retrieve.Response {
        try await api.list("v1/invoice_rendering_templates/\(id)", parameters: request)
    }

    public func unarchive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Response {
        try await api.send(.POST, "v1/invoice_rendering_templates/\(id)/unarchive", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension InvoiceRenderingTemplatesAPI {
    public func archive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Archive.Request
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Archive.Response {
        try await archive(id: id, request, idempotencyKey: nil)
    }

    public func archive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Archive.Response {
        try await archive(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func list() async throws -> Stripe.Billing.InvoiceRenderingTemplate.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.Billing.InvoiceRenderingTemplate.ID) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func unarchive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        _ request: Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Request
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Response {
        try await unarchive(id: id, request, idempotencyKey: nil)
    }

    public func unarchive(
        id: Stripe.Billing.InvoiceRenderingTemplate.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Billing.InvoiceRenderingTemplate.Unarchive.Response {
        try await unarchive(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
