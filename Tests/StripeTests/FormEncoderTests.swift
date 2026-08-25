//
//  FormEncoderTests.swift
//  swift-stripe
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing

@testable import Stripe

@Suite("Stripe form encoding")
struct FormEncoderTests {

    @Test("camelCase properties become snake_case parameters")
    func snakeCaseKeys() throws {
        struct Request: Encodable {
            let unitAmount: Int
            let currency: String
        }
        let pairs = try StripeFormEncoder().pairs(of: Request(unitAmount: 1999, currency: "usd"))
        #expect(pairs.contains { $0.key == "unit_amount" && $0.value == "1999" })
        #expect(pairs.contains { $0.key == "currency" && $0.value == "usd" })
    }

    @Test("nested objects use bracket notation")
    func nestedBrackets() throws {
        struct Recurring: Encodable { let interval: String }
        struct Request: Encodable { let recurring: Recurring }
        let pairs = try StripeFormEncoder().pairs(of: Request(recurring: .init(interval: "month")))
        #expect(pairs.map(\.key) == ["recurring[interval]"])
    }

    @Test("arrays are indexed, as Stripe requires")
    func indexedArrays() throws {
        struct Item: Encodable { let price: String; let quantity: Int }
        struct Request: Encodable { let items: [Item] }
        let request = Request(items: [
            .init(price: "price_1", quantity: 2),
            .init(price: "price_2", quantity: 1),
        ])
        let pairs = try StripeFormEncoder().pairs(of: request)
        #expect(pairs.map(\.key) == [
            "items[0][price]", "items[0][quantity]",
            "items[1][price]", "items[1][quantity]",
        ])
        #expect(pairs.map(\.value) == ["price_1", "2", "price_2", "1"])
    }

    @Test("metadata dictionaries nest by key")
    func metadata() throws {
        struct Request: Encodable { let metadata: [String: String] }
        let pairs = try StripeFormEncoder().pairs(of: Request(metadata: ["order_id": "abc"]))
        #expect(pairs.contains { $0.key == "metadata[order_id]" && $0.value == "abc" })
    }

    @Test("metadata keys round-trip under the name they were written with")
    func metadataKeysRoundTrip() throws {
        // Dictionary keys are data, not field names. The encoder leaves them verbatim and
        // `convertFromSnakeCase` leaves them alone coming back, so one constant addresses the
        // value in both directions. Snake-casing them on the way out silently broke that.
        struct Request: Encodable { let metadata: [String: String]; let successUrl: String }
        let pairs = try StripeFormEncoder().pairs(
            of: Request(metadata: ["userId": "u_1", "order_id": "o_1"], successUrl: "https://x")
        )
        #expect(pairs.contains { $0.key == "metadata[userId]" && $0.value == "u_1" })
        #expect(pairs.contains { $0.key == "metadata[order_id]" && $0.value == "o_1" })
        // Field names are still snake-cased.
        #expect(pairs.contains { $0.key == "success_url" })

        struct Response: Decodable { let metadata: [String: String] }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(
            Response.self, from: Data(#"{"metadata":{"userId":"u_1"}}"#.utf8)
        )
        #expect(decoded.metadata["userId"] == "u_1")
    }

    @Test("nested metadata keys are verbatim too")
    func nestedMetadataKeys() throws {
        struct Inner: Encodable { let metadata: [String: String]; let trialPeriodDays: Int }
        struct Request: Encodable { let subscriptionData: Inner }
        let pairs = try StripeFormEncoder().pairs(
            of: Request(subscriptionData: .init(metadata: ["userId": "u_1"], trialPeriodDays: 7))
        )
        #expect(pairs.contains { $0.key == "subscription_data[metadata][userId]" })
        #expect(pairs.contains { $0.key == "subscription_data[trial_period_days]" })
    }

    @Test("booleans render as true/false, not 1/0")
    func booleans() throws {
        struct Request: Encodable { let livemode: Bool }
        let pairs = try StripeFormEncoder().pairs(of: Request(livemode: false))
        #expect(pairs.first?.value == "false")
    }

    @Test("dates render as Unix timestamps")
    func dates() throws {
        struct Request: Encodable { let createdAt: Date }
        let pairs = try StripeFormEncoder().pairs(
            of: Request(createdAt: Date(timeIntervalSince1970: 1_614_556_800))
        )
        #expect(pairs.first?.key == "created_at")
        #expect(pairs.first?.value == "1614556800")
    }

    @Test("nil values are omitted entirely")
    func nilOmitted() throws {
        struct Request: Encodable { let email: String?; let name: String? }
        let pairs = try StripeFormEncoder().pairs(of: Request(email: "a@b.com", name: nil))
        #expect(pairs.map(\.key) == ["email"])
    }

    @Test("body is percent-encoded with + for spaces")
    func escaping() throws {
        struct Request: Encodable { let name: String }
        let body = try StripeFormEncoder().encode(Request(name: "Ada Lovelace & Co"))
        #expect(body == "name=Ada+Lovelace+%26+Co")
    }

    @Test("non-ASCII text is percent-encoded as UTF-8")
    func escapingNonASCII() throws {
        struct Request: Encodable { let name: String }
        // `CharacterSet.alphanumerics` counted these as allowed and let them through raw.
        #expect(try StripeFormEncoder().encode(Request(name: "café")) == "name=caf%C3%A9")
        #expect(try StripeFormEncoder().encode(Request(name: "日本")) == "name=%E6%97%A5%E6%9C%AC")
    }

    @Test("reserved characters that survive urlQueryAllowed are escaped")
    func escapingReserved() throws {
        struct Request: Encodable { let value: String }
        let body = try StripeFormEncoder().encode(Request(value: "a=b&c+d/e?f#g"))
        #expect(body == "value=a%3Db%26c%2Bd%2Fe%3Ff%23g")
    }
}
