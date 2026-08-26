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

/// Operations on Stripe.Terminal.Readers.Reader.
///
/// A protocol so tests can substitute a double; ``TerminalReadersClient`` is the implementation that
/// talks to Stripe.
public protocol TerminalReadersAPI: Sendable {
    func cancelAction(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CancelAction.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.CancelAction.Response
    func collectInputs(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CollectInputs.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.CollectInputs.Response
    func collectPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CollectPaymentMethod.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.CollectPaymentMethod.Response
    func confirmPaymentIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ConfirmPaymentIntent.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.ConfirmPaymentIntent.Response
    func create(
        _ request: Stripe.Terminal.Readers.Reader.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.Create.Response
    func delete(id: Stripe.Terminal.Readers.Reader.ID, idempotencyKey: String?) async throws -> Stripe.Terminal.Readers.Reader.Delete.Response
    func list(_ request: Stripe.Terminal.Readers.Reader.List.Request) async throws -> Stripe.Terminal.Readers.Reader.List.Response
    func presentPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Response
    func processPaymentIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ProcessPaymentIntent.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.ProcessPaymentIntent.Response
    func processSetupIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ProcessSetupIntent.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.ProcessSetupIntent.Response
    func refundPayment(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.RefundPayment.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.RefundPayment.Response
    func retrieve(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.Retrieve.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.Retrieve.Response
    func setReaderDisplay(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.SetReaderDisplay.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.SetReaderDisplay.Response
    func succeedInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.SucceedInputCollection.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.SucceedInputCollection.Response
    func timeoutInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Response
    func update(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.Update.Response
}

public struct TerminalReadersClient: TerminalReadersAPI {
    private let api: StripeAPI

    public init(api: StripeAPI) { self.api = api }

    public func cancelAction(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CancelAction.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.CancelAction.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/cancel_action", body: request, idempotencyKey: idempotencyKey)
    }

    public func collectInputs(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CollectInputs.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.CollectInputs.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/collect_inputs", body: request, idempotencyKey: idempotencyKey)
    }

    public func collectPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CollectPaymentMethod.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.CollectPaymentMethod.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/collect_payment_method", body: request, idempotencyKey: idempotencyKey)
    }

    public func confirmPaymentIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ConfirmPaymentIntent.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.ConfirmPaymentIntent.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/confirm_payment_intent", body: request, idempotencyKey: idempotencyKey)
    }

    public func create(
        _ request: Stripe.Terminal.Readers.Reader.Create.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.Create.Response {
        try await api.send(.POST, "v1/terminal/readers", body: request, idempotencyKey: idempotencyKey)
    }

    public func delete(id: Stripe.Terminal.Readers.Reader.ID, idempotencyKey: String?) async throws -> Stripe.Terminal.Readers.Reader.Delete.Response
    {
        try await api.send(.DELETE, "v1/terminal/readers/\(id)", idempotencyKey: idempotencyKey)
    }

    public func list(_ request: Stripe.Terminal.Readers.Reader.List.Request) async throws -> Stripe.Terminal.Readers.Reader.List.Response {
        try await api.list("v1/terminal/readers", parameters: request)
    }

    public func presentPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Response {
        try await api.send(.POST, "v1/test_helpers/terminal/readers/\(id)/present_payment_method", body: request, idempotencyKey: idempotencyKey)
    }

    public func processPaymentIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ProcessPaymentIntent.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.ProcessPaymentIntent.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/process_payment_intent", body: request, idempotencyKey: idempotencyKey)
    }

    public func processSetupIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ProcessSetupIntent.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.ProcessSetupIntent.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/process_setup_intent", body: request, idempotencyKey: idempotencyKey)
    }

    public func refundPayment(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.RefundPayment.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.RefundPayment.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/refund_payment", body: request, idempotencyKey: idempotencyKey)
    }

    public func retrieve(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.Retrieve.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.Retrieve.Response {
        try await api.list("v1/terminal/readers/\(id)", parameters: request)
    }

    public func setReaderDisplay(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.SetReaderDisplay.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.SetReaderDisplay.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)/set_reader_display", body: request, idempotencyKey: idempotencyKey)
    }

    public func succeedInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.SucceedInputCollection.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.SucceedInputCollection.Response {
        try await api.send(.POST, "v1/test_helpers/terminal/readers/\(id)/succeed_input_collection", body: request, idempotencyKey: idempotencyKey)
    }

    public func timeoutInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Response {
        try await api.send(.POST, "v1/test_helpers/terminal/readers/\(id)/timeout_input_collection", body: request, idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.Update.Request,
        idempotencyKey: String?
    ) async throws -> Stripe.Terminal.Readers.Reader.Update.Response {
        try await api.send(.POST, "v1/terminal/readers/\(id)", body: request, idempotencyKey: idempotencyKey)
    }
}

// A write with no explicit key behaves as it did before idempotency keys existed: no header,
// and no retry. See ``StripeAPI/isSafeToRetry(_:)``.
extension TerminalReadersAPI {
    public func cancelAction(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CancelAction.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.CancelAction.Response {
        try await cancelAction(id: id, request, idempotencyKey: nil)
    }

    public func cancelAction(
        id: Stripe.Terminal.Readers.Reader.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Readers.Reader.CancelAction.Response {
        try await cancelAction(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func collectInputs(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CollectInputs.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.CollectInputs.Response {
        try await collectInputs(id: id, request, idempotencyKey: nil)
    }

    public func collectPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.CollectPaymentMethod.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.CollectPaymentMethod.Response {
        try await collectPaymentMethod(id: id, request, idempotencyKey: nil)
    }

    public func confirmPaymentIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ConfirmPaymentIntent.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.ConfirmPaymentIntent.Response {
        try await confirmPaymentIntent(id: id, request, idempotencyKey: nil)
    }

    public func create(_ request: Stripe.Terminal.Readers.Reader.Create.Request) async throws -> Stripe.Terminal.Readers.Reader.Create.Response {
        try await create(request, idempotencyKey: nil)
    }

    public func delete(id: Stripe.Terminal.Readers.Reader.ID) async throws -> Stripe.Terminal.Readers.Reader.Delete.Response {
        try await delete(id: id, idempotencyKey: nil)
    }

    public func list() async throws -> Stripe.Terminal.Readers.Reader.List.Response {
        try await list(.init())
    }

    public func presentPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Response {
        try await presentPaymentMethod(id: id, request, idempotencyKey: nil)
    }

    public func presentPaymentMethod(
        id: Stripe.Terminal.Readers.Reader.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Readers.Reader.PresentPaymentMethod.Response {
        try await presentPaymentMethod(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func processPaymentIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ProcessPaymentIntent.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.ProcessPaymentIntent.Response {
        try await processPaymentIntent(id: id, request, idempotencyKey: nil)
    }

    public func processSetupIntent(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.ProcessSetupIntent.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.ProcessSetupIntent.Response {
        try await processSetupIntent(id: id, request, idempotencyKey: nil)
    }

    public func refundPayment(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.RefundPayment.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.RefundPayment.Response {
        try await refundPayment(id: id, request, idempotencyKey: nil)
    }

    public func refundPayment(
        id: Stripe.Terminal.Readers.Reader.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Readers.Reader.RefundPayment.Response {
        try await refundPayment(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func retrieve(id: Stripe.Terminal.Readers.Reader.ID) async throws -> Stripe.Terminal.Readers.Reader.Retrieve.Response {
        try await retrieve(id: id, .init())
    }

    public func setReaderDisplay(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.SetReaderDisplay.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.SetReaderDisplay.Response {
        try await setReaderDisplay(id: id, request, idempotencyKey: nil)
    }

    public func succeedInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.SucceedInputCollection.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.SucceedInputCollection.Response {
        try await succeedInputCollection(id: id, request, idempotencyKey: nil)
    }

    public func succeedInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Readers.Reader.SucceedInputCollection.Response {
        try await succeedInputCollection(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func timeoutInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Response {
        try await timeoutInputCollection(id: id, request, idempotencyKey: nil)
    }

    public func timeoutInputCollection(
        id: Stripe.Terminal.Readers.Reader.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Readers.Reader.TimeoutInputCollection.Response {
        try await timeoutInputCollection(id: id, .init(), idempotencyKey: idempotencyKey)
    }

    public func update(
        id: Stripe.Terminal.Readers.Reader.ID,
        _ request: Stripe.Terminal.Readers.Reader.Update.Request
    ) async throws -> Stripe.Terminal.Readers.Reader.Update.Response {
        try await update(id: id, request, idempotencyKey: nil)
    }

    public func update(
        id: Stripe.Terminal.Readers.Reader.ID,
        idempotencyKey: String? = nil
    ) async throws -> Stripe.Terminal.Readers.Reader.Update.Response {
        try await update(id: id, .init(), idempotencyKey: idempotencyKey)
    }
}
