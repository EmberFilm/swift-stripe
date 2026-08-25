#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Connect {
    public enum AccountLinks {}
}

extension Stripe.Connect.AccountLinks {
    // https://docs.stripe.com/api/accountLinks/create.md
    public enum Create {}
}

extension Stripe.Connect.AccountLinks.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// The identifier of the account to create an account link for
        public let account: String

        /// The type of account link the user is requesting
        public let type: LinkType

        /// The URL the user will be redirected to if the account link is expired
        public let refreshUrl: String

        /// The URL the user will be redirected to upon leaving or completing the linked flow
        public let returnUrl: String

        /// @deprecated Use collection_options instead
        public let collect: CollectType?

        /// Specifies the requirements that Stripe collects from connected accounts
        public let collectionOptions: CollectionOptions?

        public init(
            account: String,
            type: LinkType,
            refreshUrl: String,
            returnUrl: String,
            collect: CollectType? = nil,
            collectionOptions: CollectionOptions? = nil
        ) {
            self.account = account
            self.type = type
            self.refreshUrl = refreshUrl
            self.returnUrl = returnUrl
            self.collect = collect
            self.collectionOptions = collectionOptions
        }

        private enum CodingKeys: String, CodingKey {
            case account
            case type
            case refreshUrl
            case returnUrl
            case collect
            case collectionOptions
        }
    }

    public enum LinkType: String, Codable, Equatable, Sendable {
        case accountOnboarding = "account_onboarding"
        case accountUpdate = "account_update"
    }

    public enum CollectType: String, Codable, Equatable, Sendable {
        case currentlyDue = "currently_due"
        case eventuallyDue = "eventually_due"
    }

    public struct CollectionOptions: Codable, Equatable, Sendable {
        /// Specifies whether the platform collects only currently_due requirements or both currently_due and eventually_due requirements
        public let fields: FieldsType?

        /// Specifies whether the platform collects future_requirements
        public let futureRequirements: FutureRequirementsType?

        public init(
            fields: FieldsType? = nil,
            futureRequirements: FutureRequirementsType? = nil
        ) {
            self.fields = fields
            self.futureRequirements = futureRequirements
        }

        private enum CodingKeys: String, CodingKey {
            case fields
            case futureRequirements
        }
    }

    public enum FieldsType: String, Codable, Equatable, Sendable {
        case currentlyDue = "currently_due"
        case eventuallyDue = "eventually_due"
    }

    public enum FutureRequirementsType: String, Codable, Equatable, Sendable {
        case include
        case omit
    }
}
