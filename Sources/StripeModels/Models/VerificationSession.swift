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

/// A VerificationSession guides you through the process of collecting and verifying the identities of your users.
public struct VerificationSession: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    public let id: ID
    /// String representing the object's type.
    public let object: String
    /// A string to reference this user.
    public var clientReferenceId: String?
    /// The short-lived client secret used by Stripe.js to show a verification modal inside your app.
    public var clientSecret: String?
    /// Time at which the object was created.
    public var created: Date?
    /// If present, this property tells you the last error encountered when processing the verification.
    public var lastError: LastError?
    /// ID of the most recent VerificationReport.
    @Expandable<VerificationReport, String> public var lastVerificationReport: String?
    /// If the object exists in live mode, the value is `true`.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object.
    public var metadata: [String: String]?
    /// A set of options for the session’s verification checks.
    public var options: Options?
    /// Details provided about the user being verified.
    public var providedDetails: ProvidedDetails?
    /// Redaction status of this VerificationSession.
    public var redaction: Redaction?
    /// Customer ID.
    public var relatedCustomer: String?
    /// The ID of the Account representing a customer.
    public var relatedCustomerAccount: String?
    public var relatedPerson: RelatedPerson?
    /// Status of this VerificationSession.
    public var status: Status?
    /// The type of verification check to be performed.
    public var `type`: Type?
    /// The short-lived URL that you use to redirect a user to Stripe to submit their identity information.
    public var url: String?
    /// The configuration token of a verification flow from the dashboard.
    public var verificationFlow: String?
    /// The user’s verified data.
    public var verifiedOutputs: VerifiedOutputs?

    public init(
        id: ID,
        object: String,
        clientReferenceId: String? = nil,
        clientSecret: String? = nil,
        created: Date? = nil,
        lastError: LastError? = nil,
        lastVerificationReport: String? = nil,
        livemode: Bool? = nil,
        metadata: [String: String]? = nil,
        options: Options? = nil,
        providedDetails: ProvidedDetails? = nil,
        redaction: Redaction? = nil,
        relatedCustomer: String? = nil,
        relatedCustomerAccount: String? = nil,
        relatedPerson: RelatedPerson? = nil,
        status: Status? = nil,
        `type`: Type? = nil,
        url: String? = nil,
        verificationFlow: String? = nil,
        verifiedOutputs: VerifiedOutputs? = nil
    ) {
        self.id = id
        self.object = object
        self.clientReferenceId = clientReferenceId
        self.clientSecret = clientSecret
        self.created = created
        self.lastError = lastError
        self._lastVerificationReport = Expandable(id: lastVerificationReport)
        self.livemode = livemode
        self.metadata = metadata
        self.options = options
        self.providedDetails = providedDetails
        self.redaction = redaction
        self.relatedCustomer = relatedCustomer
        self.relatedCustomerAccount = relatedCustomerAccount
        self.relatedPerson = relatedPerson
        self.status = status
        self.`type` = `type`
        self.url = url
        self.verificationFlow = verificationFlow
        self.verifiedOutputs = verifiedOutputs
    }

    /// Status of this VerificationSession.
    public enum Status: String, Codable, Hashable, Sendable {
        case canceled
        case processing
        case requiresInput = "requires_input"
        case verified
    }

    /// The type of verification check to be performed.
    public enum `Type`: String, Codable, Hashable, Sendable {
        case document
        case idNumber = "id_number"
        case verificationFlow = "verification_flow"
    }

    /// Shows last VerificationSession error.
    public struct LastError: Codable, Hashable, Sendable {
        /// A short machine-readable string giving the reason for the verification or user-session failure.
        public var code: Code?
        /// A message that explains the reason for verification or user-session failure.
        public var reason: String?

        public init(
            code: Code? = nil,
            reason: String? = nil
        ) {
            self.code = code
            self.reason = reason
        }

        /// A short machine-readable string giving the reason for the verification or user-session failure.
        public enum Code: String, Codable, Hashable, Sendable {
            case abandoned
            case consentDeclined = "consent_declined"
            case countryNotSupported = "country_not_supported"
            case deviceNotSupported = "device_not_supported"
            case documentExpired = "document_expired"
            case documentTypeNotSupported = "document_type_not_supported"
            case documentUnverifiedOther = "document_unverified_other"
            case emailUnverifiedOther = "email_unverified_other"
            case emailVerificationDeclined = "email_verification_declined"
            case idNumberInsufficientDocumentData = "id_number_insufficient_document_data"
            case idNumberMismatch = "id_number_mismatch"
            case idNumberUnverifiedOther = "id_number_unverified_other"
            case phoneUnverifiedOther = "phone_unverified_other"
            case phoneVerificationDeclined = "phone_verification_declined"
            case selfieDocumentMissingPhoto = "selfie_document_missing_photo"
            case selfieFaceMismatch = "selfie_face_mismatch"
            case selfieManipulated = "selfie_manipulated"
            case selfieUnverifiedOther = "selfie_unverified_other"
            case underSupportedAge = "under_supported_age"
        }
    }

    public struct Options: Codable, Hashable, Sendable {
        public var document: Document?
        public var email: Email?
        public var idNumber: IdNumber?
        public var matching: Matching?
        public var phone: Phone?

        public init(
            document: Document? = nil,
            email: Email? = nil,
            idNumber: IdNumber? = nil,
            matching: Matching? = nil,
            phone: Phone? = nil
        ) {
            self.document = document
            self.email = email
            self.idNumber = idNumber
            self.matching = matching
            self.phone = phone
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

        public struct Email: Codable, Hashable, Sendable {
            /// Request one time password verification of `provided_details.email`.
            public var requireVerification: Bool?

            public init(
                requireVerification: Bool? = nil
            ) {
                self.requireVerification = requireVerification
            }
        }

        public struct IdNumber: Codable, Hashable, Sendable {
            public init() {}
        }

        public struct Matching: Codable, Hashable, Sendable {
            /// Strictness of the DOB matching policy to apply.
            public var dob: Dob?
            /// Strictness of the name matching policy to apply.
            public var name: Name?

            public init(
                dob: Dob? = nil,
                name: Name? = nil
            ) {
                self.dob = dob
                self.name = name
            }

            /// Strictness of the DOB matching policy to apply.
            public enum Dob: String, Codable, Hashable, Sendable {
                case none
                case similar
            }

            /// Strictness of the name matching policy to apply.
            public enum Name: String, Codable, Hashable, Sendable {
                case none
                case similar
            }
        }

        public struct Phone: Codable, Hashable, Sendable {
            /// Request one time password verification of `provided_details.phone`.
            public var requireVerification: Bool?

            public init(
                requireVerification: Bool? = nil
            ) {
                self.requireVerification = requireVerification
            }
        }
    }

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

    public struct Redaction: Codable, Hashable, Sendable {
        /// Indicates whether this object and its related objects have been redacted or not.
        public var status: Status?

        public init(
            status: Status? = nil
        ) {
            self.status = status
        }

        /// Indicates whether this object and its related objects have been redacted or not.
        public enum Status: String, Codable, Hashable, Sendable {
            case processing
            case redacted
            case validated
        }
    }

    public struct RelatedPerson: Codable, Hashable, Sendable {
        /// Token referencing the associated Account of the related Person resource.
        public var account: String?
        /// Token referencing the related Person resource.
        public var person: String?

        public init(
            account: String? = nil,
            person: String? = nil
        ) {
            self.account = account
            self.person = person
        }
    }

    public struct VerifiedOutputs: Codable, Hashable, Sendable {
        /// The user's verified address.
        public var address: Address?
        /// The user’s verified date of birth.
        public var dob: Dob?
        /// The user's verified email address.
        public var email: String?
        /// The user's verified first name.
        public var firstName: String?
        /// The user's verified id number.
        public var idNumber: String?
        /// The user's verified id number type.
        public var idNumberType: IdNumberType?
        /// The user's verified last name.
        public var lastName: String?
        /// The user's verified phone number.
        public var phone: String?
        /// The user's verified sex.
        public var sex: Sex?
        /// The user's verified place of birth as it appears in the document.
        public var unparsedPlaceOfBirth: String?
        /// The user's verified sex as it appears in the document.
        public var unparsedSex: String?

        public init(
            address: Address? = nil,
            dob: Dob? = nil,
            email: String? = nil,
            firstName: String? = nil,
            idNumber: String? = nil,
            idNumberType: IdNumberType? = nil,
            lastName: String? = nil,
            phone: String? = nil,
            sex: Sex? = nil,
            unparsedPlaceOfBirth: String? = nil,
            unparsedSex: String? = nil
        ) {
            self.address = address
            self.dob = dob
            self.email = email
            self.firstName = firstName
            self.idNumber = idNumber
            self.idNumberType = idNumberType
            self.lastName = lastName
            self.phone = phone
            self.sex = sex
            self.unparsedPlaceOfBirth = unparsedPlaceOfBirth
            self.unparsedSex = unparsedSex
        }

        /// The user's verified id number type.
        public enum IdNumberType: String, Codable, Hashable, Sendable {
            case brCpf = "br_cpf"
            case sgNric = "sg_nric"
            case usSsn = "us_ssn"
        }

        /// The user's verified sex.
        public enum Sex: String, Codable, Hashable, Sendable {
            case value_redacted_ = "[redacted]"
            case female
            case male
            case unknown
        }

        /// Point in Time.
        public struct Dob: Codable, Hashable, Sendable {
            /// Numerical day between 1 and 31.
            public var day: Int?
            /// Numerical month between 1 and 12.
            public var month: Int?
            /// The four-digit year.
            public var year: Int?

            public init(
                day: Int? = nil,
                month: Int? = nil,
                year: Int? = nil
            ) {
                self.day = day
                self.month = month
                self.year = year
            }
        }
    }
}
