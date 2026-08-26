//
//  Shipping.Rate.swift
//
//
//  Created by Andrew Edwards on 12/17/21.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Rate struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Products.Shipping.Rate` that the generator spells differently.


// https://docs.stripe.com/api/shipping_rates/object.md

extension Stripe.Products {
    public enum Shipping {}
}

extension Stripe.Products.Shipping.Rate {
    public enum Fixed {}
}

extension Stripe.Products.Shipping.Rate {
    public enum Delivery {}
}

extension Stripe.Products.Shipping.Rate {
    public enum Tax {}
}

extension Stripe.Products.Shipping.Rate.Fixed.Amount {
    public typealias Currency = Stripe.Currency
}

extension Stripe.Products.Shipping.Rate.Fixed {
    public struct Amount: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Shipping rates defined in each available currency option. Each key must be a three-letter ISO currency code and a supported currency. For example, to get your shipping rate in `eur`, fetch the value of the `eur` key in `currency_options`. This field is not included by default. To include it in the response, expand the `currency_options` field.
        public var currencyOptions:
            [Stripe.Currency: Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options]?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            currencyOptions: [Stripe.Currency: Stripe.Products.Shipping.Rate.Fixed.Amount.Currency
                .Options]? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.currencyOptions = currencyOptions
        }
    }
}

extension Stripe.Products.Shipping.Rate.Fixed.Amount.Currency {
    public struct Options: Codable, Hashable, Sendable {
        /// A non-negative integer in cents representing how much to charge.
        public var amount: Int?
        /// Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
        public var taxBehavior:
            Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options.TaxBehavior?

        public init(
            amount: Int? = nil,
            taxBehavior: Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options.TaxBehavior? =
                nil
        ) {
            self.amount = amount
            self.taxBehavior = taxBehavior
        }
    }
}

extension Stripe.Products.Shipping.Rate.Fixed.Amount.Currency.Options {
    public enum TaxBehavior: String, Codable, Sendable {
        case inclusive
        case exclusive
        case unspecified
    }
}

extension Stripe.Products.Shipping.Rate {
    public enum `Type`: String, Codable, Sendable {
        case fixedAmount = "fixed_amount"
    }
}

extension Stripe.Products.Shipping.Rate.Delivery {
    public struct Estimate: Codable, Hashable, Sendable {
        /// The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
        public var maximum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin?
        /// The lower bound of the estimated range. If empty, represents no lower bound.
        public var minimum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin?

        public init(
            maximum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin? = nil,
            minimum: Stripe.Products.Shipping.Rate.Delivery.Estimate.MaxMin? = nil
        ) {
            self.maximum = maximum
            self.minimum = minimum
        }
    }
}

extension Stripe.Products.Shipping.Rate.Delivery.Estimate {
    public struct MaxMin: Codable, Hashable, Sendable {
        /// A unit of time.
        public var unit: Stripe.Products.Shipping.Rate.Delivery.Estimate.Unit?
        /// Must be greater than 0.
        public var value: Int?

        public init(
            unit: Stripe.Products.Shipping.Rate.Delivery.Estimate.Unit? = nil,
            value: Int? = nil
        ) {
            self.unit = unit
            self.value = value
        }
    }
}

extension Stripe.Products.Shipping.Rate.Delivery.Estimate {
    public enum Unit: String, Codable, Sendable {
        case hour
        case day
        case businessDay = "business_day"
        case week
        case month
    }
}

extension Stripe.Products.Shipping.Rate.Tax {
    public enum Behavior: String, Codable, Sendable {
        case inclusive
        case exclusive
        case unspecified
    }
}

