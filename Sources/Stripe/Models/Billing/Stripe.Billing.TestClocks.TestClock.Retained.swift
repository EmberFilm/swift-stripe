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

// The TestClock struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Billing.TestClocks.TestClock` that the generator spells differently.

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
