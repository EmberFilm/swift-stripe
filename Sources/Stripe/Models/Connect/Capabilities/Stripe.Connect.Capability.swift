//
//  Capabilities.swift
//
//
//  Created by Andrew Edwards on 11/29/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/capabilities/object.md

extension Stripe.Connect {
    public struct Capability: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// The identifier for the capability.
        public var id: ID
        /// The account for which the capability enables functionality.
        @ExpandableOf<Stripe.Connect.Account> public var account: Stripe.Connect.Account.ID?
        /// Whether the capability has been requested.
        public var requested: Bool?
        /// Information about the requirements for the capability, including what information needs to be collected, and by when.
        public var requirements: Stripe.Connect.Capability.Requirements?
        /// The status of the capability. Can be active, inactive, pending, or unrequested.
        public var status: Stripe.Connect.Capability.Status?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Information about the upcoming new requirements for the capability, including what information needs to be collected, and by when.
        public var futureRequirements: Stripe.Connect.Capability.FutureRequirements?
        /// Time at which the capability was requested. Measured in seconds since the Unix epoch.
        public var requestedAt: Date?

        public init(
            id: ID,
            account: Stripe.Connect.Account.ID? = nil,
            requested: Bool? = nil,
            requirements: Stripe.Connect.Capability.Requirements? = nil,
            status: Stripe.Connect.Capability.Status? = nil,
            object: String,
            futureRequirements: Stripe.Connect.Capability.FutureRequirements? = nil,
            requestedAt: Date? = nil
        ) {
            self.id = id
            self._account = Expandable(id: account)
            self.requested = requested
            self.requirements = requirements
            self.status = status
            self.object = object
            self.futureRequirements = futureRequirements
            self.requestedAt = requestedAt
        }
    }
}

extension Stripe.Connect.Capability {
    public struct Requirements: Codable, Hashable, Sendable {
        /// Fields that are due and can be satisfied by providing the corresponding alternative fields instead.
        public var alternatives: [Stripe.Connect.Capability.Requirements.Alternative]?
        /// Date by which the fields in `currently_due` must be collected to keep the capability enabled for the account. These fields may disable the capability sooner if the next threshold is reached before they are collected.
        public var currentDeadline: Date?
        /// Fields that need to be collected to keep the capability enabled. If not collected by `current_deadline`, these fields appear in `past_due` as well, and the capability is disabled.
        public var currentlyDue: [String]?
        /// If the capability is disabled, this string describes why. Can be `requirements.past_due`, `requirements.pending_verification`, `listed`, `platform_paused`, `rejected.fraud`, `rejected.listed`, `rejected.terms_of_service`, `rejected.other`, `under_review`, or `other`.
        ///
        /// `rejected.unsupported_business` means that the account’s business is not supported by the capability. For example, payment methods may restrict the businesses they support in their terms of service:
        /// - [Adterpay Clearpay's terms of service](https://stripe.com/afterpay-clearpay/legal#restricted-businesses)
        ///
        /// If you believe that the rejection is in error, please contact support@stripe.com for assistance.
        public var disabledReason: String?
        /// Fields that are `currently_due` and need to be collected again because validation or verification failed.
        public var errors: [Stripe.Connect.Account.Requirements.Error]?
        /// Fields that need to be collected assuming all volume thresholds are reached. As they become required, they appear in `currently_due` as well, and `current_deadline` becomes set.
        public var eventuallyDue: [String]?
        /// Fields that weren’t collected by `current_deadline`. These fields need to be collected to enable the capability on the account.
        public var pastDue: [String]?
        /// Fields that may become required depending on the results of verification or review. Will be an empty array unless an asynchronous verification is pending. If verification fails, these fields move to `eventually_due`, `currently_due`, or `past_due`.
        public var pendingVerification: [String]?
    }
}

extension Stripe.Connect.Capability.Requirements {
    public struct Alternative: Codable, Hashable, Sendable {
        /// Fields that can be provided to satisfy all fields in `original_fields_due`.
        public var alternativeFieldsDue: [String]?
        /// Fields that are due and can be satisfied by providing all fields in `alternative_fields_due`.
        public var originalFieldsDue: [String]?

        public init(
            alternativeFieldsDue: [String]? = nil,
            originalFieldsDue: [String]? = nil
        ) {
            self.alternativeFieldsDue = alternativeFieldsDue
            self.originalFieldsDue = originalFieldsDue
        }
    }
}

extension Stripe.Connect.Capability {
    public enum Status: String, Codable, Sendable {
        case active
        case inactive
        case pending
        case unrequested
    }
}

extension Stripe.Connect.Capability {
    public struct FutureRequirements: Codable, Hashable, Sendable {
        /// Fields that are due and can be satisfied by providing the corresponding alternative fields instead.
        public var alternatives: [Stripe.Connect.Capability.Requirements.Alternative]?
        /// Date by which the fields in `currently_due` must be collected to keep the capability enabled for the account. These fields may disable the capability sooner if the next threshold is reached before they are collected.
        public var currentDeadline: Date?
        /// Fields that need to be collected to keep the capability enabled. If not collected by `current_deadline`, these fields appear in `past_due` as well, and the capability is disabled.
        public var currentlyDue: [String]?
        /// This is typed as a string for consistency with `requirements.disabled_reason`, but it safe to assume `future_requirements.disabled_reason` is empty because fields in `future_requirements` will never disable the account.
        public var disabledReason: String?
        /// Fields that are `currently_due` and need to be collected again because validation or verification failed.
        public var errors: [Stripe.Connect.Account.Requirements.Error]?
        /// Fields that need to be collected assuming all volume thresholds are reached. As they become required, they appear in `currently_due` as well, and `current_deadline` becomes set.
        public var eventuallyDue: [String]?
        /// Fields that weren’t collected by `current_deadline`. These fields need to be collected to enable the capability on the account.
        public var pastDue: [String]?
        /// Fields that may become required depending on the results of verification or review. Will be an empty array unless an asynchronous verification is pending. If verification fails, these fields move to `eventually_due`, `currently_due`, or `past_due`.
        public var pendingVerification: [String]?

        public init(
            alternatives: [Stripe.Connect.Capability.Requirements.Alternative]? = nil,
            currentDeadline: Date? = nil,
            currentlyDue: [String]? = nil,
            disabledReason: String? = nil,
            errors: [Stripe.Connect.Account.Requirements.Error]? = nil,
            eventuallyDue: [String]? = nil,
            pastDue: [String]? = nil,
            pendingVerification: [String]? = nil
        ) {
            self.alternatives = alternatives
            self.currentDeadline = currentDeadline
            self.currentlyDue = currentlyDue
            self.disabledReason = disabledReason
            self.errors = errors
            self.eventuallyDue = eventuallyDue
            self.pastDue = pastDue
            self.pendingVerification = pendingVerification
        }
    }
}

extension Stripe.Connect.Capability {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Capability]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Capability]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
