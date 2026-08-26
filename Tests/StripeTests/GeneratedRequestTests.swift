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

/// The shapes the request generator introduces beyond plain structs: range filters, the.
/// value-or-keyword unions, `Decimal` amounts, collection operations named on their owner, and
/// the shared page types every list and search response is.
@Suite("Generated requests")
struct GeneratedRequestTests {
    private static func pairs(_ request: some Encodable) throws -> [String: String] {
        Dictionary(uniqueKeysWithValues: try StripeFormEncoder().pairs(of: request))
    }

    @Test("a range filter encodes as bounds or as one value")
    func rangeQuery() throws {
        let bounded = try Self.pairs(
            Stripe.Customers.Customer.List.Request(
                created: .range(gte: 1_700_000_000, lt: 1_700_086_400),
                limit: 3
            )
        )
        #expect(bounded["created[gte]"] == "1700000000")
        #expect(bounded["created[lt]"] == "1700086400")
        #expect(bounded["created[gt]"] == nil)
        #expect(bounded["limit"] == "3")

        let exact = try Self.pairs(Stripe.Customers.Customer.List.Request(created: .exactly(1_700_000_000)))
        #expect(exact["created"] == "1700000000")

        let dated = try Self.pairs(
            Stripe.Customers.Customer.List.Request(
                created: .range(after: Date(timeIntervalSince1970: 1_700_000_000))
            )
        )
        #expect(dated["created[gte]"] == "1700000000")
    }

    @Test("a value-or-keyword parameter encodes either side")
    func valueOrKeyword() throws {
        let now = try Self.pairs(Stripe.FileLinks.FileLink.Update.Request(expiresAt: .now))
        #expect(now["expires_at"] == "now")

        let later = try Self.pairs(
            Stripe.FileLinks.FileLink.Update.Request(
                expiresAt: .value(Date(timeIntervalSince1970: 1_700_000_000))
            )
        )
        #expect(later["expires_at"] == "1700000000")
    }

    @Test("a Decimal amount encodes as its decimal text, not as mantissa parts")
    func decimalLeaf() throws {
        let pairs = try Self.pairs(Stripe.Products.Coupon.Create.Request(duration: .once, percentOff: 12.5))
        #expect(pairs["percent_off"] == "12.5")
        #expect(pairs["duration"] == "once")
        #expect(pairs.keys.contains { $0.hasPrefix("percent_off[") } == false)
    }

    @Test("a required parameter is not optional and an enum keeps its wire value")
    func requiredAndEnum() throws {
        let pairs = try Self.pairs(Stripe.Customers.Customer.CreateTaxId.Request(type: .euVat, value: "DE123456789"))
        #expect(pairs["type"] == "eu_vat")
        #expect(pairs["value"] == "DE123456789")
    }

    @Test("a list response is a page of the resource")
    func page() throws {
        let json = """
            {"object": "list", "url": "/v1/customers", "has_more": true,
             "data": [{"id": "cus_1", "object": "customer"}, {"id": "cus_2", "object": "customer"}]}
            """
        let page = try StripeAPI.decoder.decode(Stripe.Customers.Customer.List.Response.self, from: Data(json.utf8))
        #expect(page.data.map(\.id) == ["cus_1", "cus_2"])
        #expect(page.hasMore)
        #expect(page.totalCount == nil)
    }

    @Test("a search response carries the next page token")
    func searchPage() throws {
        let json = """
            {"object": "search_result", "url": "/v1/customers/search", "has_more": true,
             "next_page": "page_2", "total_count": 7, "data": [{"id": "cus_1", "object": "customer"}]}
            """
        let page = try StripeAPI.decoder.decode(Stripe.Customers.Customer.Search.Response.self, from: Data(json.utf8))
        #expect(page.nextPage == "page_2")
        #expect(page.totalCount == 7)
        #expect(page.data.first?.id == "cus_1")
    }

    @Test("a clearable parameter is left alone, set, or cleared with an empty value")
    func clearable() throws {
        let untouched = try Self.pairs(Stripe.Customers.Customer.Update.Request(name: "Ada"))
        #expect(untouched["metadata"] == nil)

        let set = try Self.pairs(Stripe.Customers.Customer.Update.Request(metadata: ["plan": "pro"]))
        #expect(set["metadata[plan]"] == "pro")

        let cleared = try Self.pairs(
            Stripe.Customers.Customer.Update.Request(
                balance: 0,
                description: "",
                metadata: .clear,
                shipping: .clear
            )
        )
        #expect(cleared["metadata"] == "")
        #expect(cleared["shipping"] == "")
        #expect(cleared["description"] == "", "a plain string clears itself")
        #expect(cleared["balance"] == "0")

        let keyword = try Self.pairs(Stripe.FileLinks.FileLink.Update.Request(expiresAt: .clear))
        #expect(keyword["expires_at"] == "")
    }
}
