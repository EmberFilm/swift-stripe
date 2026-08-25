//
//  Stripe Billing Test Clocks Types Billing Test Clocks.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// extension Stripe.Billing.TestClocks {
//    public struct TestClock: Codable, Equatable, Sendable {
//        public typealias ID = String
//        public let id: ID
//        public let object: String
//        public let created: Int
//        public let deletesAfter: Int
//        public let frozenTime: Int
//        public let livemode: Bool
//        public let name: String?
//        public let status: Status
//
//        public enum Status: String, Codable, Equatable, Sendable {
//            case ready
//            case advancing
//            case internalFailure = "internal_failure"
//        }
//
//        private enum CodingKeys: String, CodingKey {
//            case id
//            case object
//            case created
//            case deletesAfter
//            case frozenTime
//            case livemode
//            case name
//            case status
//        }
//    }
// }

extension Stripe.Billing.TestClocks {
    // https://docs.stripe.com/api/testClocks/create.md
    public enum Create {}
}

extension Stripe.Billing.TestClocks.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The initial frozen time for the test clock (Unix timestamp)
        public var frozenTime: Int
        /// An optional name for the test clock
        public var name: String?

        public init(
            frozenTime: Int,
            name: String? = nil
        ) {
            self.frozenTime = frozenTime
            self.name = name
        }

        private enum CodingKeys: String, CodingKey {
            case frozenTime
            case name
        }
    }
}

extension Stripe.Billing.TestClocks {
    // https://docs.stripe.com/api/testClocks/list.md
    public enum List {}
}

extension Stripe.Billing.TestClocks.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Pagination cursor for previous page
        public var endingBefore: String?
        /// Number of objects to return (1-100, default 10)
        public var limit: Int?
        /// Pagination cursor for next page
        public var startingAfter: String?

        public init(
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }

        private enum CodingKeys: String, CodingKey {
            case endingBefore
            case limit
            case startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Billing.TestClocks.TestClock]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Billing.TestClocks {
    // https://docs.stripe.com/api/testClocks/advance.md
    public enum Advance {}
}

extension Stripe.Billing.TestClocks.Advance {
    public struct Request: Codable, Equatable, Sendable {
        /// The time to advance the test clock to (Unix timestamp)
        /// Must be after the test clock's current frozen time
        public var frozenTime: Int

        public init(frozenTime: Int) {
            self.frozenTime = frozenTime
        }

        private enum CodingKeys: String, CodingKey {
            case frozenTime
        }
    }
}
