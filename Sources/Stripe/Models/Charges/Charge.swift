//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.Charges {
    /// The `Charge` object represents a single attempt to move money into your Stripe account.
    public struct Charge: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Amount intended to be collected by this payment.
        public var amount: Int?
        /// Amount in cents (or local equivalent) captured (can be less than the amount attribute on the charge if a partial.
        public var amountCaptured: Int?
        /// Amount in cents (or local equivalent) refunded (can be less than the amount attribute on the charge if a partial.
        public var amountRefunded: Int?
        /// ID of the Connect application that created the charge.
        @Expandable<Stripe.Shared.Application, String> public var application: String?
        /// The application fee (if any) for the charge.
        @Expandable<Stripe.Connect.Application.Fee, String> public var applicationFee: String?
        /// The amount of the application fee (if any) requested for the charge.
        public var applicationFeeAmount: Int?
        /// Authorization code on the charge.
        public var authorizationCode: String?
        /// ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds.
        @Expandable<Stripe.Balance.Transaction, String> public var balanceTransaction: String?
        public var billingDetails: Stripe.Shared.BillingDetails?
        /// The full statement descriptor that is passed to card networks, and that is displayed on your customers' credit card.
        public var calculatedStatementDescriptor: String?
        /// If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been.
        public var captured: Bool?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// ID of the customer this charge is for if one exists.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// Whether the charge has been disputed.
        public var disputed: Bool?
        /// ID of the balance transaction that describes the reversal of the balance on your account due to payment failure.
        @Expandable<Stripe.Balance.Transaction, String> public var failureBalanceTransaction: String?
        /// Error code explaining reason for charge failure if available (see the errors section for a list of codes).
        public var failureCode: String?
        /// Message to user further explaining reason for charge failure if available.
        public var failureMessage: String?
        /// Information on fraud assessments for the charge.
        public var fraudDetails: FraudDetails?
        public var level3: Level3?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The account (if any) the charge was made on behalf of without triggering an automatic transfer.
        @Expandable<Stripe.Connect.Account, String> public var onBehalfOf: String?
        /// Details about whether the payment was accepted, and why.
        public var outcome: Outcome?
        /// `true` if the charge succeeded, or was successfully authorized for later capture.
        public var paid: Bool?
        /// ID of the PaymentIntent associated with this charge, if one exists.
        @Expandable<Stripe.PaymentIntents.PaymentIntent, String> public var paymentIntent: String?
        /// ID of the payment method used in this charge.
        public var paymentMethod: String?
        /// Details about the payment method at the time of the transaction.
        public var paymentMethodDetails: PaymentMethodDetails?
        public var presentmentDetails: Stripe.Shared.PresentmentDetails?
        public var radarOptions: Stripe.Shared.RadarOptions?
        /// This is the email address that the receipt for this charge was sent to.
        public var receiptEmail: String?
        /// This is the transaction number that appears on email receipts sent for this charge.
        public var receiptNumber: String?
        /// This is the URL to view the receipt for this charge.
        public var receiptUrl: String?
        /// Whether the charge has been fully refunded.
        public var refunded: Bool?
        /// A list of refunds that have been applied to the charge.
        public var refunds: Refunds?
        /// ID of the review associated with this charge if one exists.
        @Expandable<Stripe.Fraud.Reviews.Review, String> public var review: String?
        /// Shipping information for the charge.
        public var shipping: ShippingLabel?
        /// This is a legacy field that will be removed in the future.
        @Boxed public var source: Stripe.PaymentSource?
        /// The transfer ID which created this charge.
        @Expandable<Stripe.Connect.Transfer, String> public var sourceTransfer: String?
        /// For a non-card charge, text that appears on the customer's statement as the statement descriptor.
        public var statementDescriptor: String?
        /// Provides information about a card charge.
        public var statementDescriptorSuffix: String?
        /// The status of the payment is either `succeeded`, `pending`, or `failed`.
        public var status: Status?
        /// ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination`.
        @Expandable<Stripe.Connect.Transfer, String> public var transfer: String?
        /// An optional dictionary including the account to automatically transfer to as part of a destination charge.
        public var transferData: TransferData?
        /// A string that identifies this transaction as part of a group.
        public var transferGroup: String?

        public init(
            id: ID,
            object: String,
            amount: Int? = nil,
            amountCaptured: Int? = nil,
            amountRefunded: Int? = nil,
            application: String? = nil,
            applicationFee: String? = nil,
            applicationFeeAmount: Int? = nil,
            authorizationCode: String? = nil,
            balanceTransaction: String? = nil,
            billingDetails: Stripe.Shared.BillingDetails? = nil,
            calculatedStatementDescriptor: String? = nil,
            captured: Bool? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            customer: String? = nil,
            description: String? = nil,
            disputed: Bool? = nil,
            failureBalanceTransaction: String? = nil,
            failureCode: String? = nil,
            failureMessage: String? = nil,
            fraudDetails: FraudDetails? = nil,
            level3: Level3? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            onBehalfOf: String? = nil,
            outcome: Outcome? = nil,
            paid: Bool? = nil,
            paymentIntent: String? = nil,
            paymentMethod: String? = nil,
            paymentMethodDetails: PaymentMethodDetails? = nil,
            presentmentDetails: Stripe.Shared.PresentmentDetails? = nil,
            radarOptions: Stripe.Shared.RadarOptions? = nil,
            receiptEmail: String? = nil,
            receiptNumber: String? = nil,
            receiptUrl: String? = nil,
            refunded: Bool? = nil,
            refunds: Refunds? = nil,
            review: String? = nil,
            shipping: ShippingLabel? = nil,
            source: Stripe.PaymentSource? = nil,
            sourceTransfer: String? = nil,
            statementDescriptor: String? = nil,
            statementDescriptorSuffix: String? = nil,
            status: Status? = nil,
            transfer: String? = nil,
            transferData: TransferData? = nil,
            transferGroup: String? = nil
        ) {
            self.id = id
            self.object = object
            self.amount = amount
            self.amountCaptured = amountCaptured
            self.amountRefunded = amountRefunded
            self._application = Expandable(id: application)
            self._applicationFee = Expandable(id: applicationFee)
            self.applicationFeeAmount = applicationFeeAmount
            self.authorizationCode = authorizationCode
            self._balanceTransaction = Expandable(id: balanceTransaction)
            self.billingDetails = billingDetails
            self.calculatedStatementDescriptor = calculatedStatementDescriptor
            self.captured = captured
            self.created = created
            self.currency = currency
            self._customer = Expandable(id: customer)
            self.description = description
            self.disputed = disputed
            self._failureBalanceTransaction = Expandable(id: failureBalanceTransaction)
            self.failureCode = failureCode
            self.failureMessage = failureMessage
            self.fraudDetails = fraudDetails
            self.level3 = level3
            self.livemode = livemode
            self.metadata = metadata
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.outcome = outcome
            self.paid = paid
            self._paymentIntent = Expandable(id: paymentIntent)
            self.paymentMethod = paymentMethod
            self.paymentMethodDetails = paymentMethodDetails
            self.presentmentDetails = presentmentDetails
            self.radarOptions = radarOptions
            self.receiptEmail = receiptEmail
            self.receiptNumber = receiptNumber
            self.receiptUrl = receiptUrl
            self.refunded = refunded
            self.refunds = refunds
            self._review = Expandable(id: review)
            self.shipping = shipping
            self._source = Boxed(wrappedValue: source)
            self._sourceTransfer = Expandable(id: sourceTransfer)
            self.statementDescriptor = statementDescriptor
            self.statementDescriptorSuffix = statementDescriptorSuffix
            self.status = status
            self._transfer = Expandable(id: transfer)
            self.transferData = transferData
            self.transferGroup = transferGroup
        }

        /// The status of the payment is either `succeeded`, `pending`, or `failed`.
        public enum Status: String, Codable, Hashable, Sendable {
            case failed
            case pending
            case succeeded
        }

        public struct FraudDetails: Codable, Hashable, Sendable {
            /// Assessments from Stripe.
            public var stripeReport: String?
            /// Assessments reported by you.
            public var userReport: String?

            public init(
                stripeReport: String? = nil,
                userReport: String? = nil
            ) {
                self.stripeReport = stripeReport
                self.userReport = userReport
            }
        }

        public struct Level3: Codable, Hashable, Sendable {
            public var customerReference: String?
            public var lineItems: [LineItems]?
            public var merchantReference: String?
            public var shippingAddressZip: String?
            public var shippingAmount: Int?
            public var shippingFromZip: String?

            public init(
                customerReference: String? = nil,
                lineItems: [LineItems]? = nil,
                merchantReference: String? = nil,
                shippingAddressZip: String? = nil,
                shippingAmount: Int? = nil,
                shippingFromZip: String? = nil
            ) {
                self.customerReference = customerReference
                self.lineItems = lineItems
                self.merchantReference = merchantReference
                self.shippingAddressZip = shippingAddressZip
                self.shippingAmount = shippingAmount
                self.shippingFromZip = shippingFromZip
            }

            public struct LineItems: Codable, Hashable, Sendable {
                public var discountAmount: Int?
                public var productCode: String?
                public var productDescription: String?
                public var quantity: Int?
                public var taxAmount: Int?
                public var unitCost: Int?

                public init(
                    discountAmount: Int? = nil,
                    productCode: String? = nil,
                    productDescription: String? = nil,
                    quantity: Int? = nil,
                    taxAmount: Int? = nil,
                    unitCost: Int? = nil
                ) {
                    self.discountAmount = discountAmount
                    self.productCode = productCode
                    self.productDescription = productDescription
                    self.quantity = quantity
                    self.taxAmount = taxAmount
                    self.unitCost = unitCost
                }
            }
        }

        public struct Outcome: Codable, Hashable, Sendable {
            /// An enumerated value providing a more detailed explanation on how to proceed with an error.
            public var adviceCode: AdviceCode?
            /// For charges declined by the network, a 2 digit code which indicates the advice returned by the network on how to.
            public var networkAdviceCode: String?
            /// For charges declined by the network, an alphanumeric code which indicates the reason the charge failed.
            public var networkDeclineCode: String?
            /// Possible values are `approved_by_network`, `declined_by_network`, `not_sent_to_network`, and.
            public var networkStatus: String?
            /// An enumerated value providing a more detailed explanation of the outcome's `type`.
            public var reason: String?
            /// Stripe Radar's evaluation of the riskiness of the payment.
            public var riskLevel: String?
            /// Stripe Radar's evaluation of the riskiness of the payment.
            public var riskScore: Int?
            /// The ID of the Radar rule that matched the payment, if applicable.
            @Expandable<Rule, String> public var rule: String?
            /// A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not.
            public var sellerMessage: String?
            /// Possible values are `authorized`, `manual_review`, `issuer_declined`, `blocked`, and `invalid`.
            public var `type`: String?

            public init(
                adviceCode: AdviceCode? = nil,
                networkAdviceCode: String? = nil,
                networkDeclineCode: String? = nil,
                networkStatus: String? = nil,
                reason: String? = nil,
                riskLevel: String? = nil,
                riskScore: Int? = nil,
                rule: String? = nil,
                sellerMessage: String? = nil,
                `type`: String? = nil
            ) {
                self.adviceCode = adviceCode
                self.networkAdviceCode = networkAdviceCode
                self.networkDeclineCode = networkDeclineCode
                self.networkStatus = networkStatus
                self.reason = reason
                self.riskLevel = riskLevel
                self.riskScore = riskScore
                self._rule = Expandable(id: rule)
                self.sellerMessage = sellerMessage
                self.`type` = `type`
            }

            /// An enumerated value providing a more detailed explanation on how to proceed with an error.
            public enum AdviceCode: String, Codable, Hashable, Sendable {
                case confirmCardData = "confirm_card_data"
                case doNotTryAgain = "do_not_try_again"
                case tryAgainLater = "try_again_later"
            }

            public struct Rule: Codable, Hashable, Sendable, Identifiable {
                public typealias ID = String
                public let id: ID
                /// The action taken on the payment.
                public var action: String?
                /// The predicate to evaluate the payment against.
                public var predicate: String?

                public init(
                    id: ID,
                    action: String? = nil,
                    predicate: String? = nil
                ) {
                    self.id = id
                    self.action = action
                    self.predicate = predicate
                }
            }
        }

        public struct PaymentMethodDetails: Codable, Hashable, Sendable {
            /// The type of transaction-specific details of the payment method used in the payment.
            public var `type`: String?
            /// The payload `type` selects.
            public var details: Details

            fileprivate enum CodingKeys: String, CodingKey {
                case `type`
                case achCreditTransfer
                case achDebit
                case acssDebit
                case affirm
                case afterpayClearpay
                case alipay
                case alma
                case amazonPay
                case auBecsDebit
                case bacsDebit
                case bancontact
                case billie
                case bizum
                case blik
                case boleto
                case card
                case cardPresent
                case cashapp
                case crypto
                case customerBalance
                case eps
                case fpx
                case giropay
                case grabpay
                case ideal
                case interacPresent
                case kakaoPay
                case klarna
                case konbini
                case krCard
                case link
                case mbWay
                case mobilepay
                case multibanco
                case naverPay
                case nzBankAccount
                case oxxo
                case p24
                case payByBank
                case payco
                case paynow
                case paypal
                case payto
                case pix
                case promptpay
                case revolutPay
                case samsungPay
                case satispay
                case scalapay
                case sepaCreditTransfer
                case sepaDebit
                case sofort
                case stripeAccount
                case sunbit
                case swish
                case twint
                case upi
                case usBankAccount
                case wechat
                case wechatPay
                case zip
            }

            public init(
                `type`: String? = nil,
                details: Details
            ) {
                self.`type` = `type`
                self.details = details
            }

            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.`type` = try container.decodeIfPresent(String.self, forKey: .`type`)
                self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
            }

            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encodeIfPresent(`type`, forKey: .`type`)
                try details.encode(into: &container)
            }

            public struct AcssDebit: Codable, Hashable, Sendable {
                /// Name of the bank associated with the bank account.
                public var bankName: String?
                /// Estimated date to debit the customer's bank account.
                public var expectedDebitDate: String?
                /// Uniquely identifies this particular bank account.
                public var fingerprint: String?
                /// Institution number of the bank account.
                public var institutionNumber: String?
                /// Last four digits of the bank account number.
                public var last4: String?
                /// ID of the mandate used to make this payment.
                public var mandate: String?
                /// Transit number of the bank account.
                public var transitNumber: String?

                public init(
                    bankName: String? = nil,
                    expectedDebitDate: String? = nil,
                    fingerprint: String? = nil,
                    institutionNumber: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil,
                    transitNumber: String? = nil
                ) {
                    self.bankName = bankName
                    self.expectedDebitDate = expectedDebitDate
                    self.fingerprint = fingerprint
                    self.institutionNumber = institutionNumber
                    self.last4 = last4
                    self.mandate = mandate
                    self.transitNumber = transitNumber
                }
            }

            public struct Affirm: Codable, Hashable, Sendable {
                /// ID of the location that this reader is assigned to.
                public var location: String?
                /// ID of the reader this transaction was made on.
                public var reader: String?
                /// The Affirm transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    location: String? = nil,
                    reader: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.location = location
                    self.reader = reader
                    self.transactionId = transactionId
                }
            }

            public struct AfterpayClearpay: Codable, Hashable, Sendable {
                /// The Afterpay order ID associated with this payment intent.
                public var orderId: String?
                /// Order identifier shown to the merchant in Afterpay's online portal.
                public var reference: String?

                public init(
                    orderId: String? = nil,
                    reference: String? = nil
                ) {
                    self.orderId = orderId
                    self.reference = reference
                }
            }

            public struct Alipay: Codable, Hashable, Sendable {
                /// Uniquely identifies this particular Alipay account.
                public var buyerId: String?
                /// Uniquely identifies this particular Alipay account.
                public var fingerprint: String?
                /// Transaction ID of this particular Alipay transaction.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    fingerprint: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.fingerprint = fingerprint
                    self.transactionId = transactionId
                }
            }

            public struct Alma: Codable, Hashable, Sendable {
                public var installments: Installments?
                /// The Alma transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    installments: Installments? = nil,
                    transactionId: String? = nil
                ) {
                    self.installments = installments
                    self.transactionId = transactionId
                }

                public struct Installments: Codable, Hashable, Sendable {
                    /// The number of installments.
                    public var count: Int?

                    public init(
                        count: Int? = nil
                    ) {
                        self.count = count
                    }
                }
            }

            public struct AmazonPay: Codable, Hashable, Sendable {
                public var funding: Funding?
                /// The Amazon Pay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    funding: Funding? = nil,
                    transactionId: String? = nil
                ) {
                    self.funding = funding
                    self.transactionId = transactionId
                }

                public struct Funding: Codable, Hashable, Sendable {
                    @Boxed public var card: Card?
                    /// funding type of the underlying payment method.
                    public var `type`: String?

                    public init(
                        card: Card? = nil,
                        `type`: String? = nil
                    ) {
                        self._card = Boxed(wrappedValue: card)
                        self.`type` = `type`
                    }

                    public struct Card: Codable, Hashable, Sendable {
                        /// Card brand.
                        public var brand: String?
                        /// Two-letter ISO code representing the country of the card.
                        public var country: String?
                        /// Two-digit number representing the card's expiration month.
                        public var expMonth: Int?
                        /// Four-digit number representing the card's expiration year.
                        public var expYear: Int?
                        /// Card funding type.
                        public var funding: String?
                        /// The last four digits of the card.
                        public var last4: String?

                        public init(
                            brand: String? = nil,
                            country: String? = nil,
                            expMonth: Int? = nil,
                            expYear: Int? = nil,
                            funding: String? = nil,
                            last4: String? = nil
                        ) {
                            self.brand = brand
                            self.country = country
                            self.expMonth = expMonth
                            self.expYear = expYear
                            self.funding = funding
                            self.last4 = last4
                        }
                    }
                }
            }

            public struct AuBecsDebit: Codable, Hashable, Sendable {
                /// Bank-State-Branch number of the bank account.
                public var bsbNumber: String?
                /// Estimated date to debit the customer's bank account.
                public var expectedDebitDate: String?
                /// Uniquely identifies this particular bank account.
                public var fingerprint: String?
                /// Last four digits of the bank account number.
                public var last4: String?
                /// ID of the mandate used to make this payment.
                public var mandate: String?

                public init(
                    bsbNumber: String? = nil,
                    expectedDebitDate: String? = nil,
                    fingerprint: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil
                ) {
                    self.bsbNumber = bsbNumber
                    self.expectedDebitDate = expectedDebitDate
                    self.fingerprint = fingerprint
                    self.last4 = last4
                    self.mandate = mandate
                }
            }

            public struct BacsDebit: Codable, Hashable, Sendable {
                /// Estimated date to debit the customer's bank account.
                public var expectedDebitDate: String?
                /// Uniquely identifies this particular bank account.
                public var fingerprint: String?
                /// Last four digits of the bank account number.
                public var last4: String?
                /// ID of the mandate used to make this payment.
                public var mandate: String?
                /// Sort code of the bank account.
                public var sortCode: String?

                public init(
                    expectedDebitDate: String? = nil,
                    fingerprint: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil,
                    sortCode: String? = nil
                ) {
                    self.expectedDebitDate = expectedDebitDate
                    self.fingerprint = fingerprint
                    self.last4 = last4
                    self.mandate = mandate
                    self.sortCode = sortCode
                }
            }

            public struct Bancontact: Codable, Hashable, Sendable {
                /// Bank code of bank associated with the bank account.
                public var bankCode: String?
                /// Name of the bank associated with the bank account.
                public var bankName: String?
                /// Bank Identifier Code of the bank associated with the bank account.
                public var bic: String?
                /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
                @Expandable<Stripe.PaymentMethods.PaymentMethod, String> public var generatedSepaDebit: String?
                /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
                @Expandable<Stripe.Mandates.Mandate, String> public var generatedSepaDebitMandate: String?
                /// Last four characters of the IBAN.
                public var ibanLast4: String?
                /// Preferred language of the Bancontact authorization page that the customer is redirected to.
                public var preferredLanguage: PreferredLanguage?
                /// Owner's verified full name.
                public var verifiedName: String?

                public init(
                    bankCode: String? = nil,
                    bankName: String? = nil,
                    bic: String? = nil,
                    generatedSepaDebit: String? = nil,
                    generatedSepaDebitMandate: String? = nil,
                    ibanLast4: String? = nil,
                    preferredLanguage: PreferredLanguage? = nil,
                    verifiedName: String? = nil
                ) {
                    self.bankCode = bankCode
                    self.bankName = bankName
                    self.bic = bic
                    self._generatedSepaDebit = Expandable(id: generatedSepaDebit)
                    self._generatedSepaDebitMandate = Expandable(id: generatedSepaDebitMandate)
                    self.ibanLast4 = ibanLast4
                    self.preferredLanguage = preferredLanguage
                    self.verifiedName = verifiedName
                }

                /// Preferred language of the Bancontact authorization page that the customer is redirected to.
                public enum PreferredLanguage: String, Codable, Hashable, Sendable {
                    case de
                    case en
                    case fr
                    case nl
                }
            }

            public struct Billie: Codable, Hashable, Sendable {
                /// The Billie transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    transactionId: String? = nil
                ) {
                    self.transactionId = transactionId
                }
            }

            public struct Bizum: Codable, Hashable, Sendable {
                /// A unique identifier for the buyer as determined by the local payment processor.
                public var buyerId: String?
                /// The Bizum transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.transactionId = transactionId
                }
            }

            public struct Blik: Codable, Hashable, Sendable {
                /// A unique and immutable identifier assigned by BLIK to every buyer.
                public var buyerId: String?

                public init(
                    buyerId: String? = nil
                ) {
                    self.buyerId = buyerId
                }
            }

            public struct Boleto: Codable, Hashable, Sendable {
                /// The tax ID of the customer (CPF for individuals consumers or CNPJ for businesses consumers).
                public var taxId: String?

                public init(
                    taxId: String? = nil
                ) {
                    self.taxId = taxId
                }
            }

            public struct Card: Codable, Hashable, Sendable {
                /// The authorized amount.
                public var amountAuthorized: Int?
                /// Authorization code on the charge.
                public var authorizationCode: String?
                /// Card brand.
                public var brand: String?
                /// When using manual capture, a future timestamp at which the charge will be automatically refunded if uncaptured.
                public var captureBefore: Date?
                /// Check results by Card networks on Card address and CVC at time of payment.
                public var checks: Checks?
                /// Two-letter ISO code representing the country of the card.
                public var country: String?
                /// A high-level description of the type of cards issued in this range.
                public var description: String?
                /// Two-digit number representing the card's expiration month.
                public var expMonth: Int?
                /// Four-digit number representing the card's expiration year.
                public var expYear: Int?
                public var extendedAuthorization: ExtendedAuthorization?
                /// Uniquely identifies this particular card number.
                public var fingerprint: String?
                /// Card funding type.
                public var funding: String?
                /// Issuer identification number of the card.
                public var iin: String?
                public var incrementalAuthorization: IncrementalAuthorization?
                /// Installment details for this payment.
                public var installments: Installments?
                /// The name of the card's issuing bank.
                public var issuer: String?
                /// The last four digits of the card.
                public var last4: String?
                /// ID of the mandate used to make this payment or created by it.
                public var mandate: String?
                /// True if this payment was marked as MOTO and out of scope for SCA.
                public var moto: Bool?
                public var multicapture: Multicapture?
                /// Identifies which network this charge was processed on.
                public var network: String?
                /// If this card has network token credentials, this contains the details of the network token credentials.
                public var networkToken: NetworkToken?
                /// This is used by the financial networks to identify a transaction.
                public var networkTransactionId: String?
                public var overcapture: Overcapture?
                /// Status of a card based on the card issuer.
                public var regulatedStatus: RegulatedStatus?
                /// Populated if this transaction used 3D Secure authentication.
                public var threeDSecure: ThreeDSecure?
                /// Transaction Link ID (TLID) is a unique identifier for a transaction.
                public var transactionLinkId: String?
                /// If this Card is part of a card wallet, this contains the details of the card wallet.
                public var wallet: Wallet?

                public init(
                    amountAuthorized: Int? = nil,
                    authorizationCode: String? = nil,
                    brand: String? = nil,
                    captureBefore: Date? = nil,
                    checks: Checks? = nil,
                    country: String? = nil,
                    description: String? = nil,
                    expMonth: Int? = nil,
                    expYear: Int? = nil,
                    extendedAuthorization: ExtendedAuthorization? = nil,
                    fingerprint: String? = nil,
                    funding: String? = nil,
                    iin: String? = nil,
                    incrementalAuthorization: IncrementalAuthorization? = nil,
                    installments: Installments? = nil,
                    issuer: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil,
                    moto: Bool? = nil,
                    multicapture: Multicapture? = nil,
                    network: String? = nil,
                    networkToken: NetworkToken? = nil,
                    networkTransactionId: String? = nil,
                    overcapture: Overcapture? = nil,
                    regulatedStatus: RegulatedStatus? = nil,
                    threeDSecure: ThreeDSecure? = nil,
                    transactionLinkId: String? = nil,
                    wallet: Wallet? = nil
                ) {
                    self.amountAuthorized = amountAuthorized
                    self.authorizationCode = authorizationCode
                    self.brand = brand
                    self.captureBefore = captureBefore
                    self.checks = checks
                    self.country = country
                    self.description = description
                    self.expMonth = expMonth
                    self.expYear = expYear
                    self.extendedAuthorization = extendedAuthorization
                    self.fingerprint = fingerprint
                    self.funding = funding
                    self.iin = iin
                    self.incrementalAuthorization = incrementalAuthorization
                    self.installments = installments
                    self.issuer = issuer
                    self.last4 = last4
                    self.mandate = mandate
                    self.moto = moto
                    self.multicapture = multicapture
                    self.network = network
                    self.networkToken = networkToken
                    self.networkTransactionId = networkTransactionId
                    self.overcapture = overcapture
                    self.regulatedStatus = regulatedStatus
                    self.threeDSecure = threeDSecure
                    self.transactionLinkId = transactionLinkId
                    self.wallet = wallet
                }

                /// Status of a card based on the card issuer.
                public enum RegulatedStatus: String, Codable, Hashable, Sendable {
                    case regulated
                    case unregulated
                }

                public struct Checks: Codable, Hashable, Sendable {
                    /// If a address line1 was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
                    public var addressLine1Check: String?
                    /// If a address postal code was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
                    public var addressPostalCodeCheck: String?
                    /// If a CVC was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
                    public var cvcCheck: String?

                    public init(
                        addressLine1Check: String? = nil,
                        addressPostalCodeCheck: String? = nil,
                        cvcCheck: String? = nil
                    ) {
                        self.addressLine1Check = addressLine1Check
                        self.addressPostalCodeCheck = addressPostalCodeCheck
                        self.cvcCheck = cvcCheck
                    }
                }

                public struct ExtendedAuthorization: Codable, Hashable, Sendable {
                    /// Indicates whether or not the capture window is extended beyond the standard authorization.
                    public var status: Status?

                    public init(
                        status: Status? = nil
                    ) {
                        self.status = status
                    }

                    /// Indicates whether or not the capture window is extended beyond the standard authorization.
                    public enum Status: String, Codable, Hashable, Sendable {
                        case disabled
                        case enabled
                    }
                }

                public struct IncrementalAuthorization: Codable, Hashable, Sendable {
                    /// Indicates whether or not the incremental authorization feature is supported.
                    public var status: Status?

                    public init(
                        status: Status? = nil
                    ) {
                        self.status = status
                    }

                    /// Indicates whether or not the incremental authorization feature is supported.
                    public enum Status: String, Codable, Hashable, Sendable {
                        case available
                        case unavailable
                    }
                }

                public struct Installments: Codable, Hashable, Sendable {
                    /// Installment plan selected for the payment.
                    public var plan: Stripe.Shared.PaymentMethodDetailsCardInstallmentsPlan?

                    public init(
                        plan: Stripe.Shared.PaymentMethodDetailsCardInstallmentsPlan? = nil
                    ) {
                        self.plan = plan
                    }
                }

                public struct Multicapture: Codable, Hashable, Sendable {
                    /// Indicates whether or not multiple captures are supported.
                    public var status: Status?

                    public init(
                        status: Status? = nil
                    ) {
                        self.status = status
                    }

                    /// Indicates whether or not multiple captures are supported.
                    public enum Status: String, Codable, Hashable, Sendable {
                        case available
                        case unavailable
                    }
                }

                public struct NetworkToken: Codable, Hashable, Sendable {
                    /// Indicates if Stripe used a network token, either user provided or Stripe managed when processing the transaction.
                    public var used: Bool?

                    public init(
                        used: Bool? = nil
                    ) {
                        self.used = used
                    }
                }

                public struct Overcapture: Codable, Hashable, Sendable {
                    /// The maximum amount that can be captured.
                    public var maximumAmountCapturable: Int?
                    /// Indicates whether or not the authorized amount can be over-captured.
                    public var status: Status?

                    public init(
                        maximumAmountCapturable: Int? = nil,
                        status: Status? = nil
                    ) {
                        self.maximumAmountCapturable = maximumAmountCapturable
                        self.status = status
                    }

                    /// Indicates whether or not the authorized amount can be over-captured.
                    public enum Status: String, Codable, Hashable, Sendable {
                        case available
                        case unavailable
                    }
                }

                public struct ThreeDSecure: Codable, Hashable, Sendable {
                    /// For authenticated transactions: how the customer was authenticated by the issuing bank.
                    public var authenticationFlow: AuthenticationFlow?
                    /// The Electronic Commerce Indicator (ECI).
                    public var electronicCommerceIndicator: ElectronicCommerceIndicator?
                    /// The exemption requested via 3DS and accepted by the issuer at authentication time.
                    public var exemptionIndicator: ExemptionIndicator?
                    /// Whether Stripe requested the value of `exemption_indicator` in the transaction.
                    public var exemptionIndicatorApplied: Bool?
                    /// Indicates the outcome of 3D Secure authentication.
                    public var result: Result?
                    /// Additional information about why 3D Secure succeeded or failed based on the `result`.
                    public var resultReason: ResultReason?
                    /// The 3D Secure 1 XID or 3D Secure 2 Directory Server Transaction ID (dsTransId) for this payment.
                    public var transactionId: String?
                    /// The version of 3D Secure that was used.
                    public var version: Version?

                    public init(
                        authenticationFlow: AuthenticationFlow? = nil,
                        electronicCommerceIndicator: ElectronicCommerceIndicator? = nil,
                        exemptionIndicator: ExemptionIndicator? = nil,
                        exemptionIndicatorApplied: Bool? = nil,
                        result: Result? = nil,
                        resultReason: ResultReason? = nil,
                        transactionId: String? = nil,
                        version: Version? = nil
                    ) {
                        self.authenticationFlow = authenticationFlow
                        self.electronicCommerceIndicator = electronicCommerceIndicator
                        self.exemptionIndicator = exemptionIndicator
                        self.exemptionIndicatorApplied = exemptionIndicatorApplied
                        self.result = result
                        self.resultReason = resultReason
                        self.transactionId = transactionId
                        self.version = version
                    }

                    /// For authenticated transactions: how the customer was authenticated by the issuing bank.
                    public enum AuthenticationFlow: String, Codable, Hashable, Sendable {
                        case challenge
                        case frictionless
                    }

                    /// The Electronic Commerce Indicator (ECI).
                    public enum ElectronicCommerceIndicator: String, Codable, Hashable, Sendable {
                        case value01 = "01"
                        case value02 = "02"
                        case value05 = "05"
                        case value06 = "06"
                        case value07 = "07"
                    }

                    /// The exemption requested via 3DS and accepted by the issuer at authentication time.
                    public enum ExemptionIndicator: String, Codable, Hashable, Sendable {
                        case lowRisk = "low_risk"
                        case none
                    }

                    /// Indicates the outcome of 3D Secure authentication.
                    public enum Result: String, Codable, Hashable, Sendable {
                        case attemptAcknowledged = "attempt_acknowledged"
                        case authenticated
                        case dataShareOnly = "data_share_only"
                        case exempted
                        case failed
                        case notSupported = "not_supported"
                        case processingError = "processing_error"
                    }

                    /// Additional information about why 3D Secure succeeded or failed based on the `result`.
                    public enum ResultReason: String, Codable, Hashable, Sendable {
                        case abandoned
                        case bypassed
                        case canceled
                        case cardNotEnrolled = "card_not_enrolled"
                        case networkNotSupported = "network_not_supported"
                        case protocolError = "protocol_error"
                        case rejected
                    }

                    /// The version of 3D Secure that was used.
                    public enum Version: String, Codable, Hashable, Sendable {
                        case value1_0_2 = "1.0.2"
                        case value2_1_0 = "2.1.0"
                        case value2_2_0 = "2.2.0"
                        case value2_3_0 = "2.3.0"
                        case value2_3_1 = "2.3.1"
                    }
                }

                public struct Wallet: Codable, Hashable, Sendable {
                    /// The last four digits of the device account number.
                    public var dynamicLast4: String?
                    /// The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`.
                    public var `type`: Type?
                    /// The payload `type` selects.
                    public var details: Details

                    fileprivate enum CodingKeys: String, CodingKey {
                        case dynamicLast4
                        case `type`
                        case amexExpressCheckout
                        case applePay
                        case googlePay
                        case link
                        case masterpass
                        case samsungPay
                        case visaCheckout
                    }

                    public init(
                        dynamicLast4: String? = nil,
                        `type`: Type? = nil,
                        details: Details
                    ) {
                        self.dynamicLast4 = dynamicLast4
                        self.`type` = `type`
                        self.details = details
                    }

                    public init(from decoder: any Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        self.dynamicLast4 = try container.decodeIfPresent(String.self, forKey: .dynamicLast4)
                        self.`type` = try container.decodeIfPresent(Type.self, forKey: .`type`)
                        self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
                    }

                    public func encode(to encoder: any Encoder) throws {
                        var container = encoder.container(keyedBy: CodingKeys.self)
                        try container.encodeIfPresent(dynamicLast4, forKey: .dynamicLast4)
                        try container.encodeIfPresent(`type`, forKey: .`type`)
                        try details.encode(into: &container)
                    }

                    /// The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`.
                    public enum `Type`: String, Codable, Hashable, Sendable {
                        case amexExpressCheckout = "amex_express_checkout"
                        case applePay = "apple_pay"
                        case googlePay = "google_pay"
                        case link
                        case masterpass
                        case samsungPay = "samsung_pay"
                        case visaCheckout = "visa_checkout"
                    }

                    public struct AmexExpressCheckout: Codable, Hashable, Sendable {
                        public init() {}
                    }

                    public struct Link: Codable, Hashable, Sendable {
                        /// The funding source group code applied to this Link payment at confirmation time.
                        public var fundingSourceGroup: String?

                        public init(
                            fundingSourceGroup: String? = nil
                        ) {
                            self.fundingSourceGroup = fundingSourceGroup
                        }
                    }

                    public struct Masterpass: Codable, Hashable, Sendable {
                        /// Owner's verified billing address.
                        public var billingAddress: Address?
                        /// Owner's verified email.
                        public var email: String?
                        /// Owner's verified full name.
                        public var name: String?
                        /// Owner's verified shipping address.
                        public var shippingAddress: Address?

                        public init(
                            billingAddress: Address? = nil,
                            email: String? = nil,
                            name: String? = nil,
                            shippingAddress: Address? = nil
                        ) {
                            self.billingAddress = billingAddress
                            self.email = email
                            self.name = name
                            self.shippingAddress = shippingAddress
                        }
                    }

                    public struct SamsungPay: Codable, Hashable, Sendable {
                        public init() {}
                    }

                    public struct VisaCheckout: Codable, Hashable, Sendable {
                        /// Owner's verified billing address.
                        public var billingAddress: Address?
                        /// Owner's verified email.
                        public var email: String?
                        /// Owner's verified full name.
                        public var name: String?
                        /// Owner's verified shipping address.
                        public var shippingAddress: Address?

                        public init(
                            billingAddress: Address? = nil,
                            email: String? = nil,
                            name: String? = nil,
                            shippingAddress: Address? = nil
                        ) {
                            self.billingAddress = billingAddress
                            self.email = email
                            self.name = name
                            self.shippingAddress = shippingAddress
                        }
                    }

                    /// The payload `type` selects; `unknown` carries a type this package does not model.
                    public indirect enum Details: Hashable, Sendable {
                        case amexExpressCheckout(AmexExpressCheckout)
                        case applePay(Stripe.Shared.ApplePay)
                        case googlePay(Stripe.Shared.GooglePay)
                        case link(Link)
                        case masterpass(Masterpass)
                        case samsungPay(SamsungPay)
                        case visaCheckout(VisaCheckout)
                        case unknown(type: String)

                        public var amexExpressCheckout: AmexExpressCheckout? {
                            if case .amexExpressCheckout(let value) = self { return value }
                            return nil
                        }
                        public var applePay: Stripe.Shared.ApplePay? {
                            if case .applePay(let value) = self { return value }
                            return nil
                        }
                        public var googlePay: Stripe.Shared.GooglePay? {
                            if case .googlePay(let value) = self { return value }
                            return nil
                        }
                        public var link: Link? {
                            if case .link(let value) = self { return value }
                            return nil
                        }
                        public var masterpass: Masterpass? {
                            if case .masterpass(let value) = self { return value }
                            return nil
                        }
                        public var samsungPay: SamsungPay? {
                            if case .samsungPay(let value) = self { return value }
                            return nil
                        }
                        public var visaCheckout: VisaCheckout? {
                            if case .visaCheckout(let value) = self { return value }
                            return nil
                        }

                        fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                            switch type {
                            case "amex_express_checkout":
                                if let value = try container.decodeIfPresent(AmexExpressCheckout.self, forKey: .amexExpressCheckout) {
                                    self = .amexExpressCheckout(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            case "apple_pay":
                                if let value = try container.decodeIfPresent(Stripe.Shared.ApplePay.self, forKey: .applePay) {
                                    self = .applePay(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            case "google_pay":
                                if let value = try container.decodeIfPresent(Stripe.Shared.GooglePay.self, forKey: .googlePay) {
                                    self = .googlePay(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            case "link":
                                if let value = try container.decodeIfPresent(Link.self, forKey: .link) {
                                    self = .link(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            case "masterpass":
                                if let value = try container.decodeIfPresent(Masterpass.self, forKey: .masterpass) {
                                    self = .masterpass(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            case "samsung_pay":
                                if let value = try container.decodeIfPresent(SamsungPay.self, forKey: .samsungPay) {
                                    self = .samsungPay(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            case "visa_checkout":
                                if let value = try container.decodeIfPresent(VisaCheckout.self, forKey: .visaCheckout) {
                                    self = .visaCheckout(value)
                                } else {
                                    self = .unknown(type: type)
                                }
                            default: self = .unknown(type: type)
                            }
                        }

                        fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                            switch self {
                            case .amexExpressCheckout(let value): try container.encode(value, forKey: .amexExpressCheckout)
                            case .applePay(let value): try container.encode(value, forKey: .applePay)
                            case .googlePay(let value): try container.encode(value, forKey: .googlePay)
                            case .link(let value): try container.encode(value, forKey: .link)
                            case .masterpass(let value): try container.encode(value, forKey: .masterpass)
                            case .samsungPay(let value): try container.encode(value, forKey: .samsungPay)
                            case .visaCheckout(let value): try container.encode(value, forKey: .visaCheckout)
                            default: break
                            }
                        }
                    }
                }
            }

            public struct Cashapp: Codable, Hashable, Sendable {
                /// A unique and immutable identifier assigned by Cash App to every buyer.
                public var buyerId: String?
                /// A public identifier for buyers using Cash App.
                public var cashtag: String?
                /// A unique and immutable identifier of payments assigned by Cash App.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    cashtag: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.cashtag = cashtag
                    self.transactionId = transactionId
                }
            }

            public struct Eps: Codable, Hashable, Sendable {
                /// The customer's bank.
                public var bank: Bank?
                /// Owner's verified full name.
                public var verifiedName: String?

                public init(
                    bank: Bank? = nil,
                    verifiedName: String? = nil
                ) {
                    self.bank = bank
                    self.verifiedName = verifiedName
                }

                /// The customer's bank.
                public enum Bank: String, Codable, Hashable, Sendable {
                    case arzteUndApothekerBank = "arzte_und_apotheker_bank"
                    case austrianAnadiBankAg = "austrian_anadi_bank_ag"
                    case bankAustria = "bank_austria"
                    case bankhausCarlSpangler = "bankhaus_carl_spangler"
                    case bankhausSchelhammerUndSchatteraAg = "bankhaus_schelhammer_und_schattera_ag"
                    case bawagPskAg = "bawag_psk_ag"
                    case bksBankAg = "bks_bank_ag"
                    case brullKallmusBankAg = "brull_kallmus_bank_ag"
                    case btvVierLanderBank = "btv_vier_lander_bank"
                    case capitalBankGraweGruppeAg = "capital_bank_grawe_gruppe_ag"
                    case deutscheBankAg = "deutsche_bank_ag"
                    case dolomitenbank
                    case easybankAg = "easybank_ag"
                    case ersteBankUndSparkassen = "erste_bank_und_sparkassen"
                    case hypoAlpeadriabankInternationalAg = "hypo_alpeadriabank_international_ag"
                    case hypoBankBurgenlandAktiengesellschaft = "hypo_bank_burgenland_aktiengesellschaft"
                    case hypoNoeLbFurNiederosterreichUWien = "hypo_noe_lb_fur_niederosterreich_u_wien"
                    case hypoOberosterreichSalzburgSteiermark = "hypo_oberosterreich_salzburg_steiermark"
                    case hypoTirolBankAg = "hypo_tirol_bank_ag"
                    case hypoVorarlbergBankAg = "hypo_vorarlberg_bank_ag"
                    case marchfelderBank = "marchfelder_bank"
                    case oberbankAg = "oberbank_ag"
                    case raiffeisenBankengruppeOsterreich = "raiffeisen_bankengruppe_osterreich"
                    case schoellerbankAg = "schoellerbank_ag"
                    case spardaBankWien = "sparda_bank_wien"
                    case volksbankGruppe = "volksbank_gruppe"
                    case volkskreditbankAg = "volkskreditbank_ag"
                    case vrBankBraunau = "vr_bank_braunau"
                }
            }

            public struct Giropay: Codable, Hashable, Sendable {
                /// Bank code of bank associated with the bank account.
                public var bankCode: String?
                /// Name of the bank associated with the bank account.
                public var bankName: String?
                /// Bank Identifier Code of the bank associated with the bank account.
                public var bic: String?
                /// Owner's verified full name.
                public var verifiedName: String?

                public init(
                    bankCode: String? = nil,
                    bankName: String? = nil,
                    bic: String? = nil,
                    verifiedName: String? = nil
                ) {
                    self.bankCode = bankCode
                    self.bankName = bankName
                    self.bic = bic
                    self.verifiedName = verifiedName
                }
            }

            public struct Ideal: Codable, Hashable, Sendable {
                /// The customer's bank.
                public var bank: Bank?
                /// The Bank Identifier Code of the customer's bank.
                public var bic: Bic?
                /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
                @Expandable<Stripe.PaymentMethods.PaymentMethod, String> public var generatedSepaDebit: String?
                /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
                @Expandable<Stripe.Mandates.Mandate, String> public var generatedSepaDebitMandate: String?
                /// Last four characters of the IBAN.
                public var ibanLast4: String?
                /// Unique transaction ID generated by iDEAL.
                public var transactionId: String?
                /// Owner's verified full name.
                public var verifiedName: String?

                public init(
                    bank: Bank? = nil,
                    bic: Bic? = nil,
                    generatedSepaDebit: String? = nil,
                    generatedSepaDebitMandate: String? = nil,
                    ibanLast4: String? = nil,
                    transactionId: String? = nil,
                    verifiedName: String? = nil
                ) {
                    self.bank = bank
                    self.bic = bic
                    self._generatedSepaDebit = Expandable(id: generatedSepaDebit)
                    self._generatedSepaDebitMandate = Expandable(id: generatedSepaDebitMandate)
                    self.ibanLast4 = ibanLast4
                    self.transactionId = transactionId
                    self.verifiedName = verifiedName
                }

                /// The customer's bank.
                public enum Bank: String, Codable, Hashable, Sendable {
                    case abnAmro = "abn_amro"
                    case adyen
                    case asnBank = "asn_bank"
                    case bunq
                    case buut
                    case finom
                    case handelsbanken
                    case ing
                    case knab
                    case mollie
                    case moneyou
                    case n26
                    case nn
                    case rabobank
                    case regiobank
                    case revolut
                    case snsBank = "sns_bank"
                    case triodosBank = "triodos_bank"
                    case vanLanschot = "van_lanschot"
                    case yoursafe
                }

                /// The Bank Identifier Code of the customer's bank.
                public enum Bic: String, Codable, Hashable, Sendable {
                    case ABNANL2A
                    case ADYBNL2A
                    case ASNBNL21
                    case BITSNL2A
                    case BUNQNL2A
                    case BUUTNL2A
                    case FNOMNL22
                    case FVLBNL22
                    case HANDNL2A
                    case INGBNL2A
                    case KNABNL2H
                    case MLLENL2A
                    case MOYONL21
                    case NNBANL2G
                    case NTSBDEB1
                    case RABONL2U
                    case RBRBNL21
                    case REVOIE23
                    case REVOLT21
                    case SNSBNL2A
                    case TRIONL2U
                }
            }

            public struct KakaoPay: Codable, Hashable, Sendable {
                /// A unique identifier for the buyer as determined by the local payment processor.
                public var buyerId: String?
                /// The Kakao Pay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.transactionId = transactionId
                }
            }

            public struct Klarna: Codable, Hashable, Sendable {
                /// ID of the location that this transaction's reader is assigned to.
                public var location: String?
                /// The payer details for this transaction.
                public var payerDetails: PayerDetails?
                /// The Klarna payment method used for this transaction.
                public var paymentMethodCategory: String?
                /// Preferred language of the Klarna authorization page that the customer is redirected to.
                public var preferredLocale: String?
                /// ID of the reader this transaction was made on.
                public var reader: String?

                public init(
                    location: String? = nil,
                    payerDetails: PayerDetails? = nil,
                    paymentMethodCategory: String? = nil,
                    preferredLocale: String? = nil,
                    reader: String? = nil
                ) {
                    self.location = location
                    self.payerDetails = payerDetails
                    self.paymentMethodCategory = paymentMethodCategory
                    self.preferredLocale = preferredLocale
                    self.reader = reader
                }

                public struct PayerDetails: Codable, Hashable, Sendable {
                    /// The payer's address.
                    public var address: Address?

                    public init(
                        address: Address? = nil
                    ) {
                        self.address = address
                    }

                    public struct Address: Codable, Hashable, Sendable {
                        /// The payer address country.
                        public var country: String?

                        public init(
                            country: String? = nil
                        ) {
                            self.country = country
                        }
                    }
                }
            }

            public struct Konbini: Codable, Hashable, Sendable {
                /// If the payment succeeded, this contains the details of the convenience store where the payment was completed.
                public var store: Store?

                public init(
                    store: Store? = nil
                ) {
                    self.store = store
                }

                public struct Store: Codable, Hashable, Sendable {
                    /// The name of the convenience store chain where the payment was completed.
                    public var chain: Chain?

                    public init(
                        chain: Chain? = nil
                    ) {
                        self.chain = chain
                    }

                    /// The name of the convenience store chain where the payment was completed.
                    public enum Chain: String, Codable, Hashable, Sendable {
                        case familymart
                        case lawson
                        case ministop
                        case seicomart
                    }
                }
            }

            public struct Link: Codable, Hashable, Sendable {
                /// Two-letter ISO code representing the funding source country beneath the Link payment.
                public var country: String?
                /// The funding source group code applied to this Link payment at confirmation time.
                public var fundingSourceGroup: String?

                public init(
                    country: String? = nil,
                    fundingSourceGroup: String? = nil
                ) {
                    self.country = country
                    self.fundingSourceGroup = fundingSourceGroup
                }
            }

            public struct MbWay: Codable, Hashable, Sendable {
                public init() {}
            }

            public struct Mobilepay: Codable, Hashable, Sendable {
                /// Internal card details.
                @Boxed public var card: Card?

                public init(
                    card: Card? = nil
                ) {
                    self._card = Boxed(wrappedValue: card)
                }

                public struct Card: Codable, Hashable, Sendable {
                    /// Brand of the card used in the transaction.
                    public var brand: String?
                    /// Two-letter ISO code representing the country of the card.
                    public var country: String?
                    /// Two digit number representing the card's expiration month.
                    public var expMonth: Int?
                    /// Two digit number representing the card's expiration year.
                    public var expYear: Int?
                    /// The last 4 digits of the card.
                    public var last4: String?

                    public init(
                        brand: String? = nil,
                        country: String? = nil,
                        expMonth: Int? = nil,
                        expYear: Int? = nil,
                        last4: String? = nil
                    ) {
                        self.brand = brand
                        self.country = country
                        self.expMonth = expMonth
                        self.expYear = expYear
                        self.last4 = last4
                    }
                }
            }

            public struct Multibanco: Codable, Hashable, Sendable {
                /// Entity number associated with this Multibanco payment.
                public var entity: String?
                /// Reference number associated with this Multibanco payment.
                public var reference: String?

                public init(
                    entity: String? = nil,
                    reference: String? = nil
                ) {
                    self.entity = entity
                    self.reference = reference
                }
            }

            public struct NaverPay: Codable, Hashable, Sendable {
                /// A unique identifier for the buyer as determined by the local payment processor.
                public var buyerId: String?
                /// The Naver Pay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.transactionId = transactionId
                }
            }

            public struct NzBankAccount: Codable, Hashable, Sendable {
                /// The name on the bank account.
                public var accountHolderName: String?
                /// The numeric code for the bank account's bank.
                public var bankCode: String?
                /// The name of the bank.
                public var bankName: String?
                /// The numeric code for the bank account's bank branch.
                public var branchCode: String?
                /// Estimated date to debit the customer's bank account.
                public var expectedDebitDate: String?
                /// Last four digits of the bank account number.
                public var last4: String?
                /// The suffix of the bank account number.
                public var suffix: String?

                public init(
                    accountHolderName: String? = nil,
                    bankCode: String? = nil,
                    bankName: String? = nil,
                    branchCode: String? = nil,
                    expectedDebitDate: String? = nil,
                    last4: String? = nil,
                    suffix: String? = nil
                ) {
                    self.accountHolderName = accountHolderName
                    self.bankCode = bankCode
                    self.bankName = bankName
                    self.branchCode = branchCode
                    self.expectedDebitDate = expectedDebitDate
                    self.last4 = last4
                    self.suffix = suffix
                }
            }

            public struct Oxxo: Codable, Hashable, Sendable {
                /// OXXO reference number.
                public var number: String?

                public init(
                    number: String? = nil
                ) {
                    self.number = number
                }
            }

            public struct P24: Codable, Hashable, Sendable {
                /// The customer's bank.
                public var bank: Bank?
                /// Unique reference for this Przelewy24 payment.
                public var reference: String?
                /// Owner's verified full name.
                public var verifiedName: String?

                public init(
                    bank: Bank? = nil,
                    reference: String? = nil,
                    verifiedName: String? = nil
                ) {
                    self.bank = bank
                    self.reference = reference
                    self.verifiedName = verifiedName
                }

                /// The customer's bank.
                public enum Bank: String, Codable, Hashable, Sendable {
                    case aliorBank = "alior_bank"
                    case bankMillennium = "bank_millennium"
                    case bankNowyBfgSa = "bank_nowy_bfg_sa"
                    case bankPekaoSa = "bank_pekao_sa"
                    case bankiSpbdzielcze = "banki_spbdzielcze"
                    case blik
                    case bnpParibas = "bnp_paribas"
                    case boz
                    case citiHandlowy = "citi_handlowy"
                    case creditAgricole = "credit_agricole"
                    case envelobank
                    case etransferPocztowy24 = "etransfer_pocztowy24"
                    case getinBank = "getin_bank"
                    case ideabank
                    case ing
                    case inteligo
                    case mbankMtransfer = "mbank_mtransfer"
                    case nestPrzelew = "nest_przelew"
                    case noblePay = "noble_pay"
                    case pbacZIpko = "pbac_z_ipko"
                    case plusBank = "plus_bank"
                    case santanderPrzelew24 = "santander_przelew24"
                    case tmobileUsbugiBankowe = "tmobile_usbugi_bankowe"
                    case toyotaBank = "toyota_bank"
                    case velobank
                    case volkswagenBank = "volkswagen_bank"
                }
            }

            public struct PayByBank: Codable, Hashable, Sendable {
                public init() {}
            }

            public struct Payco: Codable, Hashable, Sendable {
                /// A unique identifier for the buyer as determined by the local payment processor.
                public var buyerId: String?
                /// The Payco transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.transactionId = transactionId
                }
            }

            public struct Paynow: Codable, Hashable, Sendable {
                /// ID of the location that this transaction's reader is assigned to.
                public var location: String?
                /// ID of the reader this transaction was made on.
                public var reader: String?
                /// Reference number associated with this PayNow payment.
                public var reference: String?

                public init(
                    location: String? = nil,
                    reader: String? = nil,
                    reference: String? = nil
                ) {
                    self.location = location
                    self.reader = reader
                    self.reference = reference
                }
            }

            public struct Payto: Codable, Hashable, Sendable {
                /// Bank-State-Branch number of the bank account.
                public var bsbNumber: String?
                /// Last four digits of the bank account number.
                public var last4: String?
                /// ID of the mandate used to make this payment.
                public var mandate: String?
                /// The PayID alias for the bank account.
                public var payId: String?

                public init(
                    bsbNumber: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil,
                    payId: String? = nil
                ) {
                    self.bsbNumber = bsbNumber
                    self.last4 = last4
                    self.mandate = mandate
                    self.payId = payId
                }
            }

            public struct Pix: Codable, Hashable, Sendable {
                /// Unique transaction id generated by BCB.
                public var bankTransactionId: String?
                /// Uniquely identifies this particular Pix account.
                public var fingerprint: String?
                /// ID of the multi use Mandate generated by the PaymentIntent or SetupIntent.
                public var mandate: String?

                public init(
                    bankTransactionId: String? = nil,
                    fingerprint: String? = nil,
                    mandate: String? = nil
                ) {
                    self.bankTransactionId = bankTransactionId
                    self.fingerprint = fingerprint
                    self.mandate = mandate
                }
            }

            public struct Promptpay: Codable, Hashable, Sendable {
                /// Bill reference generated by PromptPay.
                public var reference: String?

                public init(
                    reference: String? = nil
                ) {
                    self.reference = reference
                }
            }

            public struct RevolutPay: Codable, Hashable, Sendable {
                public var funding: Funding?
                /// The Revolut Pay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    funding: Funding? = nil,
                    transactionId: String? = nil
                ) {
                    self.funding = funding
                    self.transactionId = transactionId
                }

                public struct Funding: Codable, Hashable, Sendable {
                    @Boxed public var card: Card?
                    /// funding type of the underlying payment method.
                    public var `type`: String?

                    public init(
                        card: Card? = nil,
                        `type`: String? = nil
                    ) {
                        self._card = Boxed(wrappedValue: card)
                        self.`type` = `type`
                    }

                    public struct Card: Codable, Hashable, Sendable {
                        /// Card brand.
                        public var brand: String?
                        /// Two-letter ISO code representing the country of the card.
                        public var country: String?
                        /// Two-digit number representing the card's expiration month.
                        public var expMonth: Int?
                        /// Four-digit number representing the card's expiration year.
                        public var expYear: Int?
                        /// Card funding type.
                        public var funding: String?
                        /// The last four digits of the card.
                        public var last4: String?

                        public init(
                            brand: String? = nil,
                            country: String? = nil,
                            expMonth: Int? = nil,
                            expYear: Int? = nil,
                            funding: String? = nil,
                            last4: String? = nil
                        ) {
                            self.brand = brand
                            self.country = country
                            self.expMonth = expMonth
                            self.expYear = expYear
                            self.funding = funding
                            self.last4 = last4
                        }
                    }
                }
            }

            public struct SamsungPay: Codable, Hashable, Sendable {
                /// A unique identifier for the buyer as determined by the local payment processor.
                public var buyerId: String?
                /// The Samsung Pay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    buyerId: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.buyerId = buyerId
                    self.transactionId = transactionId
                }
            }

            public struct Satispay: Codable, Hashable, Sendable {
                /// The Satispay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    transactionId: String? = nil
                ) {
                    self.transactionId = transactionId
                }
            }

            public struct Scalapay: Codable, Hashable, Sendable {
                /// The Scalapay transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    transactionId: String? = nil
                ) {
                    self.transactionId = transactionId
                }
            }

            public struct SepaDebit: Codable, Hashable, Sendable {
                /// Bank code of bank associated with the bank account.
                public var bankCode: String?
                /// Branch code of bank associated with the bank account.
                public var branchCode: String?
                /// Two-letter ISO code representing the country the bank account is located in.
                public var country: String?
                /// Estimated date to debit the customer's bank account.
                public var expectedDebitDate: String?
                /// Uniquely identifies this particular bank account.
                public var fingerprint: String?
                /// Last four characters of the IBAN.
                public var last4: String?
                /// Find the ID of the mandate used for this payment under the payment_method_details.sepa_debit.mandate property on the.
                public var mandate: String?

                public init(
                    bankCode: String? = nil,
                    branchCode: String? = nil,
                    country: String? = nil,
                    expectedDebitDate: String? = nil,
                    fingerprint: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil
                ) {
                    self.bankCode = bankCode
                    self.branchCode = branchCode
                    self.country = country
                    self.expectedDebitDate = expectedDebitDate
                    self.fingerprint = fingerprint
                    self.last4 = last4
                    self.mandate = mandate
                }
            }

            public struct Sofort: Codable, Hashable, Sendable {
                /// Bank code of bank associated with the bank account.
                public var bankCode: String?
                /// Name of the bank associated with the bank account.
                public var bankName: String?
                /// Bank Identifier Code of the bank associated with the bank account.
                public var bic: String?
                /// Two-letter ISO code representing the country the bank account is located in.
                public var country: String?
                /// The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
                @Expandable<Stripe.PaymentMethods.PaymentMethod, String> public var generatedSepaDebit: String?
                /// The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
                @Expandable<Stripe.Mandates.Mandate, String> public var generatedSepaDebitMandate: String?
                /// Last four characters of the IBAN.
                public var ibanLast4: String?
                /// Preferred language of the SOFORT authorization page that the customer is redirected to.
                public var preferredLanguage: PreferredLanguage?
                /// Owner's verified full name.
                public var verifiedName: String?

                public init(
                    bankCode: String? = nil,
                    bankName: String? = nil,
                    bic: String? = nil,
                    country: String? = nil,
                    generatedSepaDebit: String? = nil,
                    generatedSepaDebitMandate: String? = nil,
                    ibanLast4: String? = nil,
                    preferredLanguage: PreferredLanguage? = nil,
                    verifiedName: String? = nil
                ) {
                    self.bankCode = bankCode
                    self.bankName = bankName
                    self.bic = bic
                    self.country = country
                    self._generatedSepaDebit = Expandable(id: generatedSepaDebit)
                    self._generatedSepaDebitMandate = Expandable(id: generatedSepaDebitMandate)
                    self.ibanLast4 = ibanLast4
                    self.preferredLanguage = preferredLanguage
                    self.verifiedName = verifiedName
                }

                /// Preferred language of the SOFORT authorization page that the customer is redirected to.
                public enum PreferredLanguage: String, Codable, Hashable, Sendable {
                    case de
                    case en
                    case es
                    case fr
                    case it
                    case nl
                    case pl
                }
            }

            public struct Sunbit: Codable, Hashable, Sendable {
                /// The Sunbit transaction ID associated with this payment.
                public var transactionId: String?

                public init(
                    transactionId: String? = nil
                ) {
                    self.transactionId = transactionId
                }
            }

            public struct Swish: Codable, Hashable, Sendable {
                /// Uniquely identifies the payer's Swish account.
                public var fingerprint: String?
                /// Payer bank reference number for the payment.
                public var paymentReference: String?
                /// The last four digits of the Swish account phone number.
                public var verifiedPhoneLast4: String?

                public init(
                    fingerprint: String? = nil,
                    paymentReference: String? = nil,
                    verifiedPhoneLast4: String? = nil
                ) {
                    self.fingerprint = fingerprint
                    self.paymentReference = paymentReference
                    self.verifiedPhoneLast4 = verifiedPhoneLast4
                }
            }

            public struct Twint: Codable, Hashable, Sendable {
                /// ID of the multi use Mandate generated by the PaymentIntent or SetupIntent.
                public var mandate: String?

                public init(
                    mandate: String? = nil
                ) {
                    self.mandate = mandate
                }
            }

            public struct Upi: Codable, Hashable, Sendable {
                /// Customer's unique Virtual Payment Address.
                public var vpa: String?

                public init(
                    vpa: String? = nil
                ) {
                    self.vpa = vpa
                }
            }

            public struct UsBankAccount: Codable, Hashable, Sendable {
                /// Account holder type: individual or company.
                public var accountHolderType: AccountHolderType?
                /// Account type: checkings or savings.
                public var accountType: AccountType?
                /// Name of the bank associated with the bank account.
                public var bankName: String?
                /// Estimated date to debit the customer's bank account.
                public var expectedDebitDate: String?
                /// Uniquely identifies this particular bank account.
                public var fingerprint: String?
                /// Last four digits of the bank account number.
                public var last4: String?
                /// ID of the mandate used to make this payment.
                @Expandable<Stripe.Mandates.Mandate, String> public var mandate: String?
                /// Reference number to locate ACH payments with customer's bank.
                public var paymentReference: String?
                /// Routing number of the bank account.
                public var routingNumber: String?

                public init(
                    accountHolderType: AccountHolderType? = nil,
                    accountType: AccountType? = nil,
                    bankName: String? = nil,
                    expectedDebitDate: String? = nil,
                    fingerprint: String? = nil,
                    last4: String? = nil,
                    mandate: String? = nil,
                    paymentReference: String? = nil,
                    routingNumber: String? = nil
                ) {
                    self.accountHolderType = accountHolderType
                    self.accountType = accountType
                    self.bankName = bankName
                    self.expectedDebitDate = expectedDebitDate
                    self.fingerprint = fingerprint
                    self.last4 = last4
                    self._mandate = Expandable(id: mandate)
                    self.paymentReference = paymentReference
                    self.routingNumber = routingNumber
                }

                /// Account holder type: individual or company.
                public enum AccountHolderType: String, Codable, Hashable, Sendable {
                    case company
                    case individual
                }

                /// Account type: checkings or savings.
                public enum AccountType: String, Codable, Hashable, Sendable {
                    case checking
                    case savings
                }
            }

            public struct WechatPay: Codable, Hashable, Sendable {
                /// Uniquely identifies this particular WeChat Pay account.
                public var fingerprint: String?
                /// ID of the location that this transaction's reader is assigned to.
                public var location: String?
                /// ID of the reader this transaction was made on.
                public var reader: String?
                /// Transaction ID of this particular WeChat Pay transaction.
                public var transactionId: String?

                public init(
                    fingerprint: String? = nil,
                    location: String? = nil,
                    reader: String? = nil,
                    transactionId: String? = nil
                ) {
                    self.fingerprint = fingerprint
                    self.location = location
                    self.reader = reader
                    self.transactionId = transactionId
                }
            }

            public struct Zip: Codable, Hashable, Sendable {
                public init() {}
            }

            /// The payload `type` selects; `unknown` carries a type this package does not model.
            public indirect enum Details: Hashable, Sendable {
                case achCreditTransfer(Stripe.Shared.AchCreditTransfer)
                case achDebit(Stripe.Shared.AchDebit)
                case acssDebit(AcssDebit)
                case affirm(Affirm)
                case afterpayClearpay(AfterpayClearpay)
                case alipay(Alipay)
                case alma(Alma)
                case amazonPay(AmazonPay)
                case auBecsDebit(AuBecsDebit)
                case bacsDebit(BacsDebit)
                case bancontact(Bancontact)
                case billie(Billie)
                case bizum(Bizum)
                case blik(Blik)
                case boleto(Boleto)
                case card(Card)
                case cardPresent(Stripe.Shared.CardPresent)
                case cashapp(Cashapp)
                case crypto(Stripe.Shared.Crypto)
                case customerBalance(Stripe.Shared.PaymentMethodDetailsCustomerBalance)
                case eps(Eps)
                case fpx(Stripe.Shared.Fpx)
                case giropay(Giropay)
                case grabpay(Stripe.Shared.Grabpay)
                case ideal(Ideal)
                case interacPresent(Stripe.Shared.InteracPresent)
                case kakaoPay(KakaoPay)
                case klarna(Klarna)
                case konbini(Konbini)
                case krCard(Stripe.Shared.KrCard)
                case link(Link)
                case mbWay(MbWay)
                case mobilepay(Mobilepay)
                case multibanco(Multibanco)
                case naverPay(NaverPay)
                case nzBankAccount(NzBankAccount)
                case oxxo(Oxxo)
                case p24(P24)
                case payByBank(PayByBank)
                case payco(Payco)
                case paynow(Paynow)
                case paypal(Stripe.Shared.Paypal)
                case payto(Payto)
                case pix(Pix)
                case promptpay(Promptpay)
                case revolutPay(RevolutPay)
                case samsungPay(SamsungPay)
                case satispay(Satispay)
                case scalapay(Scalapay)
                case sepaCreditTransfer(Stripe.Shared.SepaCreditTransfer)
                case sepaDebit(SepaDebit)
                case sofort(Sofort)
                case stripeAccount(Stripe.Shared.StripeAccount)
                case sunbit(Sunbit)
                case swish(Swish)
                case twint(Twint)
                case upi(Upi)
                case usBankAccount(UsBankAccount)
                case wechat(Stripe.Shared.Wechat)
                case wechatPay(WechatPay)
                case zip(Zip)
                case unknown(type: String)

                public var achCreditTransfer: Stripe.Shared.AchCreditTransfer? {
                    if case .achCreditTransfer(let value) = self { return value }
                    return nil
                }
                public var achDebit: Stripe.Shared.AchDebit? {
                    if case .achDebit(let value) = self { return value }
                    return nil
                }
                public var acssDebit: AcssDebit? {
                    if case .acssDebit(let value) = self { return value }
                    return nil
                }
                public var affirm: Affirm? {
                    if case .affirm(let value) = self { return value }
                    return nil
                }
                public var afterpayClearpay: AfterpayClearpay? {
                    if case .afterpayClearpay(let value) = self { return value }
                    return nil
                }
                public var alipay: Alipay? {
                    if case .alipay(let value) = self { return value }
                    return nil
                }
                public var alma: Alma? {
                    if case .alma(let value) = self { return value }
                    return nil
                }
                public var amazonPay: AmazonPay? {
                    if case .amazonPay(let value) = self { return value }
                    return nil
                }
                public var auBecsDebit: AuBecsDebit? {
                    if case .auBecsDebit(let value) = self { return value }
                    return nil
                }
                public var bacsDebit: BacsDebit? {
                    if case .bacsDebit(let value) = self { return value }
                    return nil
                }
                public var bancontact: Bancontact? {
                    if case .bancontact(let value) = self { return value }
                    return nil
                }
                public var billie: Billie? {
                    if case .billie(let value) = self { return value }
                    return nil
                }
                public var bizum: Bizum? {
                    if case .bizum(let value) = self { return value }
                    return nil
                }
                public var blik: Blik? {
                    if case .blik(let value) = self { return value }
                    return nil
                }
                public var boleto: Boleto? {
                    if case .boleto(let value) = self { return value }
                    return nil
                }
                public var card: Card? {
                    if case .card(let value) = self { return value }
                    return nil
                }
                public var cardPresent: Stripe.Shared.CardPresent? {
                    if case .cardPresent(let value) = self { return value }
                    return nil
                }
                public var cashapp: Cashapp? {
                    if case .cashapp(let value) = self { return value }
                    return nil
                }
                public var crypto: Stripe.Shared.Crypto? {
                    if case .crypto(let value) = self { return value }
                    return nil
                }
                public var customerBalance: Stripe.Shared.PaymentMethodDetailsCustomerBalance? {
                    if case .customerBalance(let value) = self { return value }
                    return nil
                }
                public var eps: Eps? {
                    if case .eps(let value) = self { return value }
                    return nil
                }
                public var fpx: Stripe.Shared.Fpx? {
                    if case .fpx(let value) = self { return value }
                    return nil
                }
                public var giropay: Giropay? {
                    if case .giropay(let value) = self { return value }
                    return nil
                }
                public var grabpay: Stripe.Shared.Grabpay? {
                    if case .grabpay(let value) = self { return value }
                    return nil
                }
                public var ideal: Ideal? {
                    if case .ideal(let value) = self { return value }
                    return nil
                }
                public var interacPresent: Stripe.Shared.InteracPresent? {
                    if case .interacPresent(let value) = self { return value }
                    return nil
                }
                public var kakaoPay: KakaoPay? {
                    if case .kakaoPay(let value) = self { return value }
                    return nil
                }
                public var klarna: Klarna? {
                    if case .klarna(let value) = self { return value }
                    return nil
                }
                public var konbini: Konbini? {
                    if case .konbini(let value) = self { return value }
                    return nil
                }
                public var krCard: Stripe.Shared.KrCard? {
                    if case .krCard(let value) = self { return value }
                    return nil
                }
                public var link: Link? {
                    if case .link(let value) = self { return value }
                    return nil
                }
                public var mbWay: MbWay? {
                    if case .mbWay(let value) = self { return value }
                    return nil
                }
                public var mobilepay: Mobilepay? {
                    if case .mobilepay(let value) = self { return value }
                    return nil
                }
                public var multibanco: Multibanco? {
                    if case .multibanco(let value) = self { return value }
                    return nil
                }
                public var naverPay: NaverPay? {
                    if case .naverPay(let value) = self { return value }
                    return nil
                }
                public var nzBankAccount: NzBankAccount? {
                    if case .nzBankAccount(let value) = self { return value }
                    return nil
                }
                public var oxxo: Oxxo? {
                    if case .oxxo(let value) = self { return value }
                    return nil
                }
                public var p24: P24? {
                    if case .p24(let value) = self { return value }
                    return nil
                }
                public var payByBank: PayByBank? {
                    if case .payByBank(let value) = self { return value }
                    return nil
                }
                public var payco: Payco? {
                    if case .payco(let value) = self { return value }
                    return nil
                }
                public var paynow: Paynow? {
                    if case .paynow(let value) = self { return value }
                    return nil
                }
                public var paypal: Stripe.Shared.Paypal? {
                    if case .paypal(let value) = self { return value }
                    return nil
                }
                public var payto: Payto? {
                    if case .payto(let value) = self { return value }
                    return nil
                }
                public var pix: Pix? {
                    if case .pix(let value) = self { return value }
                    return nil
                }
                public var promptpay: Promptpay? {
                    if case .promptpay(let value) = self { return value }
                    return nil
                }
                public var revolutPay: RevolutPay? {
                    if case .revolutPay(let value) = self { return value }
                    return nil
                }
                public var samsungPay: SamsungPay? {
                    if case .samsungPay(let value) = self { return value }
                    return nil
                }
                public var satispay: Satispay? {
                    if case .satispay(let value) = self { return value }
                    return nil
                }
                public var scalapay: Scalapay? {
                    if case .scalapay(let value) = self { return value }
                    return nil
                }
                public var sepaCreditTransfer: Stripe.Shared.SepaCreditTransfer? {
                    if case .sepaCreditTransfer(let value) = self { return value }
                    return nil
                }
                public var sepaDebit: SepaDebit? {
                    if case .sepaDebit(let value) = self { return value }
                    return nil
                }
                public var sofort: Sofort? {
                    if case .sofort(let value) = self { return value }
                    return nil
                }
                public var stripeAccount: Stripe.Shared.StripeAccount? {
                    if case .stripeAccount(let value) = self { return value }
                    return nil
                }
                public var sunbit: Sunbit? {
                    if case .sunbit(let value) = self { return value }
                    return nil
                }
                public var swish: Swish? {
                    if case .swish(let value) = self { return value }
                    return nil
                }
                public var twint: Twint? {
                    if case .twint(let value) = self { return value }
                    return nil
                }
                public var upi: Upi? {
                    if case .upi(let value) = self { return value }
                    return nil
                }
                public var usBankAccount: UsBankAccount? {
                    if case .usBankAccount(let value) = self { return value }
                    return nil
                }
                public var wechat: Stripe.Shared.Wechat? {
                    if case .wechat(let value) = self { return value }
                    return nil
                }
                public var wechatPay: WechatPay? {
                    if case .wechatPay(let value) = self { return value }
                    return nil
                }
                public var zip: Zip? {
                    if case .zip(let value) = self { return value }
                    return nil
                }

                fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                    switch type {
                    case "ach_credit_transfer":
                        if let value = try container.decodeIfPresent(Stripe.Shared.AchCreditTransfer.self, forKey: .achCreditTransfer) {
                            self = .achCreditTransfer(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "ach_debit":
                        if let value = try container.decodeIfPresent(Stripe.Shared.AchDebit.self, forKey: .achDebit) {
                            self = .achDebit(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "acss_debit":
                        if let value = try container.decodeIfPresent(AcssDebit.self, forKey: .acssDebit) {
                            self = .acssDebit(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "affirm":
                        if let value = try container.decodeIfPresent(Affirm.self, forKey: .affirm) {
                            self = .affirm(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "afterpay_clearpay":
                        if let value = try container.decodeIfPresent(AfterpayClearpay.self, forKey: .afterpayClearpay) {
                            self = .afterpayClearpay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "alipay":
                        if let value = try container.decodeIfPresent(Alipay.self, forKey: .alipay) {
                            self = .alipay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "alma":
                        if let value = try container.decodeIfPresent(Alma.self, forKey: .alma) {
                            self = .alma(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "amazon_pay":
                        if let value = try container.decodeIfPresent(AmazonPay.self, forKey: .amazonPay) {
                            self = .amazonPay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "au_becs_debit":
                        if let value = try container.decodeIfPresent(AuBecsDebit.self, forKey: .auBecsDebit) {
                            self = .auBecsDebit(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "bacs_debit":
                        if let value = try container.decodeIfPresent(BacsDebit.self, forKey: .bacsDebit) {
                            self = .bacsDebit(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "bancontact":
                        if let value = try container.decodeIfPresent(Bancontact.self, forKey: .bancontact) {
                            self = .bancontact(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "billie":
                        if let value = try container.decodeIfPresent(Billie.self, forKey: .billie) {
                            self = .billie(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "bizum":
                        if let value = try container.decodeIfPresent(Bizum.self, forKey: .bizum) {
                            self = .bizum(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "blik":
                        if let value = try container.decodeIfPresent(Blik.self, forKey: .blik) {
                            self = .blik(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "boleto":
                        if let value = try container.decodeIfPresent(Boleto.self, forKey: .boleto) {
                            self = .boleto(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "card":
                        if let value = try container.decodeIfPresent(Card.self, forKey: .card) {
                            self = .card(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "card_present":
                        if let value = try container.decodeIfPresent(Stripe.Shared.CardPresent.self, forKey: .cardPresent) {
                            self = .cardPresent(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "cashapp":
                        if let value = try container.decodeIfPresent(Cashapp.self, forKey: .cashapp) {
                            self = .cashapp(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "crypto":
                        if let value = try container.decodeIfPresent(Stripe.Shared.Crypto.self, forKey: .crypto) {
                            self = .crypto(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "customer_balance":
                        if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsCustomerBalance.self, forKey: .customerBalance)
                        {
                            self = .customerBalance(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "eps":
                        if let value = try container.decodeIfPresent(Eps.self, forKey: .eps) {
                            self = .eps(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "fpx":
                        if let value = try container.decodeIfPresent(Stripe.Shared.Fpx.self, forKey: .fpx) {
                            self = .fpx(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "giropay":
                        if let value = try container.decodeIfPresent(Giropay.self, forKey: .giropay) {
                            self = .giropay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "grabpay":
                        if let value = try container.decodeIfPresent(Stripe.Shared.Grabpay.self, forKey: .grabpay) {
                            self = .grabpay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "ideal":
                        if let value = try container.decodeIfPresent(Ideal.self, forKey: .ideal) {
                            self = .ideal(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "interac_present":
                        if let value = try container.decodeIfPresent(Stripe.Shared.InteracPresent.self, forKey: .interacPresent) {
                            self = .interacPresent(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "kakao_pay":
                        if let value = try container.decodeIfPresent(KakaoPay.self, forKey: .kakaoPay) {
                            self = .kakaoPay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "klarna":
                        if let value = try container.decodeIfPresent(Klarna.self, forKey: .klarna) {
                            self = .klarna(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "konbini":
                        if let value = try container.decodeIfPresent(Konbini.self, forKey: .konbini) {
                            self = .konbini(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "kr_card":
                        if let value = try container.decodeIfPresent(Stripe.Shared.KrCard.self, forKey: .krCard) {
                            self = .krCard(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "link":
                        if let value = try container.decodeIfPresent(Link.self, forKey: .link) {
                            self = .link(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "mb_way":
                        if let value = try container.decodeIfPresent(MbWay.self, forKey: .mbWay) {
                            self = .mbWay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "mobilepay":
                        if let value = try container.decodeIfPresent(Mobilepay.self, forKey: .mobilepay) {
                            self = .mobilepay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "multibanco":
                        if let value = try container.decodeIfPresent(Multibanco.self, forKey: .multibanco) {
                            self = .multibanco(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "naver_pay":
                        if let value = try container.decodeIfPresent(NaverPay.self, forKey: .naverPay) {
                            self = .naverPay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "nz_bank_account":
                        if let value = try container.decodeIfPresent(NzBankAccount.self, forKey: .nzBankAccount) {
                            self = .nzBankAccount(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "oxxo":
                        if let value = try container.decodeIfPresent(Oxxo.self, forKey: .oxxo) {
                            self = .oxxo(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "p24":
                        if let value = try container.decodeIfPresent(P24.self, forKey: .p24) {
                            self = .p24(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "pay_by_bank":
                        if let value = try container.decodeIfPresent(PayByBank.self, forKey: .payByBank) {
                            self = .payByBank(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "payco":
                        if let value = try container.decodeIfPresent(Payco.self, forKey: .payco) {
                            self = .payco(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "paynow":
                        if let value = try container.decodeIfPresent(Paynow.self, forKey: .paynow) {
                            self = .paynow(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "paypal":
                        if let value = try container.decodeIfPresent(Stripe.Shared.Paypal.self, forKey: .paypal) {
                            self = .paypal(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "payto":
                        if let value = try container.decodeIfPresent(Payto.self, forKey: .payto) {
                            self = .payto(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "pix":
                        if let value = try container.decodeIfPresent(Pix.self, forKey: .pix) {
                            self = .pix(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "promptpay":
                        if let value = try container.decodeIfPresent(Promptpay.self, forKey: .promptpay) {
                            self = .promptpay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "revolut_pay":
                        if let value = try container.decodeIfPresent(RevolutPay.self, forKey: .revolutPay) {
                            self = .revolutPay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "samsung_pay":
                        if let value = try container.decodeIfPresent(SamsungPay.self, forKey: .samsungPay) {
                            self = .samsungPay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "satispay":
                        if let value = try container.decodeIfPresent(Satispay.self, forKey: .satispay) {
                            self = .satispay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "scalapay":
                        if let value = try container.decodeIfPresent(Scalapay.self, forKey: .scalapay) {
                            self = .scalapay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "sepa_credit_transfer":
                        if let value = try container.decodeIfPresent(Stripe.Shared.SepaCreditTransfer.self, forKey: .sepaCreditTransfer) {
                            self = .sepaCreditTransfer(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "sepa_debit":
                        if let value = try container.decodeIfPresent(SepaDebit.self, forKey: .sepaDebit) {
                            self = .sepaDebit(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "sofort":
                        if let value = try container.decodeIfPresent(Sofort.self, forKey: .sofort) {
                            self = .sofort(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "stripe_account":
                        if let value = try container.decodeIfPresent(Stripe.Shared.StripeAccount.self, forKey: .stripeAccount) {
                            self = .stripeAccount(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "sunbit":
                        if let value = try container.decodeIfPresent(Sunbit.self, forKey: .sunbit) {
                            self = .sunbit(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "swish":
                        if let value = try container.decodeIfPresent(Swish.self, forKey: .swish) {
                            self = .swish(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "twint":
                        if let value = try container.decodeIfPresent(Twint.self, forKey: .twint) {
                            self = .twint(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "upi":
                        if let value = try container.decodeIfPresent(Upi.self, forKey: .upi) {
                            self = .upi(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "us_bank_account":
                        if let value = try container.decodeIfPresent(UsBankAccount.self, forKey: .usBankAccount) {
                            self = .usBankAccount(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "wechat":
                        if let value = try container.decodeIfPresent(Stripe.Shared.Wechat.self, forKey: .wechat) {
                            self = .wechat(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "wechat_pay":
                        if let value = try container.decodeIfPresent(WechatPay.self, forKey: .wechatPay) {
                            self = .wechatPay(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    case "zip":
                        if let value = try container.decodeIfPresent(Zip.self, forKey: .zip) {
                            self = .zip(value)
                        } else {
                            self = .unknown(type: type)
                        }
                    default: self = .unknown(type: type)
                    }
                }

                fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                    switch self {
                    case .achCreditTransfer(let value): try container.encode(value, forKey: .achCreditTransfer)
                    case .achDebit(let value): try container.encode(value, forKey: .achDebit)
                    case .acssDebit(let value): try container.encode(value, forKey: .acssDebit)
                    case .affirm(let value): try container.encode(value, forKey: .affirm)
                    case .afterpayClearpay(let value): try container.encode(value, forKey: .afterpayClearpay)
                    case .alipay(let value): try container.encode(value, forKey: .alipay)
                    case .alma(let value): try container.encode(value, forKey: .alma)
                    case .amazonPay(let value): try container.encode(value, forKey: .amazonPay)
                    case .auBecsDebit(let value): try container.encode(value, forKey: .auBecsDebit)
                    case .bacsDebit(let value): try container.encode(value, forKey: .bacsDebit)
                    case .bancontact(let value): try container.encode(value, forKey: .bancontact)
                    case .billie(let value): try container.encode(value, forKey: .billie)
                    case .bizum(let value): try container.encode(value, forKey: .bizum)
                    case .blik(let value): try container.encode(value, forKey: .blik)
                    case .boleto(let value): try container.encode(value, forKey: .boleto)
                    case .card(let value): try container.encode(value, forKey: .card)
                    case .cardPresent(let value): try container.encode(value, forKey: .cardPresent)
                    case .cashapp(let value): try container.encode(value, forKey: .cashapp)
                    case .crypto(let value): try container.encode(value, forKey: .crypto)
                    case .customerBalance(let value): try container.encode(value, forKey: .customerBalance)
                    case .eps(let value): try container.encode(value, forKey: .eps)
                    case .fpx(let value): try container.encode(value, forKey: .fpx)
                    case .giropay(let value): try container.encode(value, forKey: .giropay)
                    case .grabpay(let value): try container.encode(value, forKey: .grabpay)
                    case .ideal(let value): try container.encode(value, forKey: .ideal)
                    case .interacPresent(let value): try container.encode(value, forKey: .interacPresent)
                    case .kakaoPay(let value): try container.encode(value, forKey: .kakaoPay)
                    case .klarna(let value): try container.encode(value, forKey: .klarna)
                    case .konbini(let value): try container.encode(value, forKey: .konbini)
                    case .krCard(let value): try container.encode(value, forKey: .krCard)
                    case .link(let value): try container.encode(value, forKey: .link)
                    case .mbWay(let value): try container.encode(value, forKey: .mbWay)
                    case .mobilepay(let value): try container.encode(value, forKey: .mobilepay)
                    case .multibanco(let value): try container.encode(value, forKey: .multibanco)
                    case .naverPay(let value): try container.encode(value, forKey: .naverPay)
                    case .nzBankAccount(let value): try container.encode(value, forKey: .nzBankAccount)
                    case .oxxo(let value): try container.encode(value, forKey: .oxxo)
                    case .p24(let value): try container.encode(value, forKey: .p24)
                    case .payByBank(let value): try container.encode(value, forKey: .payByBank)
                    case .payco(let value): try container.encode(value, forKey: .payco)
                    case .paynow(let value): try container.encode(value, forKey: .paynow)
                    case .paypal(let value): try container.encode(value, forKey: .paypal)
                    case .payto(let value): try container.encode(value, forKey: .payto)
                    case .pix(let value): try container.encode(value, forKey: .pix)
                    case .promptpay(let value): try container.encode(value, forKey: .promptpay)
                    case .revolutPay(let value): try container.encode(value, forKey: .revolutPay)
                    case .samsungPay(let value): try container.encode(value, forKey: .samsungPay)
                    case .satispay(let value): try container.encode(value, forKey: .satispay)
                    case .scalapay(let value): try container.encode(value, forKey: .scalapay)
                    case .sepaCreditTransfer(let value): try container.encode(value, forKey: .sepaCreditTransfer)
                    case .sepaDebit(let value): try container.encode(value, forKey: .sepaDebit)
                    case .sofort(let value): try container.encode(value, forKey: .sofort)
                    case .stripeAccount(let value): try container.encode(value, forKey: .stripeAccount)
                    case .sunbit(let value): try container.encode(value, forKey: .sunbit)
                    case .swish(let value): try container.encode(value, forKey: .swish)
                    case .twint(let value): try container.encode(value, forKey: .twint)
                    case .upi(let value): try container.encode(value, forKey: .upi)
                    case .usBankAccount(let value): try container.encode(value, forKey: .usBankAccount)
                    case .wechat(let value): try container.encode(value, forKey: .wechat)
                    case .wechatPay(let value): try container.encode(value, forKey: .wechatPay)
                    case .zip(let value): try container.encode(value, forKey: .zip)
                    default: break
                    }
                }
            }
        }

        /// A list of refunds that have been applied to the charge.
        public struct Refunds: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [Stripe.Refunds.Refund]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [Stripe.Refunds.Refund]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }

        public struct TransferData: Codable, Hashable, Sendable {
            /// The amount transferred to the destination account, if specified.
            public var amount: Int?
            /// ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge.
            @Expandable<Stripe.Connect.Account, String> public var destination: String?

            public init(
                amount: Int? = nil,
                destination: String? = nil
            ) {
                self.amount = amount
                self._destination = Expandable(id: destination)
            }
        }
    }
}
