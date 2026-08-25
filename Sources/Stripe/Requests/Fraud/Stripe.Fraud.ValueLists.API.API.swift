#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Fraud.ValueLists.API {
    // https://docs.stripe.com/api/radar/value_lists/create.md
    public enum Create {}
    // https://docs.stripe.com/api/radar/value_lists/update.md
    public enum Update {}
    // https://docs.stripe.com/api/radar/value_lists/list.md
    public enum List {}
}

extension Stripe.Fraud.ValueLists.API.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The name of the value list for use in rules.
        public var alias: String
        /// Type of the items in the value list. One of card_fingerprint, card_bin, email, ip_address, country, string, case_sensitive_string, or customer_id. Use string if the item type is unknown or mixed.
        public var itemType: Stripe.Fraud.ValueLists.ItemType?
        /// The human-readable name of the value list.
        public var name: String
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?

        private enum CodingKeys: String, CodingKey {
            case alias
            case itemType
            case name
            case metadata
        }

        public init(
            alias: String,
            itemType: Stripe.Fraud.ValueLists.ItemType? = nil,
            name: String,
            metadata: [String: String]? = nil
        ) {
            self.alias = alias
            self.itemType = itemType
            self.name = name
            self.metadata = metadata
        }
    }
}

extension Stripe.Fraud.ValueLists.API.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// The name of the value list for use in rules.
        public var alias: String?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// The human-readable name of the value list.
        public var name: String?

        public init(
            alias: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil
        ) {
            self.alias = alias
            self.metadata = metadata
            self.name = name
        }
    }
}

extension Stripe.Fraud.ValueLists.API.List {
    public struct Request: Codable, Equatable, Sendable {
        /// The alias used to reference the value list when writing rules.
        public var alias: String?
        /// A value contained within a value list - returns all value lists containing this value.
        public var contains: String?
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public var startingAfter: String?
        /// Only return value lists that were created during the given date interval.
        public var created: Stripe.DateFilter?

        private enum CodingKeys: String, CodingKey {
            case alias
            case contains
            case endingBefore
            case limit
            case startingAfter
            case created
        }

        public init(
            alias: String? = nil,
            contains: String? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            created: Stripe.DateFilter? = nil
        ) {
            self.alias = alias
            self.contains = contains
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.created = created
        }
    }
}

extension Stripe.Fraud.ValueLists.API.List {
    public struct Response: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Fraud.ValueLists.ValueList]?
        public var hasMore: Bool?
        public var url: String?

        private enum CodingKeys: String, CodingKey {
            case object
            case data
            case hasMore
            case url
        }

        public init(
            object: String,
            data: [Stripe.Fraud.ValueLists.ValueList]? = nil,
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
