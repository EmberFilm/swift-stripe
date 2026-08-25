//
//  Source.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/sources/object.md

public struct StripeSourceCodeVerification: Codable, Hashable, Sendable {
    /// The number of attempts remaining to authenticate the source object with a verification code.
    public var attemptsRemaining: Int?
    /// The status of the code verification, either `pending` (awaiting verification, `attempts_remaining` should be greater than 0), `succeeded` (successful verification) or `failed` (failed verification, cannot be verified anymore as `attempts_remaining` should be 0).
    public var status: StripeSourceCodeVerificationStatus?
}

public enum StripeSourceCodeVerificationStatus: String, Codable, Sendable {
    case pending
    case succeeded
    case failed
}

public enum StripeSourceFlow: String, Codable, Sendable {
    case redirect
    case receiver
    case codeVerification = "code_verification"
    case none
}

public struct StripeSourceOwner: Codable, Hashable, Sendable {
    /// Owner’s address.
    public var address: Address?
    /// Owner’s email address.
    public var email: String?
    /// Owner’s full name.
    public var name: String?
    /// Owner’s phone number (including extension).
    public var phone: String?
    /// Verified owner’s address. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedAddress: Address?
    /// Verified owner’s email address. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedEmail: String?
    /// Verified owner’s full name. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedName: String?
    /// Verified owner’s phone number (including extension). Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
    public var verifiedPhone: String?
}

public struct StripeSourceReceiver: Codable, Hashable, Sendable {
    /// The address of the receiver source. This is the value that should be communicated to the customer to send their funds to.
    public var address: String?
    /// The total amount that was charged by you. The amount charged is expressed in the source’s currency.
    public var amountCharged: Int?
    /// The total amount received by the receiver source. `amount_received = amount_returned + amount_charged` is true at all time. The amount received is expressed in the source’s currency.
    public var amountReceived: Int?
    /// The total amount that was returned to the customer. The amount returned is expressed in the source’s currency.
    public var amountReturned: Int?
    /// Type of refund attribute method, one of `email`, `manual`, or `none`.
    public var refundAttributesMethod: StripeSourceReceiverRefundAttributesMethod?
    /// Type of refund attribute status, one of `missing`, `requested`, or `available`.
    public var refundAttributesStatus: StripeSourceReceiverRefundAttributesStatus?
}

public enum StripeSourceReceiverRefundAttributesMethod: String, Codable, Sendable {
    case email
    case manual
    case none
}

public enum StripeSourceReceiverRefundAttributesStatus: String, Codable, Sendable {
    case missing
    case requested
    case available
}

public struct StripeSourceRedirect: Codable, Hashable, Sendable {
    /// The failure reason for the redirect, either `user_abort` (the customer aborted or dropped out of the redirect flow), `declined` (the authentication failed or the transaction was declined), or `processing_error` (the redirect failed due to a technical error). Present only if the redirect status is `failed`.
    public var failureReason: StripeSourceRedirectFailureReason?
    /// The URL you provide to redirect the customer to after they authenticated their payment.
    public var returnUrl: String?
    /// The status of the redirect, either `pending` (ready to be used by your customer to authenticate the transaction), `succeeded` (succesful authentication, cannot be reused) or `not_required` (redirect should not be used) or `failed` (failed authentication, cannot be reused).
    public var status: StripeSourceRedirectReason?
    /// The URL provided to you to redirect a customer to as part of a `redirect` authentication flow.
    public var url: String?
}

public enum StripeSourceRedirectFailureReason: String, Codable, Sendable {
    case userAbort = "user_abort"
    case declined
    case processingError = "processing_error"
    case failed
}

public enum StripeSourceRedirectReason: String, Codable, Sendable {
    case pending
    case succeeded
    case notRequired = "not_required"
    case failed
}

public enum StripeSourceStatus: String, Codable, Sendable {
    case canceled
    case chargeable
    case consumed
    case failed
    case pending
}

public enum StripeSourceType: String, Codable, Sendable {
    case achCreditTransfer = "ach_credit_transfer"
    case achDebit = "ach_debit"
    case alipay
    case bancontact
    case card
    case cardPresent = "card_present"
    case eps
    case giropay
    case ideal
    case multibanco
    case p24
    case sepaDebit = "sepa_debit"
    case sofort
    case threeDSecure = "three_d_secure"
    case wechat
}

public enum StripeSourceUsage: String, Codable, Sendable {
    case reusable
    case singleUse = "single_use"
}

// The Source struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Source` that the generator spells differently.

// MARK: - Sources
public struct StripeSourceACHCreditTransfer: Codable, Hashable, Sendable {
    public var accountNumber: String?
    public var bankName: String?
    public var fingerprint: String?
    public var routingNumber: String?
    public var swiftCode: String?
}

public struct StripeSourceACHDebit: Codable, Hashable, Sendable {
    public var bankName: String?
    public var country: String?
    public var fingerprint: String?
    public var last4: String?
    public var routingNumber: String?
    public var type: String?
}

public struct StripeSourceAlipay: Codable, Hashable, Sendable {
    public var nativeUrl: String?
    public var statementDescriptor: Stripe.StatementDescriptor?
}

public struct StripeSourceBancontact: Codable, Hashable, Sendable {
    public var bankCode: String?
    public var bankName: String?
    public var bic: String?
    public var ibnLast4: String?
    public var preferredLanguage: String?
}

public struct StripeSourceCard: Codable, Hashable, Sendable {
    public var addressLine1Check: String?
    public var addressZipCheck: String?
    public var brand: CardBrand?
    public var country: String?
    public var cvcCheck: String?
    public var dynamicLast4: String?
    public var expMonth: Int?
    public var expYear: Int?
    public var fingerprint: String?
    public var funding: CardFundingType?
    public var last4: String?
    public var name: String?
    public var threeDSecure: String?
    public var tokenizationMethod: String?
}

public struct StripeSourceCardPresent: Codable, Hashable, Sendable {
    public var applicationCryptogram: String?
    public var applicationPreferredName: String?
    public var authorizationCode: String?
    public var authorizationResponseCode: String?
    public var brand: CardBrand?
    public var country: String?
    public var cvmType: String?
    public var dataType: String?
    public var dedicatedFileName: String?
    public var emvAuthdata: String?
    public var evidenceCustomerSignature: String?
    public var evidenceTransactionCertificate: String?
    public var expMonth: Int?
    public var expyear: Int?
    public var fingerprint: String?
    public var funding: CardFundingType?
    public var last4: String?
    public var posDeviceId: String?
    public var posEntryMode: String?
    public var readMethod: String?
    public var reader: String?
    public var terminalVerificationResults: String?
    public var transactionStatusInformation: String?
}

public struct StripeSourceEPS: Codable, Hashable, Sendable {
    // The Eps sources do not have any specific property today.
    // The only ones available in the spec are for private betas.
}

public struct StripeSourceGiropay: Codable, Hashable, Sendable {
    public var bankCode: String?
    public var bic: String?
    public var bankName: String?
}

public struct StripeSourceIDEAL: Codable, Hashable, Sendable {
    public var bank: String?
    public var bic: String?
    public var ibanLast4: String?
}

public struct StripeSourceMultibanco: Codable, Hashable, Sendable {
    public var entity: String?
    public var reference: String?
}

public struct StripeSourceP24: Codable, Hashable, Sendable {
    public var reference: String?
}

public struct StripeSourceSepaDebit: Codable, Hashable, Sendable {
    public var bankCode: String?
    public var branchCode: String?
    public var country: String?
    public var fingerprint: String?
    public var last4: String?
    public var mandateReference: String?
    public var mandateUrl: String?
}

public struct StripeSourceSofort: Codable, Hashable, Sendable {
    public var bankCode: String?
    public var bankName: String?
    public var bic: String?
    public var country: String?
    public var ibanLast4: String?
    public var verifiedName: String?
}

public struct StripeSourceThreeDSecure: Codable, Hashable, Sendable {
    public var addressLine1Check: String?
    public var addressZipCheck: String?
    public var authenticated: Bool?
    public var brand: CardBrand?
    public var card: String?
    public var country: String?
    public var customer: Stripe.Customers.Customer.ID?
    public var cvcCheck: String?
    public var dynamicLast4: String?
    public var expMonth: Int?
    public var expYear: Int?
    public var fingerprint: String?
    public var funding: CardFundingType?
    public var last4: String?
    public var threedSecure: StripeSourceThreeDSecureSupportStatus?
    public var tokenizationMethod: CardTokenizedMethod?
}

public enum StripeSourceThreeDSecureSupportStatus: String, Codable, Sendable {
    case notSupported = "not_supported"
    case required
    case recommended
    case optional
}

public struct StripeSourceWechat: Codable, Hashable, Sendable {
    // Stripe has no offocial documentation details
    /// https://stripe.com/docs/api/charges/object#charge_object-payment_method_details-wechat
}

public struct StripeSourcesList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripePaymentSource]?
}

extension StripeSourcesList {
    public var bankAccounts: [BankAccount]? {
        return data?.compactMap { $0.bankAccount }
    }

    public var cards: [Card]? {
        return data?.compactMap { $0.card }
    }

    public var sources: [Source]? {
        return data?.compactMap { $0.source }
    }
}
