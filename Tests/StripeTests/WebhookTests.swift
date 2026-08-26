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

import Crypto
import Testing

@testable import Stripe

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

@Suite("Stripe webhook signatures")
struct WebhookTests {

    static let secret = "whsec_test_secret"
    static let payload = Data(#"{"id":"evt_1","object":"event","type":"payment_intent.succeeded"}"#.utf8)
    static let timestamp = Date(timeIntervalSince1970: 1_614_556_800)

    /// Signs exactly the way Stripe does, so the tests exercise real verification.
    static func sign(
        payload: Data = WebhookTests.payload,
        at date: Date = WebhookTests.timestamp,
        secret: String = WebhookTests.secret
    ) -> String {
        var signed = Data("\(Int(date.timeIntervalSince1970)).".utf8)
        signed.append(payload)
        let mac = HMAC<SHA256>.authenticationCode(
            for: signed,
            using: SymmetricKey(data: Data(secret.utf8))
        )
        let hex = mac.map { String(format: "%02x", $0) }.joined()
        return "t=\(Int(date.timeIntervalSince1970)),v1=\(hex)"
    }

    @Test("a valid signature verifies")
    func validSignature() throws {
        try StripeWebhook.verify(
            payload: Self.payload,
            signatureHeader: Self.sign(),
            secret: Self.secret,
            now: Self.timestamp
        )
    }

    @Test("a tampered payload is rejected")
    func tamperedPayload() {
        let header = Self.sign()
        #expect(throws: StripeWebhook.Error.signatureMismatch) {
            try StripeWebhook.verify(
                payload: Data(#"{"id":"evt_EVIL"}"#.utf8),
                signatureHeader: header,
                secret: Self.secret,
                now: Self.timestamp
            )
        }
    }

    @Test("the wrong secret is rejected")
    func wrongSecret() {
        #expect(throws: StripeWebhook.Error.signatureMismatch) {
            try StripeWebhook.verify(
                payload: Self.payload,
                signatureHeader: Self.sign(),
                secret: "whsec_not_the_secret",
                now: Self.timestamp
            )
        }
    }

    @Test("a stale timestamp is rejected (replay protection)")
    func staleTimestamp() {
        let header = Self.sign()
        #expect(throws: (any Error).self) {
            try StripeWebhook.verify(
                payload: Self.payload,
                signatureHeader: header,
                secret: Self.secret,
                tolerance: 300,
                now: Self.timestamp.addingTimeInterval(3600)  // an hour later
            )
        }
    }

    @Test("a stale timestamp passes when tolerance is disabled")
    func toleranceDisabled() throws {
        try StripeWebhook.verify(
            payload: Self.payload,
            signatureHeader: Self.sign(),
            secret: Self.secret,
            tolerance: 0,
            now: Self.timestamp.addingTimeInterval(3600)
        )
    }

    @Test("any one of several v1 signatures matching is enough (secret rotation)")
    func secretRotation() throws {
        let valid = Self.sign()
        // Stripe sends multiple v1 entries while a secret is being rotated.
        let combined = valid + ",v1=" + String(repeating: "0", count: 64)
        try StripeWebhook.verify(
            payload: Self.payload,
            signatureHeader: combined,
            secret: Self.secret,
            now: Self.timestamp
        )
    }

    @Test(
        "malformed headers are rejected",
        arguments: [
            "", "garbage", "t=1614556800", "v1=abc", "t=,v1=",
        ]
    )
    func malformedHeaders(header: String) {
        #expect(throws: (any Error).self) {
            try StripeWebhook.verify(
                payload: Self.payload,
                signatureHeader: header,
                secret: Self.secret,
                now: Self.timestamp
            )
        }
    }

    @Test("a non-hex signature is rejected rather than crashing")
    func nonHexSignature() {
        #expect(throws: StripeWebhook.Error.signatureMismatch) {
            try StripeWebhook.verify(
                payload: Self.payload,
                signatureHeader: "t=1614556800,v1=zzzz",
                secret: Self.secret,
                now: Self.timestamp
            )
        }
    }

    @Test("constructEvent verifies and decodes in one step")
    func constructEvent() throws {
        let payload = Data(
            #"""
            {
              "id": "evt_1",
              "object": "event",
              "api_version": "2024-06-20",
              "created": 1614556800,
              "livemode": false,
              "pending_webhooks": 0,
              "type": "payment_intent.succeeded",
              "data": {"object": {"id": "pi_1", "object": "payment_intent"}}
            }
            """#.utf8
        )

        let event = try StripeWebhook.constructEvent(
            payload: payload,
            signatureHeader: Self.sign(payload: payload),
            secret: Self.secret,
            now: Self.timestamp
        )
        #expect(event.id == "evt_1")
        #expect(event.apiVersion == "2024-06-20")
    }

    @Test("a timestamp ahead of our clock is skew, not a replay, and verifies")
    func futureTimestamp() throws {
        let ahead = Self.timestamp.addingTimeInterval(20 * 60)
        try StripeWebhook.verify(
            payload: Self.payload,
            signatureHeader: Self.sign(at: ahead),
            secret: Self.secret,
            now: Self.timestamp
        )
    }
}
