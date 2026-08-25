#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Products.PromotionCodes {
    // https://docs.stripe.com/api/promotion_codes/create.md
    public enum Create {}

    // https://docs.stripe.com/api/promotion_codes/update.md
    public enum Update {}

    // https://docs.stripe.com/api/promotion_codes/list.md
    public enum List {}
}

// MARK: - Create Request
extension Stripe.Products.PromotionCodes.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The coupon for this promotion code (required)
        public let coupon: Stripe.Products.Coupon.ID

        /// Whether the promotion code is currently active
        public let active: Bool?

        /// Customer-facing code
        public let code: String?

        /// The customer that this promotion code can be used by
        public let customer: Stripe.Customers.Customer.ID?

        /// Date at which the promotion code can no longer be redeemed
        public let expiresAt: Date?

        /// Maximum number of times this promotion code can be redeemed
        public let maxRedemptions: Int?

        /// Set of key-value pairs for additional information
        public let metadata: [String: String]?

        /// Settings that restrict the redemption of the promotion code
        public let restrictions: Stripe.Products.PromotionCodes.Restrictions?

        private enum CodingKeys: String, CodingKey {
            case coupon
            case active
            case code
            case customer
            case expiresAt
            case maxRedemptions
            case metadata
            case restrictions
        }

        public init(
            coupon: Stripe.Products.Coupon.ID,
            active: Bool? = nil,
            code: String? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            expiresAt: Date? = nil,
            maxRedemptions: Int? = nil,
            metadata: [String: String]? = nil,
            restrictions: Stripe.Products.PromotionCodes.Restrictions? = nil
        ) {
            self.coupon = coupon
            self.active = active
            self.code = code
            self.customer = customer
            self.expiresAt = expiresAt
            self.maxRedemptions = maxRedemptions
            self.metadata = metadata
            self.restrictions = restrictions
        }
    }
}

// MARK: - Update Request
extension Stripe.Products.PromotionCodes.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Whether the promotion code is currently active
        public let active: Bool?

        /// Set of key-value pairs for additional information
        public let metadata: [String: String]?

        /// Settings that restrict the redemption of the promotion code
        public let restrictions: Stripe.Products.PromotionCodes.Restrictions?

        public init(
            active: Bool? = nil,
            metadata: [String: String]? = nil,
            restrictions: Stripe.Products.PromotionCodes.Restrictions? = nil
        ) {
            self.active = active
            self.metadata = metadata
            self.restrictions = restrictions
        }
    }
}

// MARK: - List Request/Response
extension Stripe.Products.PromotionCodes.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Filter by active status
        public let active: Bool?

        /// Filter by promotion code
        public let code: String?

        /// Filter by coupon
        public let coupon: Stripe.Products.Coupon.ID?

        /// Filter by creation date
        public let created: Stripe.DateFilter?

        /// Filter by customer
        public let customer: Stripe.Customers.Customer.ID?

        /// Pagination cursor
        public let endingBefore: String?

        /// Limit on the number of objects to be returned
        public let limit: Int?

        /// Pagination cursor
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case active
            case code
            case coupon
            case created
            case customer
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            active: Bool? = nil,
            code: String? = nil,
            coupon: Stripe.Products.Coupon.ID? = nil,
            created: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.active = active
            self.code = code
            self.coupon = coupon
            self.created = created
            self.customer = customer
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Promotion.Code]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Promotion.Code]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// MARK: - Shared Types
extension Stripe.Products.PromotionCodes {
    public struct Restrictions: Codable, Equatable, Sendable {
        /// Promotion code restrictions defined in each available currency option
        public let currencyOptions: [Stripe.Currency: CurrencyOptions]?

        /// Limit to customers without any successful payments or invoices
        public let firstTimeTransaction: Bool?

        /// Minimum amount required to redeem this promotion code
        public let minimumAmount: Int?

        /// Three-letter ISO code for minimum_amount
        public let minimumAmountCurrency: Stripe.Currency?

        private enum CodingKeys: String, CodingKey {
            case currencyOptions
            case firstTimeTransaction
            case minimumAmount
            case minimumAmountCurrency
        }

        public init(
            currencyOptions: [Stripe.Currency: CurrencyOptions]? = nil,
            firstTimeTransaction: Bool? = nil,
            minimumAmount: Int? = nil,
            minimumAmountCurrency: Stripe.Currency? = nil
        ) {
            self.currencyOptions = currencyOptions
            self.firstTimeTransaction = firstTimeTransaction
            self.minimumAmount = minimumAmount
            self.minimumAmountCurrency = minimumAmountCurrency
        }
    }

    public struct CurrencyOptions: Codable, Equatable, Sendable {
        /// Minimum amount required to redeem this promotion code
        public let minimumAmount: Int?

        private enum CodingKeys: String, CodingKey {
            case minimumAmount
        }

        public init(minimumAmount: Int? = nil) {
            self.minimumAmount = minimumAmount
        }
    }
}
