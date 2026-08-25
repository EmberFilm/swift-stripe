#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Capital.FinancingOffer {
    // https://docs.stripe.com/api/capital/financing_offers/list.md
    public enum List {}
}

extension Stripe.Capital.FinancingOffer.List {
    public struct Request: Codable, Equatable, Sendable {
        public let connectedAccount: String?
        public let created: Stripe.DateFilter?
        public let endingBefore: String?
        public let limit: Int
        public let startingAfter: String?
        public let status: String?

        public init(
            connectedAccount: String? = nil,
            created: Stripe.DateFilter? = nil,
            status: String? = nil,
            limit: Int = 10,
            startingAfter: String? = nil,
            endingBefore: String? = nil
        ) {
            self.connectedAccount = connectedAccount
            self.created = created
            self.status = status
            self.limit = limit
            self.startingAfter = startingAfter
            self.endingBefore = endingBefore
        }

        private enum CodingKeys: String, CodingKey {
            case connectedAccount
            case created
            case endingBefore
            case limit
            case startingAfter
            case status
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Capital.FinancingOffer]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}
