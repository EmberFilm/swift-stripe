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

extension Stripe.Tokens.Token {
    public enum Create {}
    public enum Retrieve {}
}

// POST /v1/tokens
extension Stripe.Tokens.Token.Create {
    public struct Request: Codable, Hashable, Sendable {
        /// Information for the account this token represents.
        public var account: Account?
        /// The bank account this token will represent.
        public var bankAccount: BankAccount?
        /// The card this token will represent.
        public var card: String?
        /// Create a token for the customer, which is owned by the application's account.
        public var customer: String?
        /// The updated CVC value this token represents.
        public var cvcUpdate: CvcUpdate?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Information for the person this token represents.
        public var person: Person?
        /// The PII this token represents.
        public var pii: Pii?

        public init(
            account: Account? = nil,
            bankAccount: BankAccount? = nil,
            card: String? = nil,
            customer: String? = nil,
            cvcUpdate: CvcUpdate? = nil,
            expand: [String]? = nil,
            person: Person? = nil,
            pii: Pii? = nil
        ) {
            self.account = account
            self.bankAccount = bankAccount
            self.card = card
            self.customer = customer
            self.cvcUpdate = cvcUpdate
            self.expand = expand
            self.person = person
            self.pii = pii
        }

        /// Information for the account this token represents.
        public struct Account: Codable, Hashable, Sendable {
            /// The business type.
            public var businessType: BusinessType?
            /// Information about the company or business.
            public var company: Company?
            /// Information about the person represented by the account.
            public var individual: Individual?
            /// Whether the user described by the data in the token has been shown the Stripe Connected Account Agreement.
            public var tosShownAndAccepted: Bool?

            public init(
                businessType: BusinessType? = nil,
                company: Company? = nil,
                individual: Individual? = nil,
                tosShownAndAccepted: Bool? = nil
            ) {
                self.businessType = businessType
                self.company = company
                self.individual = individual
                self.tosShownAndAccepted = tosShownAndAccepted
            }

            public enum BusinessType: String, Codable, Hashable, Sendable {
                case company
                case governmentEntity = "government_entity"
                case individual
                case nonProfit = "non_profit"
            }

            /// Information about the company or business.
            public struct Company: Codable, Hashable, Sendable {
                /// The company's primary address.
                public var address: Address?
                /// The Kana variation of the company's primary address (Japan only).
                public var addressKana: AddressKana?
                /// The Kanji variation of the company's primary address (Japan only).
                public var addressKanji: AddressKanji?
                /// The location where the business is administered.
                public var administrativeAddress: AdministrativeAddress?
                /// Whether the company's directors have been provided.
                public var directorsProvided: Bool?
                /// This hash is used to attest that the directors information provided to Stripe is both current and correct.
                public var directorshipDeclaration: DirectorshipDeclaration?
                /// Whether the company's executives have been provided.
                public var executivesProvided: Bool?
                /// The export license ID number of the company, also referred as Import Export Code (India only).
                public var exportLicenseId: String?
                /// The purpose code to use for export transactions (India only).
                public var exportPurposeCode: String?
                /// The company's legal name.
                public var name: String?
                /// The Kana variation of the company's legal name (Japan only).
                public var nameKana: String?
                /// The Kanji variation of the company's legal name (Japan only).
                public var nameKanji: String?
                /// Whether the company's owners have been provided.
                public var ownersProvided: Bool?
                /// This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
                public var ownershipDeclaration: OwnershipDeclaration?
                /// Whether the user described by the data in the token has been shown the Ownership Declaration and indicated that it is.
                public var ownershipDeclarationShownAndSigned: Bool?
                /// This value is used to determine if a business is exempt from providing ultimate beneficial owners.
                public var ownershipExemptionReason: OwnershipExemptionReason?
                /// The company's phone number (used for verification).
                public var phone: String?
                /// The primary location where the business conducts operations.
                public var principalPlaceOfBusiness: PrincipalPlaceOfBusiness?
                /// When the business was incorporated or registered.
                public var registrationDate: Stripe.Clearable<RegistrationDate>?
                /// The identification number given to a company when it is registered or incorporated, if distinct from the.
                public var registrationNumber: String?
                /// This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
                public var representativeDeclaration: RepresentativeDeclaration?
                /// The category identifying the legal structure of the company or legal entity.
                public var structure: Structure?
                /// The business ID number of the company, as appropriate for the company’s country.
                public var taxId: String?
                /// The jurisdiction in which the `tax_id` is registered (Germany-based companies only).
                public var taxIdRegistrar: String?
                /// The VAT number of the company.
                public var vatId: String?
                /// Information on the verification state of the company.
                public var verification: Verification?

                public init(
                    address: Address? = nil,
                    addressKana: AddressKana? = nil,
                    addressKanji: AddressKanji? = nil,
                    administrativeAddress: AdministrativeAddress? = nil,
                    directorsProvided: Bool? = nil,
                    directorshipDeclaration: DirectorshipDeclaration? = nil,
                    executivesProvided: Bool? = nil,
                    exportLicenseId: String? = nil,
                    exportPurposeCode: String? = nil,
                    name: String? = nil,
                    nameKana: String? = nil,
                    nameKanji: String? = nil,
                    ownersProvided: Bool? = nil,
                    ownershipDeclaration: OwnershipDeclaration? = nil,
                    ownershipDeclarationShownAndSigned: Bool? = nil,
                    ownershipExemptionReason: OwnershipExemptionReason? = nil,
                    phone: String? = nil,
                    principalPlaceOfBusiness: PrincipalPlaceOfBusiness? = nil,
                    registrationDate: Stripe.Clearable<RegistrationDate>? = nil,
                    registrationNumber: String? = nil,
                    representativeDeclaration: RepresentativeDeclaration? = nil,
                    structure: Structure? = nil,
                    taxId: String? = nil,
                    taxIdRegistrar: String? = nil,
                    vatId: String? = nil,
                    verification: Verification? = nil
                ) {
                    self.address = address
                    self.addressKana = addressKana
                    self.addressKanji = addressKanji
                    self.administrativeAddress = administrativeAddress
                    self.directorsProvided = directorsProvided
                    self.directorshipDeclaration = directorshipDeclaration
                    self.executivesProvided = executivesProvided
                    self.exportLicenseId = exportLicenseId
                    self.exportPurposeCode = exportPurposeCode
                    self.name = name
                    self.nameKana = nameKana
                    self.nameKanji = nameKanji
                    self.ownersProvided = ownersProvided
                    self.ownershipDeclaration = ownershipDeclaration
                    self.ownershipDeclarationShownAndSigned = ownershipDeclarationShownAndSigned
                    self.ownershipExemptionReason = ownershipExemptionReason
                    self.phone = phone
                    self.principalPlaceOfBusiness = principalPlaceOfBusiness
                    self.registrationDate = registrationDate
                    self.registrationNumber = registrationNumber
                    self.representativeDeclaration = representativeDeclaration
                    self.structure = structure
                    self.taxId = taxId
                    self.taxIdRegistrar = taxIdRegistrar
                    self.vatId = vatId
                    self.verification = verification
                }

                public enum OwnershipExemptionReason: String, Codable, Hashable, Sendable {
                    case value = ""
                    case qualifiedEntityExceedsOwnershipThreshold = "qualified_entity_exceeds_ownership_threshold"
                    case qualifiesAsFinancialInstitution = "qualifies_as_financial_institution"
                }

                public enum Structure: String, Codable, Hashable, Sendable {
                    case value = ""
                    case freeZoneEstablishment = "free_zone_establishment"
                    case freeZoneLlc = "free_zone_llc"
                    case governmentInstrumentality = "government_instrumentality"
                    case governmentalUnit = "governmental_unit"
                    case incorporatedNonProfit = "incorporated_non_profit"
                    case incorporatedPartnership = "incorporated_partnership"
                    case limitedLiabilityPartnership = "limited_liability_partnership"
                    case llc
                    case multiMemberLlc = "multi_member_llc"
                    case privateCompany = "private_company"
                    case privateCorporation = "private_corporation"
                    case privatePartnership = "private_partnership"
                    case publicCompany = "public_company"
                    case publicCorporation = "public_corporation"
                    case publicPartnership = "public_partnership"
                    case registeredCharity = "registered_charity"
                    case singleMemberLlc = "single_member_llc"
                    case soleEstablishment = "sole_establishment"
                    case soleProprietorship = "sole_proprietorship"
                    case taxExemptGovernmentInstrumentality = "tax_exempt_government_instrumentality"
                    case unincorporatedAssociation = "unincorporated_association"
                    case unincorporatedNonProfit = "unincorporated_non_profit"
                    case unincorporatedPartnership = "unincorporated_partnership"
                }

                /// The company's primary address.
                public struct Address: Codable, Hashable, Sendable {
                    /// City, district, suburb, town, or village.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Address line 1, such as the street, PO Box, or company name.
                    public var line1: String?
                    /// Address line 2, such as the apartment, suite, unit, or building.
                    public var line2: String?
                    /// ZIP or postal code.
                    public var postalCode: String?
                    /// State, county, province, or region (ISO 3166-2).
                    public var state: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                    }
                }

                /// The Kana variation of the company's primary address (Japan only).
                public struct AddressKana: Codable, Hashable, Sendable {
                    /// City or ward.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Block or building number.
                    public var line1: String?
                    /// Building details.
                    public var line2: String?
                    /// Postal code.
                    public var postalCode: String?
                    /// Prefecture.
                    public var state: String?
                    /// Town or cho-me.
                    public var town: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil,
                        town: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                        self.town = town
                    }
                }

                /// The Kanji variation of the company's primary address (Japan only).
                public struct AddressKanji: Codable, Hashable, Sendable {
                    /// City or ward.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Block or building number.
                    public var line1: String?
                    /// Building details.
                    public var line2: String?
                    /// Postal code.
                    public var postalCode: String?
                    /// Prefecture.
                    public var state: String?
                    /// Town or cho-me.
                    public var town: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil,
                        town: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                        self.town = town
                    }
                }

                /// The location where the business is administered.
                public struct AdministrativeAddress: Codable, Hashable, Sendable {
                    /// City, district, suburb, town, or village.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Address line 1, such as the street, PO Box, or company name.
                    public var line1: String?
                    /// Address line 2, such as the apartment, suite, unit, or building.
                    public var line2: String?
                    /// ZIP or postal code.
                    public var postalCode: String?
                    /// State, county, province, or region (ISO 3166-2).
                    public var state: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                    }
                }

                /// This hash is used to attest that the directors information provided to Stripe is both current and correct.
                public struct DirectorshipDeclaration: Codable, Hashable, Sendable {
                    /// The Unix timestamp marking when the directorship declaration attestation was made.
                    public var date: Date?
                    /// The IP address from which the directorship declaration attestation was made.
                    public var ip: String?
                    /// The user agent of the browser from which the directorship declaration attestation was made.
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

                /// This hash is used to attest that the beneficial owner information provided to Stripe is both current and correct.
                public struct OwnershipDeclaration: Codable, Hashable, Sendable {
                    /// The Unix timestamp marking when the beneficial owner attestation was made.
                    public var date: Date?
                    /// The IP address from which the beneficial owner attestation was made.
                    public var ip: String?
                    /// The user agent of the browser from which the beneficial owner attestation was made.
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

                /// The primary location where the business conducts operations.
                public struct PrincipalPlaceOfBusiness: Codable, Hashable, Sendable {
                    /// City, district, suburb, town, or village.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Address line 1, such as the street, PO Box, or company name.
                    public var line1: String?
                    /// Address line 2, such as the apartment, suite, unit, or building.
                    public var line2: String?
                    /// ZIP or postal code.
                    public var postalCode: String?
                    /// State, county, province, or region (ISO 3166-2).
                    public var state: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                    }
                }

                public struct RegistrationDate: Codable, Hashable, Sendable {
                    /// The day of registration, between 1 and 31.
                    public var day: Int
                    /// The month of registration, between 1 and 12.
                    public var month: Int
                    /// The four-digit year of registration.
                    public var year: Int

                    public init(
                        day: Int,
                        month: Int,
                        year: Int
                    ) {
                        self.day = day
                        self.month = month
                        self.year = year
                    }
                }

                /// This hash is used to attest that the representative is authorized to act as the representative of their legal entity.
                public struct RepresentativeDeclaration: Codable, Hashable, Sendable {
                    /// The Unix timestamp marking when the representative declaration attestation was made.
                    public var date: Date?
                    /// The IP address from which the representative declaration attestation was made.
                    public var ip: String?
                    /// The user agent of the browser from which the representative declaration attestation was made.
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

                /// Information on the verification state of the company.
                public struct Verification: Codable, Hashable, Sendable {
                    /// A document verifying the business.
                    public var document: Document?

                    public init(
                        document: Document? = nil
                    ) {
                        self.document = document
                    }

                    /// A document verifying the business.
                    public struct Document: Codable, Hashable, Sendable {
                        /// The back of a document returned by a file upload with a `purpose` value of `additional_verification`.
                        public var back: String?
                        /// The front of a document returned by a file upload with a `purpose` value of `additional_verification`.
                        public var front: String?

                        public init(
                            back: String? = nil,
                            front: String? = nil
                        ) {
                            self.back = back
                            self.front = front
                        }
                    }
                }
            }

            /// Information about the person represented by the account.
            public struct Individual: Codable, Hashable, Sendable {
                /// The individual's primary address.
                public var address: Address?
                /// The Kana variation of the individual's primary address (Japan only).
                public var addressKana: AddressKana?
                /// The Kanji variation of the individual's primary address (Japan only).
                public var addressKanji: AddressKanji?
                /// The individual's date of birth.
                public var dob: Stripe.Clearable<Dob>?
                /// The individual's email address.
                public var email: String?
                /// The individual's first name.
                public var firstName: String?
                /// The Kana variation of the individual's first name (Japan only).
                public var firstNameKana: String?
                /// The Kanji variation of the individual's first name (Japan only).
                public var firstNameKanji: String?
                /// A list of alternate names or aliases that the individual is known by.
                public var fullNameAliases: Stripe.Clearable<[String]>?
                /// The individual's gender.
                public var gender: String?
                /// The government-issued ID number of the individual, as appropriate for the representative's country.
                public var idNumber: String?
                /// The government-issued secondary ID number of the individual, as appropriate for the representative's country, will be.
                public var idNumberSecondary: String?
                /// The individual's last name.
                public var lastName: String?
                /// The Kana variation of the individual's last name (Japan only).
                public var lastNameKana: String?
                /// The Kanji variation of the individual's last name (Japan only).
                public var lastNameKanji: String?
                /// The individual's maiden name.
                public var maidenName: String?
                /// Set of key-value pairs that you can attach to an object.
                public var metadata: Stripe.Clearable<[String: String]>?
                /// The individual's phone number.
                public var phone: String?
                /// Indicates if the person or any of their representatives, family members, or other closely related persons, declares.
                public var politicalExposure: PoliticalExposure?
                /// The individual's registered address.
                public var registeredAddress: RegisteredAddress?
                /// Describes the person’s relationship to the account.
                public var relationship: Relationship?
                /// The last four digits of the individual's Social Security Number (U.S.
                public var ssnLast4: String?
                /// The individual's verification document information.
                public var verification: Verification?

                public init(
                    address: Address? = nil,
                    addressKana: AddressKana? = nil,
                    addressKanji: AddressKanji? = nil,
                    dob: Stripe.Clearable<Dob>? = nil,
                    email: String? = nil,
                    firstName: String? = nil,
                    firstNameKana: String? = nil,
                    firstNameKanji: String? = nil,
                    fullNameAliases: Stripe.Clearable<[String]>? = nil,
                    gender: String? = nil,
                    idNumber: String? = nil,
                    idNumberSecondary: String? = nil,
                    lastName: String? = nil,
                    lastNameKana: String? = nil,
                    lastNameKanji: String? = nil,
                    maidenName: String? = nil,
                    metadata: Stripe.Clearable<[String: String]>? = nil,
                    phone: String? = nil,
                    politicalExposure: PoliticalExposure? = nil,
                    registeredAddress: RegisteredAddress? = nil,
                    relationship: Relationship? = nil,
                    ssnLast4: String? = nil,
                    verification: Verification? = nil
                ) {
                    self.address = address
                    self.addressKana = addressKana
                    self.addressKanji = addressKanji
                    self.dob = dob
                    self.email = email
                    self.firstName = firstName
                    self.firstNameKana = firstNameKana
                    self.firstNameKanji = firstNameKanji
                    self.fullNameAliases = fullNameAliases
                    self.gender = gender
                    self.idNumber = idNumber
                    self.idNumberSecondary = idNumberSecondary
                    self.lastName = lastName
                    self.lastNameKana = lastNameKana
                    self.lastNameKanji = lastNameKanji
                    self.maidenName = maidenName
                    self.metadata = metadata
                    self.phone = phone
                    self.politicalExposure = politicalExposure
                    self.registeredAddress = registeredAddress
                    self.relationship = relationship
                    self.ssnLast4 = ssnLast4
                    self.verification = verification
                }

                public enum PoliticalExposure: String, Codable, Hashable, Sendable {
                    case existing
                    case none
                }

                /// The individual's primary address.
                public struct Address: Codable, Hashable, Sendable {
                    /// City, district, suburb, town, or village.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Address line 1, such as the street, PO Box, or company name.
                    public var line1: String?
                    /// Address line 2, such as the apartment, suite, unit, or building.
                    public var line2: String?
                    /// ZIP or postal code.
                    public var postalCode: String?
                    /// State, county, province, or region (ISO 3166-2).
                    public var state: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                    }
                }

                /// The Kana variation of the individual's primary address (Japan only).
                public struct AddressKana: Codable, Hashable, Sendable {
                    /// City or ward.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Block or building number.
                    public var line1: String?
                    /// Building details.
                    public var line2: String?
                    /// Postal code.
                    public var postalCode: String?
                    /// Prefecture.
                    public var state: String?
                    /// Town or cho-me.
                    public var town: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil,
                        town: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                        self.town = town
                    }
                }

                /// The Kanji variation of the individual's primary address (Japan only).
                public struct AddressKanji: Codable, Hashable, Sendable {
                    /// City or ward.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Block or building number.
                    public var line1: String?
                    /// Building details.
                    public var line2: String?
                    /// Postal code.
                    public var postalCode: String?
                    /// Prefecture.
                    public var state: String?
                    /// Town or cho-me.
                    public var town: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil,
                        town: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                        self.town = town
                    }
                }

                public struct Dob: Codable, Hashable, Sendable {
                    /// The day of birth, between 1 and 31.
                    public var day: Int
                    /// The month of birth, between 1 and 12.
                    public var month: Int
                    /// The four-digit year of birth.
                    public var year: Int

                    public init(
                        day: Int,
                        month: Int,
                        year: Int
                    ) {
                        self.day = day
                        self.month = month
                        self.year = year
                    }
                }

                /// The individual's registered address.
                public struct RegisteredAddress: Codable, Hashable, Sendable {
                    /// City, district, suburb, town, or village.
                    public var city: String?
                    /// Two-letter country code (ISO 3166-1 alpha-2).
                    public var country: String?
                    /// Address line 1, such as the street, PO Box, or company name.
                    public var line1: String?
                    /// Address line 2, such as the apartment, suite, unit, or building.
                    public var line2: String?
                    /// ZIP or postal code.
                    public var postalCode: String?
                    /// State, county, province, or region (ISO 3166-2).
                    public var state: String?

                    public init(
                        city: String? = nil,
                        country: String? = nil,
                        line1: String? = nil,
                        line2: String? = nil,
                        postalCode: String? = nil,
                        state: String? = nil
                    ) {
                        self.city = city
                        self.country = country
                        self.line1 = line1
                        self.line2 = line2
                        self.postalCode = postalCode
                        self.state = state
                    }
                }

                /// Describes the person’s relationship to the account.
                public struct Relationship: Codable, Hashable, Sendable {
                    /// Whether the person is a director of the account's legal entity.
                    public var director: Bool?
                    /// Whether the person has significant responsibility to control, manage, or direct the organization.
                    public var executive: Bool?
                    /// Whether the person is an owner of the account’s legal entity.
                    public var owner: Bool?
                    /// The percent owned by the person of the account's legal entity.
                    public var percentOwnership: Stripe.Clearable<Decimal>?
                    /// The person's title (e.g., CEO, Support Engineer).
                    public var title: String?

                    public init(
                        director: Bool? = nil,
                        executive: Bool? = nil,
                        owner: Bool? = nil,
                        percentOwnership: Stripe.Clearable<Decimal>? = nil,
                        title: String? = nil
                    ) {
                        self.director = director
                        self.executive = executive
                        self.owner = owner
                        self.percentOwnership = percentOwnership
                        self.title = title
                    }
                }

                /// The individual's verification document information.
                public struct Verification: Codable, Hashable, Sendable {
                    /// A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
                    public var additionalDocument: AdditionalDocument?
                    /// An identifying document, either a passport or local ID card.
                    public var document: Document?

                    public init(
                        additionalDocument: AdditionalDocument? = nil,
                        document: Document? = nil
                    ) {
                        self.additionalDocument = additionalDocument
                        self.document = document
                    }

                    /// A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
                    public struct AdditionalDocument: Codable, Hashable, Sendable {
                        /// The back of an ID returned by a file upload with a `purpose` value of `identity_document`.
                        public var back: String?
                        /// The front of an ID returned by a file upload with a `purpose` value of `identity_document`.
                        public var front: String?

                        public init(
                            back: String? = nil,
                            front: String? = nil
                        ) {
                            self.back = back
                            self.front = front
                        }
                    }

                    /// An identifying document, either a passport or local ID card.
                    public struct Document: Codable, Hashable, Sendable {
                        /// The back of an ID returned by a file upload with a `purpose` value of `identity_document`.
                        public var back: String?
                        /// The front of an ID returned by a file upload with a `purpose` value of `identity_document`.
                        public var front: String?

                        public init(
                            back: String? = nil,
                            front: String? = nil
                        ) {
                            self.back = back
                            self.front = front
                        }
                    }
                }
            }
        }

        /// The bank account this token will represent.
        public struct BankAccount: Codable, Hashable, Sendable {
            /// The name of the person or business that owns the bank account.
            public var accountHolderName: String?
            /// The type of entity that holds the account.
            public var accountHolderType: AccountHolderType?
            /// The account number for the bank account, in string form.
            public var accountNumber: String
            /// The bank account type.
            public var accountType: AccountType?
            /// The country in which the bank account is located.
            public var country: String
            /// The currency the bank account is in.
            public var currency: Stripe.Currency?
            /// The ID of a Payment Method with a `type` of `us_bank_account`.
            public var paymentMethod: String?
            /// The routing number, sort code, or other country-appropriate institution number for the bank account.
            public var routingNumber: String?

            public init(
                accountHolderName: String? = nil,
                accountHolderType: AccountHolderType? = nil,
                accountNumber: String,
                accountType: AccountType? = nil,
                country: String,
                currency: Stripe.Currency? = nil,
                paymentMethod: String? = nil,
                routingNumber: String? = nil
            ) {
                self.accountHolderName = accountHolderName
                self.accountHolderType = accountHolderType
                self.accountNumber = accountNumber
                self.accountType = accountType
                self.country = country
                self.currency = currency
                self.paymentMethod = paymentMethod
                self.routingNumber = routingNumber
            }

            public enum AccountHolderType: String, Codable, Hashable, Sendable {
                case company
                case individual
            }

            public enum AccountType: String, Codable, Hashable, Sendable {
                case checking
                case futsu
                case savings
                case toza
            }
        }

        /// The updated CVC value this token represents.
        public struct CvcUpdate: Codable, Hashable, Sendable {
            /// The CVC value, in string form.
            public var cvc: String

            public init(
                cvc: String
            ) {
                self.cvc = cvc
            }
        }

        /// Information for the person this token represents.
        public struct Person: Codable, Hashable, Sendable {
            /// Details on the legal guardian's or authorizer's acceptance of the required Stripe agreements.
            public var additionalTosAcceptances: AdditionalTosAcceptances?
            /// The person's address.
            public var address: Address?
            /// The Kana variation of the person's address (Japan only).
            public var addressKana: AddressKana?
            /// The Kanji variation of the person's address (Japan only).
            public var addressKanji: AddressKanji?
            /// The person's date of birth.
            public var dob: Stripe.Clearable<Dob>?
            /// Documents that may be submitted to satisfy various informational requests.
            public var documents: Documents?
            /// The person's email address.
            public var email: String?
            /// The person's first name.
            public var firstName: String?
            /// The Kana variation of the person's first name (Japan only).
            public var firstNameKana: String?
            /// The Kanji variation of the person's first name (Japan only).
            public var firstNameKanji: String?
            /// A list of alternate names or aliases that the person is known by.
            public var fullNameAliases: Stripe.Clearable<[String]>?
            /// The person's gender (International regulations require either "male" or "female").
            public var gender: String?
            /// The person's ID number, as appropriate for their country.
            public var idNumber: String?
            /// The person's secondary ID number, as appropriate for their country, will be used for enhanced verification checks.
            public var idNumberSecondary: String?
            /// The person's last name.
            public var lastName: String?
            /// The Kana variation of the person's last name (Japan only).
            public var lastNameKana: String?
            /// The Kanji variation of the person's last name (Japan only).
            public var lastNameKanji: String?
            /// The person's maiden name.
            public var maidenName: String?
            /// Set of key-value pairs that you can attach to an object.
            public var metadata: Stripe.Clearable<[String: String]>?
            /// The country where the person is a national.
            public var nationality: String?
            /// The person's phone number.
            public var phone: String?
            /// Indicates if the person or any of their representatives, family members, or other closely related persons, declares.
            public var politicalExposure: PoliticalExposure?
            /// The person's registered address.
            public var registeredAddress: RegisteredAddress?
            /// The relationship that this person has with the account's legal entity.
            public var relationship: Relationship?
            /// The last four digits of the person's Social Security number (U.S.
            public var ssnLast4: String?
            /// Demographic data related to the person.
            public var usCfpbData: UsCfpbData?
            /// The person's verification status.
            public var verification: Verification?

            public init(
                additionalTosAcceptances: AdditionalTosAcceptances? = nil,
                address: Address? = nil,
                addressKana: AddressKana? = nil,
                addressKanji: AddressKanji? = nil,
                dob: Stripe.Clearable<Dob>? = nil,
                documents: Documents? = nil,
                email: String? = nil,
                firstName: String? = nil,
                firstNameKana: String? = nil,
                firstNameKanji: String? = nil,
                fullNameAliases: Stripe.Clearable<[String]>? = nil,
                gender: String? = nil,
                idNumber: String? = nil,
                idNumberSecondary: String? = nil,
                lastName: String? = nil,
                lastNameKana: String? = nil,
                lastNameKanji: String? = nil,
                maidenName: String? = nil,
                metadata: Stripe.Clearable<[String: String]>? = nil,
                nationality: String? = nil,
                phone: String? = nil,
                politicalExposure: PoliticalExposure? = nil,
                registeredAddress: RegisteredAddress? = nil,
                relationship: Relationship? = nil,
                ssnLast4: String? = nil,
                usCfpbData: UsCfpbData? = nil,
                verification: Verification? = nil
            ) {
                self.additionalTosAcceptances = additionalTosAcceptances
                self.address = address
                self.addressKana = addressKana
                self.addressKanji = addressKanji
                self.dob = dob
                self.documents = documents
                self.email = email
                self.firstName = firstName
                self.firstNameKana = firstNameKana
                self.firstNameKanji = firstNameKanji
                self.fullNameAliases = fullNameAliases
                self.gender = gender
                self.idNumber = idNumber
                self.idNumberSecondary = idNumberSecondary
                self.lastName = lastName
                self.lastNameKana = lastNameKana
                self.lastNameKanji = lastNameKanji
                self.maidenName = maidenName
                self.metadata = metadata
                self.nationality = nationality
                self.phone = phone
                self.politicalExposure = politicalExposure
                self.registeredAddress = registeredAddress
                self.relationship = relationship
                self.ssnLast4 = ssnLast4
                self.usCfpbData = usCfpbData
                self.verification = verification
            }

            public enum PoliticalExposure: String, Codable, Hashable, Sendable {
                case existing
                case none
            }

            /// Details on the legal guardian's or authorizer's acceptance of the required Stripe agreements.
            public struct AdditionalTosAcceptances: Codable, Hashable, Sendable {
                /// Details on the legal guardian's acceptance of the main Stripe service agreement.
                public var account: Account?

                public init(
                    account: Account? = nil
                ) {
                    self.account = account
                }

                /// Details on the legal guardian's acceptance of the main Stripe service agreement.
                public struct Account: Codable, Hashable, Sendable {
                    /// The Unix timestamp marking when the account representative accepted the service agreement.
                    public var date: Date?
                    /// The IP address from which the account representative accepted the service agreement.
                    public var ip: String?
                    /// The user agent of the browser from which the account representative accepted the service agreement.
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
            }

            /// The person's address.
            public struct Address: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State, county, province, or region (ISO 3166-2).
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                }
            }

            /// The Kana variation of the person's address (Japan only).
            public struct AddressKana: Codable, Hashable, Sendable {
                /// City or ward.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Block or building number.
                public var line1: String?
                /// Building details.
                public var line2: String?
                /// Postal code.
                public var postalCode: String?
                /// Prefecture.
                public var state: String?
                /// Town or cho-me.
                public var town: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil,
                    town: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                    self.town = town
                }
            }

            /// The Kanji variation of the person's address (Japan only).
            public struct AddressKanji: Codable, Hashable, Sendable {
                /// City or ward.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Block or building number.
                public var line1: String?
                /// Building details.
                public var line2: String?
                /// Postal code.
                public var postalCode: String?
                /// Prefecture.
                public var state: String?
                /// Town or cho-me.
                public var town: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil,
                    town: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                    self.town = town
                }
            }

            public struct Dob: Codable, Hashable, Sendable {
                /// The day of birth, between 1 and 31.
                public var day: Int
                /// The month of birth, between 1 and 12.
                public var month: Int
                /// The four-digit year of birth.
                public var year: Int

                public init(
                    day: Int,
                    month: Int,
                    year: Int
                ) {
                    self.day = day
                    self.month = month
                    self.year = year
                }
            }

            /// Documents that may be submitted to satisfy various informational requests.
            public struct Documents: Codable, Hashable, Sendable {
                /// One or more documents that demonstrate proof that this person is authorized to represent the company.
                public var companyAuthorization: CompanyAuthorization?
                /// One or more documents showing the person's passport page with photo and personal data.
                public var passport: Passport?
                /// One or more documents showing the person's visa required for living in the country where they are residing.
                public var visa: Visa?

                public init(
                    companyAuthorization: CompanyAuthorization? = nil,
                    passport: Passport? = nil,
                    visa: Visa? = nil
                ) {
                    self.companyAuthorization = companyAuthorization
                    self.passport = passport
                    self.visa = visa
                }

                /// One or more documents that demonstrate proof that this person is authorized to represent the company.
                public struct CompanyAuthorization: Codable, Hashable, Sendable {
                    /// One or more document ids returned by a file upload with a `purpose` value of `account_requirement`.
                    public var files: [String]?

                    public init(
                        files: [String]? = nil
                    ) {
                        self.files = files
                    }
                }

                /// One or more documents showing the person's passport page with photo and personal data.
                public struct Passport: Codable, Hashable, Sendable {
                    /// One or more document ids returned by a file upload with a `purpose` value of `account_requirement`.
                    public var files: [String]?

                    public init(
                        files: [String]? = nil
                    ) {
                        self.files = files
                    }
                }

                /// One or more documents showing the person's visa required for living in the country where they are residing.
                public struct Visa: Codable, Hashable, Sendable {
                    /// One or more document ids returned by a file upload with a `purpose` value of `account_requirement`.
                    public var files: [String]?

                    public init(
                        files: [String]? = nil
                    ) {
                        self.files = files
                    }
                }
            }

            /// The person's registered address.
            public struct RegisteredAddress: Codable, Hashable, Sendable {
                /// City, district, suburb, town, or village.
                public var city: String?
                /// Two-letter country code (ISO 3166-1 alpha-2).
                public var country: String?
                /// Address line 1, such as the street, PO Box, or company name.
                public var line1: String?
                /// Address line 2, such as the apartment, suite, unit, or building.
                public var line2: String?
                /// ZIP or postal code.
                public var postalCode: String?
                /// State, county, province, or region (ISO 3166-2).
                public var state: String?

                public init(
                    city: String? = nil,
                    country: String? = nil,
                    line1: String? = nil,
                    line2: String? = nil,
                    postalCode: String? = nil,
                    state: String? = nil
                ) {
                    self.city = city
                    self.country = country
                    self.line1 = line1
                    self.line2 = line2
                    self.postalCode = postalCode
                    self.state = state
                }
            }

            /// The relationship that this person has with the account's legal entity.
            public struct Relationship: Codable, Hashable, Sendable {
                /// Whether the person is the authorizer of the account's representative.
                public var authorizer: Bool?
                /// Whether the person is a director of the account's legal entity.
                public var director: Bool?
                /// Whether the person has significant responsibility to control, manage, or direct the organization.
                public var executive: Bool?
                /// Whether the person is the legal guardian of the account's representative.
                public var legalGuardian: Bool?
                /// Whether the person is an owner of the account’s legal entity.
                public var owner: Bool?
                /// The percent owned by the person of the account's legal entity.
                public var percentOwnership: Stripe.Clearable<Decimal>?
                /// Whether the person is authorized as the primary representative of the account.
                public var representative: Bool?
                /// The person's title (e.g., CEO, Support Engineer).
                public var title: String?

                public init(
                    authorizer: Bool? = nil,
                    director: Bool? = nil,
                    executive: Bool? = nil,
                    legalGuardian: Bool? = nil,
                    owner: Bool? = nil,
                    percentOwnership: Stripe.Clearable<Decimal>? = nil,
                    representative: Bool? = nil,
                    title: String? = nil
                ) {
                    self.authorizer = authorizer
                    self.director = director
                    self.executive = executive
                    self.legalGuardian = legalGuardian
                    self.owner = owner
                    self.percentOwnership = percentOwnership
                    self.representative = representative
                    self.title = title
                }
            }

            /// Demographic data related to the person.
            public struct UsCfpbData: Codable, Hashable, Sendable {
                /// The persons ethnicity details.
                public var ethnicityDetails: EthnicityDetails?
                /// The persons race details.
                public var raceDetails: RaceDetails?
                /// The persons self-identified gender.
                public var selfIdentifiedGender: String?

                public init(
                    ethnicityDetails: EthnicityDetails? = nil,
                    raceDetails: RaceDetails? = nil,
                    selfIdentifiedGender: String? = nil
                ) {
                    self.ethnicityDetails = ethnicityDetails
                    self.raceDetails = raceDetails
                    self.selfIdentifiedGender = selfIdentifiedGender
                }

                /// The persons ethnicity details.
                public struct EthnicityDetails: Codable, Hashable, Sendable {
                    /// The persons ethnicity.
                    public var ethnicity: [Ethnicity]?
                    /// Please specify your origin, when other is selected.
                    public var ethnicityOther: String?

                    public init(
                        ethnicity: [Ethnicity]? = nil,
                        ethnicityOther: String? = nil
                    ) {
                        self.ethnicity = ethnicity
                        self.ethnicityOther = ethnicityOther
                    }

                    public enum Ethnicity: String, Codable, Hashable, Sendable {
                        case cuban
                        case hispanicOrLatino = "hispanic_or_latino"
                        case mexican
                        case notHispanicOrLatino = "not_hispanic_or_latino"
                        case otherHispanicOrLatino = "other_hispanic_or_latino"
                        case preferNotToAnswer = "prefer_not_to_answer"
                        case puertoRican = "puerto_rican"
                    }
                }

                /// The persons race details.
                public struct RaceDetails: Codable, Hashable, Sendable {
                    /// The persons race.
                    public var race: [Race]?
                    /// Please specify your race, when other is selected.
                    public var raceOther: String?

                    public init(
                        race: [Race]? = nil,
                        raceOther: String? = nil
                    ) {
                        self.race = race
                        self.raceOther = raceOther
                    }

                    public enum Race: String, Codable, Hashable, Sendable {
                        case africanAmerican = "african_american"
                        case americanIndianOrAlaskaNative = "american_indian_or_alaska_native"
                        case asian
                        case asianIndian = "asian_indian"
                        case blackOrAfricanAmerican = "black_or_african_american"
                        case chinese
                        case ethiopian
                        case filipino
                        case guamanianOrChamorro = "guamanian_or_chamorro"
                        case haitian
                        case jamaican
                        case japanese
                        case korean
                        case nativeHawaiian = "native_hawaiian"
                        case nativeHawaiianOrOtherPacificIslander = "native_hawaiian_or_other_pacific_islander"
                        case nigerian
                        case otherAsian = "other_asian"
                        case otherBlackOrAfricanAmerican = "other_black_or_african_american"
                        case otherPacificIslander = "other_pacific_islander"
                        case preferNotToAnswer = "prefer_not_to_answer"
                        case samoan
                        case somali
                        case vietnamese
                        case white
                    }
                }
            }

            /// The person's verification status.
            public struct Verification: Codable, Hashable, Sendable {
                /// A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
                public var additionalDocument: AdditionalDocument?
                /// An identifying document, either a passport or local ID card.
                public var document: Document?

                public init(
                    additionalDocument: AdditionalDocument? = nil,
                    document: Document? = nil
                ) {
                    self.additionalDocument = additionalDocument
                    self.document = document
                }

                /// A document showing address, either a passport, local ID card, or utility bill from a well-known utility company.
                public struct AdditionalDocument: Codable, Hashable, Sendable {
                    /// The back of an ID returned by a file upload with a `purpose` value of `identity_document`.
                    public var back: String?
                    /// The front of an ID returned by a file upload with a `purpose` value of `identity_document`.
                    public var front: String?

                    public init(
                        back: String? = nil,
                        front: String? = nil
                    ) {
                        self.back = back
                        self.front = front
                    }
                }

                /// An identifying document, either a passport or local ID card.
                public struct Document: Codable, Hashable, Sendable {
                    /// The back of an ID returned by a file upload with a `purpose` value of `identity_document`.
                    public var back: String?
                    /// The front of an ID returned by a file upload with a `purpose` value of `identity_document`.
                    public var front: String?

                    public init(
                        back: String? = nil,
                        front: String? = nil
                    ) {
                        self.back = back
                        self.front = front
                    }
                }
            }
        }

        /// The PII this token represents.
        public struct Pii: Codable, Hashable, Sendable {
            /// The `id_number` for the PII, in string form.
            public var idNumber: String?

            public init(
                idNumber: String? = nil
            ) {
                self.idNumber = idNumber
            }
        }
    }

    public typealias Response = Stripe.Tokens.Token
}

// GET /v1/tokens/{token}
extension Stripe.Tokens.Token.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Stripe.Tokens.Token
}
