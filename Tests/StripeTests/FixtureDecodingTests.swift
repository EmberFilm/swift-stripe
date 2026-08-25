//
//  FixtureDecodingTests.swift
//  swift-stripe
//
//  Every generated resource decodes a fixture in which every spec field is populated, and it
//  must accept every value the spec allows. A rejection here is a model that will throw on a
//  real object one day.
//

import Foundation
import Testing

@testable import Stripe

@Suite("Spec fixture decoding")
struct FixtureDecodingTests {

    private static func fixture(_ name: String) throws -> Data {
        let url = try #require(Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"))
        return try Data(contentsOf: url)
    }

    private static func decodes<T: Decodable>(_ schema: String, as type: T.Type) throws {
        let data = try fixture(schema)
        do {
            _ = try StripeAPI.decoder.decode(type, from: data)
        } catch let error as DecodingError {
            Issue.record("\(schema): \(error)")
        }
    }

    @Test("checkout.session") func checkoutSession() throws { try Self.decodes("checkout.session", as: Stripe.Checkout.Session.self) }
    @Test("subscription") func subscription() throws { try Self.decodes("subscription", as: Stripe.Billing.Subscription.self) }
    @Test("subscription_item") func subscriptionItem() throws { try Self.decodes("subscription_item", as: Stripe.Billing.Subscription.Item.self) }
    @Test("customer") func customer() throws { try Self.decodes("customer", as: Stripe.Customers.Customer.self) }
    @Test("invoice") func invoice() throws { try Self.decodes("invoice", as: Stripe.Billing.Invoice.self) }
    @Test("invoice_payment") func invoicePayment() throws { try Self.decodes("invoice_payment", as: Stripe.Billing.Invoice.Payment.self) }
    @Test("price") func price() throws { try Self.decodes("price", as: Stripe.Products.Price.self) }
    @Test("product") func product() throws { try Self.decodes("product", as: Stripe.Products.Product.self) }
    @Test("payment_intent") func paymentIntent() throws { try Self.decodes("payment_intent", as: Stripe.PaymentIntents.PaymentIntent.self) }
    @Test("charge") func charge() throws { try Self.decodes("charge", as: Stripe.Charges.Charge.self) }
}
