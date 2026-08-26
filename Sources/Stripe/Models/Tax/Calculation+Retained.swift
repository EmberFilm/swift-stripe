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

//  Created on 2025-01-14.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/tax/calculations/object.md

// The Calculation struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Tax.Calculation` that the generator spells differently.

extension Stripe.Tax.Calculation {
    public struct CustomerDetails: Codable, Hashable, Sendable {
        /// The customer's postal address (for example, home or business location).
        public var address: Address?
        /// The type of customer address provided.
        public var addressSource: AddressSource?
        /// The customer's IP address (IPv4 or IPv6).
        public var ipAddress: String?
        /// The customer's tax exemption.
        ///
        /// One of none, exempt, or reverse.
        public var taxability: Taxability?
        /// The customer's tax IDs.
        public var taxIds: [TaxID]?

        public init(
            address: Address? = nil,
            addressSource: AddressSource? = nil,
            ipAddress: String? = nil,
            taxability: Taxability? = nil,
            taxIds: [TaxID]? = nil
        ) {
            self.address = address
            self.addressSource = addressSource
            self.ipAddress = ipAddress
            self.taxability = taxability
            self.taxIds = taxIds
        }
    }

    public struct LineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String

        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object's type.
        ///
        /// Objects of the same type share the same value.
        public var object: String
        /// The line item amount in the smallest currency unit.
        public var amount: Int
        /// The amount of tax calculated for this line item, in the smallest currency unit.
        public var amountTax: Int
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool
        /// The product used for this line item.
        public var product: Stripe.Products.Product.ID?
        /// The number of units of the item being purchased.
        public var quantity: Int
        /// A custom identifier for this line item.
        public var reference: String?
        /// Specifies whether the amount includes taxes.
        public var taxBehavior: TaxBehavior?
        /// The tax code for the line item.
        public var taxCode: String?

        public init(
            id: ID,
            object: String,
            amount: Int,
            amountTax: Int,
            livemode: Bool,
            product: Stripe.Products.Product.ID? = nil,
            quantity: Int,
            reference: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxCode: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountTax = amountTax
            self.livemode = livemode
            self.product = product
            self.quantity = quantity
            self.reference = reference
            self.taxBehavior = taxBehavior
            self.taxCode = taxCode
        }
    }

    public struct TaxRateDetails: Codable, Hashable, Sendable {
        /// The tax rate percentage as a string (for example, "8.5").
        public var percentageDecimal: String
        /// The tax type, such as vat or sales_tax.
        public var taxType: String?

        public init(
            percentageDecimal: String,
            taxType: String? = nil
        ) {
            self.percentageDecimal = percentageDecimal
            self.taxType = taxType
        }
    }

    public struct TaxID: Codable, Hashable, Sendable {
        /// The type of the tax ID.
        public var type: String
        /// The value of the tax ID.
        public var value: String

        public init(type: String, value: String) {
            self.type = type
            self.value = value
        }
    }

    public enum AddressSource: String, Codable, Sendable {
        case shipping
        case billing
    }

    public enum Taxability: String, Codable, Sendable {
        case exempt
        case none
        case reverse
    }

    public enum TaxBehavior: String, Codable, Sendable {
        case exclusive
        case inclusive
    }

    public enum Sourcing: String, Codable, Sendable {
        case destination
        case origin
    }

    public enum TaxabilityReason: String, Codable, Sendable {
        case accountExempt = "account_exempt"
        case customerExempt = "customer_exempt"
        case notCollecting = "not_collecting"
        case notSubjectToTax = "not_subject_to_tax"
        case notSupported = "not_supported"
        case portionProductExempt = "portion_product_exempt"
        case portionReducedRated = "portion_reduced_rated"
        case portionStandardRated = "portion_standard_rated"
        case productExempt = "product_exempt"
        case productExemptHoliday = "product_exempt_holiday"
        case reverseCharge = "reverse_charge"
        case standardRated = "standard_rated"
        case taxableBasisReduced = "taxable_basis_reduced"
        case zeroRated = "zero_rated"
    }
}
