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

@Suite("Stripe response decoding")
struct DecodingTests {

    /// A trimmed but faithful `customer` object as Stripe returns it.
    static let customerJSON = Data(
        #"""
        {
          "id": "cus_NffrFeUfNV2Hib",
          "object": "customer",
          "balance": 0,
          "created": 1680893993,
          "currency": "usd",
          "delinquent": false,
          "email": "ada@example.com",
          "invoice_prefix": "0759376C",
          "next_invoice_sequence": 47,
          "livemode": false,
          "name": "Ada Lovelace",
          "tax_exempt": "exempt",
          "invoice_settings": {
            "custom_fields": null,
            "footer": "Thanks for your business"
          }
        }
        """#.utf8
    )

    @Test("snake_case fields decode into camelCase properties")
    func decodesSnakeCaseFields() throws {
        let customer = try StripeAPI.decoder.decode(
            Stripe.Customers.Customer.self,
            from: Self.customerJSON
        )

        #expect(customer.id == "cus_NffrFeUfNV2Hib")
        #expect(customer.email == "ada@example.com")

        // These are the fields the upstream package silently dropped: the model
        // declares no CodingKeys, so `.useDefaultKeys` never matched them.
        #expect(customer.invoicePrefix == "0759376C")
        #expect(customer.nextInvoiceSequence == 47)
        #expect(customer.taxExempt == .exempt)
        #expect(customer.invoiceSettings?.footer == "Thanks for your business")
    }

    @Test("the upstream key strategy loses those same fields")
    func upstreamStrategyRegression() throws {
        // Reproduces swift-stripe-http's decoder: `.useDefaultKeys`, on the
        // stated assumption that "our models have explicit CodingKeys".
        let upstream = JSONDecoder()
        upstream.dateDecodingStrategy = .secondsSince1970

        let customer = try upstream.decode(Stripe.Customers.Customer.self, from: Self.customerJSON)

        // Single-word keys still land...
        #expect(customer.email == "ada@example.com")
        // ...but every multi-word field is silently nil.
        #expect(customer.invoicePrefix == nil)
        #expect(customer.nextInvoiceSequence == nil)
        #expect(customer.taxExempt == nil)
        #expect(customer.invoiceSettings == nil)
    }

    @Test("list responses decode pagination")
    func decodesListResponse() throws {
        let json = Data(
            #"""
            {
              "object": "list",
              "url": "/v1/customers",
              "has_more": true,
              "data": [
                {
                  "id": "cus_1",
                  "object": "customer",
                  "created": 1680893993,
                  "livemode": false,
                  "invoice_prefix": "ABC123"
                }
              ]
            }
            """#.utf8
        )

        let page = try StripeAPI.decoder.decode(
            Stripe.Customers.Customer.List.Response.self,
            from: json
        )
        #expect(page.hasMore == true)
        #expect(page.data.count == 1)
        #expect(page.data[0].invoicePrefix == "ABC123")
    }

    @Test("Stripe error payloads decode")
    func decodesErrors() throws {
        let json = Data(
            #"""
            {
              "error": {
                "type": "card_error",
                "code": "card_declined",
                "decline_code": "insufficient_funds",
                "message": "Your card has insufficient funds.",
                "param": "payment_method"
              }
            }
            """#.utf8
        )

        struct Envelope: Decodable { let error: StripeError.Error }
        let decoded = try StripeAPI.decoder.decode(Envelope.self, from: json)

        #expect(decoded.error.message == "Your card has insufficient funds.")
        #expect(decoded.error.param == "payment_method")
        #expect(decoded.error.type == .cardError)
    }

    @Test("fields whose names were misspelled decode again")
    func correctedFieldNames() throws {
        // Each of these silently decoded to nil because the property name did not match the wire
        // name once `.convertFromSnakeCase` had run. Found by diffing the models against live
        // API responses; the same class of defect as the three in README's corrections table.
        struct Case {
            let json: String
            let check: (Data) throws -> Bool
        }

        let customer = try StripeAPI.decoder.decode(
            Stripe.Customers.Customer.self,
            from: Data(#"{"id":"cus_1","object":"customer","created":1,"preferred_locales":["en"]}"#.utf8)
        )
        #expect(customer.preferredLocales == ["en"])

        let invoice = try StripeAPI.decoder.decode(
            Stripe.Billing.Invoice.self,
            from: Data(#"{"object":"invoice","created":1,"amount_remaining":250}"#.utf8)
        )
        #expect(invoice.amountRemaining == 250)
    }

    @Test("percentages are decimals, as the spec declares them")
    func fractionalPercentages() throws {
        // These were `Int`, so a 12.5% coupon or an 87.5% transfer split failed to decode at all.
        let coupon = try StripeAPI.decoder.decode(
            Stripe.Products.Coupon.self,
            from: Data(#"{"id":"co_1","object":"coupon","created":1,"percent_off":12.5}"#.utf8)
        )
        #expect(coupon.percentOff == 12.5)

        let subscription = try StripeAPI.decoder.decode(
            Stripe.Billing.Subscription.self,
            from: Data(#"{"id":"sub_1","object":"subscription","created":1,"transfer_data":{"amount_percent":87.5,"destination":"acct_1"}}"#.utf8)
        )
        #expect(subscription.transferData?.amountPercent == 87.5)

        let rate = try StripeAPI.decoder.decode(
            Stripe.Tax.Rate.self,
            from: Data(#"{"id":"txr_1","object":"tax_rate","created":1,"percentage":7.25,"effective_percentage":7.25}"#.utf8)
        )
        #expect(rate.percentage == 7.25)
    }

}
