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

//  The `Idempotency-Key` header and the retry policy it unlocks.
//

import AsyncHTTPClient
import NIOHTTP1
import Testing

@testable import Stripe

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

@Suite("Idempotency keys")
struct IdempotencyTests {

    private static func api() -> StripeAPI {
        StripeAPI(
            configuration: StripeConfiguration(secretKey: "sk_test_123"),
            httpClient: .shared
        )
    }

    @Test("a key becomes the Idempotency-Key header")
    func headerSent() throws {
        let request = try Self.api().makeRequest(
            .POST,
            "v1/customers",
            idempotencyKey: "customer-42"
        )
        #expect(request.headers.first(name: "Idempotency-Key") == "customer-42")
    }

    @Test("no key means no header")
    func headerAbsent() throws {
        let request = try Self.api().makeRequest(.POST, "v1/customers")
        #expect(request.headers.contains(name: "Idempotency-Key") == false)
    }

    @Test("reads are retryable; writes are retryable only with a key")
    func retryPolicy() throws {
        let api = Self.api()

        #expect(StripeAPI.isSafeToRetry(try api.makeRequest(.GET, "v1/customers/cus_1")))
        #expect(StripeAPI.isSafeToRetry(try api.makeRequest(.POST, "v1/customers")) == false)
        #expect(
            StripeAPI.isSafeToRetry(
                try api.makeRequest(.POST, "v1/customers", idempotencyKey: "k")
            )
        )
        #expect(StripeAPI.isSafeToRetry(try api.makeRequest(.DELETE, "v1/customers/cus_1")) == false)
    }

    @Test("a keyed write survives a 500 by retrying")
    func keyedWriteRetries() async throws {
        let failure = ScriptedResponse(
            status: 500,
            body: #"{"error":{"type":"api_error","message":"boom"}}"#
        )
        let success = ScriptedResponse(
            body: #"{"id":"cus_1","object":"customer","created":1,"livemode":false}"#
        )

        try await IntegrationTests.withServer(
            responses: [failure, success],
            maxRetries: 2
        ) { stripe, server in
            let customer = try await stripe.customers.create(
                .init(email: "ada@example.com"),
                idempotencyKey: "customer-42"
            )
            #expect(customer.id == "cus_1")
            #expect(server.received.count == 2)
            #expect(
                server.received.allSatisfy {
                    $0.headers.first(name: "Idempotency-Key") == "customer-42"
                }
            )
        }
    }

    @Test("an unkeyed write surfaces the 500 rather than risking a duplicate")
    func unkeyedWriteDoesNotRetry() async throws {
        let failure = ScriptedResponse(
            status: 500,
            body: #"{"error":{"type":"api_error","message":"boom"}}"#
        )

        try await IntegrationTests.withServer(
            responses: [failure, failure, failure],
            maxRetries: 2
        ) { stripe, server in
            await #expect(throws: StripeClientError.self) {
                _ = try await stripe.customers.create(.init(email: "ada@example.com"))
            }
            #expect(server.received.count == 1)
        }
    }
}
