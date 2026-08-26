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

extension Stripe.Climate {
    /// A Climate product represents a type of carbon removal unit available for reservation.
    public struct Product: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// Current prices for a metric ton of carbon removal in a currency's smallest unit.
        public var currentPricesPerMetricTon: [String: CurrentPricesPerMetricTon]?
        /// The year in which the carbon removal is expected to be delivered.
        public var deliveryYear: Int?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?
        /// The quantity of metric tons available for reservation.
        public var metricTonsAvailable: String?
        /// The Climate product's name.
        public var name: String?
        /// The carbon removal suppliers that fulfill orders for this Climate product.
        public var suppliers: [Stripe.Climate.Supplier]?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            currentPricesPerMetricTon: [String: CurrentPricesPerMetricTon]? = nil,
            deliveryYear: Int? = nil,
            livemode: Bool? = nil,
            metricTonsAvailable: String? = nil,
            name: String? = nil,
            suppliers: [Stripe.Climate.Supplier]? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.currentPricesPerMetricTon = currentPricesPerMetricTon
            self.deliveryYear = deliveryYear
            self.livemode = livemode
            self.metricTonsAvailable = metricTonsAvailable
            self.name = name
            self.suppliers = suppliers
        }

        public struct CurrentPricesPerMetricTon: Codable, Hashable, Sendable {
            /// Fees for one metric ton of carbon removal in the currency's smallest unit.
            public var amountFees: Int?
            /// Subtotal for one metric ton of carbon removal (excluding fees) in the currency's smallest unit.
            public var amountSubtotal: Int?
            /// Total for one metric ton of carbon removal (including fees) in the currency's smallest unit.
            public var amountTotal: Int?

            public init(
                amountFees: Int? = nil,
                amountSubtotal: Int? = nil,
                amountTotal: Int? = nil
            ) {
                self.amountFees = amountFees
                self.amountSubtotal = amountSubtotal
                self.amountTotal = amountTotal
            }
        }
    }
}
