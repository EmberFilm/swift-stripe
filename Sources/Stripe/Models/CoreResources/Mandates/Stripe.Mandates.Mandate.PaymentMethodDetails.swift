//
//  MandatePaymentMethods.swift
//
//
//  Created by Andrew Edwards on 3/7/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// MARK: - ACSSDebit
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct ACSSDebit: Codable, Hashable, Sendable {
        /// List of Stripe products where this mandate can be selected automatically.
        public var defaultFor: Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit.DefaultFor?
        /// Description of the interval. Only required if the `'payment_schedule'` parameter is `'interval'` or`'combined'`.
        public var intervalDescription: String?
        /// Payment schedule for the mandate.
        public var paymentSchedule:
            Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit.PaymentSchedule?
        /// Transaction type of the mandate.
        public var transactionType:
            Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit.TransactionType?

        public init(
            defaultFor: Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit.DefaultFor? = nil,
            intervalDescription: String? = nil,
            paymentSchedule: Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit
                .PaymentSchedule? =
                nil,
            transactionType: Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit
                .TransactionType? = nil
        ) {
            self.defaultFor = defaultFor
            self.intervalDescription = intervalDescription
            self.paymentSchedule = paymentSchedule
            self.transactionType = transactionType
        }
    }
}

extension Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit {
    public enum DefaultFor: String, Codable, Sendable {
        /// Enables payments for Stripe Invoices. 'subscription' must also be provided.
        case invoice
        /// Enables payments for Stripe Subscriptions. 'invoice' must also be provided.
        case subscription
    }

    public enum PaymentSchedule: String, Codable, Sendable {
        /// Payments are initiated at a regular pre-defined interval
        case interval
        /// Payments are initiated sporadically
        case sporadic
        /// Payments can be initiated at a pre-defined interval or sporadically
        case combined
    }

    public enum TransactionType: String, Codable, Sendable {
        /// Transactions are made for personal reasons
        case personal
        /// Transactions are made for business reasons
        case business
    }
}

// MARK: - AUBecsDebit
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct AuBecsDebit: Codable, Hashable, Sendable {
        /// The URL of the mandate. This URL generally contains sensitive information about the customer and should be shared with them exclusively.
        public var url: String?

        public init(
            url: String? = nil
        ) {
            self.url = url
        }
    }
}

// MARK: - BacsDebit
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct BacsDebit: Codable, Hashable, Sendable {
        /// The status of the mandate on the Bacs network. Can be one of  `pending`, `revoked`,`refused`, or `accepted`.
        public var networkStatus:
            Stripe.Mandates.Mandate.PaymentMethodDetails.BacsDebit.NetworkStatus?
        /// The unique reference identifying the mandate on the Bacs network.
        public var reference: String?
        /// The URL that will contain the mandate that the customer has signed.
        public var url: String?

        public init(
            networkStatus: Stripe.Mandates.Mandate.PaymentMethodDetails.BacsDebit.NetworkStatus? =
                nil,
            reference: String? = nil,
            url: String? = nil
        ) {
            self.networkStatus = networkStatus
            self.reference = reference
            self.url = url
        }
    }
}

extension Stripe.Mandates.Mandate.PaymentMethodDetails.BacsDebit {
    public enum NetworkStatus: String, Codable, Sendable {
        case pending
        case revoked
        case refused
        case accepted
    }
}

// MARK: - Blik
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct Blik: Codable, Hashable, Sendable {
        /// Date at which the mandate expires.
        public var expiresAfter: Date?
        /// Details for off-session mandates.
        public var offSession: Stripe.Mandates.Mandate.PaymentMethodDetails.Blik.OffSession?
        /// Type of the mandate.
        public var type: Stripe.Mandates.Mandate.PaymentMethodDetails.Blik.`Type`?

        public init(
            expiresAfter: Date? = nil,
            offSession: Stripe.Mandates.Mandate.PaymentMethodDetails.Blik.OffSession? = nil,
            type: Stripe.Mandates.Mandate.PaymentMethodDetails.Blik.`Type`? = nil
        ) {
            self.expiresAfter = expiresAfter
            self.offSession = offSession
            self.type = type
        }
    }
}

extension Stripe.Mandates.Mandate.PaymentMethodDetails.Blik {
    public struct OffSession: Codable, Hashable, Sendable {
        /// Amount of each recurring payment.
        public var amount: Int?
        /// Currency of each recurring payment.
        public var currency: Stripe.Currency?
        /// Frequency interval of each recurring payment.
        public var interval: Stripe.Interval?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil,
            interval: Stripe.Interval? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.interval = interval
        }
    }

    public enum `Type`: String, Codable, Sendable {
        /// Mandate for on-session payments.
        case onSession = "on_session"
        /// Mandate for off-session payments.
        case offSession = "off_session"
    }
}

extension Stripe.Mandates.Mandate.PaymentMethodDetails.Blik.OffSession {
    // Using shared Stripe.Interval type
    public typealias Interval = Stripe.Interval
}

// MARK: - Card
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct Card: Codable, Hashable, Sendable {
        public init() {}
    }
}

// MARK: - Link
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct Link: Codable, Hashable, Sendable {
        public init() {}
    }
}

// MARK: - SepaDebit
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct SepaDebit: Codable, Hashable, Sendable {
        /// The unique reference of the mandate.
        public var reference: String?
        /// The URL of the mandate. This URL generally contains sensitive information about the customer and should be shared with them exclusively.
        public var url: String?

        public init(
            reference: String? = nil,
            url: String? = nil
        ) {
            self.reference = reference
            self.url = url
        }
    }
}

// MARK: - US Bank Account
extension Stripe.Mandates.Mandate.PaymentMethodDetails {
    public struct UsBankAccount: Codable, Hashable, Sendable {
        public init() {}
    }
}
