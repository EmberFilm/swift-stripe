//
//  Mandate.swift
//
//
//  Created by Andrew Edwards on 11/23/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/mandates/object.md

extension Stripe.Mandates {
    public struct Mandate: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// Details about the customer’s acceptance of the mandate.
        public var customerAcceptance: Stripe.Mandates.Mandate.CustomerAcceptance?
        /// ID of the payment method associated with this mandate.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var paymentMethod
        /// Additional mandate information specific to the payment method type.
        public var paymentMethodDetails: Stripe.Mandates.Mandate.PaymentMethodDetails?
        /// The status of the Mandate, one of `active`, `inactive`, or `pending`. The Mandate can be used to initiate a payment only if status=active.
        public var status: Stripe.Mandates.Mandate.Status?
        /// The type of the mandate, one of `multi_use` or `single_use`.
        public var type: Stripe.Mandates.Mandate.`Type`?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool?
        /// If this is a `multi_use` mandate, this hash contains details about the mandate.
        public var multiUse: String?
        /// If this is a `single_use` mandate, this hash contains details about the mandate.
        public var singleUse: Stripe.Mandates.Mandate.SingleUse?

        public init(
            id: ID,
            customerAcceptance: Stripe.Mandates.Mandate.CustomerAcceptance? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            paymentMethodDetails: Stripe.Mandates.Mandate.PaymentMethodDetails? = nil,
            status: Stripe.Mandates.Mandate.Status? = nil,
            type: Stripe.Mandates.Mandate.`Type`? = nil,
            object: String,
            livemode: Bool? = nil,
            multiUse: String? = nil,
            singleUse: Stripe.Mandates.Mandate.SingleUse? = nil
        ) {
            self.id = id
            self.customerAcceptance = customerAcceptance
            self._paymentMethod = Expandable(id: paymentMethod)
            self.paymentMethodDetails = paymentMethodDetails
            self.status = status
            self.type = type
            self.object = object
            self.livemode = livemode
            self.multiUse = multiUse
            self.singleUse = singleUse
        }
    }
}

extension Stripe.Mandates.Mandate {
    public struct CustomerAcceptance: Codable, Hashable, Sendable {
        /// The time at which the customer accepted the Mandate.
        public var acceptedAt: Date?
        /// If this is a Mandate accepted offline, this hash contains details about the offline acceptance.
        public var offline: Stripe.Mandates.Mandate.CustomerAcceptance.Offline?
        /// If this is a Mandate accepted online, this hash contains details about the online acceptance.
        public var online: Stripe.Mandates.Mandate.CustomerAcceptance.Online?
        /// The type of customer acceptance information included with the Mandate. One of online or offline.
        public var type: Stripe.Mandates.Mandate.CustomerAcceptance.`Type`?

        public init(
            acceptedAt: Date? = nil,
            offline: Stripe.Mandates.Mandate.CustomerAcceptance.Offline? = nil,
            online: Stripe.Mandates.Mandate.CustomerAcceptance.Online? = nil,
            type: Stripe.Mandates.Mandate.CustomerAcceptance.`Type`? = nil
        ) {
            self.acceptedAt = acceptedAt
            self.offline = offline
            self.online = online
            self.type = type
        }
    }
}

extension Stripe.Mandates.Mandate.CustomerAcceptance {
    public struct Offline: Codable, Hashable, Sendable {
        public init() {}
    }

    public struct Online: Codable, Hashable, Sendable {
        /// The IP address from which the Mandate was accepted by the customer
        public var ipAddress: String?
        /// The user agent of the browser from which the Mandate was accepted by the customer.
        public var userAgent: String?

        public init(
            ipAddress: String? = nil,
            userAgent: String? = nil
        ) {
            self.ipAddress = ipAddress
            self.userAgent = userAgent
        }
    }

    public enum `Type`: String, Codable, Sendable {
        case online
        case offline
    }
}

extension Stripe.Mandates.Mandate {
    public struct PaymentMethodDetails: Codable, Hashable, Sendable {
        /// If this mandate is associated with a `acss_debit` payment method, this hash contains mandate information specific to the `acss_debit` payment method.
        public var acssDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit?
        /// If this mandate is associated with a `au_becs_debit` payment method, this hash contains mandate information specific to the `au_becs_debit` payment method.
        public var auBecsDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.AuBecsDebit?
        /// If this mandate is associated with a `bacs_debit` payment method, this hash contains mandate information specific to the `bacs_debit` payment method.
        public var bacsDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.BacsDebit?
        /// If this mandate is associated with a `blik` payment method, this hash contains mandate information specific to the `blik` payment method.
        public var blik: Stripe.Mandates.Mandate.PaymentMethodDetails.Blik?
        /// If this mandate is associated with a `card` payment method, this hash contains mandate information specific to the `card` payment method.
        public var card: Stripe.Mandates.Mandate.PaymentMethodDetails.Card?
        /// If this mandate is associated with a `link` payment method, this hash contains mandate information specific to the `link` payment method.
        public var link: Stripe.Mandates.Mandate.PaymentMethodDetails.Link?
        /// If this mandate is associated with a `sepa_debit` payment method, this hash contains mandate information specific to the `sepa_debit` payment method.
        public var sepaDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.SepaDebit?
        /// The type of the payment method associated with this mandate. An additional hash is included on `payment_method_details` with a name matching this value. It contains mandate information specific to the payment method.
        public var type: Stripe.PaymentMethods.PaymentMethod.`Type`?

        public init(
            acssDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.ACSSDebit? = nil,
            auBecsDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.AuBecsDebit? = nil,
            bacsDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.BacsDebit? = nil,
            blik: Stripe.Mandates.Mandate.PaymentMethodDetails.Blik? = nil,
            card: Stripe.Mandates.Mandate.PaymentMethodDetails.Card? = nil,
            link: Stripe.Mandates.Mandate.PaymentMethodDetails.Link? = nil,
            sepaDebit: Stripe.Mandates.Mandate.PaymentMethodDetails.SepaDebit? = nil,
            type: Stripe.PaymentMethods.PaymentMethod.`Type`? = nil
        ) {
            self.acssDebit = acssDebit
            self.auBecsDebit = auBecsDebit
            self.bacsDebit = bacsDebit
            self.blik = blik
            self.card = card
            self.link = link
            self.sepaDebit = sepaDebit
            self.type = type
        }
    }
}

extension Stripe.Mandates.Mandate {
    public struct SingleUse: Codable, Hashable, Sendable {
        /// On a single use mandate, the amount of the payment.
        public var amount: Int?
        /// On a single use mandate, the currency of the payment.
        public var currency: Stripe.Currency?

        public init(
            amount: Int? = nil,
            currency: Stripe.Currency? = nil
        ) {
            self.amount = amount
            self.currency = currency
        }
    }
}

extension Stripe.Mandates.Mandate {
    public struct MultiUse: Codable, Hashable, Sendable {
        public init() {}
    }
}

extension Stripe.Mandates.Mandate {
    public enum Status: String, Codable, Sendable {
        /// The mandate can be used to initiate a payment.
        case active
        /// The mandate was rejected, revoked, or previously used, and may not be used to initiate future payments.
        case inactive
        /// The mandate is newly created and is not yet active or inactive.
        case pending
    }
}

extension Stripe.Mandates.Mandate {
    public enum `Type`: String, Codable, Sendable {
        /// Represents permission given for multiple payments.
        case multiUse = "multi_use"
        /// Represents a one-time permission given for a single payment.
        case singleUse = "single_use"
    }
}
