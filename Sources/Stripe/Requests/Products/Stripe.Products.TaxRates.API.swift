//
//  Stripe Products Tax Rate Types.swift
//  swift-stripe-types
//
//  Created on 2025-01-14.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Products.TaxRates {
    // https://docs.stripe.com/api/tax_rates/create.md
    public enum Create {}

    // https://docs.stripe.com/api/tax_rates/update.md
    public enum Update {}

    // https://docs.stripe.com/api/tax_rates/list.md
    public enum List {}
}

extension Stripe.Products.TaxRates.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The display name of the tax rate, which will be shown to users.
        public let displayName: String
        /// This specifies if the tax rate is inclusive or exclusive.
        public let inclusive: Bool
        /// This represents the tax rate percent out of 100.
        public let percentage: Decimal
        /// Flag determining whether the tax rate is active or inactive (archived). Inactive tax rates cannot be used with new applications or Checkout Sessions, but will still work for subscriptions and invoices that already have it set.
        public let active: Bool?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public let country: String?
        /// An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
        public let description: String?
        /// The jurisdiction for the tax rate. You can use this label field for tax reporting purposes. It also appears on your customer's invoice.
        public let jurisdiction: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
        public let metadata: [String: String]?
        /// ISO 3166-2 subdivision code, without country prefix. For example, "NY" for New York, United States.
        public let state: String?
        /// The high-level tax type, such as vat or sales_tax.
        public let taxType: Stripe.Tax.Rate.TaxType?

        private enum CodingKeys: String, CodingKey {
            case displayName
            case inclusive
            case percentage
            case active
            case country
            case description
            case jurisdiction
            case metadata
            case state
            case taxType
        }

        public init(
            displayName: String,
            inclusive: Bool,
            percentage: Decimal,
            active: Bool? = nil,
            country: String? = nil,
            description: String? = nil,
            jurisdiction: String? = nil,
            metadata: [String: String]? = nil,
            state: String? = nil,
            taxType: Stripe.Tax.Rate.TaxType? = nil
        ) {
            self.displayName = displayName
            self.inclusive = inclusive
            self.percentage = percentage
            self.active = active
            self.country = country
            self.description = description
            self.jurisdiction = jurisdiction
            self.metadata = metadata
            self.state = state
            self.taxType = taxType
        }
    }
}

extension Stripe.Products.TaxRates.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Flag determining whether the tax rate is active or inactive (archived). Inactive tax rates cannot be used with new applications or Checkout Sessions, but will still work for subscriptions and invoices that already have it set.
        public let active: Bool?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public let country: String?
        /// An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
        public let description: String?
        /// The display name of the tax rate, which will be shown to users.
        public let displayName: String?
        /// The jurisdiction for the tax rate. You can use this label field for tax reporting purposes. It also appears on your customer's invoice.
        public let jurisdiction: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
        public let metadata: [String: String]?
        /// ISO 3166-2 subdivision code, without country prefix. For example, "NY" for New York, United States.
        public let state: String?
        /// The high-level tax type, such as vat or sales_tax.
        public let taxType: Stripe.Tax.Rate.TaxType?

        private enum CodingKeys: String, CodingKey {
            case active
            case country
            case description
            case displayName
            case jurisdiction
            case metadata
            case state
            case taxType
        }

        public init(
            active: Bool? = nil,
            country: String? = nil,
            description: String? = nil,
            displayName: String? = nil,
            jurisdiction: String? = nil,
            metadata: [String: String]? = nil,
            state: String? = nil,
            taxType: Stripe.Tax.Rate.TaxType? = nil
        ) {
            self.active = active
            self.country = country
            self.description = description
            self.displayName = displayName
            self.jurisdiction = jurisdiction
            self.metadata = metadata
            self.state = state
            self.taxType = taxType
        }
    }
}

extension Stripe.Products.TaxRates.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Optional flag to filter by active or inactive (archived) tax rates.
        public let active: Bool?
        /// A filter on the list, based on the object created field. The value can be a string with an integer Unix timestamp or a dictionary with the following options.
        public let created: Stripe.DateFilter?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_bar, your subsequent call can include ending_before=obj_bar in order to fetch the previous page of the list.
        public let endingBefore: String?
        /// Optional flag to filter by inclusive or exclusive tax rates.
        public let inclusive: Bool?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public let limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include starting_after=obj_foo in order to fetch the next page of the list.
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case active
            case created
            case endingBefore
            case inclusive
            case limit
            case startingAfter
        }

        public init(
            active: Bool? = nil,
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            inclusive: Bool? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.active = active
            self.created = created
            self.endingBefore = endingBefore
            self.inclusive = inclusive
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        /// String representing the object's type. Objects of the same type share the same value. Always has the value list.
        public let object: String
        /// True if this list has another page of items after this one that can be fetched.
        public let hasMore: Bool
        /// The URL where this list can be accessed.
        public let url: String
        /// An array of up to limit tax rates.
        public let data: [Stripe.Tax.Rate]

        private enum CodingKeys: String, CodingKey {
            case object
            case hasMore
            case url
            case data
        }

        public init(
            object: String,
            hasMore: Bool,
            url: String,
            data: [Stripe.Tax.Rate]
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
