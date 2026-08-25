//
//  CountrySpec.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/country_specs/object.md

extension Stripe.Connect {
    /// Stripe needs to collect certain pieces of information about each account created. These requirements can differ depending on the account's country. The Country Specs API makes these rules available to your integration.
    public struct CountrySpec: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object. Represented as the ISO country code for this country.
        public var id: ID
        /// The default currency for this country. This applies to both payment methods and bank accounts.
        public var defaultCurrency: Stripe.Currency?
        /// Currencies that can be accepted in the specific country (for transfers).
        public var supportedBankAccountCurrencies: [String: [String]]?
        /// Currencies that can be accepted in the specified country (for payments).
        public var supportedPaymentCurrencies: [Stripe.Currency]?
        /// Payment methods available in the specified country. You may need to enable some payment methods (e.g., [ACH](https://stripe.com/docs/ach)) on your account before they appear in this list. The `stripe` payment method refers to [charging through your platform](https://stripe.com/docs/connect/destination-charges).
        public var supportedPaymentMethods: [String]?
        /// Countries that can accept transfers from the specified country.
        public var supportedTransferCountries: [String]?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Lists the types of verification data needed to keep an account open.
        public var verificationFields: Stripe.Connect.CountrySpec.VerificationFields?

        public init(
            id: ID,
            defaultCurrency: Stripe.Currency? = nil,
            supportedBankAccountCurrencies: [String: [String]]? = nil,
            supportedPaymentCurrencies: [Stripe.Currency]? = nil,
            supportedPaymentMethods: [String]? = nil,
            supportedTransferCountries: [String]? = nil,
            object: String,
            verificationFields: Stripe.Connect.CountrySpec.VerificationFields? = nil
        ) {
            self.id = id
            self.defaultCurrency = defaultCurrency
            self.supportedBankAccountCurrencies = supportedBankAccountCurrencies
            self.supportedPaymentCurrencies = supportedPaymentCurrencies
            self.supportedPaymentMethods = supportedPaymentMethods
            self.supportedTransferCountries = supportedTransferCountries
            self.object = object
            self.verificationFields = verificationFields
        }
    }
}

extension Stripe.Connect.CountrySpec {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.CountrySpec]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.CountrySpec]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

extension Stripe.Connect.CountrySpec {
    public struct VerificationFields: Codable, Hashable, Sendable {
        /// Verification types for company account.
        public var company: Stripe.Connect.CountrySpec.VerificationFields.Attributes?
        /// Verification types for individual account.
        public var individual: Stripe.Connect.CountrySpec.VerificationFields.Attributes?

        public init(
            company: Stripe.Connect.CountrySpec.VerificationFields.Attributes? = nil,
            individual: Stripe.Connect.CountrySpec.VerificationFields.Attributes? = nil
        ) {
            self.company = company
            self.individual = individual
        }
    }
}

extension Stripe.Connect.CountrySpec.VerificationFields {
    public struct Attributes: Codable, Hashable, Sendable {
        /// Additional fieCountrySpecy required for some users.
        public var additional: [String]?
        /// Fields which every account must eventually provide.
        public var minimum: [String]?

        public init(
            additional: [String]? = nil,
            minimum: [String]? = nil
        ) {
            self.additional = additional
            self.minimum = minimum
        }
    }
}
