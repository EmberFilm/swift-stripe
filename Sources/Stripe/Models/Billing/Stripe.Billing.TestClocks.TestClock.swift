//
//  TestClock.swift
//
//
//  Created by Andrew Edwards on 5/14/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/testClocks/object.md
extension Stripe.Billing.TestClocks {
    public struct TestClock: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Time at which this clock is scheduled to auto delete.
        public var deletesAfter: Date?
        /// Time at which all objects belonging to this clock are frozen.
        public var frozenTime: Date?
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool
        /// The custom name supplied at creation.
        public var name: String?
        /// The status of the Test Clock.
        public var status: TestClock.Status?

        public init(
            id: ID,
            object: String,
            created: Date,
            deletesAfter: Date? = nil,
            frozenTime: Date? = nil,
            livemode: Bool,
            name: String? = nil,
            status: TestClock.Status? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.deletesAfter = deletesAfter
            self.frozenTime = frozenTime
            self.livemode = livemode
            self.name = name
            self.status = status
        }
    }
}

extension Stripe.Billing.TestClocks.TestClock {
    public enum Status: String, Codable, Sendable {
        /// All test clock objects have advanced to the `frozen_time`.
        case ready
        /// In the process of advancing time for the test clock objects.
        case advancing
        /// Failed to advance time. Future requests to advance time will fail.
        case intervalFailure = "interval_failure"
    }
}

extension Stripe.Billing.TestClocks.TestClock {
    public struct List: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of Test Clocks, paginated by any request parameters.
        public var data: [Stripe.Billing.TestClocks.TestClock]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.Billing.TestClocks.TestClock]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}
