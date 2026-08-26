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

extension VerificationSession {
    public enum Cancel {}
    public enum Create {}
    public enum List {}
    public enum Redact {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/identity/verification_sessions/{session}/cancel
extension VerificationSession.Cancel {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = VerificationSession
}

// POST /v1/identity/verification_sessions
extension VerificationSession.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// A string to reference this user.
        public var clientReferenceId: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// A set of options for the session’s verification checks.
        public var options: Options?
        /// Details provided about the user being verified.
        public var providedDetails: ProvidedDetails?
        /// Customer ID.
        public var relatedCustomer: String?
        /// The ID of the Account representing a customer.
        public var relatedCustomerAccount: String?
        /// Tokens referencing a Person resource and its associated account.
        public var relatedPerson: RelatedPerson?
        /// The URL that the user will be redirected to upon completing the verification flow.
        public var returnUrl: String?
        /// The type of verification check to be performed.
        public var `type`: Type?
        /// The ID of a verification flow from the Dashboard.
        public var verificationFlow: String?

        public init(
            clientReferenceId: String? = nil,
            expand: [String]? = nil,
            metadata: [String: String]? = nil,
            options: Options? = nil,
            providedDetails: ProvidedDetails? = nil,
            relatedCustomer: String? = nil,
            relatedCustomerAccount: String? = nil,
            relatedPerson: RelatedPerson? = nil,
            returnUrl: String? = nil,
            `type`: Type? = nil,
            verificationFlow: String? = nil
        ) {
            self.clientReferenceId = clientReferenceId
            self.expand = expand
            self.metadata = metadata
            self.options = options
            self.providedDetails = providedDetails
            self.relatedCustomer = relatedCustomer
            self.relatedCustomerAccount = relatedCustomerAccount
            self.relatedPerson = relatedPerson
            self.returnUrl = returnUrl
            self.`type` = `type`
            self.verificationFlow = verificationFlow
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case document
            case idNumber = "id_number"
        }

        /// A set of options for the session’s verification checks.
        public struct Options: Codable, Hashable, Sendable {
            /// Options that apply to the document check.
            public var document: Stripe.Clearable<Document>?

            public init(
                document: Stripe.Clearable<Document>? = nil
            ) {
                self.document = document
            }

            public struct Document: Codable, Hashable, Sendable {
                /// Array of strings of allowed identity document types.
                public var allowedTypes: [AllowedTypes]?
                /// Collect an ID number and perform an ID number check with the document’s extracted name and date of birth.
                public var requireIdNumber: Bool?
                /// Disable image uploads, identity document images have to be captured using the device’s camera.
                public var requireLiveCapture: Bool?
                /// Capture a face image and perform a selfie check comparing a photo ID and a picture of your user’s face.
                public var requireMatchingSelfie: Bool?

                public init(
                    allowedTypes: [AllowedTypes]? = nil,
                    requireIdNumber: Bool? = nil,
                    requireLiveCapture: Bool? = nil,
                    requireMatchingSelfie: Bool? = nil
                ) {
                    self.allowedTypes = allowedTypes
                    self.requireIdNumber = requireIdNumber
                    self.requireLiveCapture = requireLiveCapture
                    self.requireMatchingSelfie = requireMatchingSelfie
                }

                public enum AllowedTypes: String, Codable, Hashable, Sendable {
                    case drivingLicense = "driving_license"
                    case idCard = "id_card"
                    case passport
                }
            }
        }

        /// Details provided about the user being verified.
        public struct ProvidedDetails: Codable, Hashable, Sendable {
            /// Email of user being verified.
            public var email: String?
            /// Phone number of user being verified.
            public var phone: String?

            public init(
                email: String? = nil,
                phone: String? = nil
            ) {
                self.email = email
                self.phone = phone
            }
        }

        /// Tokens referencing a Person resource and its associated account.
        public struct RelatedPerson: Codable, Hashable, Sendable {
            /// A token representing a connected account.
            public var account: String
            /// A token referencing a Person resource that this verification is being used to verify.
            public var person: String

            public init(
                account: String,
                person: String
            ) {
                self.account = account
                self.person = person
            }
        }
    }

    public typealias Response = VerificationSession
}

// GET /v1/identity/verification_sessions
extension VerificationSession.List {
    public struct Request: Codable, Hashable, Sendable {
        /// A string to reference this user.
        public var clientReferenceId: String?
        /// Only return VerificationSessions that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// Customer ID.
        public var relatedCustomer: String?
        /// The ID of the Account representing a customer.
        public var relatedCustomerAccount: String?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return VerificationSessions with this status.
        public var status: Status?

        public init(
            clientReferenceId: String? = nil,
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            relatedCustomer: String? = nil,
            relatedCustomerAccount: String? = nil,
            startingAfter: String? = nil,
            status: Status? = nil
        ) {
            self.clientReferenceId = clientReferenceId
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.relatedCustomer = relatedCustomer
            self.relatedCustomerAccount = relatedCustomerAccount
            self.startingAfter = startingAfter
            self.status = status
        }

        public enum Status: String, Codable, Hashable, Sendable {
            case canceled
            case processing
            case requiresInput = "requires_input"
            case verified
        }
    }

    public typealias Response = Stripe.Page<VerificationSession>
}

// POST /v1/identity/verification_sessions/{session}/redact
extension VerificationSession.Redact {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = VerificationSession
}

// GET /v1/identity/verification_sessions/{session}
extension VerificationSession.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = VerificationSession
}

// POST /v1/identity/verification_sessions/{session}
extension VerificationSession.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// A set of options for the session’s verification checks.
        public var options: Options?
        /// Details provided about the user being verified.
        public var providedDetails: ProvidedDetails?
        /// The type of verification check to be performed.
        public var `type`: Type?

        public init(
            expand: [String]? = nil,
            metadata: [String: String]? = nil,
            options: Options? = nil,
            providedDetails: ProvidedDetails? = nil,
            `type`: Type? = nil
        ) {
            self.expand = expand
            self.metadata = metadata
            self.options = options
            self.providedDetails = providedDetails
            self.`type` = `type`
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case document
            case idNumber = "id_number"
        }

        /// A set of options for the session’s verification checks.
        public struct Options: Codable, Hashable, Sendable {
            /// Options that apply to the document check.
            public var document: Stripe.Clearable<Document>?

            public init(
                document: Stripe.Clearable<Document>? = nil
            ) {
                self.document = document
            }

            public struct Document: Codable, Hashable, Sendable {
                /// Array of strings of allowed identity document types.
                public var allowedTypes: [AllowedTypes]?
                /// Collect an ID number and perform an ID number check with the document’s extracted name and date of birth.
                public var requireIdNumber: Bool?
                /// Disable image uploads, identity document images have to be captured using the device’s camera.
                public var requireLiveCapture: Bool?
                /// Capture a face image and perform a selfie check comparing a photo ID and a picture of your user’s face.
                public var requireMatchingSelfie: Bool?

                public init(
                    allowedTypes: [AllowedTypes]? = nil,
                    requireIdNumber: Bool? = nil,
                    requireLiveCapture: Bool? = nil,
                    requireMatchingSelfie: Bool? = nil
                ) {
                    self.allowedTypes = allowedTypes
                    self.requireIdNumber = requireIdNumber
                    self.requireLiveCapture = requireLiveCapture
                    self.requireMatchingSelfie = requireMatchingSelfie
                }

                public enum AllowedTypes: String, Codable, Hashable, Sendable {
                    case drivingLicense = "driving_license"
                    case idCard = "id_card"
                    case passport
                }
            }
        }

        /// Details provided about the user being verified.
        public struct ProvidedDetails: Codable, Hashable, Sendable {
            /// Email of user being verified.
            public var email: String?
            /// Phone number of user being verified.
            public var phone: String?

            public init(
                email: String? = nil,
                phone: String? = nil
            ) {
                self.email = email
                self.phone = phone
            }
        }
    }

    public typealias Response = VerificationSession
}
