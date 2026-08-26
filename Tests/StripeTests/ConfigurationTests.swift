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

import Configuration
import Testing

@testable import Stripe

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

private func reader(_ values: [AbsoluteConfigKey: ConfigValue]) -> ConfigReader {
    ConfigReader(provider: InMemoryProvider(values: values))
}

@Suite("StripeConfiguration from a ConfigReader")
struct ConfigurationTests {

    @Test("only secretKey is required; everything else defaults")
    func defaults() throws {

        let config = try StripeConfiguration(config: reader(["secretKey": "sk_test_123"]))

        #expect(config.secretKey == "sk_test_123")
        #expect(config.baseURL.absoluteString == "https://api.stripe.com")
        #expect(config.apiVersion == Stripe.generatedAPIVersion)
        #expect(config.connectedAccount == nil)
        #expect(config.maxRetries == 2)
        #expect(config.timeout == .seconds(60))
    }

    @Test("every documented key is read")
    func allKeys() throws {

        let config = try StripeConfiguration(
            config: reader([
                "secretKey": "sk_live_abc",
                "baseURL": "https://stripe.test.internal",
                "apiVersion": "2024-06-20",
                "connectedAccount": "acct_123",
                "maxRetries": 5,
                "timeoutSeconds": 30,
            ])
        )

        #expect(config.secretKey == "sk_live_abc")
        #expect(config.baseURL.absoluteString == "https://stripe.test.internal")
        #expect(config.apiVersion == "2024-06-20")
        #expect(config.connectedAccount == "acct_123")
        #expect(config.maxRetries == 5)
        #expect(config.timeout == .seconds(30))
    }

    @Test("a missing secretKey throws")
    func missingSecretKey() {

        #expect(throws: (any Error).self) {
            try StripeConfiguration(config: reader(["maxRetries": 3]))
        }
    }

    @Test("keys are read unscoped, so the caller chooses the namespace")
    func callerScopes() throws {

        // The library reads `secretKey`; the caller puts it under `stripe`.
        // With EnvironmentVariablesProvider that is STRIPE_SECRET_KEY.
        let source = reader([
            "stripe.secretKey": "sk_test_scoped",
            "stripe.maxRetries": 4,
            // A sibling library's configuration must not leak in.
            "otherService.secretKey": "not_stripes",
            "otherService.maxRetries": 9,
        ])
        let config = try StripeConfiguration(config: source.scoped(to: "stripe"))

        #expect(config.secretKey == "sk_test_scoped")
        #expect(config.maxRetries == 4)
    }

    @Test("values are taken as given, with no range checking")
    func noValidation() throws {

        let config = try StripeConfiguration(
            config: reader([
                "secretKey": "",
                "maxRetries": 99,
                "timeoutSeconds": 0,
            ])
        )
        #expect(config.secretKey == "")
        #expect(config.maxRetries == 99)
        #expect(config.timeout == .seconds(0))
    }

    @Test("a value the reader cannot convert falls back to the default")
    func conversionFallsBack() throws {

        let config = try StripeConfiguration(
            config: reader([
                "secretKey": "sk_test_123",
                // Not an int, so the int read misses and the default stands.
                "timeoutSeconds": 12.5,
            ])
        )
        #expect(config.timeout == .seconds(60))
    }

    @Test("the configuration drives a client end to end")
    func buildsAClient() async throws {

        let server = try await TestHTTPServer.start(responses: [
            ScriptedResponse(body: #"{"id":"cus_1","object":"customer","created":1,"livemode":false}"#)
        ])
        defer { Task { try? await server.stop() } }

        let config = try StripeConfiguration(
            config: reader([
                "secretKey": "sk_test_123",
                "baseURL": ConfigValue(.string("http://127.0.0.1:\(server.port)"), isSecret: false),
                "apiVersion": "2024-06-20",
            ])
        )
        let stripe = StripeClient(configuration: config)
        _ = try await stripe.customers.retrieve(id: "cus_1")

        let sent = try #require(server.received.first)
        #expect(sent.headers.first(name: "Authorization") == "Bearer sk_test_123")
        #expect(sent.headers.first(name: "Stripe-Version") == "2024-06-20")
    }
}
