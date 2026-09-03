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

extension Stripe {
    /// [Deprecated] The `ExchangeRate` APIs are deprecated.
    public struct ExchangeRate: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Hash where the keys are supported currencies and the values are the exchange rate at which the base id currency.
        public var rates: [String: Double]?

        public init(
            id: ID,
            object: String,
            rates: [String: Double]? = nil
        ) {
            self.id = id
            self.object = object
            self.rates = rates
        }
    }
}
