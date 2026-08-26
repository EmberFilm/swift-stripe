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

//  End-to-end over a real AsyncHTTPClient connection to a local server, so the
//  assertions are on bytes that actually crossed a socket.
//

import AsyncHTTPClient
import Testing

@testable import Stripe

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

@Suite("StripeClient over a real connection")
struct IntegrationTests {

    /// Runs `body` against a client pointed at a local server.
    static func withServer(
        responses: [ScriptedResponse],
        maxRetries: Int = 0,
        _ body: (StripeClient, TestHTTPServer) async throws -> Void
    ) async throws {
        let server = try await TestHTTPServer.start(responses: responses)
        let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
        defer {
            Task {
                try? await httpClient.shutdown()
                try? await server.stop()
            }
        }

        let stripe = StripeClient(
            configuration: StripeConfiguration(
                secretKey: "sk_test_123",
                baseURL: URL(string: "http://127.0.0.1:\(server.port)")!,
                apiVersion: "2024-06-20",
                filesBaseURL: URL(string: "http://127.0.0.1:\(server.port)")!,
                maxRetries: maxRetries
            ),
            httpClient: httpClient
        )
        try await body(stripe, server)
    }

    @Test("creating a customer sends the right method, path, headers and body")
    func createCustomer() async throws {
        try await Self.withServer(responses: [
            ScriptedResponse(
                body: #"""
                    {"id":"cus_1","object":"customer","created":1680893993,"livemode":false,
                     "email":"ada@example.com","invoice_prefix":"ABC"}
                    """#
            )
        ]) { stripe, server in
            let customer = try await stripe.customers.create(
                .init(email: "ada@example.com", metadata: ["plan": "pro"], name: "Ada Lovelace")
            )

            #expect(customer.id == "cus_1")
            #expect(customer.invoicePrefix == "ABC")

            let sent = try #require(server.received.first)
            #expect(sent.method == .POST)
            #expect(sent.uri == "/v1/customers")
            #expect(sent.headers.first(name: "Authorization") == "Bearer sk_test_123")
            #expect(sent.headers.first(name: "Stripe-Version") == "2024-06-20")
            #expect(
                sent.headers.first(name: "Content-Type") == "application/x-www-form-urlencoded"
            )

            // The actual bytes on the wire.
            #expect(sent.body.contains("email=ada%40example.com"))
            #expect(sent.body.contains("name=Ada+Lovelace"))
            #expect(sent.body.contains("metadata%5Bplan%5D=pro"))  // metadata[plan]=pro
        }
    }

    @Test("list parameters go into the query string, not the body")
    func listQuery() async throws {
        try await Self.withServer(responses: [
            ScriptedResponse(body: #"{"object":"list","url":"/v1/customers","has_more":false,"data":[]}"#)
        ]) { stripe, server in
            let page = try await stripe.customers.list(.init(email: "ada@example.com", limit: 5))
            #expect(page.hasMore == false)

            let sent = try #require(server.received.first)
            #expect(sent.method == .GET)
            #expect(sent.body.isEmpty)
            #expect(sent.uri.contains("limit=5"))
            #expect(sent.uri.contains("email=ada%40example.com"))
        }
    }

    @Test("a 402 becomes a typed error with the request id")
    func declinedCard() async throws {
        try await Self.withServer(responses: [
            ScriptedResponse(
                status: 402,
                body: #"""
                    {"error":{"type":"card_error","code":"card_declined",
                              "message":"Your card was declined."}}
                    """#,
                headers: [("Request-Id", "req_test_123")]
            )
        ]) { stripe, _ in
            do {
                _ = try await stripe.customers.retrieve(id: "cus_1")
                Issue.record("expected an error")
            } catch let error as StripeClientError {
                guard case .api(let status, let stripeError, let requestID) = error else {
                    Issue.record("expected .api, got \(error)")
                    return
                }
                #expect(status == 402)
                #expect(stripeError.message == "Your card was declined.")
                #expect(requestID == "req_test_123")
            }
        }
    }

    @Test("retryable failures are retried, then succeed")
    func retries() async throws {
        let failure = ScriptedResponse(
            status: 500,
            body: #"{"error":{"type":"api_error","message":"boom"}}"#
        )
        let success = ScriptedResponse(
            body: #"{"id":"cus_1","object":"customer","created":1,"livemode":false}"#
        )

        try await Self.withServer(
            responses: [failure, failure, success],
            maxRetries: 2
        ) { stripe, server in
            let customer = try await stripe.customers.retrieve(id: "cus_1")
            #expect(customer.id == "cus_1")
            #expect(server.received.count == 3)
        }
    }

    @Test("a non-retryable failure is not retried")
    func noRetryOn4xx() async throws {
        try await Self.withServer(
            responses: [
                ScriptedResponse(
                    status: 404,
                    body: #"{"error":{"type":"invalid_request_error","message":"No such customer"}}"#
                )
            ],
            maxRetries: 3
        ) { stripe, server in
            _ = try? await stripe.customers.retrieve(id: "cus_missing")
            #expect(server.received.count == 1)
        }
    }

    @Test("connected-account requests carry Stripe-Account over the wire")
    func connectedAccount() async throws {
        let server = try await TestHTTPServer.start(responses: [
            ScriptedResponse(body: #"{"id":"cus_1","object":"customer","created":1,"livemode":false}"#)
        ])
        let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
        defer {
            Task {
                try? await httpClient.shutdown()
                try? await server.stop()
            }
        }

        let stripe = StripeClient(
            configuration: StripeConfiguration(
                secretKey: "sk_test_123",
                baseURL: URL(string: "http://127.0.0.1:\(server.port)")!,
                filesBaseURL: URL(string: "http://127.0.0.1:\(server.port)")!,
                connectedAccount: "acct_123"
            ),
            httpClient: httpClient
        )

        _ = try await stripe.customers.retrieve(id: "cus_1")
        let sent = try #require(server.received.first)
        #expect(sent.headers.first(name: "Stripe-Account") == "acct_123")
    }

    @Test("generated clients route nested, singleton and custom operations")
    func generatedClientPaths() async throws {
        try await Self.withServer(responses: [
            ScriptedResponse(body: #"{"id":"txi_1","object":"tax_id","type":"eu_vat","value":"DE1"}"#),
            ScriptedResponse(body: #"{"object":"balance","available":[],"pending":[],"livemode":false}"#),
            ScriptedResponse(body: #"{"id":"cs_1","object":"checkout.session","status":"expired"}"#),
        ]) { stripe, server in
            let taxId = try await stripe.customers.retrieveTaxId(customer: "cus_1", id: "txi_1")
            #expect(taxId.value == "DE1")
            _ = try await stripe.balance.retrieve()
            let session = try await stripe.checkoutSessions.expire(id: "cs_1", idempotencyKey: "k_1")
            #expect(session.status == .expired)

            let sent = server.received
            #expect(sent.map(\.method) == [.GET, .GET, .POST])
            #expect(
                sent.map(\.uri) == [
                    "/v1/customers/cus_1/tax_ids/txi_1", "/v1/balance", "/v1/checkout/sessions/cs_1/expire",
                ]
            )
            #expect(sent[2].headers.first(name: "Idempotency-Key") == "k_1")
        }
    }

    @Test("an upload is multipart to the files host; a PDF comes back as bytes")
    func filesHost() async throws {
        try await Self.withServer(responses: [
            ScriptedResponse(body: #"{"id":"file_1","object":"file","purpose":"dispute_evidence","size":5}"#),
            ScriptedResponse(body: "%PDF-1.7 fake"),
        ]) { stripe, server in
            let file = try await stripe.files.create(
                .init(purpose: .disputeEvidence),
                file: .init(data: Data("hello".utf8), filename: "receipt.txt", contentType: "text/plain")
            )
            #expect(file.id == "file_1")
            let pdf = try await stripe.quotes.pdf(id: "qt_1")
            #expect(String(decoding: pdf, as: UTF8.self).hasPrefix("%PDF"))

            let upload = try #require(server.received.first)
            #expect(upload.method == .POST)
            #expect(upload.uri == "/v1/files")
            let contentType = try #require(upload.headers.first(name: "Content-Type"))
            #expect(contentType.hasPrefix("multipart/form-data; boundary="))
            #expect(upload.body.contains("name=\"purpose\"\r\n\r\ndispute_evidence"))
            #expect(upload.body.contains("name=\"file\"; filename=\"receipt.txt\"\r\nContent-Type: text/plain\r\n\r\nhello"))
            #expect(server.received[1].uri == "/v1/quotes/qt_1/pdf")
        }
    }
}
