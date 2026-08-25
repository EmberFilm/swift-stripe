//
//  PortalSessionsTests.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing

@testable import Stripe

@Suite("Billing portal sessions")
struct PortalSessionsTests {

    @Test("creating a session posts to billing_portal and decodes the short-lived URL")
    func create() async throws {
        try await IntegrationTests.withServer(responses: [
            ScriptedResponse(body: #"""
            {"id":"bps_1","object":"billing_portal.session","created":1680893993,
             "customer":"cus_1","livemode":false,"return_url":"https://example.com/account",
             "url":"https://billing.stripe.com/session/live_YWNj"}
            """#)
        ]) { stripe, server in
            let session = try await stripe.portalSessions.create(
                .init(customer: "cus_1", returnUrl: "https://example.com/account")
            )

            #expect(session.id == "bps_1")
            #expect(session.customer == "cus_1")
            #expect(session.url == "https://billing.stripe.com/session/live_YWNj")
            #expect(session.returnUrl == "https://example.com/account")

            let sent = try #require(server.received.first)
            #expect(sent.method == .POST)
            #expect(sent.uri == "/v1/billing_portal/sessions")
            #expect(sent.body.contains("customer=cus_1"))
            // return_url, not returnUrl, and percent-encoded.
            #expect(sent.body.contains("return_url=https%3A%2F%2Fexample.com%2Faccount"))
        }
    }

    @Test("a session create takes an idempotency key like any other write")
    func idempotencyKey() async throws {
        try await IntegrationTests.withServer(responses: [
            ScriptedResponse(body: #"""
            {"id":"bps_1","object":"billing_portal.session","created":1,"url":"https://b.stripe.com/s"}
            """#)
        ]) { stripe, server in
            _ = try await stripe.portalSessions.create(
                .init(customer: "cus_1", returnUrl: "https://example.com/account"),
                idempotencyKey: "portal-cus_1"
            )
            #expect(
                server.received.first?.headers.first(name: "Idempotency-Key") == "portal-cus_1"
            )
        }
    }
}
