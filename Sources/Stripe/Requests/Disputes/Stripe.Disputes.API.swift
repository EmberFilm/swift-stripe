//
//  Stripe Disputes Types Disputes.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Disputes {
    // https://docs.stripe.com/api/disputes/update.md
    public enum Update {}
    // https://docs.stripe.com/api/disputes/list.md
    public enum List {}
}

// https://docs.stripe.com/api/disputes/update.md
extension Stripe.Disputes.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// Evidence to upload to respond to a dispute
        public let evidence: Evidence?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?
        /// Whether to immediately submit evidence to the bank
        public let submit: Bool?

        public init(
            evidence: Evidence? = nil,
            metadata: [String: String]? = nil,
            submit: Bool? = nil
        ) {
            self.evidence = evidence
            self.metadata = metadata
            self.submit = submit
        }
    }
}

extension Stripe.Disputes.Update.Request {
    public struct Evidence: Codable, Equatable, Sendable {
        /// Any server or activity logs showing proof that the customer accessed or downloaded the purchased digital product
        public let accessActivityLog: String?
        /// The billing address provided by the customer
        public let billingAddress: String?
        /// Your correspondence with the customer that addresses the dispute
        public let customerCommunication: String?
        /// The email address of the customer
        public let customerEmailAddress: String?
        /// The name of the customer
        public let customerName: String?
        /// The IP address that the customer used when making the purchase
        public let customerPurchaseIp: String?
        /// A relevant document or contract showing the customer's signature
        public let customerSignature: String?
        /// Documentation for the prior charge that can uniquely identify the charge
        public let duplicateChargeDocumentation: String?
        /// An explanation of the difference between the disputed charge versus the prior charge
        public let duplicateChargeExplanation: String?
        /// The Stripe ID for the prior charge which appears to be a duplicate
        public let duplicateChargeId: String?
        /// A description of the product or service that was sold
        public let productDescription: String?
        /// Any receipt or message sent to the customer notifying them of the charge
        public let receipt: String?
        /// Your refund policy, as shown to the customer
        public let refundPolicy: String?
        /// Documentation demonstrating that the customer was shown your refund policy
        public let refundPolicyDisclosure: String?
        /// A justification for why the customer is not entitled to a refund
        public let refundRefusalExplanation: String?
        /// The date on which the customer received or began receiving the purchased service
        public let serviceDate: String?
        /// Documentation showing proof that a service was provided to the customer
        public let serviceDocumentation: String?
        /// The address to which a physical product was shipped
        public let shippingAddress: String?
        /// The delivery service that shipped a physical product
        public let shippingCarrier: String?
        /// The date on which a physical product began its route to the shipping address
        public let shippingDate: String?
        /// Documentation showing proof that a product was shipped to the customer
        public let shippingDocumentation: String?
        /// The tracking number for a physical product
        public let shippingTrackingNumber: String?
        /// Any additional evidence or statements
        public let uncategorizedFile: String?
        /// Any additional evidence or statements (max 20,000 characters)
        public let uncategorizedText: String?

        private enum CodingKeys: String, CodingKey {
            case accessActivityLog
            case billingAddress
            case customerCommunication
            case customerEmailAddress
            case customerName
            case customerPurchaseIp
            case customerSignature
            case duplicateChargeDocumentation
            case duplicateChargeExplanation
            case duplicateChargeId
            case productDescription
            case receipt
            case refundPolicy
            case refundPolicyDisclosure
            case refundRefusalExplanation
            case serviceDate
            case serviceDocumentation
            case shippingAddress
            case shippingCarrier
            case shippingDate
            case shippingDocumentation
            case shippingTrackingNumber
            case uncategorizedFile
            case uncategorizedText
        }

        public init(
            accessActivityLog: String? = nil,
            billingAddress: String? = nil,
            customerCommunication: String? = nil,
            customerEmailAddress: String? = nil,
            customerName: String? = nil,
            customerPurchaseIp: String? = nil,
            customerSignature: String? = nil,
            duplicateChargeDocumentation: String? = nil,
            duplicateChargeExplanation: String? = nil,
            duplicateChargeId: String? = nil,
            productDescription: String? = nil,
            receipt: String? = nil,
            refundPolicy: String? = nil,
            refundPolicyDisclosure: String? = nil,
            refundRefusalExplanation: String? = nil,
            serviceDate: String? = nil,
            serviceDocumentation: String? = nil,
            shippingAddress: String? = nil,
            shippingCarrier: String? = nil,
            shippingDate: String? = nil,
            shippingDocumentation: String? = nil,
            shippingTrackingNumber: String? = nil,
            uncategorizedFile: String? = nil,
            uncategorizedText: String? = nil
        ) {
            self.accessActivityLog = accessActivityLog
            self.billingAddress = billingAddress
            self.customerCommunication = customerCommunication
            self.customerEmailAddress = customerEmailAddress
            self.customerName = customerName
            self.customerPurchaseIp = customerPurchaseIp
            self.customerSignature = customerSignature
            self.duplicateChargeDocumentation = duplicateChargeDocumentation
            self.duplicateChargeExplanation = duplicateChargeExplanation
            self.duplicateChargeId = duplicateChargeId
            self.productDescription = productDescription
            self.receipt = receipt
            self.refundPolicy = refundPolicy
            self.refundPolicyDisclosure = refundPolicyDisclosure
            self.refundRefusalExplanation = refundRefusalExplanation
            self.serviceDate = serviceDate
            self.serviceDocumentation = serviceDocumentation
            self.shippingAddress = shippingAddress
            self.shippingCarrier = shippingCarrier
            self.shippingDate = shippingDate
            self.shippingDocumentation = shippingDocumentation
            self.shippingTrackingNumber = shippingTrackingNumber
            self.uncategorizedFile = uncategorizedFile
            self.uncategorizedText = uncategorizedText
        }
    }
}

// https://docs.stripe.com/api/disputes/list.md
extension Stripe.Disputes.List {
    public struct Request: Codable, Equatable, Sendable {
        /// Only return disputes associated with the specified charge
        public let charge: Stripe.Charges.Charge.ID?
        /// Only return disputes associated with the specified payment intent
        public let paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID?
        /// Only return disputes created during the given date interval
        public let created: Stripe.DateFilter?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// A cursor for use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case charge
            case paymentIntent
            case created
            case endingBefore
            case limit
            case startingAfter
        }

        public init(
            charge: Stripe.Charges.Charge.ID? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent.ID? = nil,
            created: Stripe.DateFilter? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil
        ) {
            self.charge = charge
            self.paymentIntent = paymentIntent
            self.created = created
            self.endingBefore = endingBefore
            self.limit = limit
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Disputes.Dispute]

        private enum CodingKeys: String, CodingKey {
            case object
            case url
            case hasMore
            case data
        }

        public init(
            object: String,
            url: String,
            hasMore: Bool,
            data: [Stripe.Disputes.Dispute]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}
