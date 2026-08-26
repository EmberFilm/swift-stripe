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

extension Stripe {
    /// A payment method domain represents a web domain that you have registered with Stripe.
    public struct PaymentMethodDomain: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        public var amazonPay: AmazonPay?
        public var applePay: ApplePay?
        /// Time at which the object was created.
        public var created: Date?
        /// The domain name that this payment method domain object represents.
        public var domainName: String?
        /// Whether this payment method domain is enabled.
        public var enabled: Bool?
        public var googlePay: GooglePay?
        public var klarna: Klarna?
        public var link: Link?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        public var paypal: Paypal?

        public init(
            id: ID,
            object: String,
            amazonPay: AmazonPay? = nil,
            applePay: ApplePay? = nil,
            created: Date? = nil,
            domainName: String? = nil,
            enabled: Bool? = nil,
            googlePay: GooglePay? = nil,
            klarna: Klarna? = nil,
            link: Link? = nil,
            livemode: Bool? = nil,
            paypal: Paypal? = nil
        ) {
            self.id = id
            self.object = object
            self.amazonPay = amazonPay
            self.applePay = applePay
            self.created = created
            self.domainName = domainName
            self.enabled = enabled
            self.googlePay = googlePay
            self.klarna = klarna
            self.link = link
            self.livemode = livemode
            self.paypal = paypal
        }

        /// Indicates the status of a specific payment method on a payment method domain.
        public struct AmazonPay: Codable, Hashable, Sendable {
            /// The status of the payment method on the domain.
            public var status: Status?
            public var statusDetails: StatusDetails?

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            /// The status of the payment method on the domain.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case inactive
            }

            /// Contains additional details about the status of a payment method for a specific payment method domain.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// The error message associated with the status of the payment method on the domain.
                public var errorMessage: String?

                public init(
                    errorMessage: String? = nil
                ) {
                    self.errorMessage = errorMessage
                }
            }
        }

        /// Indicates the status of a specific payment method on a payment method domain.
        public struct ApplePay: Codable, Hashable, Sendable {
            /// The status of the payment method on the domain.
            public var status: Status?
            public var statusDetails: StatusDetails?

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            /// The status of the payment method on the domain.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case inactive
            }

            /// Contains additional details about the status of a payment method for a specific payment method domain.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// The error message associated with the status of the payment method on the domain.
                public var errorMessage: String?

                public init(
                    errorMessage: String? = nil
                ) {
                    self.errorMessage = errorMessage
                }
            }
        }

        /// Indicates the status of a specific payment method on a payment method domain.
        public struct GooglePay: Codable, Hashable, Sendable {
            /// The status of the payment method on the domain.
            public var status: Status?
            public var statusDetails: StatusDetails?

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            /// The status of the payment method on the domain.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case inactive
            }

            /// Contains additional details about the status of a payment method for a specific payment method domain.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// The error message associated with the status of the payment method on the domain.
                public var errorMessage: String?

                public init(
                    errorMessage: String? = nil
                ) {
                    self.errorMessage = errorMessage
                }
            }
        }

        /// Indicates the status of a specific payment method on a payment method domain.
        public struct Klarna: Codable, Hashable, Sendable {
            /// The status of the payment method on the domain.
            public var status: Status?
            public var statusDetails: StatusDetails?

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            /// The status of the payment method on the domain.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case inactive
            }

            /// Contains additional details about the status of a payment method for a specific payment method domain.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// The error message associated with the status of the payment method on the domain.
                public var errorMessage: String?

                public init(
                    errorMessage: String? = nil
                ) {
                    self.errorMessage = errorMessage
                }
            }
        }

        /// Indicates the status of a specific payment method on a payment method domain.
        public struct Link: Codable, Hashable, Sendable {
            /// The status of the payment method on the domain.
            public var status: Status?
            public var statusDetails: StatusDetails?

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            /// The status of the payment method on the domain.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case inactive
            }

            /// Contains additional details about the status of a payment method for a specific payment method domain.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// The error message associated with the status of the payment method on the domain.
                public var errorMessage: String?

                public init(
                    errorMessage: String? = nil
                ) {
                    self.errorMessage = errorMessage
                }
            }
        }

        /// Indicates the status of a specific payment method on a payment method domain.
        public struct Paypal: Codable, Hashable, Sendable {
            /// The status of the payment method on the domain.
            public var status: Status?
            public var statusDetails: StatusDetails?

            public init(
                status: Status? = nil,
                statusDetails: StatusDetails? = nil
            ) {
                self.status = status
                self.statusDetails = statusDetails
            }

            /// The status of the payment method on the domain.
            public enum Status: String, Codable, Hashable, Sendable {
                case active
                case inactive
            }

            /// Contains additional details about the status of a payment method for a specific payment method domain.
            public struct StatusDetails: Codable, Hashable, Sendable {
                /// The error message associated with the status of the payment method on the domain.
                public var errorMessage: String?

                public init(
                    errorMessage: String? = nil
                ) {
                    self.errorMessage = errorMessage
                }
            }
        }
    }
}
