//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Connect.AccountLink {
    public enum Create {}
}

// POST /v1/account_links
extension Stripe.Connect.AccountLink.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The identifier of the account to create an account link for.
        public var account: String
        /// The collect parameter is deprecated.
        public var collect: Collect?
        /// Specifies the requirements that Stripe collects from connected accounts in the Connect Onboarding flow.
        public var collectionOptions: CollectionOptions?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The URL the user will be redirected to if the account link is expired, has been previously-visited, or is otherwise.
        public var refreshUrl: String?
        /// The URL that the user will be redirected to upon leaving or completing the linked flow.
        public var returnUrl: String?
        /// The type of account link the user is requesting.
        public var `type`: Type

        public init(
            account: String,
            collect: Collect? = nil,
            collectionOptions: CollectionOptions? = nil,
            expand: [String]? = nil,
            refreshUrl: String? = nil,
            returnUrl: String? = nil,
            `type`: Type
        ) {
            self.account = account
            self.collect = collect
            self.collectionOptions = collectionOptions
            self.expand = expand
            self.refreshUrl = refreshUrl
            self.returnUrl = returnUrl
            self.`type` = `type`
        }

        public enum Collect: String, Codable, Hashable, Sendable {
            case currentlyDue = "currently_due"
            case eventuallyDue = "eventually_due"
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case accountOnboarding = "account_onboarding"
            case accountUpdate = "account_update"
        }

        /// Specifies the requirements that Stripe collects from connected accounts in the Connect Onboarding flow.
        public struct CollectionOptions: Codable, Hashable, Sendable {
            /// Specifies whether the platform collects only currently_due requirements (`currently_due`) or both currently_due and.
            public var fields: Fields?
            /// Specifies whether the platform collects future_requirements in addition to requirements in Connect Onboarding.
            public var futureRequirements: FutureRequirements?

            public init(
                fields: Fields? = nil,
                futureRequirements: FutureRequirements? = nil
            ) {
                self.fields = fields
                self.futureRequirements = futureRequirements
            }

            public enum Fields: String, Codable, Hashable, Sendable {
                case currentlyDue = "currently_due"
                case eventuallyDue = "eventually_due"
            }

            public enum FutureRequirements: String, Codable, Hashable, Sendable {
                case include
                case omit
            }
        }
    }

    public typealias Response = Stripe.Connect.AccountLink
}
