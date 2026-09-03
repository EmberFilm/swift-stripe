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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Issuing.PersonalizationDesign {
    public enum Activate {}
    public enum Create {}
    public enum Deactivate {}
    public enum List {}
    public enum Reject {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/test_helpers/issuing/personalization_designs/{personalization_design}/activate
extension Stripe.Issuing.PersonalizationDesign.Activate {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Issuing.PersonalizationDesign
}

// POST /v1/issuing/personalization_designs
extension Stripe.Issuing.PersonalizationDesign.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// The file for the card logo, for use with physical bundles that support card logos.
        public var cardLogo: String?
        /// Hash containing carrier text, for use with physical bundles that support carrier text.
        public var carrierText: CarrierText?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A lookup key used to retrieve personalization designs dynamically from a static string.
        public var lookupKey: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Friendly display name.
        public var name: String?
        /// The physical bundle object belonging to this personalization design.
        public var physicalBundle: String
        /// Information on whether this personalization design is used to create cards when one is not specified.
        public var preferences: Preferences?
        /// If set to true, will atomically remove the lookup key from the existing personalization design, and assign it to this.
        public var transferLookupKey: Bool?

        public init(
            cardLogo: String? = nil,
            carrierText: CarrierText? = nil,
            expand: [String]? = nil,
            lookupKey: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            physicalBundle: String,
            preferences: Preferences? = nil,
            transferLookupKey: Bool? = nil
        ) {
            self.cardLogo = cardLogo
            self.carrierText = carrierText
            self.expand = expand
            self.lookupKey = lookupKey
            self.metadata = metadata
            self.name = name
            self.physicalBundle = physicalBundle
            self.preferences = preferences
            self.transferLookupKey = transferLookupKey
        }

        /// Hash containing carrier text, for use with physical bundles that support carrier text.
        public struct CarrierText: Codable, Hashable, Sendable {
            /// The footer body text of the carrier letter.
            public var footerBody: String?
            /// The footer title text of the carrier letter.
            public var footerTitle: String?
            /// The header body text of the carrier letter.
            public var headerBody: String?
            /// The header title text of the carrier letter.
            public var headerTitle: String?

            public init(
                footerBody: String? = nil,
                footerTitle: String? = nil,
                headerBody: String? = nil,
                headerTitle: String? = nil
            ) {
                self.footerBody = footerBody
                self.footerTitle = footerTitle
                self.headerBody = headerBody
                self.headerTitle = headerTitle
            }
        }

        /// Information on whether this personalization design is used to create cards when one is not specified.
        public struct Preferences: Codable, Hashable, Sendable {
            /// Whether we use this personalization design to create cards when one isn't specified.
            public var isDefault: Bool

            public init(
                isDefault: Bool
            ) {
                self.isDefault = isDefault
            }
        }
    }

    public typealias Response = Stripe.Issuing.PersonalizationDesign
}

// POST /v1/test_helpers/issuing/personalization_designs/{personalization_design}/deactivate
extension Stripe.Issuing.PersonalizationDesign.Deactivate {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Issuing.PersonalizationDesign
}

// GET /v1/issuing/personalization_designs
extension Stripe.Issuing.PersonalizationDesign.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Only return personalization designs with the given lookup keys.
        public var lookupKeys: [String]?
        /// Only return personalization designs with the given preferences.
        public var preferences: Preferences?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return personalization designs with the given status.
        public var status: Status?

        public init(
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            lookupKeys: [String]? = nil,
            preferences: Preferences? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.lookupKeys = lookupKeys
            self.preferences = preferences
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case inactive
            case rejected
            case review
        }

        /// Only return personalization designs with the given preferences.
        public struct Preferences: Codable, Hashable, Sendable {
            /// Only return the personalization design that's set as the default.
            public var isDefault: Bool?
            /// Only return the personalization design that is set as the Connect platform's default.
            public var isPlatformDefault: Bool?

            public init(
                isDefault: Bool? = nil,
                isPlatformDefault: Bool? = nil
            ) {
                self.isDefault = isDefault
                self.isPlatformDefault = isPlatformDefault
            }
        }
    }

    public typealias Response = Stripe.Page<Stripe.Issuing.PersonalizationDesign>
}

// POST /v1/test_helpers/issuing/personalization_designs/{personalization_design}/reject
extension Stripe.Issuing.PersonalizationDesign.Reject {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The reason(s) the personalization design was rejected.
        public var rejectionReasons: RejectionReasons

        public init(
            expand: [String]? = nil,
            rejectionReasons: RejectionReasons
        ) {
            self.expand = expand
            self.rejectionReasons = rejectionReasons
        }

        /// The reason(s) the personalization design was rejected.
        public struct RejectionReasons: Codable, Hashable, Sendable {
            /// The reason(s) the card logo was rejected.
            public var cardLogo: [CardLogo]?
            /// The reason(s) the carrier text was rejected.
            public var carrierText: [CarrierText]?

            public init(
                cardLogo: [CardLogo]? = nil,
                carrierText: [CarrierText]? = nil
            ) {
                self.cardLogo = cardLogo
                self.carrierText = carrierText
            }

            public enum CardLogo: String, Codable, Hashable, Sendable {
                case geographicLocation = "geographic_location"
                case inappropriate
                case networkName = "network_name"
                case nonBinaryImage = "non_binary_image"
                case nonFiatCurrency = "non_fiat_currency"
                case other
                case otherEntity = "other_entity"
                case promotionalMaterial = "promotional_material"
            }

            public enum CarrierText: String, Codable, Hashable, Sendable {
                case geographicLocation = "geographic_location"
                case inappropriate
                case networkName = "network_name"
                case nonFiatCurrency = "non_fiat_currency"
                case other
                case otherEntity = "other_entity"
                case promotionalMaterial = "promotional_material"
            }
        }
    }

    public typealias Response = Stripe.Issuing.PersonalizationDesign
}

// GET /v1/issuing/personalization_designs/{personalization_design}
extension Stripe.Issuing.PersonalizationDesign.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Issuing.PersonalizationDesign
}

// POST /v1/issuing/personalization_designs/{personalization_design}
extension Stripe.Issuing.PersonalizationDesign.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// The file for the card logo, for use with physical bundles that support card logos.
        public var cardLogo: String?
        /// Hash containing carrier text, for use with physical bundles that support carrier text.
        public var carrierText: Stripe.Clearable<CarrierText>?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A lookup key used to retrieve personalization designs dynamically from a static string.
        public var lookupKey: String?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// Friendly display name.
        public var name: String?
        /// The physical bundle object belonging to this personalization design.
        public var physicalBundle: String?
        /// Information on whether this personalization design is used to create cards when one is not specified.
        public var preferences: Preferences?
        /// If set to true, will atomically remove the lookup key from the existing personalization design, and assign it to this.
        public var transferLookupKey: Bool?

        public init(
            cardLogo: String? = nil,
            carrierText: Stripe.Clearable<CarrierText>? = nil,
            expand: [String]? = nil,
            lookupKey: String? = nil,
            metadata: [String: String]? = nil,
            name: String? = nil,
            physicalBundle: String? = nil,
            preferences: Preferences? = nil,
            transferLookupKey: Bool? = nil
        ) {
            self.cardLogo = cardLogo
            self.carrierText = carrierText
            self.expand = expand
            self.lookupKey = lookupKey
            self.metadata = metadata
            self.name = name
            self.physicalBundle = physicalBundle
            self.preferences = preferences
            self.transferLookupKey = transferLookupKey
        }

        public struct CarrierText: Codable, Hashable, Sendable {
            /// The footer body text of the carrier letter.
            public var footerBody: String?
            /// The footer title text of the carrier letter.
            public var footerTitle: String?
            /// The header body text of the carrier letter.
            public var headerBody: String?
            /// The header title text of the carrier letter.
            public var headerTitle: String?

            public init(
                footerBody: String? = nil,
                footerTitle: String? = nil,
                headerBody: String? = nil,
                headerTitle: String? = nil
            ) {
                self.footerBody = footerBody
                self.footerTitle = footerTitle
                self.headerBody = headerBody
                self.headerTitle = headerTitle
            }
        }

        /// Information on whether this personalization design is used to create cards when one is not specified.
        public struct Preferences: Codable, Hashable, Sendable {
            /// Whether we use this personalization design to create cards when one isn't specified.
            public var isDefault: Bool

            public init(
                isDefault: Bool
            ) {
                self.isDefault = isDefault
            }
        }
    }

    public typealias Response = Stripe.Issuing.PersonalizationDesign
}
