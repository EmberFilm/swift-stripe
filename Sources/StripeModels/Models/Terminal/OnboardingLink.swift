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

extension Stripe.Terminal {
    /// Returns redirect links used for onboarding onto Tap to Pay on iPhone.
    public struct OnboardingLink: Codable, Hashable, Sendable {
        /// String representing the object's type.
        public let object: String
        public var linkOptions: LinkOptions?
        /// The type of link being generated.
        public var linkType: String?
        /// Stripe account ID to generate the link for.
        public var onBehalfOf: String?
        /// The link passed back to the user for their onboarding.
        public var redirectUrl: String?

        public init(
            object: String,
            linkOptions: LinkOptions? = nil,
            linkType: String? = nil,
            onBehalfOf: String? = nil,
            redirectUrl: String? = nil
        ) {
            self.object = object
            self.linkOptions = linkOptions
            self.linkType = linkType
            self.onBehalfOf = onBehalfOf
            self.redirectUrl = redirectUrl
        }

        /// Link type options associated with the current onboarding link object.
        public struct LinkOptions: Codable, Hashable, Sendable {
            /// The options associated with the Apple Terms and Conditions link type.
            public var appleTermsAndConditions: AppleTermsAndConditions?

            public init(
                appleTermsAndConditions: AppleTermsAndConditions? = nil
            ) {
                self.appleTermsAndConditions = appleTermsAndConditions
            }

            /// Options associated with the Apple Terms and Conditions link type.
            public struct AppleTermsAndConditions: Codable, Hashable, Sendable {
                /// Whether the link should also support users relinking their Apple account.
                public var allowRelinking: Bool?
                /// The business name of the merchant accepting Apple's Terms and Conditions.
                public var merchantDisplayName: String?

                public init(
                    allowRelinking: Bool? = nil,
                    merchantDisplayName: String? = nil
                ) {
                    self.allowRelinking = allowRelinking
                    self.merchantDisplayName = merchantDisplayName
                }
            }
        }
    }
}
