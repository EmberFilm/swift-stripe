//
//  Stripe Connect Accounts Types Accounts.swift
//  swift-stripe-types
//
//  Created by coenttb on 2025-01-14.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/create.md
    public enum Create {}
}

extension Stripe.Connect.Accounts.Create {
    public struct Request: Codable, Equatable, Sendable {
        public var businessType: Stripe.Connect.Account.BusinessType?
        public var country: String?
        public var email: String?
        public var type: Stripe.Connect.Account.`Type`?
        public var company: CompanyParam?
        public var individual: IndividualParam?
        public var metadata: [String: String]?
        public var tosAcceptance: TOSAcceptanceParam?
        public var businessProfile: BusinessProfileParam?
        public var capabilities: CapabilitiesParam?
        public var documents: DocumentsParam?
        public var externalAccount: String?
        public var settings: SettingsParam?
        public var controller: ControllerParam?

        private enum CodingKeys: String, CodingKey {
            case businessType
            case country
            case email
            case type
            case company
            case individual
            case metadata
            case tosAcceptance
            case businessProfile
            case capabilities
            case documents
            case externalAccount
            case settings
            case controller
        }

        public init(
            businessType: Stripe.Connect.Account.BusinessType? = nil,
            country: String? = nil,
            email: String? = nil,
            type: Stripe.Connect.Account.`Type`? = nil,
            company: CompanyParam? = nil,
            individual: IndividualParam? = nil,
            metadata: [String: String]? = nil,
            tosAcceptance: TOSAcceptanceParam? = nil,
            businessProfile: BusinessProfileParam? = nil,
            capabilities: CapabilitiesParam? = nil,
            documents: DocumentsParam? = nil,
            externalAccount: String? = nil,
            settings: SettingsParam? = nil,
            controller: ControllerParam? = nil
        ) {
            self.businessType = businessType
            self.country = country
            self.email = email
            self.type = type
            self.company = company
            self.individual = individual
            self.metadata = metadata
            self.tosAcceptance = tosAcceptance
            self.businessProfile = businessProfile
            self.capabilities = capabilities
            self.documents = documents
            self.externalAccount = externalAccount
            self.settings = settings
            self.controller = controller
        }

        public struct CompanyParam: Codable, Equatable, Sendable {
            public var address: Address?
            public var addressKana: AddressKana?
            public var addressKanji: AddressKanji?
            public var directorsProvided: Bool?
            public var executivesProvided: Bool?
            public var exportLicenseId: String?
            public var exportPurposeCode: String?
            public var name: String?
            public var nameKana: String?
            public var nameKanji: String?
            public var ownersProvided: Bool?
            public var ownershipDeclaration: OwnershipDeclarationParam?
            public var phone: String?
            public var registrationNumber: String?
            public var structure: String?
            public var taxId: String?
            public var taxIdRegistrar: String?
            public var vatId: String?
            public var verification: VerificationParam?

            private enum CodingKeys: String, CodingKey {
                case address
                case addressKana
                case addressKanji
                case directorsProvided
                case executivesProvided
                case exportLicenseId
                case exportPurposeCode
                case name
                case nameKana
                case nameKanji
                case ownersProvided
                case ownershipDeclaration
                case phone
                case registrationNumber
                case structure
                case taxId
                case taxIdRegistrar
                case vatId
                case verification
            }

            public struct OwnershipDeclarationParam: Codable, Equatable, Sendable {
                public var date: Date?
                public var ip: String?
                public var userAgent: String?

                private enum CodingKeys: String, CodingKey {
                    case date
                    case ip
                    case userAgent
                }
            }

            public struct VerificationParam: Codable, Equatable, Sendable {
                public var document: DocumentParam?

                public struct DocumentParam: Codable, Equatable, Sendable {
                    public var back: String?
                    public var front: String?
                }
            }
        }

        public struct IndividualParam: Codable, Equatable, Sendable {
            public var address: Address?
            public var addressKana: AddressKana?
            public var addressKanji: AddressKanji?
            public var dob: DOBParam?
            public var email: String?
            public var firstName: String?
            public var firstNameKana: String?
            public var firstNameKanji: String?
            public var fullNameAliases: [String]?
            public var gender: String?
            public var idNumber: String?
            public var idNumberSecondary: String?
            public var lastName: String?
            public var lastNameKana: String?
            public var lastNameKanji: String?
            public var maidenName: String?
            public var metadata: [String: String]?
            public var nationality: String?
            public var phone: String?
            public var politicalExposure: String?
            public var registeredAddress: Address?
            public var ssnLast4: String?
            public var verification: VerificationParam?

            private enum CodingKeys: String, CodingKey {
                case address
                case addressKana
                case addressKanji
                case dob
                case email
                case firstName
                case firstNameKana
                case firstNameKanji
                case fullNameAliases
                case gender
                case idNumber
                case idNumberSecondary
                case lastName
                case lastNameKana
                case lastNameKanji
                case maidenName
                case metadata
                case nationality
                case phone
                case politicalExposure
                case registeredAddress
                case ssnLast4
                case verification
            }

            public struct DOBParam: Codable, Equatable, Sendable {
                public var day: Int?
                public var month: Int?
                public var year: Int?
            }

            public struct VerificationParam: Codable, Equatable, Sendable {
                public var additionalDocument: DocumentParam?
                public var document: DocumentParam?

                private enum CodingKeys: String, CodingKey {
                    case additionalDocument
                    case document
                }

                public struct DocumentParam: Codable, Equatable, Sendable {
                    public var back: String?
                    public var front: String?
                }
            }
        }

        public struct TOSAcceptanceParam: Codable, Equatable, Sendable {
            public var date: Date?
            public var ip: String?
            public var userAgent: String?

            private enum CodingKeys: String, CodingKey {
                case date
                case ip
                case userAgent
            }
        }

        public struct BusinessProfileParam: Codable, Equatable, Sendable {
            public var annualRevenue: AnnualRevenueParam?
            public var estimatedWorkerCount: Int?
            public var mcc: String?
            public var monthlyEstimatedRevenue: MonthlyEstimatedRevenueParam?
            public var name: String?
            public var productDescription: String?
            public var supportAddress: Address?
            public var supportEmail: String?
            public var supportPhone: String?
            public var supportUrl: String?
            public var url: String?

            private enum CodingKeys: String, CodingKey {
                case annualRevenue
                case estimatedWorkerCount
                case mcc
                case monthlyEstimatedRevenue
                case name
                case productDescription
                case supportAddress
                case supportEmail
                case supportPhone
                case supportUrl
                case url
            }

            public struct AnnualRevenueParam: Codable, Equatable, Sendable {
                public var amount: Int?
                public var currency: Stripe.Currency?
                public var fiscalYearEnd: String?

                private enum CodingKeys: String, CodingKey {
                    case amount
                    case currency
                    case fiscalYearEnd
                }
            }

            public struct MonthlyEstimatedRevenueParam: Codable, Equatable, Sendable {
                public var amount: Int?
                public var currency: Stripe.Currency?
            }
        }

        public struct CapabilitiesParam: Codable, Equatable, Sendable {
            public var acssDebitPayments: CapabilityParam?
            public var affirmPayments: CapabilityParam?
            public var afterpayClearpayPayments: CapabilityParam?
            public var amazonPayPayments: CapabilityParam?
            public var auBecsDebitPayments: CapabilityParam?
            public var bacsDebitPayments: CapabilityParam?
            public var bancontactPayments: CapabilityParam?
            public var bankTransferPayments: CapabilityParam?
            public var blikPayments: CapabilityParam?
            public var boletoPayments: CapabilityParam?
            public var cardIssuing: CapabilityParam?
            public var cardPayments: CapabilityParam?
            public var cartesBancairesPayments: CapabilityParam?
            public var cashappPayments: CapabilityParam?
            public var epsPayments: CapabilityParam?
            public var fpxPayments: CapabilityParam?
            public var gbBankTransferPayments: CapabilityParam?
            public var giropayPayments: CapabilityParam?
            public var grabpayPayments: CapabilityParam?
            public var idealPayments: CapabilityParam?
            public var indiaInternationalPayments: CapabilityParam?
            public var jcbPayments: CapabilityParam?
            public var jpBankTransferPayments: CapabilityParam?
            public var klarnaPayments: CapabilityParam?
            public var konbiniPayments: CapabilityParam?
            public var linkPayments: CapabilityParam?
            public var mobilepayPayments: CapabilityParam?
            public var multibancoPayments: CapabilityParam?
            public var mxBankTransferPayments: CapabilityParam?
            public var oxxoPayments: CapabilityParam?
            public var p24Payments: CapabilityParam?
            public var paynowPayments: CapabilityParam?
            public var promptpayPayments: CapabilityParam?
            public var revolutPayPayments: CapabilityParam?
            public var sepaDebitPayments: CapabilityParam?
            public var sofortPayments: CapabilityParam?
            public var swishPayments: CapabilityParam?
            public var taxReportingUs1099K: CapabilityParam?
            public var taxReportingUs1099Misc: CapabilityParam?
            public var transfers: CapabilityParam?
            public var treasury: CapabilityParam?
            public var twintPayments: CapabilityParam?
            public var usBankAccountAchPayments: CapabilityParam?
            public var usBankTransferPayments: CapabilityParam?
            public var zipPayments: CapabilityParam?

            private enum CodingKeys: String, CodingKey {
                case acssDebitPayments
                case affirmPayments
                case afterpayClearpayPayments
                case amazonPayPayments
                case auBecsDebitPayments
                case bacsDebitPayments
                case bancontactPayments
                case bankTransferPayments
                case blikPayments
                case boletoPayments
                case cardIssuing
                case cardPayments
                case cartesBancairesPayments
                case cashappPayments
                case epsPayments
                case fpxPayments
                case gbBankTransferPayments
                case giropayPayments
                case grabpayPayments
                case idealPayments
                case indiaInternationalPayments
                case jcbPayments
                case jpBankTransferPayments
                case klarnaPayments
                case konbiniPayments
                case linkPayments
                case mobilepayPayments
                case multibancoPayments
                case mxBankTransferPayments
                case oxxoPayments
                case p24Payments
                case paynowPayments
                case promptpayPayments
                case revolutPayPayments
                case sepaDebitPayments
                case sofortPayments
                case swishPayments
                case taxReportingUs1099K
                case taxReportingUs1099Misc
                case transfers
                case treasury
                case twintPayments
                case usBankAccountAchPayments
                case usBankTransferPayments
                case zipPayments
            }

            public struct CapabilityParam: Codable, Equatable, Sendable {
                public var requested: Bool?
            }
        }

        public struct DocumentsParam: Codable, Equatable, Sendable {
            public var bankAccountOwnershipVerification: BankAccountOwnershipVerificationParam?
            public var companyLicense: DocumentParam?
            public var companyMemorandumOfAssociation: DocumentParam?
            public var companyMinisterialDecree: DocumentParam?
            public var companyRegistrationVerification: DocumentParam?
            public var companyTaxIdVerification: DocumentParam?
            public var proofOfRegistration: DocumentParam?

            private enum CodingKeys: String, CodingKey {
                case bankAccountOwnershipVerification
                case companyLicense
                case companyMemorandumOfAssociation
                case companyMinisterialDecree
                case companyRegistrationVerification
                case companyTaxIdVerification
                case proofOfRegistration
            }

            public struct BankAccountOwnershipVerificationParam: Codable, Equatable, Sendable {
                public var files: [String]?
            }

            public struct DocumentParam: Codable, Equatable, Sendable {
                public var files: [String]?
            }
        }

        public struct SettingsParam: Codable, Equatable, Sendable {
            public var bacsDebitPayments: BacsDebitPaymentsParam?
            public var branding: BrandingParam?
            public var cardIssuing: CardIssuingParam?
            public var cardPayments: CardPaymentsParam?
            public var invoices: InvoicesParam?
            public var payments: PaymentsParam?
            public var payouts: PayoutsParam?
            public var treasury: TreasuryParam?

            private enum CodingKeys: String, CodingKey {
                case bacsDebitPayments
                case branding
                case cardIssuing
                case cardPayments
                case invoices
                case payments
                case payouts
                case treasury
            }

            public struct BacsDebitPaymentsParam: Codable, Equatable, Sendable {
                public var displayName: String?

                private enum CodingKeys: String, CodingKey {
                    case displayName
                }
            }

            public struct BrandingParam: Codable, Equatable, Sendable {
                public var icon: String?
                public var logo: String?
                public var primaryColor: String?
                public var secondaryColor: String?

                private enum CodingKeys: String, CodingKey {
                    case icon
                    case logo
                    case primaryColor
                    case secondaryColor
                }
            }

            public struct CardIssuingParam: Codable, Equatable, Sendable {
                public var tosAcceptance: TOSAcceptanceParam?

                private enum CodingKeys: String, CodingKey {
                    case tosAcceptance
                }

                public struct TOSAcceptanceParam: Codable, Equatable, Sendable {
                    public var date: Date?
                    public var ip: String?
                    public var userAgent: String?

                    private enum CodingKeys: String, CodingKey {
                        case date
                        case ip
                        case userAgent
                    }
                }
            }

            public struct CardPaymentsParam: Codable, Equatable, Sendable {
                public var declineOn: DeclineOnParam?
                public var statementDescriptorPrefix: String?
                public var statementDescriptorPrefixKana: String?
                public var statementDescriptorPrefixKanji: String?

                private enum CodingKeys: String, CodingKey {
                    case declineOn
                    case statementDescriptorPrefix
                    case statementDescriptorPrefixKana
                    case statementDescriptorPrefixKanji
                }

                public struct DeclineOnParam: Codable, Equatable, Sendable {
                    public var avsFailure: Bool?
                    public var cvcFailure: Bool?

                    private enum CodingKeys: String, CodingKey {
                        case avsFailure
                        case cvcFailure
                    }
                }
            }

            public struct InvoicesParam: Codable, Equatable, Sendable {
                public var defaultAccountTaxIds: [String]?

                private enum CodingKeys: String, CodingKey {
                    case defaultAccountTaxIds
                }
            }

            public struct PaymentsParam: Codable, Equatable, Sendable {
                public var statementDescriptor: String?
                public var statementDescriptorKana: String?
                public var statementDescriptorKanji: String?

                private enum CodingKeys: String, CodingKey {
                    case statementDescriptor
                    case statementDescriptorKana
                    case statementDescriptorKanji
                }
            }

            public struct PayoutsParam: Codable, Equatable, Sendable {
                public var debitNegativeBalances: Bool?
                public var schedule: ScheduleParam?
                public var statementDescriptor: String?

                private enum CodingKeys: String, CodingKey {
                    case debitNegativeBalances
                    case schedule
                    case statementDescriptor
                }

                public struct ScheduleParam: Codable, Equatable, Sendable {
                    public var delayDays: DelayDays?
                    public var interval: Interval?
                    public var monthlyAnchor: Int?
                    public var weeklyAnchor: WeeklyAnchor?

                    private enum CodingKeys: String, CodingKey {
                        case delayDays
                        case interval
                        case monthlyAnchor
                        case weeklyAnchor
                    }

                    public enum DelayDays: Codable, Equatable, Sendable {
                        case minimum
                        case days(Int)

                        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
                        // signature. The standard library declares the requirement with untyped `throws`, so
                        // the thrown type cannot be narrowed here without failing to satisfy it.
                        // swiftlint:disable:next typed_throws_required
                        public init(from decoder: Decoder) throws {
                            let container = try decoder.singleValueContainer()
                            // REASON: probing a decoding container for an alternative payload shape. `decode` throws
                            // the standard library's untyped error domain, and a failed probe is control flow here —
                            // the next shape is attempted — not an error this type can classify.
                            // swiftlint:disable:next no_try_optional
                            if let stringValue = try? container.decode(String.self),
                                stringValue == "minimum"
                            {
                                self = .minimum
                                // REASON: probing a decoding container for an alternative payload shape. `decode` throws
                                // the standard library's untyped error domain, and a failed probe is control flow here —
                                // the next shape is attempted — not an error this type can classify.
                                // swiftlint:disable:next no_try_optional
                            } else if let intValue = try? container.decode(Int.self) {
                                self = .days(intValue)
                            } else {
                                throw DecodingError.dataCorruptedError(
                                    in: container,
                                    debugDescription: "Invalid delay_days value"
                                )
                            }
                        }

                        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
                        // signature. The standard library declares the requirement with untyped `throws`, so
                        // the thrown type cannot be narrowed here without failing to satisfy it.
                        // swiftlint:disable:next typed_throws_required
                        public func encode(to encoder: Encoder) throws {
                            var container = encoder.singleValueContainer()
                            switch self {
                            case .minimum:
                                try container.encode("minimum")

                            case .days(let days):
                                try container.encode(days)
                            }
                        }
                    }

                    public enum Interval: String, Codable, Sendable {
                        case daily
                        case weekly
                        case monthly
                        case manual
                    }

                    public enum WeeklyAnchor: String, Codable, Sendable {
                        case monday
                        case tuesday
                        case wednesday
                        case thursday
                        case friday
                        case saturday
                        case sunday
                    }
                }
            }

            public struct TreasuryParam: Codable, Equatable, Sendable {
                public var tosAcceptance: TOSAcceptanceParam?

                private enum CodingKeys: String, CodingKey {
                    case tosAcceptance
                }

                public struct TOSAcceptanceParam: Codable, Equatable, Sendable {
                    public var date: Date?
                    public var ip: String?
                    public var userAgent: String?

                    private enum CodingKeys: String, CodingKey {
                        case date
                        case ip
                        case userAgent
                    }
                }
            }
        }

        public struct ControllerParam: Codable, Equatable, Sendable {
            public var fees: FeesParam?
            public var losses: LossesParam?
            public var requirementCollection: RequirementCollection?
            public var stripeDashboard: StripeDashboardParam?

            private enum CodingKeys: String, CodingKey {
                case fees
                case losses
                case requirementCollection
                case stripeDashboard
            }

            public struct FeesParam: Codable, Equatable, Sendable {
                public var payer: Payer?

                public enum Payer: String, Codable, Sendable {
                    case account
                    case application
                }
            }

            public struct LossesParam: Codable, Equatable, Sendable {
                public var payments: Payments?

                public enum Payments: String, Codable, Sendable {
                    case application
                    case stripe
                }
            }

            public enum RequirementCollection: String, Codable, Sendable {
                case application
                case stripe
            }

            public struct StripeDashboardParam: Codable, Equatable, Sendable {
                public var type: `Type`?

                public enum `Type`: String, Codable, Sendable {
                    case express
                    case full
                    case none
                }
            }
        }
    }
}

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/update.md
    public enum Update {}
}

extension Stripe.Connect.Accounts.Update {
    public typealias Request = Stripe.Connect.Accounts.Create.Request
}

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/list.md
    public enum List {}
}

extension Stripe.Connect.Accounts.List {
    public struct Request: Codable, Equatable, Sendable {
        public var created: Stripe.DateFilter?
        public var endingBefore: String?
        public var expand: [String]?
        public var limit: Int?
        public var startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case created
            case endingBefore
            case expand
            case limit
            case startingAfter
        }

        public init(
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Connect.Account]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }
    }
}

extension Stripe.Connect.Accounts {
    // https://docs.stripe.com/api/accounts/reject.md
    public enum Reject {}
}

extension Stripe.Connect.Accounts.Reject {
    public struct Request: Codable, Equatable, Sendable {
        public var reason: Reason

        public enum Reason: String, Codable, Sendable {
            case fraud
            case termsOfService = "terms_of_service"
            case other
        }

        public init(reason: Reason) {
            self.reason = reason
        }
    }
}
