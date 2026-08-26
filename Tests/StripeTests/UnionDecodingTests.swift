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

import Testing

@testable import Stripe

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// The three union shapes the generator expresses: a `type`-selected payload (`Details`), a.
/// resource union told apart by `object` (`PaymentSource`), and the event catalogue
/// (`Event.Object`, `Event.Type`).
@Suite("Union decoding")
struct UnionDecodingTests {
    private static func decode<T: Decodable>(_ type: T.Type, _ json: String) throws -> T {
        try StripeAPI.decoder.decode(type, from: Data(json.utf8))
    }

    @Test("a type-selected payload decodes into the matching case and reads through its accessor")
    func detailsCase() throws {
        let charge = try Self.decode(
            Stripe.Charges.Charge.self,
            """
            {"id": "ch_1", "object": "charge",
             "payment_method_details": {"type": "card", "card": {"brand": "visa", "last4": "4242"},
                                        "sepa_debit": {"last4": "0000"}}}
            """
        )
        let details = try #require(charge.paymentMethodDetails?.details)
        guard case .card(let card) = details else {
            Issue.record("expected .card, got \(details)")
            return
        }
        #expect(card.brand == "visa")
        #expect(card.last4 == "4242")
        #expect(details.card?.last4 == "4242")
        #expect(details.sepaDebit == nil, "only the payload `type` names is selected")
        #expect(charge.paymentMethodDetails?.type == "card")
    }

    @Test("a type this package does not model is carried, not rejected")
    func detailsUnknown() throws {
        let charge = try Self.decode(
            Stripe.Charges.Charge.self,
            """
            {"id": "ch_1", "object": "charge", "payment_method_details": {"type": "space_bucks"}}
            """
        )
        #expect(charge.paymentMethodDetails?.details == .unknown(type: "space_bucks"))

        // a known type whose payload is missing is not a decoding failure either
        let bare = try Self.decode(
            Stripe.Charges.Charge.self,
            """
            {"id": "ch_1", "object": "charge", "payment_method_details": {"type": "card"}}
            """
        )
        #expect(bare.paymentMethodDetails?.details == .unknown(type: "card"))
    }

    @Test("a union round-trips through the encoder under its own key")
    func detailsEncoding() throws {
        let charge = try Self.decode(
            Stripe.Charges.Charge.self,
            """
            {"id": "ch_1", "object": "charge", "amount": 500,
             "payment_method_details": {"type": "card", "card": {"brand": "visa"}}}
            """
        )
        let data = try JSONEncoder().encode(charge)
        let back = try JSONDecoder().decode(Stripe.Charges.Charge.self, from: data)
        #expect(back.paymentMethodDetails?.details.card?.brand == "visa")
        #expect(back.paymentMethodDetails?.type == "card")
        #expect(back.amount == 500)
    }

    @Test("a root resource with a type-selected payload keeps its id and the payload")
    func rootUnion() throws {
        let method = try Self.decode(
            Stripe.PaymentMethods.PaymentMethod.self,
            """
            {"id": "pm_1", "object": "payment_method", "type": "sepa_debit",
             "sepa_debit": {"last4": "3000", "country": "DE"}, "customer": "cus_1"}
            """
        )
        #expect(method.id == "pm_1")
        #expect(method.type == .sepaDebit)
        #expect(method.details.sepaDebit?.last4 == "3000")
        #expect(method.customer == "cus_1")
    }

    @Test("a resource union decodes by its object value")
    func paymentSource() throws {
        let sources = try Self.decode(
            [Stripe.PaymentSource].self,
            """
            [{"id": "card_1", "object": "card", "brand": "Visa", "last4": "4242"},
             {"id": "ba_1", "object": "bank_account", "last4": "6789"},
             {"id": "x_1", "object": "crypto_wallet"}]
            """
        )
        #expect(sources.count == 3)
        #expect(sources[0].card?.last4 == "4242")
        #expect(sources[1].bankAccount?.last4 == "6789")
        #expect(sources[2] == .unknown(object: "crypto_wallet"))
    }

    @Test("an event carries its object as the matching case, or as unknown")
    func eventObject() throws {
        let event = try Self.decode(
            Stripe.Events.Event.self,
            """
            {"id": "evt_1", "object": "event", "created": 1, "api_version": "2026-07-29.dahlia", "livemode": false, "pending_webhooks": 0, "type": "checkout.session.completed",
             "data": {"object": {"id": "cs_1", "object": "checkout.session", "status": "complete"}}}
            """
        )
        #expect(event.type == .checkoutSessionCompleted)
        guard case .checkoutSession(let session) = event.data.object else {
            Issue.record("expected .checkoutSession")
            return
        }
        #expect(session.id == "cs_1")

        let other = try Self.decode(
            Stripe.Events.Event.self,
            """
            {"id": "evt_2", "object": "event", "created": 1, "api_version": "2026-07-29.dahlia", "livemode": false, "pending_webhooks": 0, "type": "emberfilm.made_up.event",
             "data": {"object": {"id": "wd_1", "object": "emberfilm.widget"}}}
            """
        )
        #expect(other.type == nil, "a type the enum lacks decodes as nil")
        #expect(other.rawType == "emberfilm.made_up.event")
        #expect(other.data.object == .unknown(type: "emberfilm.widget"))
    }
}
