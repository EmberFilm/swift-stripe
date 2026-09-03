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

/// Operations on Stripe.PaymentIntents.PaymentIntent.
///
/// A protocol so tests can substitute a double; ``PaymentIntentsClient`` is the implementation that
/// talks to Stripe.
public protocol PaymentIntentsAPI: Sendable {
    func applyCustomerBalance(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Response
    func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Cancel.Response
    func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Capture.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Capture.Response
    func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Confirm.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Confirm.Response
    func create(
        _ request: Stripe.PaymentIntents.PaymentIntent.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Create.Response
    func incrementAuthorization(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.IncrementAuthorization.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.IncrementAuthorization.Response
    func list(_ request: Stripe.PaymentIntents.PaymentIntent.List.Request) async throws -> Stripe.PaymentIntents.PaymentIntent.List.Response
    func retrieve(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Retrieve.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Retrieve.Response
    func search(_ request: Stripe.PaymentIntents.PaymentIntent.Search.Request) async throws -> Stripe.PaymentIntents.PaymentIntent.Search.Response
    func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Update.Response
    func verifyMicrodeposits(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Response
}

public struct PaymentIntentsClient: PaymentIntentsAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func applyCustomerBalance(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)/apply_customer_balance", body: request, idempotencyKey: idempotencyKey)
    }

    public func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Cancel.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Cancel.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)/cancel", body: request, idempotencyKey: idempotencyKey)
    }

    public func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Capture.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Capture.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)/capture", body: request, idempotencyKey: idempotencyKey)
    }

    public func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Confirm.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Confirm.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)/confirm", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.PaymentIntents.PaymentIntent.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Create.Response {
        try await api.send(.POST, "v1/payment_intents", body: request, idempotencyKey: idempotencyKey)
    }

    public func incrementAuthorization(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.IncrementAuthorization.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.IncrementAuthorization.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)/increment_authorization", body: request, idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.PaymentIntents.PaymentIntent.List.Request) async throws -> Stripe.PaymentIntents.PaymentIntent.List.Response {
        try await api.list("v1/payment_intents", parameters: request)
    }

    public func retrieve(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Retrieve.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Retrieve.Response {
        try await api.list("v1/payment_intents/\(id)", parameters: request)
    }

    public func search(
        _ request: Stripe.PaymentIntents.PaymentIntent.Search.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Search.Response {
        try await api.list("v1/payment_intents/search", parameters: request)
    }

    public func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Update.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)", body: request, idempotencyKey: idempotencyKey)
    }

    public func verifyMicrodeposits(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Response {
        try await api.send(.POST, "v1/payment_intents/\(id)/verify_microdeposits", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension PaymentIntentsAPI {
    public func applyCustomerBalance(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Response {
        try await applyCustomerBalance(id: id, request, idempotencyKey: nil)
    }

    public func applyCustomerBalance(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.ApplyCustomerBalance.Response {
        try await applyCustomerBalance(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Cancel.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Cancel.Response {
        try await cancel(id: id, request, idempotencyKey: nil)
    }

    public func cancel(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Cancel.Response {
        try await cancel(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Capture.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Capture.Response {
        try await capture(id: id, request, idempotencyKey: nil)
    }

    public func capture(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Capture.Response {
        try await capture(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Confirm.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Confirm.Response {
        try await confirm(id: id, request, idempotencyKey: nil)
    }

    public func confirm(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Confirm.Response {
        try await confirm(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.PaymentIntents.PaymentIntent.Create.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func incrementAuthorization(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.IncrementAuthorization.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.IncrementAuthorization.Response {
        try await incrementAuthorization(id: id, request, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.PaymentIntents.PaymentIntent.List.Response {
        try await list(.init())
    }

    public func retrieve(id: Stripe.PaymentIntents.PaymentIntent.ID) async throws -> Stripe.PaymentIntents.PaymentIntent.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.Update.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func verifyMicrodeposits(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        _ request: Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Request
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Response {
        try await verifyMicrodeposits(id: id, request, idempotencyKey: nil)
    }

    public func verifyMicrodeposits(
        id: Stripe.PaymentIntents.PaymentIntent.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.PaymentIntents.PaymentIntent.VerifyMicrodeposits.Response {
        try await verifyMicrodeposits(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
