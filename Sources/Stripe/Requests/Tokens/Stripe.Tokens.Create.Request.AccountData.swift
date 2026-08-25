//
//  Stripe Tokens Types Tokens.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Tokens {
    // https://docs.stripe.com/api/tokens/create.md
    public enum Create {}
}

// https://docs.stripe.com/api/tokens/create.md
extension Stripe.Tokens.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// Information for the account token
        public let account: AccountData?
        /// The bank account data
        public let bankAccount: BankAccountData?
        /// The card data
        public let card: CardData?
        /// The customer to associate with this token
        public let customer: Stripe.Customers.Customer.ID?
        /// The CVC update data
        public let cvcUpdate: CVCUpdate?
        /// The person data for Connect accounts
        public let person: PersonData?
        /// The PII data
        public let pii: PIIData?

        private enum CodingKeys: String, CodingKey {
            case account
            case bankAccount
            case card
            case customer
            case cvcUpdate
            case person
            case pii
        }

        public init(
            account: AccountData? = nil,
            bankAccount: BankAccountData? = nil,
            card: CardData? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            cvcUpdate: CVCUpdate? = nil,
            person: PersonData? = nil,
            pii: PIIData? = nil
        ) {
            self.account = account
            self.bankAccount = bankAccount
            self.card = card
            self.customer = customer
            self.cvcUpdate = cvcUpdate
            self.person = person
            self.pii = pii
        }
    }
}

extension Stripe.Tokens.Create.Request {
    public struct AccountData: Codable, Equatable, Sendable {
        public let businessType: String?
        public let company: [String: String]?
        public let individual: [String: String]?
        public let tosShownAndAccepted: Bool?

        private enum CodingKeys: String, CodingKey {
            case businessType
            case company
            case individual
            case tosShownAndAccepted
        }

        public init(
            businessType: String? = nil,
            company: [String: String]? = nil,
            individual: [String: String]? = nil,
            tosShownAndAccepted: Bool? = nil
        ) {
            self.businessType = businessType
            self.company = company
            self.individual = individual
            self.tosShownAndAccepted = tosShownAndAccepted
        }
    }

    public struct BankAccountData: Codable, Equatable, Sendable {
        public let country: String
        public let currency: Stripe.Currency
        public let accountHolderName: String?
        public let accountHolderType: String?
        public let routingNumber: String?
        public let accountNumber: String

        private enum CodingKeys: String, CodingKey {
            case country
            case currency
            case accountHolderName
            case accountHolderType
            case routingNumber
            case accountNumber
        }

        public init(
            country: String,
            currency: Stripe.Currency,
            accountNumber: String,
            accountHolderName: String? = nil,
            accountHolderType: String? = nil,
            routingNumber: String? = nil
        ) {
            self.country = country
            self.currency = currency
            self.accountNumber = accountNumber
            self.accountHolderName = accountHolderName
            self.accountHolderType = accountHolderType
            self.routingNumber = routingNumber
        }
    }

    public struct CardData: Codable, Equatable, Sendable {
        public let number: String
        public let expMonth: String
        public let expYear: String
        public let cvc: String?
        public let name: String?
        public let addressLine1: String?
        public let addressLine2: String?
        public let addressCity: String?
        public let addressState: String?
        public let addressZip: String?
        public let addressCountry: String?

        private enum CodingKeys: String, CodingKey {
            case number
            case expMonth
            case expYear
            case cvc
            case name
            case addressLine1
            case addressLine2
            case addressCity
            case addressState
            case addressZip
            case addressCountry
        }

        public init(
            number: String,
            expMonth: String,
            expYear: String,
            cvc: String? = nil,
            name: String? = nil,
            addressLine1: String? = nil,
            addressLine2: String? = nil,
            addressCity: String? = nil,
            addressState: String? = nil,
            addressZip: String? = nil,
            addressCountry: String? = nil
        ) {
            self.number = number
            self.expMonth = expMonth
            self.expYear = expYear
            self.cvc = cvc
            self.name = name
            self.addressLine1 = addressLine1
            self.addressLine2 = addressLine2
            self.addressCity = addressCity
            self.addressState = addressState
            self.addressZip = addressZip
            self.addressCountry = addressCountry
        }
    }

    public struct CVCUpdate: Codable, Equatable, Sendable {
        public let cvc: String

        public init(cvc: String) {
            self.cvc = cvc
        }
    }

    public struct PersonData: Codable, Equatable, Sendable {
        public let firstName: String?
        public let lastName: String?
        public let email: String?
        public let phone: String?

        private enum CodingKeys: String, CodingKey {
            case firstName
            case lastName
            case email
            case phone
        }

        public init(
            firstName: String? = nil,
            lastName: String? = nil,
            email: String? = nil,
            phone: String? = nil
        ) {
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.phone = phone
        }
    }

    public struct PIIData: Codable, Equatable, Sendable {
        public let idNumber: String

        private enum CodingKeys: String, CodingKey {
            case idNumber
        }

        public init(idNumber: String) {
            self.idNumber = idNumber
        }
    }
}
