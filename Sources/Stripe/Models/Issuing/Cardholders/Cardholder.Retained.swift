//
//  Cardholder.Retained.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/21/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/issuing/cardholders/object.md

public struct CardholderSpendingControls: Codable, Hashable, Sendable {
    /// Array of strings containing categories of authorizations to allow. All other categories will be blocked. Cannot be set with `blocked_categories`.
    public var allowedCategories: [String]?
    /// Array of strings containing categories of authorizations to decline. All other categories will be allowed. Cannot be set with `allowed_categories`.
    public var blockedCategories: [String]?
    /// Limit spending with amount-based rules that apply across this cardholder’s cards.
    public var spendingLimits: [CardholderSpendingControlSpendingLimit]?
    /// Currency of the amounts within `spending_limits`.
    public var spendingLimitsCurrency: Stripe.Currency?

    public init(
        allowedCategories: [String]? = nil,
        blockedCategories: [String]? = nil,
        spendingLimits: [CardholderSpendingControlSpendingLimit]? = nil,
        spendingLimitsCurrency: Stripe.Currency? = nil
    ) {
        self.allowedCategories = allowedCategories
        self.blockedCategories = blockedCategories
        self.spendingLimits = spendingLimits
        self.spendingLimitsCurrency = spendingLimitsCurrency
    }
}

public struct CardholderSpendingControlSpendingLimit: Codable, Hashable, Sendable {
    /// Maximum amount allowed to spend per interval. This amount is in the card’s currency and in the smallest currency unit.
    public var amount: Int?
    /// Array of strings containing categories this limit applies to. Omitting this field will apply the limit to all categories.
    public var categories: [String]?
    /// Interval (or event) to which the amount applies.
    public var interval: CardholderSpendingControlSpendingLimitInterval?
}

public enum CardholderSpendingControlSpendingLimitInterval: String, Codable, Sendable {
    /// Limit applies to each authorization.
    case perAuthorization = "per_authorization"
    /// Limit applies to a day, starting at midnight UTC.
    case daily
    /// Limit applies to a week, starting on Sunday at midnight UTC.
    case weekly
    /// Limit applies to a month, starting on the 1st.
    case monthly
    /// Limit applies to a year, starting on January 1st.
    case yearly
    /// Limit applies to all transactions.
    case allTime = "all_time"
}

public struct CardholderBilling: Codable, Hashable, Sendable {
    /// The cardholder’s billing address.
    public var address: Address?

    public init(
        address: Address? = nil
    ) {
        self.address = address
    }
}

public struct CardholderCompany: Codable, Hashable, Sendable {
    /// Whether the company’s business ID number was provided.
    public var taxIdProvided: Bool?

    public init(
        taxIdProvided: Bool? = nil
    ) {
        self.taxIdProvided = taxIdProvided
    }
}

public struct CardholderIndividual: Codable, Hashable, Sendable {
    /// Information related to the `card_issuing` program for this cardholder.
    public var cardIssuing: CardholderIndividualCardIssuing?
    /// The date of birth of this cardholder.
    public var dob: Stripe.Connect.Person.DOB?
    /// The first name of this cardholder
    public var firstName: String?
    /// The first name of this cardholder
    public var lastName: String?
    /// Government-issued ID document for this cardholder.
    public var verification: CardholderIndividualVerification?

    public init(
        cardIssuing: CardholderIndividualCardIssuing? = nil,
        dob: Stripe.Connect.Person.DOB? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        verification: CardholderIndividualVerification? = nil
    ) {
        self.cardIssuing = cardIssuing
        self.dob = dob
        self.firstName = firstName
        self.lastName = lastName
        self.verification = verification
    }
}

public struct CardholderIndividualCardIssuing: Codable, Hashable, Sendable {
    /// Information about cardholder acceptance of [Authorized User Terms](https://stripe.com/docs/issuing/cards) .
    public var userTermsAcceptance: CardholderIndividualCardIssuingUserTermsAcceptance?

    public init(
        userTermsAcceptance: CardholderIndividualCardIssuingUserTermsAcceptance? = nil
    ) {
        self.userTermsAcceptance = userTermsAcceptance
    }
}

public struct CardholderIndividualCardIssuingUserTermsAcceptance: Codable, Hashable, Sendable {
    /// The Unix timestamp marking when the cardholder accepted the Authorized User Terms. Required for Celtic Spend Card users.
    public var date: Date?
    /// The IP address from which the cardholder accepted the Authorized User Terms. Required for Celtic Spend Card users.
    public var ip: String?
    /// The user agent of the browser from which the cardholder accepted the Authorized User Terms.
    public var userAgent: String?

    public init(
        date: Date? = nil,
        ip: String? = nil,
        userAgent: String? = nil
    ) {
        self.date = date
        self.ip = ip
        self.userAgent = userAgent
    }
}

public struct CardholderIndividualVerification: Codable, Hashable, Sendable {
    /// An identifying document, either a passport or local ID card.
    public var document: CardholderIndividualVerificationDocument?

    public init(
        document: CardholderIndividualVerificationDocument? = nil
    ) {
        self.document = document
    }
}

public struct CardholderIndividualVerificationDocument: Codable, Hashable, Sendable {
    /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @ExpandableOf<Stripe.Files.File> public var back: Stripe.Files.File.ID?
    /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
    @ExpandableOf<Stripe.Files.File> public var front: Stripe.Files.File.ID?

    public init(
        back: Stripe.Files.File.ID? = nil,
        front: Stripe.Files.File.ID? = nil
    ) {
        self._back = Expandable(id: back)
        self._front = Expandable(id: front)
    }
}

public struct CardholderAuthorizationRequirements: Codable, Hashable, Sendable {
    /// If `disabled_reason` is present, all cards will decline authorizations with `cardholder_verification_required` reason.
    public var disabledReason: CardholderAuthorizationRequirementsDisabledReason?
    /// Array of fields that need to be collected in order to verify and re-enable the cardholder.
    public var pastDue: [CardholderAuthorizationRequirementsPastDue]?

    public init(
        disabledReason: CardholderAuthorizationRequirementsDisabledReason? = nil,
        pastDue: [CardholderAuthorizationRequirementsPastDue]? = nil
    ) {
        self.disabledReason = disabledReason
        self.pastDue = pastDue
    }
}

public enum CardholderStatus: String, Codable, Sendable {
    /// Cards attached to this cardholder can approve authorizations,
    case active
    /// Cards attached to this cardholder will decline all authorizations with a `cardholder_inactive` reason.
    case inactive
    /// Cards attached to this cardholder will decline all authorizations without an authorization object created. This status is non-reversible.
    case blocked
}

public enum CardholderType: String, Codable, Sendable {
    /// The cardholder is a person, and additional information includes first and last name, date of birth, etc. If you’re issuing Celtic Spend Cards, then Individual cardholders must accept Authorized User Terms prior to activating their card.
    case individial
    /// The cardholder is a company or business entity, and additional information includes their tax ID. This option may not be available if your use case only supports individual cardholders.
    case company
}

public enum CardholderAuthorizationRequirementsDisabledReason: String, Codable, Sendable {
    /// Account might be on a prohibited persons or companies list. The `past_due` field contains information that you need to provide before the cardholder can approve authorizations.
    case listed
    /// This cardholder has raised additional review. Stripe will make a decision and update the `disabled_reason` field.
    case underReview = "under_review"
    /// Cardholder is rejected because they are on a third-party prohibited persons or companies list (such as financial services provider or government). Their status will be `blocked`.
    case rejectedListed = "rejected.listed"
    /// Cardholder has outstanding requirements. The `past_due` field contains information that you need to provide before the cardholder can activate cards.
    case requirementsPastDue = "requirements.past_due"
}

public enum CardholderAuthorizationRequirementsPastDue: String, Codable, Sendable {
    /// The IP address from which the Cardholder accepted their Authorized User Terms. Required for Celtic Spend Card users.
    case individualCardIssuingUserTermsAcceptanceIp =
        "individual.card_issuing.user_terms_acceptance.ip"
    /// The Unix timestamp marking when the Cardholder accepted their Authorized User Terms. Required for Celtic Spend Card users.
    case individualCardIssuingUserTermsAcceptanceDate =
        "individual.card_issuing.user_terms_acceptance.date"
    /// The cardholder’s legal first name.
    case individualFirstName = "individual.first_name"
    /// The cardholder’s legal last name.
    case individualLastName = "individual.last_name"
    /// The cardholder’s date of birth’s day.
    case individualDobDay = "individual.dob.day"
    /// The cardholder’s date of birth’s month.
    case individualDobMonth = "individual.dob.month"
    /// The cardholder’s date of birth’s year.
    case individualDobYear = "individual.dob.year"
    /// The front and back of a government-issued form of identification.
    case individualVerificationDocument = "individual.verification.document"
    /// The cardholder’s business number (Tax ID).
    case companyTaxId = "company.tax_id"
}

public struct CardholderList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Cardholder]?

    public init(
        object: String,
        hasMore: Bool? = nil,
        url: String? = nil,
        data: [Cardholder]? = nil
    ) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

// The Cardholder struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Cardholder` that the generator spells differently.

