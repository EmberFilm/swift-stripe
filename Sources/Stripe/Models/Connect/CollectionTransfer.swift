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

extension Stripe.Connect {
    public struct CollectionTransfer: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Amount transferred, in cents (or local equivalent).
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// ID of the account that funds are being collected for.
        @Expandable<Stripe.Connect.Account, String> public var destination: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            destination: String? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.currency = currency
            self._destination = Expandable(id: destination)
            self.livemode = livemode
        }
    }
}
