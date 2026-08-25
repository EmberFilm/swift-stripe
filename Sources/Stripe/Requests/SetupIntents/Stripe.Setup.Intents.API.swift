//
//  Stripe Setup Intents Types Setup Intents.swift
//  swift-stripe-types
//
//  Created by Coen ten Thije Boonkkamp on 13/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Setup.Intents {
    // https://docs.stripe.com/api/setup_intents/create.md
    public enum Create {}

    // https://docs.stripe.com/api/setup_intents/update.md
    public enum Update {}

    // https://docs.stripe.com/api/setup_intents/list.md
    public enum List {}

    // https://docs.stripe.com/api/setup_intents/confirm.md
    public enum Confirm {}

    // https://docs.stripe.com/api/setup_intents/cancel.md
    public enum Cancel {}

    // https://docs.stripe.com/api/setup_intents/verify_microdeposits.md
    public enum VerifyMicrodeposits {}
}

// MARK: - Create
extension Stripe.Setup.Intents.Create {
    public struct Request: Codable, Equatable, Sendable {
        /// If present, the SetupIntent's payment method will be attached to the in-context Stripe Account
        public let attachToSelf: Bool?
        /// Set to true to attempt to confirm this SetupIntent immediately
        public let confirm: Bool?
        /// ID of the Customer this SetupIntent belongs to
        public let customer: Stripe.Customers.Customer.ID?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?
        /// The ID of the payment method to attach to this SetupIntent
        public let paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        // Payment-method-specific configuration is handled separately in the live implementation
        // public let paymentMethodOptions: SetupIntentPaymentMethodOptions?
        /// The list of payment method types that this SetupIntent is allowed to use
        public let paymentMethodTypes: [String]?
        /// The URL to redirect your customer back to after they authenticate or cancel their payment
        public let returnUrl: String?
        /// Indicates how the payment method is intended to be used in the future
        public let usage: String?

        private enum CodingKeys: String, CodingKey {
            case attachToSelf
            case confirm
            case customer
            case description
            case metadata
            case paymentMethod
            case paymentMethodTypes
            case returnUrl
            case usage
        }

        public init(
            attachToSelf: Bool? = nil,
            confirm: Bool? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            paymentMethodTypes: [String]? = nil,
            returnUrl: String? = nil,
            usage: String? = nil
        ) {
            self.attachToSelf = attachToSelf
            self.confirm = confirm
            self.customer = customer
            self.description = description
            self.metadata = metadata
            self.paymentMethod = paymentMethod
            self.paymentMethodTypes = paymentMethodTypes
            self.returnUrl = returnUrl
            self.usage = usage
        }

        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
        // signature. The standard library declares the requirement with untyped `throws`, so
        // the thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(attachToSelf, forKey: .attachToSelf)
            try container.encodeIfPresent(confirm, forKey: .confirm)
            try container.encodeIfPresent(customer, forKey: .customer)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(metadata, forKey: .metadata)
            try container.encodeIfPresent(paymentMethod, forKey: .paymentMethod)
            try container.encodeIfPresent(paymentMethodTypes, forKey: .paymentMethodTypes)
            try container.encodeIfPresent(returnUrl, forKey: .returnUrl)
            try container.encodeIfPresent(usage, forKey: .usage)
        }

        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
        // signature. The standard library declares the requirement with untyped `throws`, so
        // the thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            attachToSelf = try container.decodeIfPresent(Bool.self, forKey: .attachToSelf)
            confirm = try container.decodeIfPresent(Bool.self, forKey: .confirm)
            customer = try container.decodeIfPresent(
                Stripe.Customers.Customer.ID.self,
                forKey: .customer
            )
            description = try container.decodeIfPresent(String.self, forKey: .description)
            metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
            paymentMethod = try container.decodeIfPresent(
                Stripe.PaymentMethods.PaymentMethod.ID.self,
                forKey: .paymentMethod
            )
            paymentMethodTypes = try container.decodeIfPresent(
                [String].self,
                forKey: .paymentMethodTypes
            )
            returnUrl = try container.decodeIfPresent(String.self, forKey: .returnUrl)
            usage = try container.decodeIfPresent(String.self, forKey: .usage)
        }
    }
}

// MARK: - Update
extension Stripe.Setup.Intents.Update {
    public struct Request: Codable, Equatable, Sendable {
        /// If present, the SetupIntent's payment method will be attached to the in-context Stripe Account
        public let attachToSelf: Bool?
        /// ID of the Customer this SetupIntent belongs to
        public let customer: Stripe.Customers.Customer.ID?
        /// An arbitrary string attached to the object
        public let description: String?
        /// Set of key-value pairs that you can attach to an object
        public let metadata: [String: String]?
        /// The ID of the payment method to attach to this SetupIntent
        public let paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        // Payment-method-specific configuration is handled separately in the live implementation
        // public let paymentMethodOptions: SetupIntentPaymentMethodOptions?
        /// The list of payment method types that this SetupIntent is allowed to use
        public let paymentMethodTypes: [String]?

        private enum CodingKeys: String, CodingKey {
            case attachToSelf
            case customer
            case description
            case metadata
            case paymentMethod
            case paymentMethodTypes
        }

        public init(
            attachToSelf: Bool? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            description: String? = nil,
            metadata: [String: String]? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            paymentMethodOptions: [String: Any]? = nil,
            paymentMethodTypes: [String]? = nil
        ) {
            self.attachToSelf = attachToSelf
            self.customer = customer
            self.description = description
            self.metadata = metadata
            self.paymentMethod = paymentMethod
            self.paymentMethodTypes = paymentMethodTypes
        }

        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
        // signature. The standard library declares the requirement with untyped `throws`, so
        // the thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(attachToSelf, forKey: .attachToSelf)
            try container.encodeIfPresent(customer, forKey: .customer)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(metadata, forKey: .metadata)
            try container.encodeIfPresent(paymentMethod, forKey: .paymentMethod)
            try container.encodeIfPresent(paymentMethodTypes, forKey: .paymentMethodTypes)
        }

        // REASON: this is the exact `Swift.Decodable`/`Swift.Encodable` protocol requirement
        // signature. The standard library declares the requirement with untyped `throws`, so
        // the thrown type cannot be narrowed here without failing to satisfy it.
        // swiftlint:disable:next typed_throws_required
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            attachToSelf = try container.decodeIfPresent(Bool.self, forKey: .attachToSelf)
            customer = try container.decodeIfPresent(
                Stripe.Customers.Customer.ID.self,
                forKey: .customer
            )
            description = try container.decodeIfPresent(String.self, forKey: .description)
            metadata = try container.decodeIfPresent([String: String].self, forKey: .metadata)
            paymentMethod = try container.decodeIfPresent(
                Stripe.PaymentMethods.PaymentMethod.ID.self,
                forKey: .paymentMethod
            )
            paymentMethodTypes = try container.decodeIfPresent(
                [String].self,
                forKey: .paymentMethodTypes
            )
        }
    }
}

// MARK: - List
extension Stripe.Setup.Intents.List {
    public struct Request: Codable, Equatable, Sendable {
        /// If present, the SetupIntent's payment method will be attached to the in-context Stripe Account
        public let attachToSelf: Bool?
        /// Only return SetupIntents created during the given date interval
        public let created: Stripe.DateFilter?
        /// Only return SetupIntents for the customer specified by this customer ID
        public let customer: Stripe.Customers.Customer.ID?
        /// A cursor for use in pagination
        public let endingBefore: String?
        /// A limit on the number of objects to be returned
        public let limit: Int?
        /// Only return SetupIntents associated with the specified payment method
        public let paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        /// A cursor for use in pagination
        public let startingAfter: String?

        private enum CodingKeys: String, CodingKey {
            case attachToSelf
            case created
            case customer
            case endingBefore
            case limit
            case paymentMethod
            case startingAfter
        }

        public init(
            attachToSelf: Bool? = nil,
            created: Stripe.DateFilter? = nil,
            customer: Stripe.Customers.Customer.ID? = nil,
            endingBefore: String? = nil,
            limit: Int? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            startingAfter: String? = nil
        ) {
            self.attachToSelf = attachToSelf
            self.created = created
            self.customer = customer
            self.endingBefore = endingBefore
            self.limit = limit
            self.paymentMethod = paymentMethod
            self.startingAfter = startingAfter
        }
    }

    public struct Response: Codable, Sendable {
        public let object: String
        public let url: String
        public let hasMore: Bool
        public let data: [Stripe.Setup.Intent]

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
            data: [Stripe.Setup.Intent]
        ) {
            self.object = object
            self.url = url
            self.hasMore = hasMore
            self.data = data
        }
    }
}

// MARK: - Confirm
extension Stripe.Setup.Intents.Confirm {
    public struct Request: Codable, Equatable, Sendable {
        /// The client secret of the SetupIntent
        public let clientSecret: String?
        /// ID of the payment method to attach to this SetupIntent
        public let paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID?
        // Payment-method-specific configuration is handled separately in the live implementation
        // public let paymentMethodOptions: SetupIntentPaymentMethodOptions?
        /// The URL to redirect your customer back to after they authenticate
        public let returnUrl: String?

        private enum CodingKeys: String, CodingKey {
            case clientSecret
            case paymentMethod
            case returnUrl
        }

        public init(
            clientSecret: String? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            returnUrl: String? = nil
        ) {
            self.clientSecret = clientSecret
            self.paymentMethod = paymentMethod
            self.returnUrl = returnUrl
        }
    }
}

// MARK: - Cancel
extension Stripe.Setup.Intents.Cancel {
    public struct Request: Codable, Equatable, Sendable {
        /// Reason for cancellation of this SetupIntent
        public let cancellationReason: Stripe.Setup.Intent.CancellationReason?

        private enum CodingKeys: String, CodingKey {
            case cancellationReason
        }

        public init(
            cancellationReason: Stripe.Setup.Intent.CancellationReason? = nil
        ) {
            self.cancellationReason = cancellationReason
        }
    }
}

// MARK: - VerifyMicrodeposits
extension Stripe.Setup.Intents.VerifyMicrodeposits {
    public struct Request: Codable, Equatable, Sendable {
        /// Two positive integers, in cents, equal to the values of the microdeposits sent to the bank account
        public let amounts: [Int]?
        /// A six-character descriptor code that identifies the microdeposit
        public let descriptorCode: String?

        private enum CodingKeys: String, CodingKey {
            case amounts
            case descriptorCode
        }

        public init(
            amounts: [Int]? = nil,
            descriptorCode: String? = nil
        ) {
            self.amounts = amounts
            self.descriptorCode = descriptorCode
        }
    }
}
