#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Capital {
    public struct FinancingSummary: Codable, Equatable, Sendable {
        public let object: String
        public let details: Details?
        public let financingOffer: String?
        public let status: String

        public struct Details: Codable, Equatable, Sendable {
            public let advanceAmount: Int
            public let advancePaidOutAt: Date?
            public let currency: Stripe.Currency
            public let currentRepaymentInterval: String?
            public let feeAmount: Int
            public let paidAmount: Int
            public let remainingAmount: Int
            public let repaymentsBeginAt: Date?
            public let withholdRate: Double

            private enum CodingKeys: String, CodingKey {
                case advanceAmount
                case advancePaidOutAt
                case currency
                case currentRepaymentInterval
                case feeAmount
                case paidAmount
                case remainingAmount
                case repaymentsBeginAt
                case withholdRate
            }
        }

        private enum CodingKeys: String, CodingKey {
            case object
            case details
            case financingOffer
            case status
        }
    }
}
