//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Account struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Account` that the generator spells differently.


// https://docs.stripe.com/api/accounts/object.md

// The LoginLink struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Connect.Account.LoginLink` that the generator spells differently.

extension Stripe.Connect.Account {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Account]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Account]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}



extension Stripe.Connect.Account {
    public struct Capablities: Codable, Hashable, Sendable {
        /// The status of the ACSS Direct Debits payments capability of the account, or whether the account can directly process ACSS Direct Debits charges.
        public var acssDebitPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Affirm capability of the account, or whether the account can directly process Affirm charges.
        public var affirmPayments: Stripe.Connect.Account.CapabilitiesStatus?

        /// The status of the Afterpay Clearpay capability of the account, or whether the account can directly process Afterpay Clearpay charges.
        public var afterpayClearpayPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the BECS Direct Debit (AU) payments capability of the account, or whether the account can directly process BECS Direct Debit (AU) charges.
        public var auBecsDebitPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Bacs Direct Debits payments capability of the account, or whether the account can directly process Bacs Direct Debits charges.
        public var bacsDebitPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Bancontact payments capability of the account, or whether the account can directly process Bancontact charges.
        public var bancontactPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the `customer_balance` payments capability of the account, or whether the account can directly process `customer_balance` charges.
        public var bankTransferPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the blik payments capability of the account, or whether the account can directly process blik charges.
        public var blikPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the boleto payments capability of the account, or whether the account can directly process boleto charges.
        public var boletoPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the card issuing capability of the account, or whether you can use Issuing to distribute funds on cards
        public var cardIssuing: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the card payments capability of the account, or whether the account can directly process credit and debit card charges.
        public var cardPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Cartes Bancaires payments capability of the account, or whether the account can directly process Cartes Bancaires card charges in EUR currency.
        public var cartesBancairesPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Cash App Pay capability of the account, or whether the account can directly process Cash App Pay payments.
        public var cashappPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the EPS payments capability of the account, or whether the account can directly process EPS charges.
        public var epsPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the FPX payments capability of the account, or whether the account can directly process FPX charges.
        public var fpxPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the giropay payments capability of the account, or whether the account can directly process giropay charges.
        public var giropayPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the GrabPay payments capability of the account, or whether the account can directly process GrabPay charges.
        public var grabpayPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the iDEAL payments capability of the account, or whether the account can directly process iDEAL charges.
        public var idealPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the `india_international_payments` capability of the account, or whether the account can process international charges (non INR) in India.
        public var indiaInternationalPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the JCB payments capability of the account, or whether the account (Japan only) can directly process JCB credit card charges in JPY currency.
        public var jcbPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Klarna payments capability of the account, or whether the account can directly process Klarna charges.
        public var klarnaPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the konbini payments capability of the account, or whether the account can directly process konbini charges.
        public var konbiniPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the legacy payments capability of the account.
        public var legacyPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the `link_payments` capability of the account, or whether the account can directly process Link charges.
        public var linkPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the OXXO payments capability of the account, or whether the account can directly process OXXO charges.
        public var oxxoPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the P24 payments capability of the account, or whether the account can directly process P24 charges.
        public var p24Payments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the paynow payments capability of the account, or whether the account can directly process paynow charges.
        public var paynowPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the promptpay payments capability of the account, or whether the account can directly process promptpay charges.
        public var promptpayPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the SEPA Direct Debits payments capability of the account, or whether the account can directly process SEPA Direct Debits charges.
        public var sepaDebitPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the Sofort payments capability of the account, or whether the account can directly process Sofort charges.
        public var sofortPayments: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the tax reporting 1099-K (US) capability of the account.
        public var taxReportingUs1099K: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the tax reporting 1099-MISC (US) capability of the account.
        public var taxReportingUs1099Misc: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the transfers capability of the account, or whether your platform can transfer funds to the account.
        public var transfers: Stripe.Connect.Account.CapabilitiesStatus?
        /// The status of the US bank account ACH payments capability of the account, or whether the account can directly process US bank account charges.
        public var usBankAccountAchPayments: Stripe.Connect.Account.CapabilitiesStatus?

        public init(
            acssDebitPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            affirmPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            afterpayClearpayPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            auBecsDebitPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            bacsDebitPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            bancontactPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            bankTransferPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            blikPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            boletoPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            cardIssuing: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            cardPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            cartesBancairesPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            cashappPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            epsPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            fpxPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            giropayPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            grabpayPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            idealPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            indiaInternationalPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            jcbPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            klarnaPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            konbiniPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            legacyPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            linkPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            oxxoPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            p24Payments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            paynowPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            promptpayPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            sepaDebitPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            sofortPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            taxReportingUs1099K: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            taxReportingUs1099Misc: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            transfers: Stripe.Connect.Account.CapabilitiesStatus? = nil,
            usBankAccountAchPayments: Stripe.Connect.Account.CapabilitiesStatus? = nil
        ) {
            self.acssDebitPayments = acssDebitPayments
            self.affirmPayments = affirmPayments
            self.afterpayClearpayPayments = afterpayClearpayPayments
            self.auBecsDebitPayments = auBecsDebitPayments
            self.bacsDebitPayments = bacsDebitPayments
            self.bancontactPayments = bancontactPayments
            self.bankTransferPayments = bankTransferPayments
            self.blikPayments = blikPayments
            self.boletoPayments = boletoPayments
            self.cardIssuing = cardIssuing
            self.cardPayments = cardPayments
            self.cartesBancairesPayments = cartesBancairesPayments
            self.cashappPayments = cashappPayments
            self.epsPayments = epsPayments
            self.fpxPayments = fpxPayments
            self.giropayPayments = giropayPayments
            self.grabpayPayments = grabpayPayments
            self.idealPayments = idealPayments
            self.indiaInternationalPayments = indiaInternationalPayments
            self.jcbPayments = jcbPayments
            self.klarnaPayments = klarnaPayments
            self.konbiniPayments = konbiniPayments
            self.legacyPayments = legacyPayments
            self.linkPayments = linkPayments
            self.oxxoPayments = oxxoPayments
            self.p24Payments = p24Payments
            self.paynowPayments = paynowPayments
            self.promptpayPayments = promptpayPayments
            self.sepaDebitPayments = sepaDebitPayments
            self.sofortPayments = sofortPayments
            self.taxReportingUs1099K = taxReportingUs1099K
            self.taxReportingUs1099Misc = taxReportingUs1099Misc
            self.transfers = transfers
            self.usBankAccountAchPayments = usBankAccountAchPayments
        }
    }
}

extension Stripe.Connect.Account {
    public enum CapabilitiesStatus: String, Codable, Sendable {
        case active
        case inactive
        case pending
    }
}






extension Stripe.Connect.Account {
    public struct TOSAcceptance: Codable, Hashable, Sendable {
        /// The Unix timestamp marking when the Stripe Services Agreement was accepted by the account representative
        public var date: Date?
        /// The IP address from which the Stripe Services Agreement was accepted by the account representative
        public var ip: String?
        /// The user agent of the browser from which the Stripe Services Agreement was accepted by the account representative
        public var userAgent: String?
        /// The user’s service agreement type
        public var serviceAgreement: String?

        public init(
            date: Date? = nil,
            ip: String? = nil,
            userAgent: String? = nil,
            serviceAgreement: String? = nil
        ) {
            self.date = date
            self.ip = ip
            self.userAgent = userAgent
            self.serviceAgreement = serviceAgreement
        }
    }
}


extension Stripe.Connect.Account {
    public enum ConnectAccountRejectReason: String, Codable, Sendable {
        case fraud
        case termsOfService = "terms_of_service"
        case other
    }
}
