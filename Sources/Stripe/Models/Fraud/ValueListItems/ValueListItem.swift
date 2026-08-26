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

extension Stripe.Fraud.ValueListItems {
    /// Value list items allow you to add specific values to a given Radar value list, which can then be used in rules.
    public struct ValueListItem: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// The name or email address of the user who added this item to the value list.
        public var createdBy: String?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// The value of the item.
        public var value: String?
        /// The identifier of the value list this item belongs to.
        public var valueList: String?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            createdBy: String? = nil,
            livemode: Bool? = nil,
            value: String? = nil,
            valueList: String? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.createdBy = createdBy
            self.livemode = livemode
            self.value = value
            self.valueList = valueList
        }
    }
}
