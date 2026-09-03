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
import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Verification of Stripe webhook signatures.
///
/// Stripe signs each webhook with the endpoint's signing secret and sends the
/// result in a `Stripe-Signature` header:
///
/// ```
/// Stripe-Signature: t=1614556800,v1=5257a8...,v1=a1b2c3...
/// ```
///
/// The signed payload is `"{timestamp}.{raw body}"`, HMAC-SHA256'd with the
/// signing secret. Verification **must** run against the exact bytes Stripe
/// sent — decoding and re-encoding the JSON first will change them and the
/// signature will not match.
public enum StripeWebhook {

    /// Errors raised while verifying a webhook.
    public enum Error: Swift.Error, Equatable, Sendable {
        /// The `Stripe-Signature` header was malformed or had no `t=`/`v1=` parts.
        case malformedSignatureHeader
        /// No `v1` signature in the header matched the computed one.
        case signatureMismatch
        /// The timestamp fell outside the allowed tolerance (replay protection).
        case timestampOutsideTolerance(age: TimeInterval)
        /// The verified payload did not decode into the requested type.
        case decodingFailed(String)
    }

    /// Verifies `payload` against `signatureHeader`, returning the decoded event.
    ///
    /// - Parameters:
    ///   - payload: The **raw** request body bytes, exactly as received.
    ///   - signatureHeader: The value of the `Stripe-Signature` header.
    ///   - secret: The endpoint signing secret (`whsec_…`).
    ///   - tolerance: Maximum accepted age of the signature. Defaults to
    ///     Stripe's recommended five minutes.
    ///   - now: Current time; injectable for testing.
    public static func constructEvent(
        payload: Data,
        signatureHeader: String,
        secret: String,
        tolerance: TimeInterval = 300,
        now: Date = Date()
    ) throws -> Stripe.Events.Event {
        try verify(
            payload: payload,
            signatureHeader: signatureHeader,
            secret: secret,
            tolerance: tolerance,
            now: now
        )
        do {
            return try StripeAPI.decoder.decode(Stripe.Events.Event.self, from: payload)
        } catch {
            throw Error.decodingFailed(String(describing: error))
        }
    }

    /// Verifies a signature without decoding the payload.
    ///
    /// - Throws: ``Error`` when the header is malformed, stale, or unmatched.
    public static func verify(
        payload: Data,
        signatureHeader: String,
        secret: String,
        tolerance: TimeInterval = 300,
        now: Date = Date()
    ) throws {
        let header = try SignatureHeader(signatureHeader)

        // A stale signature is a replay; a timestamp ahead of our clock is only skew, which
        // Stripe's own libraries accept. Same rule here.
        if tolerance > 0 {
            let age = now.timeIntervalSince1970 - header.timestamp
            guard age <= tolerance else {
                throw Error.timestampOutsideTolerance(age: age)
            }
        }

        var signedPayload = Data("\(Int(header.timestamp)).".utf8)
        signedPayload.append(payload)

        let key = SymmetricKey(data: Data(secret.utf8))
        // Stripe may send several v1 signatures during a secret rotation; any match is
        // sufficient. swift-crypto compares in constant time.
        let matched = header.signatures.contains { candidate in
            guard let bytes = Data(hexEncoded: candidate) else { return false }
            return HMAC<SHA256>.isValidAuthenticationCode(bytes, authenticating: signedPayload, using: key)
        }
        guard matched else { throw Error.signatureMismatch }
    }

    // MARK: - Header parsing

    struct SignatureHeader {
        let timestamp: TimeInterval
        let signatures: [String]

        init(_ raw: String) throws {
            var timestamp: TimeInterval?
            var signatures: [String] = []

            for element in raw.split(separator: ",") {
                let pair = element.split(separator: "=", maxSplits: 1)
                guard pair.count == 2 else { continue }
                // Trimmed with the standard library: `CharacterSet` lives in Foundation proper,
                // and this is the one place the package would otherwise link it.
                let key = String(pair[0].drop(while: \.isWhitespace).reversed().drop(while: \.isWhitespace).reversed())
                let value = String(pair[1].drop(while: \.isWhitespace).reversed().drop(while: \.isWhitespace).reversed())
                switch key {
                case "t": timestamp = TimeInterval(value)
                case "v1": signatures.append(value)
                default: break  // v0 (test-mode) and future schemes are ignored.
                }
            }

            guard let timestamp, !signatures.isEmpty else {
                throw Error.malformedSignatureHeader
            }
            self.timestamp = timestamp
            self.signatures = signatures
        }
    }
}

extension Data {
    /// Decodes a lowercase or uppercase hex string, returning `nil` if malformed.
    init?(hexEncoded string: String) {
        let characters = Array(string.utf8)
        guard characters.count.isMultiple(of: 2) else { return nil }
        var bytes = [UInt8]()
        bytes.reserveCapacity(characters.count / 2)
        for index in stride(from: 0, to: characters.count, by: 2) {
            guard let high = Data.hexValue(characters[index]),
                let low = Data.hexValue(characters[index + 1])
            else { return nil }
            bytes.append(high << 4 | low)
        }
        self.init(bytes)
    }

    private static func hexValue(_ byte: UInt8) -> UInt8? {
        switch byte {
        case UInt8(ascii: "0")...UInt8(ascii: "9"): return byte - UInt8(ascii: "0")
        case UInt8(ascii: "a")...UInt8(ascii: "f"): return byte - UInt8(ascii: "a") + 10
        case UInt8(ascii: "A")...UInt8(ascii: "F"): return byte - UInt8(ascii: "A") + 10
        default: return nil
        }
    }
}
