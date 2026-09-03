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

extension Stripe.Fraud.ValueLists {
    /// Value lists allow you to group values together which can then be referenced in rules.
    public struct ValueList: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The name of the value list for use in rules.
        public var alias: String?
        /// Time at which the object was created.
        public var created: Date?
        /// The name or email address of the user who created this value list.
        public var createdBy: String?
        /// The type of items in the value list.
        public var itemType: ItemType?
        /// List of items contained within this value list.
        public var listItems: ListItems?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The name of the value list.
        public var name: String?

        public init(
            id: ID,
            object: String,
            alias: String? = nil,
            created: Date? = nil,
            createdBy: String? = nil,
            itemType: ItemType? = nil,
            listItems: ListItems? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil
        ) {
            self.id = id
            self.object = object
            self.alias = alias
            self.created = created
            self.createdBy = createdBy
            self.itemType = itemType
            self.listItems = listItems
            self.livemode = livemode
            self.metadata = metadata
            self.name = name
        }

        /// The type of items in the value list.
        public enum ItemType: String, Codable, Hashable, Sendable {
            case account
            case cardBin = "card_bin"
            case cardFingerprint = "card_fingerprint"
            case caseSensitiveString = "case_sensitive_string"
            case country
            case cryptoFingerprint = "crypto_fingerprint"
            case customerId = "customer_id"
            case email
            case ipAddress = "ip_address"
            case sepaDebitFingerprint = "sepa_debit_fingerprint"
            case string
            case usBankAccountFingerprint = "us_bank_account_fingerprint"
        }

        /// List of items contained within this value list.
        public struct ListItems: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [Stripe.Fraud.ValueListItems.ValueListItem]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [Stripe.Fraud.ValueListItems.ValueListItem]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }
    }
}
