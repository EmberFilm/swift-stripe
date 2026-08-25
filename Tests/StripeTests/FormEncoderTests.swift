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
}
