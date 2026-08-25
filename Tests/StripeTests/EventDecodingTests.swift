//
//  EventDecodingTests.swift
//  swift-stripe
//
//  A webhook endpoint receives whatever is enabled on it, so decoding an event
//  must not depend on this package modelling every type Stripe can send.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing

@testable import Stripe

@Suite("Event decoding")
struct EventDecodingTests {

    private static func event(_ json: String) throws -> Stripe.Events.Event {
        try StripeAPI.decoder.decode(Stripe.Events.Event.self, from: Data(json.utf8))
    }

    @Test("a modelled event decodes its type and its object")
    func modelled() throws {
        let event = try Self.event(#"""
        {"id":"evt_1","object":"event","created":1,"type":"checkout.session.completed",
         "data":{"object":{"id":"cs_1","object":"checkout.session","created":1,
                           "mode":"subscription","subscription":"sub_1"}}}
        """#)

        #expect(event.type == .checkoutSessionCompleted)
        #expect(event.rawType == "checkout.session.completed")
        guard case .checkoutSession(let session) = try #require(event.data?.object) else {
            Issue.record("expected a checkout session")
            return
        }
        #expect(session.id == "cs_1")
        #expect(session.subscription == "sub_1")
    }

    @Test("an event type this package does not model still decodes")
    func unknownType() throws {
        let event = try Self.event(#"""
        {"id":"evt_2","object":"event","created":1,"type":"some.brand.new_event",
         "data":{"object":{"id":"obj_1","object":"customer","created":1}}}
        """#)

        #expect(event.id == "evt_2")
        #expect(event.type == nil)
        #expect(event.rawType == "some.brand.new_event")
    }

    @Test("an object this package does not model decodes as .unknown, not a failure")
    func unknownObject() throws {
        let event = try Self.event(#"""
        {"id":"evt_3","object":"event","created":1,"type":"invoice.paid",
         "data":{"object":{"id":"obj_1","object":"some_future_resource"}}}
        """#)

        #expect(event.type == .invoicePaid)
        #expect(event.data?.object == .unknown(type: "some_future_resource"))
    }

    @Test("every modelled object type is still reachable after the decoder split")
    func allObjectTypesReachable() throws {
        // The decoder is split across groups by hand; this guards against a case being dropped.
        for (object, expected) in [
            ("charge", "charge"), ("customer", "customer"), ("invoice", "invoice"),
            ("subscription", "subscription"), ("checkout.session", "checkoutSession"),
            ("payment_intent", "paymentIntent"), ("transfer", "transfer"),
            ("account", "account"), ("payout", "payout"), ("refund", "refund"),
        ] {
            let event = try Self.event(#"""
            {"id":"evt_x","object":"event","created":1,"type":"charge.succeeded",
             "data":{"object":{"id":"obj_1","object":"\#(object)","created":1}}}
            """#)
            let decoded = try #require(event.data?.object)
            #expect(
                String(describing: decoded).hasPrefix(expected),
                "\(object) decoded as \(String(describing: decoded).prefix(30))"
            )
        }
    }

    @Test("a subscription invoice reports its subscription under parent")
    func invoiceParent() throws {
        // Where `subscription` has lived since API version 2025-03-31.basil.
        let event = try Self.event(#"""
        {"id":"evt_4","object":"event","created":1,"type":"invoice.paid",
         "data":{"object":{"id":"in_1","object":"invoice","created":1,
                           "parent":{"type":"subscription_details",
                                     "subscription_details":{"subscription":"sub_9",
                                                             "metadata":{"user_id":"u_1"}}}}}}
        """#)

        guard case .invoice(let invoice) = try #require(event.data?.object) else {
            Issue.record("expected an invoice")
            return
        }
        #expect(invoice.parent?.type == .subscriptionDetails)
        #expect(invoice.parent?.subscriptionDetails?.subscription == "sub_9")
        // Metadata keys are data, not field names: `.convertFromSnakeCase` does not touch them.
        #expect(invoice.parent?.subscriptionDetails?.metadata?["user_id"] == "u_1")
    }
}
