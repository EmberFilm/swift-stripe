//
//  VerificationSession.Retained.swift
//  StripeKit
//
//  Created by Andrew Edwards on 7/24/21.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/identity/verification_sessions/object.md

public struct VerificationSessionLastError: Codable, Hashable, Sendable {
    /// A short machine-readable string giving the reason for the verification or user-session failure.
    public var code: VerificationSessionLastErrorCode?
    /// A message that explains the reason for verification or user-session failure.
    public var reason: String?

    public init(
        code: VerificationSessionLastErrorCode? = nil,
        reason: String? = nil
    ) {
        self.code = code
        self.reason = reason
    }
}

public enum VerificationSessionLastErrorCode: String, Codable, Sendable {
    /// The user declined to be verified by Stripe. Check with your legal counsel to see if you have an obligation to offer an alternative, non-biometric means to verify, such as through a manual review.
    case consentDeclined = "consent_declined"
    /// The user’s device didn’t have a camera or they declined to grant Stripe permission to access it.
    case deviceNotSupported = "device_not_supported"
    /// The user began the verification but didn’t submit it.
    case abandoned
    /// Stripe does not verify users under the age of 16.
    case underSupportedAge = "under_supported_age"
    /// Stripe does not verify users from the provided country.
    case countryNotSupported = "country_not_supported"
    /// The provided identity document has expired.
    case documentExpired = "document_expired"
    /// Stripe couldn’t verify the provided identity document. See list of supported document types.
    case documentUnverifiedOther = "document_unverified_other"
    /// The provided identity document isn’t one of the session’s allowed document types.
    case documentTypeNotSupported = "document_type_not_supported"
    /// The provided identity document didn’t contain a picture of a face.
    case selfieDocumentMissingPhoto = "selfie_document_missing_photo"
    /// The captured face image didn’t match with the document’s face.
    case selfieFaceMismatch = "selfie_face_mismatch"
    /// Stripe couldn’t verify the provided selfie.
    case selfieUnverifiedOther = "selfie_unverified_other"
    /// The captured face image was manipulated.
    case selfieManipulated = "selfie_manipulated"
    /// The information provided couldn’t be verified. See list of supported ID numbers.
    case idNumberUnverifiedOther = "id_number_unverified_other"
    /// The provided document didn’t contain enough data to match against the ID number.
    case idNumberInsufficientDocumentData = "id_number_insufficient_document_data"
    /// The information provided couldn’t be matched against global databases.
    case idNumberMismatch = "id_number_mismatch"
}

public struct VerificationSessionOptions: Codable, Hashable, Sendable {
    /// Configuration options to apply to the `document` check.
    public var document: VerificationSessionOptionsDocument?
    /// Configuration options to apply to the `id_number` check.
    public var idNumber: VerificationSessionOptionsIdNumber?

    public init(
        document: VerificationSessionOptionsDocument? = nil,
        idNumber: VerificationSessionOptionsIdNumber? = nil
    ) {
        self.document = document
        self.idNumber = idNumber
    }
}

public struct VerificationSessionOptionsDocument: Codable, Hashable, Sendable {
    /// Array of strings of allowed identity document types. If the provided identity document isn’t one of the allowed types, the verification check will fail with a `document_type_not_allowed` error code.
    public var allowedTypes: [VerificationSessionOptionsDocumentAllowedType]?
    /// Collect an ID number and perform an [ID number check](https://stripe.com/docs/identity/verification-checks?type=id-number) with the document’s extracted name and date of birth.
    public var requireIdNumber: Bool?
    /// Disable image uploads, identity document images have to be captured using the device’s camera.
    public var requireLiveCapture: Bool?
    /// Capture a face image and perform a [selfie check](https://stripe.com/docs/identity/verification-checks?type=selfie) comparing a photo ID and a picture of your user’s face. Learn more.
    public var requireMatchingSelfie: Bool

    public init(
        allowedTypes: [VerificationSessionOptionsDocumentAllowedType]? = nil,
        requireIdNumber: Bool? = nil,
        requireLiveCapture: Bool? = nil,
        requireMatchingSelfie: Bool
    ) {
        self.allowedTypes = allowedTypes
        self.requireIdNumber = requireIdNumber
        self.requireLiveCapture = requireLiveCapture
        self.requireMatchingSelfie = requireMatchingSelfie
    }
}

public enum VerificationSessionOptionsDocumentAllowedType: String, Codable, Sendable {
    /// Drivers license document type.
    case drivingLicense = "driving_license"
    /// Passport document type.
    case passport
    /// ID card document type.
    case idCard = "id_card"
}

public struct VerificationSessionOptionsIdNumber: Codable, Hashable, Sendable {
    public init() {}
}

public struct VerificationSessionRedaction: Codable, Hashable, Sendable {
    /// Indicates whether this object and its related objects have been redacted or not.
    public var status: VerificationSessionRedactionStatus?

    public init(
        status: VerificationSessionRedactionStatus? = nil
    ) {
        self.status = status
    }
}

public enum VerificationSessionRedactionStatus: String, Codable, Sendable {
    /// This object and its related objects have been redacted.
    case redacted
    /// This object has been redacted, and its related objects are in the process of being redacted. This process may take up to four days.
    case processing
}

public enum VerificationSessionStatus: String, Codable, Sendable {
    /// Requires user input before processing can continue.
    case requiresInput = "requires_input"
    /// The session has been submitted and is being processed. Most [verification checks](https://stripe.com/docs/identity/verification-checks) take a few minutes to process.
    case processing
    /// Processing of all the verification checks are complete and successfully verified.
    case verified
    /// The VerificationSession has been invalidated for future submission attempts.
    case canceled
}

public enum VerificationSessionType: String, Codable, Sendable {
    /// [Document check](https://stripe.com/docs/identity/verification-checks?type=document)
    case document
    /// [ID number check](https://stripe.com/docs/identity/verification-checks?type=id-number).
    case idNumber = "id_number"
}

public struct VerificationSessionVerifiedOutputs: Codable, Hashable, Sendable {
    /// The user’s verified address.
    public var address: Address?
    /// The user’s verified date of birth.
    /// This field is not included by default. To include it in the response, expand the `dob` field.
    public var dob: Stripe.Connect.Person.DOB?
    /// The user’s verified first name.
    public var firstName: String?
    /// The user’s verified id number.
    /// This field is not included by default. To include it in the response, expand the `id_number` field.
    public var idNumber: String?
    /// The user’s verified id number type.
    public var idNumberType: VerificationSessionVerifiedOutputsIdNumberType?
    /// The user’s verified last name.
    public var lastName: String?

    public init(
        address: Address? = nil,
        dob: Stripe.Connect.Person.DOB? = nil,
        firstName: String? = nil,
        idNumber: String? = nil,
        idNumberType: VerificationSessionVerifiedOutputsIdNumberType? = nil,
        lastName: String? = nil
    ) {
        self.address = address
        self.dob = dob
        self.firstName = firstName
        self.idNumber = idNumber
        self.idNumberType = idNumberType
        self.lastName = lastName
    }
}

public enum VerificationSessionVerifiedOutputsIdNumberType: String, Codable, Sendable {
    /// An individual CPF number from Brazil.
    case brCpf = "br_cpf"
    /// A national registration identity card number from Singapore.
    case sgNric = "sg_nric"
    /// A social security number from the United States.
    case usSsn = "us_ssn"
}

public struct VerificationSessionList: Codable, Hashable, Sendable {
    public var object: String
    public var data: [VerificationSession]?
    public var hasMore: Bool?
    public var url: String?

    public init(
        object: String,
        data: [VerificationSession]? = nil,
        hasMore: Bool? = nil,
        url: String? = nil
    ) {
        self.object = object
        self.data = data
        self.hasMore = hasMore
        self.url = url
    }
}

// The VerificationSession struct is generated (Models/Generated). These are the nested types the
// request layer still names under `VerificationSession` that the generator spells differently.

