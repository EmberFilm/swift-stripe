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

extension Stripe.Billing {
    public struct AlertTriggered: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        @Boxed public var alert: Stripe.Billing.Alert?
        /// Time at which the object was created.
        public var created: Date?
        /// ID of customer for which the alert triggered.
        public var customer: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The value triggering the alert.
        public var value: Int?

        public init(
            object: String,
            alert: Stripe.Billing.Alert? = nil,
            created: Date? = nil,
            customer: String? = nil,
            livemode: Bool? = nil,
            value: Int? = nil
        ) {
            self.object = object
            self._alert = Boxed(wrappedValue: alert)
            self.created = created
            self.customer = customer
            self.livemode = livemode
            self.value = value
        }
    }
}
