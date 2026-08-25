#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Fraud.Reviews.API {
    // https://docs.stripe.com/api/radar/reviews/list.md
    public enum List {}
    // https://docs.stripe.com/api/radar/reviews/approve.md
    public enum Approve {}
}

extension Stripe.Fraud.Reviews.API.List {
    public struct Request: Codable, Equatable, Sendable {
        /// A cursor for use in pagination. ending_before is an object ID that defines your place in the list.
        public var endingBefore: String?
        /// A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
        public var limit: Int?
        /// A cursor for use in pagination. starting_after is an object ID that defines your place in the list.
        public var startingAfter: String?
        /// Only return reviews that were created during the given date interval.
        public var created: Stripe.DateFilter?

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
            case created
        }

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            created: Stripe.DateFilter? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
            self.created = created
        }
    }
}

extension Stripe.Fraud.Reviews.API.List {
    public struct Response: Codable, Hashable, Sendable {
        public var object: String
        public var data: [Stripe.Fraud.Reviews.Review]?
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
            data: [Stripe.Fraud.Reviews.Review]? = nil,
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

extension Stripe.Fraud.Reviews.API.Approve {
    public struct Request: Codable, Equatable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(expand: [String]? = nil) {
            self.expand = expand
        }
    }
}
