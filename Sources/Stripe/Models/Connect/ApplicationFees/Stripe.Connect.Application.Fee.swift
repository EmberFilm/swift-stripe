//
//  ApplicationFee.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/16/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/application_fees/object.md

extension Stripe.Connect.Application {
    /// When you collect a transaction fee on top of a charge made for your user (using [Connect](https://stripe.com/docs/connect) ), an `Application Fee` object is created in your account. You can list, retrieve, and refund application fees. For details, see [Collecting application fees](https://stripe.com/docs/connect/direct-charges#collecting-fees). [Learn More](https://stripe.com/docs/api/application_fees)
    public struct Fee: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// ID of the Stripe account this fee was taken from.
        @ExpandableOf<Stripe.Connect.Account> public var account: Stripe.Connect.Account.ID?
        /// Amount earned, in cents.
        public var amount: Int?
        /// Amount in cents refunded (can be less than the amount attribute on the fee if a partial refund was issued)
        public var amountRefunded: Int?
        /// ID of the charge that the application fee was taken from.
        @ExpandableOf<Stripe.Charges.Charge> public var charge: Stripe.Charges.Charge.ID?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Whether the fee has been fully refunded. If the fee is only partially refunded, this attribute will still be false.
        public var refunded: Bool?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// ID of the Connect application that earned the fee.
        public var application: String?
        /// Balance transaction that describes the impact of this collected application fee on your account balance (not including refunds).
        @ExpandableOf<Stripe.Balance.Transaction> public var balanceTransaction:
            Stripe.Balance.Transaction.ID?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool
        /// ID of the corresponding charge on the platform account, if this fee was the result of a charge using the destination parameter.
        @DynamicExpandable<Stripe.Charges.Charge, Stripe.Connect.Transfer> public
            var originatingTransaction: String?
        /// A list of refunds that have been applied to the fee.
        public var refunds: Stripe.Connect.Application.Fee.Refund.List?
        ///
        public var source: Stripe.Connect.Application.Fee.Source?

        public init(
            id: ID,
            account: Stripe.Connect.Account.ID? = nil,
            amount: Int? = nil,
            amountRefunded: Int? = nil,
            charge: Stripe.Charges.Charge.ID? = nil,
            currency: Stripe.Currency? = nil,
            refunded: Bool? = nil,
            object: String,
            application: String? = nil,
            balanceTransaction: Stripe.Balance.Transaction.ID? = nil,
            created: Date,
            livemode: Bool,
            originatingTransaction: String? = nil,
            refunds: Stripe.Connect.Application.Fee.Refund.List? = nil,
            source: Stripe.Connect.Application.Fee.Source? = nil
        ) {
            self.id = id
            self._account = Expandable(id: account)
            self.amount = amount
            self.amountRefunded = amountRefunded
            self._charge = Expandable(id: charge)
            self.currency = currency
            self.refunded = refunded
            self.object = object
            self.application = application
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.created = created
            self.livemode = livemode
            self._originatingTransaction = DynamicExpandable(id: originatingTransaction)
            self.refunds = refunds
            self.source = source
        }
    }
}

extension Stripe.Connect.Application.Fee {
    public struct Source: Codable, Hashable, Sendable {
        public var feeType: String?
        public var resource: Stripe.Connect.Application.Fee.Source.Resource?

        public init(
            feeType: String? = nil,
            resource: Stripe.Connect.Application.Fee.Source.Resource? = nil
        ) {
            self.feeType = feeType
            self.resource = resource
        }
    }
}

extension Stripe.Connect.Application.Fee.Source {
    public struct Resource: Codable, Hashable, Sendable {
        public var charge: Stripe.Charges.Charge.ID?
        public var payout: Stripe.Payouts.Payout.ID?
        public var type: String?

        public init(
            charge: Stripe.Charges.Charge.ID? = nil,
            payout: Stripe.Payouts.Payout.ID? = nil,
            type: String? = nil
        ) {
            self.charge = charge
            self.payout = payout
            self.type = type
        }
    }
}

extension Stripe.Connect.Application.Fee {
    public struct List: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Connect.Application.Fee]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Connect.Application.Fee]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}
