//
//  Dispute.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/11/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/disputes/object.md

/// The [Dispute Object](https://stripe.com/docs/api/disputes/object)
extension Stripe.Disputes {
    public struct Dispute: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String

        /// Unique identifier for the object.
        public var id: ID
        /// Disputed amount. Usually the amount of the charge, but can differ (usually because of currency fluctuation or because only part of the order is disputed).
        public var amount: Int?
        /// ID of the charge that was disputed.
        @ExpandableOf<Stripe.Charges.Charge> public var charge: Stripe.Charges.Charge.ID?
        /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
        public var currency: Stripe.Currency?
        /// Evidence provided to respond to a dispute. Updating any field in the hash will submit all fields in the hash for review.
        public var evidence: Stripe.Disputes.Dispute.Evidence?
        /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        public var metadata: [String: String]?
        /// ID of the PaymentIntent that was disputed.
        @ExpandableOf<Stripe.PaymentIntents.PaymentIntent> public var paymentIntent:
            Stripe.PaymentIntents.PaymentIntent.ID?
        /// Reason given by cardholder for dispute. Possible values are `bank_cannot_process`, `check_returned`, `credit_not_processed`, `customer_initiated`, `debit_not_authorized`, `duplicate`, `fraudulent`, `general`, `incorrect_account_details`, `insufficient_funds`, `product_not_received`, `product_unacceptable`, `subscription_canceled`, or `unrecognized`. Read more about [dispute reasons](https://stripe.com/docs/disputes/categories).
        public var reason: Stripe.Disputes.Dispute.Reason?
        /// Current status of dispute. Possible values are `warning_needs_response`, `warning_under_review`, `warning_closed`, `needs_response`, `under_review`, `charge_refunded`, `won`, or `lost`.
        public var status: Stripe.Disputes.Dispute.Status?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String
        /// List of zero, one, or two balance transactions that show funds withdrawn and reinstated to your Stripe account as a result of this dispute.
        public var balanceTransactions: [Stripe.Balance.Transaction]?
        /// Time at which the object was created. Measured in seconds since the Unix epoch.
        public var created: Date
        /// Information about the evidence submission.
        public var evidenceDetails: Stripe.Disputes.Dispute.EvidenceDetails?
        /// If true, it is still possible to refund the disputed payment. Once the payment has been fully refunded, no further funds will be withdrawn from your Stripe account as a result of this dispute.
        public var isChargeRefundable: Bool?
        /// Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        public var livemode: Bool?

        public init(
            id: ID,
            amount: Int? = nil,
            charge: Stripe.Charges.Charge.ID? = nil,
            currency: Stripe.Currency? = nil,
            evidence: Stripe.Disputes.Dispute.Evidence? = nil,
            metadata: [String: String]? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            reason: Stripe.Disputes.Dispute.Reason? = nil,
            status: Stripe.Disputes.Dispute.Status? = nil,
            object: String,
            balanceTransactions: [Stripe.Balance.Transaction]? = nil,
            created: Date,
            evidenceDetails: Stripe.Disputes.Dispute.EvidenceDetails? = nil,
            isChargeRefundable: Bool? = nil,
            livemode: Bool? = nil
        ) {
            self.id = id
            self.amount = amount
            self._charge = Expandable(id: charge)
            self.currency = currency
            self.evidence = evidence
            self.metadata = metadata
            self._paymentIntent = Expandable(id: paymentIntent)
            self.reason = reason
            self.status = status
            self.object = object
            self.balanceTransactions = balanceTransactions
            self.created = created
            self.evidenceDetails = evidenceDetails
            self.isChargeRefundable = isChargeRefundable
            self.livemode = livemode
        }
    }
}

extension Stripe.Disputes.Dispute {
    public struct EvidenceDetails: Codable, Hashable, Sendable {
        /// Date by which evidence must be submitted in order to successfully challenge dispute. Will be null if the customer’s bank or credit card company doesn’t allow a response for this particular dispute.
        public var dueBy: Date?
        /// Whether evidence has been staged for this dispute.
        public var hasEvidence: Bool?
        /// Whether the last evidence submission was submitted past the due date. Defaults to `false` if no evidence submissions have occurred. If `true`, then delivery of the latest evidence is not guaranteed.
        public var pastDue: Bool?
        /// The number of times evidence has been submitted. Typically, you may only submit evidence once.
        public var submissionCount: Int?

        public init(
            dueBy: Date? = nil,
            hasEvidence: Bool? = nil,
            pastDue: Bool? = nil,
            submissionCount: Int? = nil
        ) {
            self.dueBy = dueBy
            self.hasEvidence = hasEvidence
            self.pastDue = pastDue
            self.submissionCount = submissionCount
        }
    }

    public enum Reason: String, Codable, Sendable {
        case bankCannotProcess = "bank_cannot_process"
        case checkReturned = "check_returned"
        case creditNotProcessed = "credit_not_processed"
        case customerInitiated = "customer_initiated"
        case debitNotAuthorized = "debit_not_authorized"
        case duplicate
        case fraudulent
        case general
        case incorrectAccountDetails = "incorrect_account_details"
        case insufficientFunds = "insufficient_funds"
        case productNotReceived = "product_not_received"
        case productUnacceptable = "product_unacceptable"
        case subscriptionCanceled = "subscription_canceled"
        case unrecognized
    }

    public enum Status: String, Codable, Sendable {
        case warningNeedsResponse = "warning_needs_response"
        case warningUnderReview = "warning_under_review"
        case warningClosed = "warning_closed"
        case needsResponse = "needs_response"
        case underReview = "under_review"
        case chargeRefunded = "charge_refunded"
        case won
        case lost
    }
}
