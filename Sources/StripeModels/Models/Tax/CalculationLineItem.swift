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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Tax {
    public struct CalculationLineItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The line item amount in the smallest currency unit.
        public var amount: Int?
        /// The amount of tax calculated for this line item, in the smallest currency unit.
        public var amountTax: Int?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The ID of an existing Product.
        public var product: String?
        /// The number of units of the item being purchased.
        public var quantity: Int?
        /// A custom identifier for this line item.
        public var reference: String?
        /// Specifies whether the `amount` includes taxes.
        public var taxBehavior: TaxBehavior?
        /// Detailed account of taxes relevant to this line item.
        public var taxBreakdown: [Stripe.Shared.TaxBreakdown]?
        /// The tax code ID used for this resource.
        public var taxCode: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            amountTax: Int? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            product: String? = nil,
            quantity: Int? = nil,
            reference: String? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxBreakdown: [Stripe.Shared.TaxBreakdown]? = nil,
            taxCode: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountTax = amountTax
            self.livemode = livemode
            self.metadata = metadata
            self.product = product
            self.quantity = quantity
            self.reference = reference
            self.taxBehavior = taxBehavior
            self.taxBreakdown = taxBreakdown
            self.taxCode = taxCode
        }

        /// Specifies whether the `amount` includes taxes.
        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
        }
    }
}
