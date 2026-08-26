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

extension Stripe.Fraud.Reviews {
    /// Reviews can be used to supplement automated fraud detection with human expertise.
    public struct Review: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The ZIP or postal code of the card used, if applicable.
        public var billingZip: String?
        /// The charge associated with this review.
        @Expandable<Stripe.Charges.Charge, String> public var charge: String?
        /// The reason the review was closed, or null if it has not yet been closed.
        public var closedReason: ClosedReason?
        /// Time at which the object was created.
        public var created: Date?
        /// The IP address where the payment originated.
        public var ipAddress: String?
        /// Information related to the location of the payment.
        public var ipAddressLocation: IpAddressLocation?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// If `true`, the review needs action.
        public var open: Bool?
        /// The reason the review was opened.
        public var openedReason: OpenedReason?
        /// The PaymentIntent ID associated with this review, if one exists.
        @Expandable<Stripe.PaymentIntents.PaymentIntent, String> public var paymentIntent: String?
        /// The reason the review is currently open or closed.
        public var reason: String?
        /// Information related to the browsing session of the user who initiated the payment.
        public var session: Session?

        public init(
            id: ID,
            object: String,
            billingZip: String? = nil,
            charge: String? = nil,
            closedReason: ClosedReason? = nil,
            created: Date? = nil,
            ipAddress: String? = nil,
            ipAddressLocation: IpAddressLocation? = nil,
            livemode: Bool? = nil,
            open: Bool? = nil,
            openedReason: OpenedReason? = nil,
            paymentIntent: String? = nil,
            reason: String? = nil,
            session: Session? = nil
        ) {
            self.id = id
            self.object = object
            self.billingZip = billingZip
            self._charge = Expandable(id: charge)
            self.closedReason = closedReason
            self.created = created
            self.ipAddress = ipAddress
            self.ipAddressLocation = ipAddressLocation
            self.livemode = livemode
            self.open = open
            self.openedReason = openedReason
            self._paymentIntent = Expandable(id: paymentIntent)
            self.reason = reason
            self.session = session
        }

        /// The reason the review was closed, or null if it has not yet been closed.
        public enum ClosedReason: String, Codable, Hashable, Sendable {
            case acknowledged
            case approved
            case canceled
            case disputed
            case paymentNeverSettled = "payment_never_settled"
            case redacted
            case refunded
            case refundedAsFraud = "refunded_as_fraud"
        }

        /// The reason the review was opened.
        public enum OpenedReason: String, Codable, Hashable, Sendable {
            case manual
            case rule
        }

        public struct IpAddressLocation: Codable, Hashable, Sendable {
            /// The city where the payment originated.
            public var city: String?
            /// Two-letter ISO code representing the country where the payment originated.
            public var country: String?
            /// The geographic latitude where the payment originated.
            public var latitude: Double?
            /// The geographic longitude where the payment originated.
            public var longitude: Double?
            /// The state/county/province/region where the payment originated.
            public var region: String?

            public init(
                city: String? = nil,
                country: String? = nil,
                latitude: Double? = nil,
                longitude: Double? = nil,
                region: String? = nil
            ) {
                self.city = city
                self.country = country
                self.latitude = latitude
                self.longitude = longitude
                self.region = region
            }
        }

        public struct Session: Codable, Hashable, Sendable {
            /// The browser used in this browser session (e.g., `Chrome`).
            public var browser: String?
            /// Information about the device used for the browser session (e.g., `Samsung SM-G930T`).
            public var device: String?
            /// The platform for the browser session (e.g., `Macintosh`).
            public var platform: String?
            /// The version for the browser session (e.g., `61.0.3163.100`).
            public var version: String?

            public init(
                browser: String? = nil,
                device: String? = nil,
                platform: String? = nil,
                version: String? = nil
            ) {
                self.browser = browser
                self.device = device
                self.platform = platform
                self.version = version
            }
        }
    }
}
