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

extension Stripe {
    public enum Shared {}
}

// funding_instructions_bank_transfer_aba_record
extension Stripe.Shared {
    /// ABA Records contain U.S.
    public struct Aba: Codable, Hashable, Sendable {
        public var accountHolderAddress: Address?
        /// The account holder name.
        public var accountHolderName: String?
        /// The ABA account number.
        public var accountNumber: String?
        /// The account type.
        public var accountType: String?
        public var bankAddress: Address?
        /// The bank name.
        public var bankName: String?
        /// The ABA routing number.
        public var routingNumber: String?

        public init(
            accountHolderAddress: Address? = nil,
            accountHolderName: String? = nil,
            accountNumber: String? = nil,
            accountType: String? = nil,
            bankAddress: Address? = nil,
            bankName: String? = nil,
            routingNumber: String? = nil
        ) {
            self.accountHolderAddress = accountHolderAddress
            self.accountHolderName = accountHolderName
            self.accountNumber = accountNumber
            self.accountType = accountType
            self.bankAddress = bankAddress
            self.bankName = bankName
            self.routingNumber = routingNumber
        }
    }
}

// bank_connections_resource_accountholder
extension Stripe.Shared {
    public struct AccountHolder: Codable, Hashable, Sendable {
        /// The ID of the Stripe account that this account belongs to.
        @Expandable<Stripe.Connect.Account, String> public var account: String?
        /// The ID for an Account representing a customer that this account belongs to.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        public var customerAccount: String?
        /// Type of account holder that this account belongs to.
        public var `type`: Type?

        public init(
            account: String? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            `type`: Type? = nil
        ) {
            self._account = Expandable(id: account)
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.`type` = `type`
        }

        /// Type of account holder that this account belongs to.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case account
            case customer
        }
    }
}

// payment_method_details_ach_credit_transfer
extension Stripe.Shared {
    public struct AchCreditTransfer: Codable, Hashable, Sendable {
        /// Account number to transfer funds to.
        public var accountNumber: String?
        /// Name of the bank associated with the routing number.
        public var bankName: String?
        /// Routing transit number for the bank account to transfer funds to.
        public var routingNumber: String?
        /// SWIFT code of the bank associated with the routing number.
        public var swiftCode: String?

        public init(
            accountNumber: String? = nil,
            bankName: String? = nil,
            routingNumber: String? = nil,
            swiftCode: String? = nil
        ) {
            self.accountNumber = accountNumber
            self.bankName = bankName
            self.routingNumber = routingNumber
            self.swiftCode = swiftCode
        }
    }
}

// payment_method_details_ach_debit
extension Stripe.Shared {
    public struct AchDebit: Codable, Hashable, Sendable {
        /// Type of entity that holds the account.
        public var accountHolderType: AccountHolderType?
        /// Name of the bank associated with the bank account.
        public var bankName: String?
        /// Two-letter ISO code representing the country the bank account is located in.
        public var country: String?
        /// Uniquely identifies this particular bank account.
        public var fingerprint: String?
        /// Last four digits of the bank account number.
        public var last4: String?
        /// Routing transit number of the bank account.
        public var routingNumber: String?

        public init(
            accountHolderType: AccountHolderType? = nil,
            bankName: String? = nil,
            country: String? = nil,
            fingerprint: String? = nil,
            last4: String? = nil,
            routingNumber: String? = nil
        ) {
            self.accountHolderType = accountHolderType
            self.bankName = bankName
            self.country = country
            self.fingerprint = fingerprint
            self.last4 = last4
            self.routingNumber = routingNumber
        }

        /// Type of entity that holds the account.
        public enum AccountHolderType: String, Codable, Hashable, Sendable {
            case company
            case individual
        }
    }
}

// invoice_payment_method_options_acss_debit
extension Stripe.Shared {
    public struct AcssDebit: Codable, Hashable, Sendable {
        public var mandateOptions: Stripe.Shared.InvoicePaymentMethodOptionsAcssDebitMandateOptions?
        /// Bank account verification method.
        public var verificationMethod: VerificationMethod?

        public init(
            mandateOptions: Stripe.Shared.InvoicePaymentMethodOptionsAcssDebitMandateOptions? = nil,
            verificationMethod: VerificationMethod? = nil
        ) {
            self.mandateOptions = mandateOptions
            self.verificationMethod = verificationMethod
        }

        /// Bank account verification method.
        public enum VerificationMethod: String, Codable, Hashable, Sendable {
            case automatic
            case instant
            case microdeposits
        }
    }
}

// tax_product_resource_postal_address
extension Stripe.Shared {
    public struct Address: Codable, Hashable, Sendable {
        /// City, district, suburb, town, or village.
        public var city: String?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String?
        /// Address line 1, such as the street, PO Box, or company name.
        public var line1: String?
        /// Address line 2, such as the apartment, suite, unit, or building.
        public var line2: String?
        /// ZIP or postal code.
        public var postalCode: String?
        /// State/province as an ISO 3166-2 subdivision code, without country prefix, such as "NY" or "TX".
        public var state: String?

        public init(
            city: String? = nil,
            country: String? = nil,
            line1: String? = nil,
            line2: String? = nil,
            postalCode: String? = nil,
            state: String? = nil
        ) {
            self.city = city
            self.country = country
            self.line1 = line1
            self.line2 = line2
            self.postalCode = postalCode
            self.state = state
        }
    }
}

// payment_method_affirm
extension Stripe.Shared {
    public struct Affirm: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_afterpay_clearpay
extension Stripe.Shared {
    public struct AfterpayClearpay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_flows_private_payment_methods_alipay
extension Stripe.Shared {
    public struct Alipay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_alma
extension Stripe.Shared {
    public struct Alma: Codable, Hashable, Sendable {
        public init() {}
    }
}

// account_requirements_alternative
extension Stripe.Shared {
    public struct Alternatives: Codable, Hashable, Sendable {
        /// Fields that can be provided to resolve all fields in `original_fields_due`.
        public var alternativeFieldsDue: [String]?
        /// Fields that are due and can be resolved by providing all fields in `alternative_fields_due`.
        public var originalFieldsDue: [String]?

        public init(
            alternativeFieldsDue: [String]? = nil,
            originalFieldsDue: [String]? = nil
        ) {
            self.alternativeFieldsDue = alternativeFieldsDue
            self.originalFieldsDue = originalFieldsDue
        }
    }
}

// payment_method_amazon_pay
extension Stripe.Shared {
    public struct AmazonPay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_card_wallet_amex_express_checkout
extension Stripe.Shared {
    public struct AmexExpressCheckout: Codable, Hashable, Sendable {
        public init() {}
    }
}

// api_errors
extension Stripe.Shared {
    public struct ApiErrors: Codable, Hashable, Sendable {
        /// For card errors resulting from a card issuer decline, a short string indicating how to proceed with an error if they.
        public var adviceCode: String?
        /// For card errors, the ID of the failed charge.
        public var charge: String?
        /// For some errors that could be handled programmatically, a short string indicating the error code reported.
        public var code: Code?
        /// For card errors resulting from a card issuer decline, a short string indicating the card issuer's reason for the.
        public var declineCode: String?
        /// A URL to more information about the error code reported.
        public var docUrl: String?
        /// A human-readable message providing more details about the error.
        public var message: String?
        /// For card errors resulting from a card issuer decline, a 2 digit code which indicates the advice given to merchant by.
        public var networkAdviceCode: String?
        /// For payments declined by the network, an alphanumeric code which indicates the reason the payment failed.
        public var networkDeclineCode: String?
        /// If the error is parameter-specific, the parameter related to the error.
        public var param: String?
        @Boxed public var paymentIntent: Stripe.PaymentIntents.PaymentIntent?
        @Boxed public var paymentMethod: Stripe.PaymentMethods.PaymentMethod?
        /// If the error is specific to the type of payment method, the payment method type that had a problem.
        public var paymentMethodType: String?
        /// A URL to the request log entry in your dashboard.
        public var requestLogUrl: String?
        @Boxed public var setupIntent: Stripe.Setup.Intent?
        @Boxed public var source: Stripe.PaymentSource?
        /// The type of error returned.
        public var `type`: Type?

        public init(
            adviceCode: String? = nil,
            charge: String? = nil,
            code: Code? = nil,
            declineCode: String? = nil,
            docUrl: String? = nil,
            message: String? = nil,
            networkAdviceCode: String? = nil,
            networkDeclineCode: String? = nil,
            param: String? = nil,
            paymentIntent: Stripe.PaymentIntents.PaymentIntent? = nil,
            paymentMethod: Stripe.PaymentMethods.PaymentMethod? = nil,
            paymentMethodType: String? = nil,
            requestLogUrl: String? = nil,
            setupIntent: Stripe.Setup.Intent? = nil,
            source: Stripe.PaymentSource? = nil,
            `type`: Type? = nil
        ) {
            self.adviceCode = adviceCode
            self.charge = charge
            self.code = code
            self.declineCode = declineCode
            self.docUrl = docUrl
            self.message = message
            self.networkAdviceCode = networkAdviceCode
            self.networkDeclineCode = networkDeclineCode
            self.param = param
            self._paymentIntent = Boxed(wrappedValue: paymentIntent)
            self._paymentMethod = Boxed(wrappedValue: paymentMethod)
            self.paymentMethodType = paymentMethodType
            self.requestLogUrl = requestLogUrl
            self._setupIntent = Boxed(wrappedValue: setupIntent)
            self._source = Boxed(wrappedValue: source)
            self.`type` = `type`
        }

        /// For some errors that could be handled programmatically, a short string indicating the error code reported.
        public enum Code: String, Codable, Hashable, Sendable {
            case accountClosed = "account_closed"
            case accountCountryInvalidAddress = "account_country_invalid_address"
            case accountErrorCountryChangeRequiresAdditionalSteps = "account_error_country_change_requires_additional_steps"
            case accountInformationMismatch = "account_information_mismatch"
            case accountInvalid = "account_invalid"
            case accountNumberInvalid = "account_number_invalid"
            case accountTokenRequiredForV2Account = "account_token_required_for_v2_account"
            case acssDebitSessionIncomplete = "acss_debit_session_incomplete"
            case actionBlocked = "action_blocked"
            case alipayUpgradeRequired = "alipay_upgrade_required"
            case amountTooLarge = "amount_too_large"
            case amountTooSmall = "amount_too_small"
            case anomalousMoneyMovementRequest = "anomalous_money_movement_request"
            case apiKeyExpired = "api_key_expired"
            case applicationFeesNotAllowed = "application_fees_not_allowed"
            case approvalRequired = "approval_required"
            case authenticationFailure = "authentication_failure"
            case authenticationRequired = "authentication_required"
            case balanceInsufficient = "balance_insufficient"
            case balanceInvalidParameter = "balance_invalid_parameter"
            case bankAccountBadRoutingNumbers = "bank_account_bad_routing_numbers"
            case bankAccountDeclined = "bank_account_declined"
            case bankAccountExists = "bank_account_exists"
            case bankAccountRestricted = "bank_account_restricted"
            case bankAccountUnusable = "bank_account_unusable"
            case bankAccountUnverified = "bank_account_unverified"
            case bankAccountVerificationFailed = "bank_account_verification_failed"
            case billingInvalidMandate = "billing_invalid_mandate"
            case bitcoinUpgradeRequired = "bitcoin_upgrade_required"
            case capabilityNotActive = "capability_not_active"
            case captureChargeAuthorizationExpired = "capture_charge_authorization_expired"
            case captureUnauthorizedPayment = "capture_unauthorized_payment"
            case cardDeclineRateLimitExceeded = "card_decline_rate_limit_exceeded"
            case cardDeclined = "card_declined"
            case cardholderPhoneNumberRequired = "cardholder_phone_number_required"
            case chargeAlreadyCaptured = "charge_already_captured"
            case chargeAlreadyRefunded = "charge_already_refunded"
            case chargeDisputed = "charge_disputed"
            case chargeExceedsSourceLimit = "charge_exceeds_source_limit"
            case chargeExceedsTransactionLimit = "charge_exceeds_transaction_limit"
            case chargeExpiredForCapture = "charge_expired_for_capture"
            case chargeInvalidParameter = "charge_invalid_parameter"
            case chargeNotRefundable = "charge_not_refundable"
            case clearingCodeUnsupported = "clearing_code_unsupported"
            case countryCodeInvalid = "country_code_invalid"
            case countryUnsupported = "country_unsupported"
            case couponExpired = "coupon_expired"
            case customerMaxPaymentMethods = "customer_max_payment_methods"
            case customerMaxSubscriptions = "customer_max_subscriptions"
            case customerSessionExpired = "customer_session_expired"
            case customerTaxLocationInvalid = "customer_tax_location_invalid"
            case debitNotAuthorized = "debit_not_authorized"
            case emailInvalid = "email_invalid"
            case expiredCard = "expired_card"
            case expiredPaymentMethod = "expired_payment_method"
            case failedTaxCalculation = "failed_tax_calculation"
            case financialAccountBalanceDoesNotSupportCurrency = "financial_account_balance_does_not_support_currency"
            case financialAccountCapabilityNotEnabled = "financial_account_capability_not_enabled"
            case financialAccountCapabilityRestricted = "financial_account_capability_restricted"
            case financialConnectionsAccountInactive = "financial_connections_account_inactive"
            case financialConnectionsAccountPendingAccountNumbers = "financial_connections_account_pending_account_numbers"
            case financialConnectionsAccountUnavailableAccountNumbers = "financial_connections_account_unavailable_account_numbers"
            case financialConnectionsNoSuccessfulTransactionRefresh = "financial_connections_no_successful_transaction_refresh"
            case forwardingApiInactive = "forwarding_api_inactive"
            case forwardingApiInvalidParameter = "forwarding_api_invalid_parameter"
            case forwardingApiRetryableUpstreamError = "forwarding_api_retryable_upstream_error"
            case forwardingApiUpstreamConnectionError = "forwarding_api_upstream_connection_error"
            case forwardingApiUpstreamConnectionTimeout = "forwarding_api_upstream_connection_timeout"
            case forwardingApiUpstreamError = "forwarding_api_upstream_error"
            case idempotencyKeyInUse = "idempotency_key_in_use"
            case incorrectAddress = "incorrect_address"
            case incorrectCvc = "incorrect_cvc"
            case incorrectNumber = "incorrect_number"
            case incorrectPostalCode = "incorrect_postal_code"
            case incorrectZip = "incorrect_zip"
            case indiaRecurringPaymentMandateCanceled = "india_recurring_payment_mandate_canceled"
            case instantPayoutsConfigDisabled = "instant_payouts_config_disabled"
            case instantPayoutsCurrencyDisabled = "instant_payouts_currency_disabled"
            case instantPayoutsLimitExceeded = "instant_payouts_limit_exceeded"
            case instantPayoutsUnsupported = "instant_payouts_unsupported"
            case insufficientFunds = "insufficient_funds"
            case intentInvalidState = "intent_invalid_state"
            case intentVerificationMethodMissing = "intent_verification_method_missing"
            case invalidCanceledSubscriptionFields = "invalid_canceled_subscription_fields"
            case invalidCardType = "invalid_card_type"
            case invalidCharacters = "invalid_characters"
            case invalidChargeAmount = "invalid_charge_amount"
            case invalidCvc = "invalid_cvc"
            case invalidExpiryMonth = "invalid_expiry_month"
            case invalidExpiryYear = "invalid_expiry_year"
            case invalidMandateReferencePrefixFormat = "invalid_mandate_reference_prefix_format"
            case invalidNumber = "invalid_number"
            case invalidSourceUsage = "invalid_source_usage"
            case invalidTaxLocation = "invalid_tax_location"
            case invoiceNoCustomerLineItems = "invoice_no_customer_line_items"
            case invoiceNoPaymentMethodTypes = "invoice_no_payment_method_types"
            case invoiceNoSubscriptionLineItems = "invoice_no_subscription_line_items"
            case invoiceNotEditable = "invoice_not_editable"
            case invoiceOnBehalfOfNotEditable = "invoice_on_behalf_of_not_editable"
            case invoicePaymentIntentRequiresAction = "invoice_payment_intent_requires_action"
            case invoiceUpcomingNone = "invoice_upcoming_none"
            case livemodeMismatch = "livemode_mismatch"
            case lockTimeout = "lock_timeout"
            case missing
            case noAccount = "no_account"
            case notAllowedOnStandardAccount = "not_allowed_on_standard_account"
            case outOfInventory = "out_of_inventory"
            case ownershipDeclarationNotAllowed = "ownership_declaration_not_allowed"
            case parameterInvalidEmpty = "parameter_invalid_empty"
            case parameterInvalidInteger = "parameter_invalid_integer"
            case parameterInvalidStringBlank = "parameter_invalid_string_blank"
            case parameterInvalidStringEmpty = "parameter_invalid_string_empty"
            case parameterMissing = "parameter_missing"
            case parameterUnknown = "parameter_unknown"
            case parametersExclusive = "parameters_exclusive"
            case paymentIntentActionRequired = "payment_intent_action_required"
            case paymentIntentAuthenticationFailure = "payment_intent_authentication_failure"
            case paymentIntentIncompatiblePaymentMethod = "payment_intent_incompatible_payment_method"
            case paymentIntentInvalidParameter = "payment_intent_invalid_parameter"
            case paymentIntentKonbiniRejectedConfirmationNumber = "payment_intent_konbini_rejected_confirmation_number"
            case paymentIntentMandateInvalid = "payment_intent_mandate_invalid"
            case paymentIntentPaymentAttemptExpired = "payment_intent_payment_attempt_expired"
            case paymentIntentPaymentAttemptFailed = "payment_intent_payment_attempt_failed"
            case paymentIntentRateLimitExceeded = "payment_intent_rate_limit_exceeded"
            case paymentIntentUnexpectedState = "payment_intent_unexpected_state"
            case paymentMethodBankAccountAlreadyVerified = "payment_method_bank_account_already_verified"
            case paymentMethodBankAccountBlocked = "payment_method_bank_account_blocked"
            case paymentMethodBillingDetailsAddressMissing = "payment_method_billing_details_address_missing"
            case paymentMethodConfigurationFailures = "payment_method_configuration_failures"
            case paymentMethodCurrencyMismatch = "payment_method_currency_mismatch"
            case paymentMethodCustomerDecline = "payment_method_customer_decline"
            case paymentMethodInvalidParameter = "payment_method_invalid_parameter"
            case paymentMethodInvalidParameterTestmode = "payment_method_invalid_parameter_testmode"
            case paymentMethodMicrodepositFailed = "payment_method_microdeposit_failed"
            case paymentMethodMicrodepositProcessingError = "payment_method_microdeposit_processing_error"
            case paymentMethodMicrodepositVerificationAmountsInvalid = "payment_method_microdeposit_verification_amounts_invalid"
            case paymentMethodMicrodepositVerificationAmountsMismatch = "payment_method_microdeposit_verification_amounts_mismatch"
            case paymentMethodMicrodepositVerificationAttemptsExceeded = "payment_method_microdeposit_verification_attempts_exceeded"
            case paymentMethodMicrodepositVerificationDescriptorCodeMismatch = "payment_method_microdeposit_verification_descriptor_code_mismatch"
            case paymentMethodMicrodepositVerificationTimeout = "payment_method_microdeposit_verification_timeout"
            case paymentMethodNotAvailable = "payment_method_not_available"
            case paymentMethodProviderDecline = "payment_method_provider_decline"
            case paymentMethodProviderTimeout = "payment_method_provider_timeout"
            case paymentMethodRestricted = "payment_method_restricted"
            case paymentMethodUnactivated = "payment_method_unactivated"
            case paymentMethodUnexpectedState = "payment_method_unexpected_state"
            case paymentMethodUnsupportedType = "payment_method_unsupported_type"
            case payoutReconciliationNotReady = "payout_reconciliation_not_ready"
            case payoutsLimitExceeded = "payouts_limit_exceeded"
            case payoutsNotAllowed = "payouts_not_allowed"
            case platformAccountRequired = "platform_account_required"
            case platformApiKeyExpired = "platform_api_key_expired"
            case postalCodeInvalid = "postal_code_invalid"
            case processingError = "processing_error"
            case productInactive = "product_inactive"
            case progressiveOnboardingLimitExceeded = "progressive_onboarding_limit_exceeded"
            case rateLimit = "rate_limit"
            case referToCustomer = "refer_to_customer"
            case refundDisputedPayment = "refund_disputed_payment"
            case requestBlocked = "request_blocked"
            case resourceAlreadyExists = "resource_already_exists"
            case resourceMissing = "resource_missing"
            case returnIntentAlreadyProcessed = "return_intent_already_processed"
            case routingNumberInvalid = "routing_number_invalid"
            case secretKeyRequired = "secret_key_required"
            case sepaUnsupportedAccount = "sepa_unsupported_account"
            case servicePeriodCouponWithMeteredTieredItemUnsupported = "service_period_coupon_with_metered_tiered_item_unsupported"
            case setupAttemptFailed = "setup_attempt_failed"
            case setupIntentAuthenticationFailure = "setup_intent_authentication_failure"
            case setupIntentInvalidParameter = "setup_intent_invalid_parameter"
            case setupIntentMandateInvalid = "setup_intent_mandate_invalid"
            case setupIntentMobileWalletUnsupported = "setup_intent_mobile_wallet_unsupported"
            case setupIntentSetupAttemptExpired = "setup_intent_setup_attempt_expired"
            case setupIntentUnexpectedState = "setup_intent_unexpected_state"
            case shippingAddressInvalid = "shipping_address_invalid"
            case shippingCalculationFailed = "shipping_calculation_failed"
            case siretInvalid = "siret_invalid"
            case skuInactive = "sku_inactive"
            case stateUnsupported = "state_unsupported"
            case statusTransitionInvalid = "status_transition_invalid"
            case storerCapabilityMissing = "storer_capability_missing"
            case storerCapabilityNotActive = "storer_capability_not_active"
            case stripeTaxInactive = "stripe_tax_inactive"
            case taxIdInvalid = "tax_id_invalid"
            case taxIdProhibited = "tax_id_prohibited"
            case taxesCalculationFailed = "taxes_calculation_failed"
            case terminalLocationCountryUnsupported = "terminal_location_country_unsupported"
            case terminalReaderBusy = "terminal_reader_busy"
            case terminalReaderHardwareFault = "terminal_reader_hardware_fault"
            case terminalReaderInvalidLocationForActivation = "terminal_reader_invalid_location_for_activation"
            case terminalReaderInvalidLocationForPayment = "terminal_reader_invalid_location_for_payment"
            case terminalReaderOffline = "terminal_reader_offline"
            case terminalReaderTimeout = "terminal_reader_timeout"
            case testmodeChargesOnly = "testmode_charges_only"
            case tlsVersionUnsupported = "tls_version_unsupported"
            case tokenAlreadyUsed = "token_already_used"
            case tokenCardNetworkInvalid = "token_card_network_invalid"
            case tokenInUse = "token_in_use"
            case transferSourceBalanceParametersMismatch = "transfer_source_balance_parameters_mismatch"
            case transfersNotAllowed = "transfers_not_allowed"
            case urlInvalid = "url_invalid"
        }

        /// The type of error returned.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case apiError = "api_error"
            case cardError = "card_error"
            case idempotencyError = "idempotency_error"
            case invalidRequestError = "invalid_request_error"
        }
    }
}

// payment_method_details_card_wallet_apple_pay
extension Stripe.Shared {
    public struct ApplePay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// application
extension Stripe.Shared {
    public struct Application: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The name of the application.
        public var name: String?

        public init(
            id: ID,
            object: String,
            name: String? = nil
        ) {
            self.id = id
            self.object = object
            self.name = name
        }
    }
}

// payment_method_au_becs_debit
extension Stripe.Shared {
    public struct AuBecsDebit: Codable, Hashable, Sendable {
        /// Six-digit number identifying bank and branch associated with this bank account.
        public var bsbNumber: String?
        /// Uniquely identifies this particular bank account.
        public var fingerprint: String?
        /// Last four digits of the bank account number.
        public var last4: String?

        public init(
            bsbNumber: String? = nil,
            fingerprint: String? = nil,
            last4: String? = nil
        ) {
            self.bsbNumber = bsbNumber
            self.fingerprint = fingerprint
            self.last4 = last4
        }
    }
}

// payment_method_bacs_debit
extension Stripe.Shared {
    public struct BacsDebit: Codable, Hashable, Sendable {
        /// Uniquely identifies this particular bank account.
        public var fingerprint: String?
        /// Last four digits of the bank account number.
        public var last4: String?
        /// Sort code of the bank account.
        public var sortCode: String?

        public init(
            fingerprint: String? = nil,
            last4: String? = nil,
            sortCode: String? = nil
        ) {
            self.fingerprint = fingerprint
            self.last4 = last4
            self.sortCode = sortCode
        }
    }
}

// treasury_transactions_resource_balance_impact
extension Stripe.Shared {
    /// Change to a FinancialAccount's balance.
    public struct BalanceImpact: Codable, Hashable, Sendable {
        /// The change made to funds the user can spend right now.
        public var cash: Int?
        /// The change made to funds that are not spendable yet, but will become available at a later time.
        public var inboundPending: Int?
        /// The change made to funds in the account, but not spendable because they are being held for pending outbound flows.
        public var outboundPending: Int?

        public init(
            cash: Int? = nil,
            inboundPending: Int? = nil,
            outboundPending: Int? = nil
        ) {
            self.cash = cash
            self.inboundPending = inboundPending
            self.outboundPending = outboundPending
        }
    }
}

// invoice_payment_method_options_bancontact
extension Stripe.Shared {
    public struct Bancontact: Codable, Hashable, Sendable {
        /// Preferred language of the Bancontact authorization page that the customer is redirected to.
        public var preferredLanguage: PreferredLanguage?

        public init(
            preferredLanguage: PreferredLanguage? = nil
        ) {
            self.preferredLanguage = preferredLanguage
        }

        /// Preferred language of the Bancontact authorization page that the customer is redirected to.
        public enum PreferredLanguage: String, Codable, Hashable, Sendable {
            case de
            case en
            case fr
            case nl
        }
    }
}

// invoice_payment_method_options_customer_balance_bank_transfer
extension Stripe.Shared {
    public struct BankTransfer: Codable, Hashable, Sendable {
        public var euBankTransfer: Stripe.Shared.InvoicePaymentMethodOptionsCustomerBalanceBankTransferEuBankTransfer?
        /// The bank transfer type that can be used for funding.
        public var `type`: String?

        public init(
            euBankTransfer: Stripe.Shared.InvoicePaymentMethodOptionsCustomerBalanceBankTransferEuBankTransfer? = nil,
            `type`: String? = nil
        ) {
            self.euBankTransfer = euBankTransfer
            self.`type` = `type`
        }
    }
}

// payment_method_billie
extension Stripe.Shared {
    public struct Billie: Codable, Hashable, Sendable {
        public init() {}
    }
}

// billing_bill_resource_invoicing_taxes_tax
extension Stripe.Shared {
    public struct BillingBillResourceInvoicingTaxesTax: Codable, Hashable, Sendable {
        /// The amount of the tax, in cents (or local equivalent).
        public var amount: Int?
        /// Whether this tax is inclusive or exclusive.
        public var taxBehavior: TaxBehavior?
        /// Additional details about the tax rate.
        public var taxRateDetails: Stripe.Shared.TaxRateDetails?
        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public var taxabilityReason: TaxabilityReason?
        /// The amount on which tax is calculated, in cents (or local equivalent).
        public var taxableAmount: Int?
        /// The type of tax information.
        public var `type`: String?

        public init(
            amount: Int? = nil,
            taxBehavior: TaxBehavior? = nil,
            taxRateDetails: Stripe.Shared.TaxRateDetails? = nil,
            taxabilityReason: TaxabilityReason? = nil,
            taxableAmount: Int? = nil,
            `type`: String? = nil
        ) {
            self.amount = amount
            self.taxBehavior = taxBehavior
            self.taxRateDetails = taxRateDetails
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
            self.`type` = `type`
        }

        /// Whether this tax is inclusive or exclusive.
        public enum TaxBehavior: String, Codable, Hashable, Sendable {
            case exclusive
            case inclusive
        }

        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public enum TaxabilityReason: String, Codable, Hashable, Sendable {
            case customerExempt = "customer_exempt"
            case notAvailable = "not_available"
            case notCollecting = "not_collecting"
            case notSubjectToTax = "not_subject_to_tax"
            case notSupported = "not_supported"
            case portionProductExempt = "portion_product_exempt"
            case portionReducedRated = "portion_reduced_rated"
            case portionStandardRated = "portion_standard_rated"
            case productExempt = "product_exempt"
            case productExemptHoliday = "product_exempt_holiday"
            case proportionallyRated = "proportionally_rated"
            case reducedRated = "reduced_rated"
            case reverseCharge = "reverse_charge"
            case standardRated = "standard_rated"
            case taxableBasisReduced = "taxable_basis_reduced"
            case zeroRated = "zero_rated"
        }
    }
}

// billing_credit_grants_resource_amount
extension Stripe.Shared {
    public struct BillingCreditGrantsResourceAmount: Codable, Hashable, Sendable {
        /// The monetary amount.
        public var monetary: Stripe.Shared.Monetary?
        /// The type of this amount.
        public var `type`: String?

        public init(
            monetary: Stripe.Shared.Monetary? = nil,
            `type`: String? = nil
        ) {
            self.monetary = monetary
            self.`type` = `type`
        }
    }
}

// billing_details
extension Stripe.Shared {
    public struct BillingDetails: Codable, Hashable, Sendable {
        /// Billing address.
        public var address: Address?
        /// Email address.
        public var email: String?
        /// Full name.
        public var name: String?
        /// Billing phone number (including extension).
        public var phone: String?
        /// Taxpayer identification number.
        public var taxId: String?

        public init(
            address: Address? = nil,
            email: String? = nil,
            name: String? = nil,
            phone: String? = nil,
            taxId: String? = nil
        ) {
            self.address = address
            self.email = email
            self.name = name
            self.phone = phone
            self.taxId = taxId
        }
    }
}

// subscriptions_resource_billing_mode
extension Stripe.Shared {
    /// The billing mode of the subscription.
    public struct BillingMode: Codable, Hashable, Sendable {
        /// Configure behavior for flexible billing mode.
        public var flexible: Stripe.Shared.Flexible?
        /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
        public var `type`: Type?
        /// Details on when the current billing_mode was adopted.
        public var updatedAt: Date?

        public init(
            flexible: Stripe.Shared.Flexible? = nil,
            `type`: Type? = nil,
            updatedAt: Date? = nil
        ) {
            self.flexible = flexible
            self.`type` = `type`
            self.updatedAt = updatedAt
        }

        /// Controls how prorations and invoices for subscriptions are calculated and orchestrated.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case classic
            case flexible
        }
    }
}

// subscription_billing_thresholds
extension Stripe.Shared {
    public struct BillingThresholds: Codable, Hashable, Sendable {
        /// Monetary threshold that triggers the subscription to create an invoice.
        public var amountGte: Int?
        /// Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached.
        public var resetBillingCycleAnchor: Bool?

        public init(
            amountGte: Int? = nil,
            resetBillingCycleAnchor: Bool? = nil
        ) {
            self.amountGte = amountGte
            self.resetBillingCycleAnchor = resetBillingCycleAnchor
        }
    }
}

// payment_method_bizum
extension Stripe.Shared {
    public struct Bizum: Codable, Hashable, Sendable {
        /// A unique identifier for the buyer as determined by the local payment processor.
        public var buyerId: String?

        public init(
            buyerId: String? = nil
        ) {
            self.buyerId = buyerId
        }
    }
}

// payment_method_blik
extension Stripe.Shared {
    public struct Blik: Codable, Hashable, Sendable {
        /// A unique and immutable identifier assigned by BLIK to every buyer.
        public var buyerId: String?

        public init(
            buyerId: String? = nil
        ) {
            self.buyerId = buyerId
        }
    }
}

// payment_intent_next_action_blik_authorize
extension Stripe.Shared {
    public struct BlikAuthorize: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_us_bank_account_blocked
extension Stripe.Shared {
    public struct Blocked: Codable, Hashable, Sendable {
        /// The ACH network code that resulted in this block.
        public var networkCode: NetworkCode?
        /// The reason why this PaymentMethod's fingerprint has been blocked.
        public var reason: Reason?

        public init(
            networkCode: NetworkCode? = nil,
            reason: Reason? = nil
        ) {
            self.networkCode = networkCode
            self.reason = reason
        }

        /// The ACH network code that resulted in this block.
        public enum NetworkCode: String, Codable, Hashable, Sendable {
            case R02
            case R03
            case R04
            case R05
            case R07
            case R08
            case R10
            case R11
            case R16
            case R20
            case R29
            case R31
        }

        /// The reason why this PaymentMethod's fingerprint has been blocked.
        public enum Reason: String, Codable, Hashable, Sendable {
            case bankAccountClosed = "bank_account_closed"
            case bankAccountFrozen = "bank_account_frozen"
            case bankAccountInvalidDetails = "bank_account_invalid_details"
            case bankAccountRestricted = "bank_account_restricted"
            case bankAccountUnusable = "bank_account_unusable"
            case debitNotAuthorized = "debit_not_authorized"
            case tokenizedAccountNumberDeactivated = "tokenized_account_number_deactivated"
        }
    }
}

// payment_method_boleto
extension Stripe.Shared {
    public struct Boleto: Codable, Hashable, Sendable {
        /// Uniquely identifies the customer tax id (CNPJ or CPF).
        public var taxId: String?

        public init(
            taxId: String? = nil
        ) {
            self.taxId = taxId
        }
    }
}

// payment_method_card
extension Stripe.Shared {
    public struct Card: Codable, Hashable, Sendable {
        /// Card brand.
        public var brand: String?
        /// Checks on Card address and CVC if provided.
        public var checks: Stripe.Shared.Checks?
        /// Two-letter ISO code representing the country of the card.
        public var country: String?
        /// A high-level description of the type of cards issued in this range.
        public var description: String?
        /// The brand to use when displaying the card, this accounts for customer's brand choice on dual-branded cards.
        public var displayBrand: String?
        /// Two-digit number representing the card's expiration month.
        public var expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public var expYear: Int?
        /// Uniquely identifies this particular card number.
        public var fingerprint: String?
        /// Card funding type.
        public var funding: String?
        /// Details of the original PaymentMethod that created this object.
        public var generatedFrom: Stripe.Shared.GeneratedFrom?
        /// Issuer identification number of the card.
        public var iin: String?
        /// The name of the card's issuing bank.
        public var issuer: String?
        /// The last four digits of the card.
        public var last4: String?
        /// Contains information about card networks that can be used to process the payment.
        public var networks: Stripe.Shared.Networks?
        /// Status of a card based on the card issuer.
        public var regulatedStatus: RegulatedStatus?
        /// Contains details on how this Card may be used for 3D Secure authentication.
        public var threeDSecureUsage: Stripe.Shared.ThreeDSecureUsage?
        /// If this Card is part of a card wallet, this contains the details of the card wallet.
        public var wallet: Stripe.Shared.PaymentMethodCardWallet?

        public init(
            brand: String? = nil,
            checks: Stripe.Shared.Checks? = nil,
            country: String? = nil,
            description: String? = nil,
            displayBrand: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            fingerprint: String? = nil,
            funding: String? = nil,
            generatedFrom: Stripe.Shared.GeneratedFrom? = nil,
            iin: String? = nil,
            issuer: String? = nil,
            last4: String? = nil,
            networks: Stripe.Shared.Networks? = nil,
            regulatedStatus: RegulatedStatus? = nil,
            threeDSecureUsage: Stripe.Shared.ThreeDSecureUsage? = nil,
            wallet: Stripe.Shared.PaymentMethodCardWallet? = nil
        ) {
            self.brand = brand
            self.checks = checks
            self.country = country
            self.description = description
            self.displayBrand = displayBrand
            self.expMonth = expMonth
            self.expYear = expYear
            self.fingerprint = fingerprint
            self.funding = funding
            self.generatedFrom = generatedFrom
            self.iin = iin
            self.issuer = issuer
            self.last4 = last4
            self.networks = networks
            self.regulatedStatus = regulatedStatus
            self.threeDSecureUsage = threeDSecureUsage
            self.wallet = wallet
        }

        /// Status of a card based on the card issuer.
        public enum RegulatedStatus: String, Codable, Hashable, Sendable {
            case regulated
            case unregulated
        }
    }
}

// payment_method_details_card_present
extension Stripe.Shared {
    public struct CardPresent: Codable, Hashable, Sendable {
        /// The authorized amount.
        public var amountAuthorized: Int?
        /// Card brand.
        public var brand: String?
        /// The product code that identifies the specific program or product associated with a card.
        public var brandProduct: String?
        /// When using manual capture, a future timestamp after which the charge will be automatically refunded if uncaptured.
        public var captureBefore: Date?
        /// The cardholder name as read from the card, in ISO 7813 format.
        public var cardholderName: String?
        /// Two-letter ISO code representing the country of the card.
        public var country: String?
        /// A high-level description of the type of cards issued in this range.
        public var description: String?
        /// Authorization response cryptogram.
        public var emvAuthData: String?
        /// Two-digit number representing the card's expiration month.
        public var expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public var expYear: Int?
        /// Uniquely identifies this particular card number.
        public var fingerprint: String?
        /// Card funding type.
        public var funding: String?
        /// ID of a card PaymentMethod generated from the card_present PaymentMethod that may be attached to a Customer for.
        public var generatedCard: String?
        /// Issuer identification number of the card.
        public var iin: String?
        /// Whether this PaymentIntent is eligible for incremental authorizations.
        public var incrementalAuthorizationSupported: Bool?
        /// The name of the card's issuing bank.
        public var issuer: String?
        /// The last four digits of the card.
        public var last4: String?
        /// ID of the location that this transaction's reader is assigned to.
        public var location: String?
        /// Identifies which network this charge was processed on.
        public var network: String?
        /// This is used by the financial networks to identify a transaction.
        public var networkTransactionId: String?
        /// Details about payments collected offline.
        public var offline: Stripe.Shared.Offline?
        /// Defines whether the authorized amount can be over-captured or not.
        public var overcaptureSupported: Bool?
        /// The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card.
        public var preferredLocales: [String]?
        /// How card details were read in this transaction.
        public var readMethod: ReadMethod?
        /// ID of the reader this transaction was made on.
        public var reader: String?
        /// A collection of fields required to be displayed on receipts.
        public var receipt: Stripe.Shared.Receipt?
        public var wallet: Stripe.Shared.Wallet?

        public init(
            amountAuthorized: Int? = nil,
            brand: String? = nil,
            brandProduct: String? = nil,
            captureBefore: Date? = nil,
            cardholderName: String? = nil,
            country: String? = nil,
            description: String? = nil,
            emvAuthData: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            fingerprint: String? = nil,
            funding: String? = nil,
            generatedCard: String? = nil,
            iin: String? = nil,
            incrementalAuthorizationSupported: Bool? = nil,
            issuer: String? = nil,
            last4: String? = nil,
            location: String? = nil,
            network: String? = nil,
            networkTransactionId: String? = nil,
            offline: Stripe.Shared.Offline? = nil,
            overcaptureSupported: Bool? = nil,
            preferredLocales: [String]? = nil,
            readMethod: ReadMethod? = nil,
            reader: String? = nil,
            receipt: Stripe.Shared.Receipt? = nil,
            wallet: Stripe.Shared.Wallet? = nil
        ) {
            self.amountAuthorized = amountAuthorized
            self.brand = brand
            self.brandProduct = brandProduct
            self.captureBefore = captureBefore
            self.cardholderName = cardholderName
            self.country = country
            self.description = description
            self.emvAuthData = emvAuthData
            self.expMonth = expMonth
            self.expYear = expYear
            self.fingerprint = fingerprint
            self.funding = funding
            self.generatedCard = generatedCard
            self.iin = iin
            self.incrementalAuthorizationSupported = incrementalAuthorizationSupported
            self.issuer = issuer
            self.last4 = last4
            self.location = location
            self.network = network
            self.networkTransactionId = networkTransactionId
            self.offline = offline
            self.overcaptureSupported = overcaptureSupported
            self.preferredLocales = preferredLocales
            self.readMethod = readMethod
            self.reader = reader
            self.receipt = receipt
            self.wallet = wallet
        }

        /// How card details were read in this transaction.
        public enum ReadMethod: String, Codable, Hashable, Sendable {
            case contactEmv = "contact_emv"
            case contactlessEmv = "contactless_emv"
            case contactlessMagstripeMode = "contactless_magstripe_mode"
            case magneticStripeFallback = "magnetic_stripe_fallback"
            case magneticStripeTrack2 = "magnetic_stripe_track2"
        }
    }
}

// payment_method_cashapp
extension Stripe.Shared {
    public struct Cashapp: Codable, Hashable, Sendable {
        /// A unique and immutable identifier assigned by Cash App to every buyer.
        public var buyerId: String?
        /// A public identifier for buyers using Cash App.
        public var cashtag: String?

        public init(
            buyerId: String? = nil,
            cashtag: String? = nil
        ) {
            self.buyerId = buyerId
            self.cashtag = cashtag
        }
    }
}

// payment_intent_next_action_cashapp_handle_redirect_or_display_qr_code
extension Stripe.Shared {
    public struct CashappHandleRedirectOrDisplayQrCode: Codable, Hashable, Sendable {
        /// The URL to the hosted Cash App Pay instructions page, which allows customers to view the QR code, and supports QR.
        public var hostedInstructionsUrl: String?
        /// The url for mobile redirect based auth.
        public var mobileAuthUrl: String?
        public var qrCode: Stripe.Shared.QrCode?

        public init(
            hostedInstructionsUrl: String? = nil,
            mobileAuthUrl: String? = nil,
            qrCode: Stripe.Shared.QrCode? = nil
        ) {
            self.hostedInstructionsUrl = hostedInstructionsUrl
            self.mobileAuthUrl = mobileAuthUrl
            self.qrCode = qrCode
        }
    }
}

// payment_method_card_checks
extension Stripe.Shared {
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
}

// climate_removals_location
extension Stripe.Shared {
    public struct ClimateRemovalsLocation: Codable, Hashable, Sendable {
        /// The city where the supplier is located.
        public var city: String?
        /// Two-letter ISO code representing the country where the supplier is located.
        public var country: String?
        /// The geographic latitude where the supplier is located.
        public var latitude: Double?
        /// The geographic longitude where the supplier is located.
        public var longitude: Double?
        /// The state/county/province/region where the supplier is located.
        public var region: String?

        public init(
            city: String? = nil,
            country: String? = nil,
            latitude: Double? = nil,
            longitude: Double? = nil,
            region: String? = nil
        ) {
            self.city = city
            self.country = country
            self.latitude = latitude
            self.longitude = longitude
            self.region = region
        }
    }
}

// connect_account_reference
extension Stripe.Shared {
    public struct ConnectAccountReference: Codable, Hashable, Sendable {
        /// The connected account being referenced when `type` is `account`.
        @Expandable<Stripe.Connect.Account, String> public var account: String?
        /// Type of the account referenced.
        public var `type`: Type?

        public init(
            account: String? = nil,
            `type`: Type? = nil
        ) {
            self._account = Expandable(id: account)
            self.`type` = `type`
        }

        /// Type of the account referenced.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case account
            case `self`
        }
    }
}

// payment_method_details_crypto
extension Stripe.Shared {
    public struct Crypto: Codable, Hashable, Sendable {
        /// The wallet address of the customer.
        public var buyerAddress: String?
        /// The blockchain network that the transaction was sent on.
        public var network: Network?
        /// The token currency that the transaction was sent with.
        public var tokenCurrency: TokenCurrency?
        /// The blockchain transaction hash of the crypto payment.
        public var transactionHash: String?

        public init(
            buyerAddress: String? = nil,
            network: Network? = nil,
            tokenCurrency: TokenCurrency? = nil,
            transactionHash: String? = nil
        ) {
            self.buyerAddress = buyerAddress
            self.network = network
            self.tokenCurrency = tokenCurrency
            self.transactionHash = transactionHash
        }

        /// The blockchain network that the transaction was sent on.
        public enum Network: String, Codable, Hashable, Sendable {
            case base
            case ethereum
            case polygon
            case solana
            case sui
            case tempo
        }

        /// The token currency that the transaction was sent with.
        public enum TokenCurrency: String, Codable, Hashable, Sendable {
            case phantomCash = "phantom_cash"
            case usdc
            case usdg
            case usdp
            case usdsui
            case usdt
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_custom_details
extension Stripe.Shared {
    /// Custom Payment Methods represent Payment Method types not modeled directly in the Stripe API.
    public struct Custom: Codable, Hashable, Sendable {
        /// Display name for the custom (user-defined) payment method type used to make this payment.
        public var displayName: String?
        /// The custom payment method type associated with this payment.
        public var `type`: String?

        public init(
            displayName: String? = nil,
            `type`: String? = nil
        ) {
            self.displayName = displayName
            self.`type` = `type`
        }
    }
}

// invoice_setting_custom_field
extension Stripe.Shared {
    public struct CustomFields: Codable, Hashable, Sendable {
        /// The name of the custom field.
        public var name: String?
        /// The value of the custom field.
        public var value: String?

        public init(
            name: String? = nil,
            value: String? = nil
        ) {
            self.name = name
            self.value = value
        }
    }
}

// invoice_payment_method_options_customer_balance
extension Stripe.Shared {
    public struct CustomerBalance: Codable, Hashable, Sendable {
        public var bankTransfer: Stripe.Shared.BankTransfer?
        /// The funding method type to be used when there are not enough funds in the customer balance.
        public var fundingType: String?

        public init(
            bankTransfer: Stripe.Shared.BankTransfer? = nil,
            fundingType: String? = nil
        ) {
            self.bankTransfer = bankTransfer
            self.fundingType = fundingType
        }
    }
}

// tax_product_resource_customer_details
extension Stripe.Shared {
    public struct CustomerDetails: Codable, Hashable, Sendable {
        /// The customer's postal address (for example, home or business location).
        public var address: Stripe.Shared.Address?
        /// The type of customer address provided.
        public var addressSource: AddressSource?
        /// The customer's IP address (IPv4 or IPv6).
        public var ipAddress: String?
        /// The customer's tax IDs (for example, EU VAT numbers).
        public var taxIds: [Stripe.Shared.TaxIds]?
        /// The taxability override used for taxation.
        public var taxabilityOverride: TaxabilityOverride?

        public init(
            address: Stripe.Shared.Address? = nil,
            addressSource: AddressSource? = nil,
            ipAddress: String? = nil,
            taxIds: [Stripe.Shared.TaxIds]? = nil,
            taxabilityOverride: TaxabilityOverride? = nil
        ) {
            self.address = address
            self.addressSource = addressSource
            self.ipAddress = ipAddress
            self.taxIds = taxIds
            self.taxabilityOverride = taxabilityOverride
        }

        /// The type of customer address provided.
        public enum AddressSource: String, Codable, Hashable, Sendable {
            case billing
            case shipping
        }

        /// The taxability override used for taxation.
        public enum TaxabilityOverride: String, Codable, Hashable, Sendable {
            case customerExempt = "customer_exempt"
            case none
            case reverseCharge = "reverse_charge"
        }
    }
}

// discount
extension Stripe.Shared {
    /// A discount represents the actual application of a coupon or promotion code.
    public struct Discount: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode.
        public var checkoutSession: String?
        /// The ID of the customer associated with this discount.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// The ID of the account representing the customer associated with this discount.
        public var customerAccount: String?
        /// If the coupon has a duration of `repeating`, the date that this discount will end.
        public var end: Date?
        /// The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice.
        public var invoice: String?
        /// The invoice item `id` (or invoice line item `id` for invoice line items of type='subscription') that the discount's.
        public var invoiceItem: String?
        /// The promotion code applied to create this discount.
        @Expandable<Promotion.Code, String> public var promotionCode: String?
        public var source: Stripe.Shared.Source?
        /// Date that the coupon was applied.
        public var start: Date?
        /// The subscription that this coupon is applied to, if it is applied to a particular subscription.
        public var subscription: String?
        /// The subscription item that this coupon is applied to, if it is applied to a particular subscription item.
        public var subscriptionItem: String?

        public init(
            id: ID,
            object: String,
            checkoutSession: String? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            end: Date? = nil,
            invoice: String? = nil,
            invoiceItem: String? = nil,
            promotionCode: String? = nil,
            source: Stripe.Shared.Source? = nil,
            start: Date? = nil,
            subscription: String? = nil,
            subscriptionItem: String? = nil
        ) {
            self.id = id
            self.object = object
            self.checkoutSession = checkoutSession
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.end = end
            self.invoice = invoice
            self.invoiceItem = invoiceItem
            self._promotionCode = Expandable(id: promotionCode)
            self.source = source
            self.start = start
            self.subscription = subscription
            self.subscriptionItem = subscriptionItem
        }
    }
}

// line_items_discount_amount
extension Stripe.Shared {
    public struct Discounts: Codable, Hashable, Sendable {
        /// The amount discounted.
        public var amount: Int?
        public var discount: Stripe.Shared.Discount?

        public init(
            amount: Int? = nil,
            discount: Stripe.Shared.Discount? = nil
        ) {
            self.amount = amount
            self.discount = discount
        }
    }
}

// discounts_resource_discount_amount
extension Stripe.Shared {
    public struct DiscountsResourceDiscountAmount: Codable, Hashable, Sendable {
        /// The amount, in cents (or local equivalent), of the discount.
        public var amount: Int?
        /// The discount that was applied to get this discount amount.
        @Expandable<Stripe.Shared.Discount, String> public var discount: String?

        public init(
            amount: Int? = nil,
            discount: String? = nil
        ) {
            self.amount = amount
            self._discount = Expandable(id: discount)
        }
    }
}

// payment_flows_private_payment_methods_klarna_dob
extension Stripe.Shared {
    public struct Dob: Codable, Hashable, Sendable {
        /// The day of birth, between 1 and 31.
        public var day: Int?
        /// The month of birth, between 1 and 12.
        public var month: Int?
        /// The four-digit year of birth.
        public var year: Int?

        public init(
            day: Int? = nil,
            month: Int? = nil,
            year: Int? = nil
        ) {
            self.day = day
            self.month = month
            self.year = year
        }
    }
}

// payment_method_eps
extension Stripe.Shared {
    public struct Eps: Codable, Hashable, Sendable {
        /// The customer's bank.
        public var bank: Bank?

        public init(
            bank: Bank? = nil
        ) {
            self.bank = bank
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
}

// account_requirements_error
extension Stripe.Shared {
    public struct Errors: Codable, Hashable, Sendable {
        /// The code for the type of error.
        public var code: Code?
        /// An informative message that indicates the error type and provides additional details about the error.
        public var reason: String?
        /// The specific user onboarding requirement field (in the requirements hash) that needs to be resolved.
        public var requirement: String?

        public init(
            code: Code? = nil,
            reason: String? = nil,
            requirement: String? = nil
        ) {
            self.code = code
            self.reason = reason
            self.requirement = requirement
        }

        /// The code for the type of error.
        public enum Code: String, Codable, Hashable, Sendable {
            case externalRequest = "external_request"
            case informationMissing = "information_missing"
            case invalidAddressCityStatePostalCode = "invalid_address_city_state_postal_code"
            case invalidAddressHighwayContractBox = "invalid_address_highway_contract_box"
            case invalidAddressPrivateMailbox = "invalid_address_private_mailbox"
            case invalidBusinessProfileName = "invalid_business_profile_name"
            case invalidBusinessProfileNameDenylisted = "invalid_business_profile_name_denylisted"
            case invalidCompanyNameDenylisted = "invalid_company_name_denylisted"
            case invalidDobAgeOverMaximum = "invalid_dob_age_over_maximum"
            case invalidDobAgeUnder18 = "invalid_dob_age_under_18"
            case invalidDobAgeUnderMinimum = "invalid_dob_age_under_minimum"
            case invalidProductDescriptionLength = "invalid_product_description_length"
            case invalidProductDescriptionUrlMatch = "invalid_product_description_url_match"
            case invalidRepresentativeCountry = "invalid_representative_country"
            case invalidSignator = "invalid_signator"
            case invalidStatementDescriptorBusinessMismatch = "invalid_statement_descriptor_business_mismatch"
            case invalidStatementDescriptorDenylisted = "invalid_statement_descriptor_denylisted"
            case invalidStatementDescriptorLength = "invalid_statement_descriptor_length"
            case invalidStatementDescriptorPrefixDenylisted = "invalid_statement_descriptor_prefix_denylisted"
            case invalidStatementDescriptorPrefixMismatch = "invalid_statement_descriptor_prefix_mismatch"
            case invalidStreetAddress = "invalid_street_address"
            case invalidTaxId = "invalid_tax_id"
            case invalidTaxIdFormat = "invalid_tax_id_format"
            case invalidTosAcceptance = "invalid_tos_acceptance"
            case invalidUrlDenylisted = "invalid_url_denylisted"
            case invalidUrlFormat = "invalid_url_format"
            case invalidUrlLength = "invalid_url_length"
            case invalidUrlWebPresenceDetected = "invalid_url_web_presence_detected"
            case invalidUrlWebsiteBusinessInformationMismatch = "invalid_url_website_business_information_mismatch"
            case invalidUrlWebsiteEmpty = "invalid_url_website_empty"
            case invalidUrlWebsiteInaccessible = "invalid_url_website_inaccessible"
            case invalidUrlWebsiteInaccessibleGeoblocked = "invalid_url_website_inaccessible_geoblocked"
            case invalidUrlWebsiteInaccessiblePasswordProtected = "invalid_url_website_inaccessible_password_protected"
            case invalidUrlWebsiteIncomplete = "invalid_url_website_incomplete"
            case invalidUrlWebsiteIncompleteCancellationPolicy = "invalid_url_website_incomplete_cancellation_policy"
            case invalidUrlWebsiteIncompleteCustomerServiceDetails = "invalid_url_website_incomplete_customer_service_details"
            case invalidUrlWebsiteIncompleteLegalRestrictions = "invalid_url_website_incomplete_legal_restrictions"
            case invalidUrlWebsiteIncompleteRefundPolicy = "invalid_url_website_incomplete_refund_policy"
            case invalidUrlWebsiteIncompleteReturnPolicy = "invalid_url_website_incomplete_return_policy"
            case invalidUrlWebsiteIncompleteTermsAndConditions = "invalid_url_website_incomplete_terms_and_conditions"
            case invalidUrlWebsiteIncompleteUnderConstruction = "invalid_url_website_incomplete_under_construction"
            case invalidUrlWebsiteOther = "invalid_url_website_other"
            case invalidValueOther = "invalid_value_other"
            case unsupportedBusinessType = "unsupported_business_type"
            case verificationDirectorsMismatch = "verification_directors_mismatch"
            case verificationDocumentAddressMismatch = "verification_document_address_mismatch"
            case verificationDocumentAddressMissing = "verification_document_address_missing"
            case verificationDocumentCorrupt = "verification_document_corrupt"
            case verificationDocumentCountryNotSupported = "verification_document_country_not_supported"
            case verificationDocumentDirectorsMismatch = "verification_document_directors_mismatch"
            case verificationDocumentDobMismatch = "verification_document_dob_mismatch"
            case verificationDocumentDuplicateType = "verification_document_duplicate_type"
            case verificationDocumentExpired = "verification_document_expired"
            case verificationDocumentFailedCopy = "verification_document_failed_copy"
            case verificationDocumentFailedGreyscale = "verification_document_failed_greyscale"
            case verificationDocumentFailedOther = "verification_document_failed_other"
            case verificationDocumentFailedTestMode = "verification_document_failed_test_mode"
            case verificationDocumentFraudulent = "verification_document_fraudulent"
            case verificationDocumentIdNumberMismatch = "verification_document_id_number_mismatch"
            case verificationDocumentIdNumberMissing = "verification_document_id_number_missing"
            case verificationDocumentIncomplete = "verification_document_incomplete"
            case verificationDocumentInvalid = "verification_document_invalid"
            case verificationDocumentIssueOrExpiryDateMissing = "verification_document_issue_or_expiry_date_missing"
            case verificationDocumentManipulated = "verification_document_manipulated"
            case verificationDocumentMissingBack = "verification_document_missing_back"
            case verificationDocumentMissingFront = "verification_document_missing_front"
            case verificationDocumentNameMismatch = "verification_document_name_mismatch"
            case verificationDocumentNameMissing = "verification_document_name_missing"
            case verificationDocumentNationalityMismatch = "verification_document_nationality_mismatch"
            case verificationDocumentNotReadable = "verification_document_not_readable"
            case verificationDocumentNotSigned = "verification_document_not_signed"
            case verificationDocumentNotUploaded = "verification_document_not_uploaded"
            case verificationDocumentPhotoMismatch = "verification_document_photo_mismatch"
            case verificationDocumentTooLarge = "verification_document_too_large"
            case verificationDocumentTypeNotSupported = "verification_document_type_not_supported"
            case verificationExtraneousDirectors = "verification_extraneous_directors"
            case verificationFailedAddressMatch = "verification_failed_address_match"
            case verificationFailedAuthorizerAuthority = "verification_failed_authorizer_authority"
            case verificationFailedBusinessIecNumber = "verification_failed_business_iec_number"
            case verificationFailedDocumentMatch = "verification_failed_document_match"
            case verificationFailedIdNumberMatch = "verification_failed_id_number_match"
            case verificationFailedKeyedIdentity = "verification_failed_keyed_identity"
            case verificationFailedKeyedMatch = "verification_failed_keyed_match"
            case verificationFailedNameMatch = "verification_failed_name_match"
            case verificationFailedOther = "verification_failed_other"
            case verificationFailedRepresentativeAuthority = "verification_failed_representative_authority"
            case verificationFailedResidentialAddress = "verification_failed_residential_address"
            case verificationFailedTaxIdMatch = "verification_failed_tax_id_match"
            case verificationFailedTaxIdNotIssued = "verification_failed_tax_id_not_issued"
            case verificationLegalEntityStructureMismatch = "verification_legal_entity_structure_mismatch"
            case verificationMissingDirectors = "verification_missing_directors"
            case verificationMissingExecutives = "verification_missing_executives"
            case verificationMissingOwners = "verification_missing_owners"
            case verificationRejectedOwnershipExemptionReason = "verification_rejected_ownership_exemption_reason"
            case verificationRequiresAdditionalMemorandumOfAssociations = "verification_requires_additional_memorandum_of_associations"
            case verificationRequiresAdditionalProofOfRegistration = "verification_requires_additional_proof_of_registration"
            case verificationSupportability = "verification_supportability"
        }
    }
}

// payment_method_options_customer_balance_eu_bank_account
extension Stripe.Shared {
    public struct EuBankTransfer: Codable, Hashable, Sendable {
        /// The desired country code of the bank account information.
        public var country: Country?

        public init(
            country: Country? = nil
        ) {
            self.country = country
        }

        /// The desired country code of the bank account information.
        public enum Country: String, Codable, Hashable, Sendable {
            case BE
            case DE
            case ES
            case FR
            case IE
            case NL
        }
    }
}

// invoice_payment_method_options_us_bank_account_linked_account_options_filters
extension Stripe.Shared {
    public struct Filters: Codable, Hashable, Sendable {
        /// The account subcategories to use to filter for possible accounts to link.
        public var accountSubcategories: [AccountSubcategories]?

        public init(
            accountSubcategories: [AccountSubcategories]? = nil
        ) {
            self.accountSubcategories = accountSubcategories
        }

        public enum AccountSubcategories: String, Codable, Hashable, Sendable {
            case checking
            case savings
        }
    }
}

// received_payment_method_details_financial_account
extension Stripe.Shared {
    public struct FinancialAccount: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// The rails the ReceivedCredit was sent over.
        public var network: String?

        public init(
            id: ID,
            network: String? = nil
        ) {
            self.id = id
            self.network = network
        }
    }
}

// funding_instructions_bank_transfer_financial_address
extension Stripe.Shared {
    /// FinancialAddresses contain identifying information that resolves to a FinancialAccount.
    public struct FinancialAddresses: Codable, Hashable, Sendable {
        /// The payment networks supported by this FinancialAddress.
        public var supportedNetworks: [SupportedNetworks]?
        /// The type of financial address.
        public var `type`: Type?
        /// The payload `type` selects.
        public var details: Details

        fileprivate enum CodingKeys: String, CodingKey {
            case supportedNetworks
            case `type`
            case aba
            case iban
            case sortCode
            case spei
            case swift
            case zengin
        }

        public init(
            supportedNetworks: [SupportedNetworks]? = nil,
            `type`: Type? = nil,
            details: Details
        ) {
            self.supportedNetworks = supportedNetworks
            self.`type` = `type`
            self.details = details
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.supportedNetworks = try container.decodeIfPresent([SupportedNetworks].self, forKey: .supportedNetworks)
            self.`type` = try container.decodeIfPresent(Type.self, forKey: .`type`)
            self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(supportedNetworks, forKey: .supportedNetworks)
            try container.encodeIfPresent(`type`, forKey: .`type`)
            try details.encode(into: &container)
        }

        public enum SupportedNetworks: String, Codable, Hashable, Sendable {
            case ach
            case bacs
            case chaps
            case domesticWireUs = "domestic_wire_us"
            case fps
            case sepa
            case spei
            case swift
            case zengin
        }

        /// The type of financial address.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case aba
            case iban
            case sortCode = "sort_code"
            case spei
            case swift
            case zengin
        }

        /// The payload `type` selects; `unknown` carries a type this package does not model.
        public indirect enum Details: Hashable, Sendable {
            case aba(Stripe.Shared.Aba)
            case iban(Stripe.Shared.Iban)
            case sortCode(Stripe.Shared.SortCode)
            case spei(Stripe.Shared.Spei)
            case swift(Stripe.Shared.Swift)
            case zengin(Stripe.Shared.Zengin)
            case unknown(type: String)

            public var aba: Stripe.Shared.Aba? {
                if case .aba(let value) = self { return value }
                return nil
            }
            public var iban: Stripe.Shared.Iban? {
                if case .iban(let value) = self { return value }
                return nil
            }
            public var sortCode: Stripe.Shared.SortCode? {
                if case .sortCode(let value) = self { return value }
                return nil
            }
            public var spei: Stripe.Shared.Spei? {
                if case .spei(let value) = self { return value }
                return nil
            }
            public var swift: Stripe.Shared.Swift? {
                if case .swift(let value) = self { return value }
                return nil
            }
            public var zengin: Stripe.Shared.Zengin? {
                if case .zengin(let value) = self { return value }
                return nil
            }

            fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                switch type {
                case "aba":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Aba.self, forKey: .aba) {
                        self = .aba(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "iban":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Iban.self, forKey: .iban) {
                        self = .iban(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "sort_code":
                    if let value = try container.decodeIfPresent(Stripe.Shared.SortCode.self, forKey: .sortCode) {
                        self = .sortCode(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "spei":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Spei.self, forKey: .spei) {
                        self = .spei(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "swift":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Swift.self, forKey: .swift) {
                        self = .swift(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "zengin":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Zengin.self, forKey: .zengin) {
                        self = .zengin(value)
                    } else {
                        self = .unknown(type: type)
                    }
                default: self = .unknown(type: type)
                }
            }

            fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                switch self {
                case .aba(let value): try container.encode(value, forKey: .aba)
                case .iban(let value): try container.encode(value, forKey: .iban)
                case .sortCode(let value): try container.encode(value, forKey: .sortCode)
                case .spei(let value): try container.encode(value, forKey: .spei)
                case .swift(let value): try container.encode(value, forKey: .swift)
                case .zengin(let value): try container.encode(value, forKey: .zengin)
                default: break
                }
            }
        }
    }
}

// invoice_payment_method_options_us_bank_account_linked_account_options
extension Stripe.Shared {
    public struct FinancialConnections: Codable, Hashable, Sendable {
        public var filters: Stripe.Shared.Filters?
        /// The list of permissions to request.
        public var permissions: [Permissions]?
        /// Data features requested to be retrieved upon account creation.
        public var prefetch: [Prefetch]?

        public init(
            filters: Stripe.Shared.Filters? = nil,
            permissions: [Permissions]? = nil,
            prefetch: [Prefetch]? = nil
        ) {
            self.filters = filters
            self.permissions = permissions
            self.prefetch = prefetch
        }

        public enum Permissions: String, Codable, Hashable, Sendable {
            case balances
            case ownership
            case paymentMethod = "payment_method"
            case transactions
        }

        public enum Prefetch: String, Codable, Hashable, Sendable {
            case balances
            case ownership
            case transactions
        }
    }
}

// reserves_reserve_plans_resources_fixed_release
extension Stripe.Shared {
    public struct FixedRelease: Codable, Hashable, Sendable {
        /// The time after which all reserved funds are requested for release.
        public var releaseAfter: Int?
        /// The time at which reserved funds are scheduled for release, automatically set to midnight UTC of the day after.
        public var scheduledRelease: Date?

        public init(
            releaseAfter: Int? = nil,
            scheduledRelease: Date? = nil
        ) {
            self.releaseAfter = releaseAfter
            self.scheduledRelease = scheduledRelease
        }
    }
}

// tax_rate_flat_amount
extension Stripe.Shared {
    /// The amount of the tax rate when the `rate_type`` is `flat_amount`.
    public struct FlatAmount: Codable, Hashable, Sendable {
        /// Amount of the tax when the `rate_type` is `flat_amount`.
        public var amount: Int?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: String?

        public init(
            amount: Int? = nil,
            currency: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
        }
    }
}

// subscriptions_resource_billing_mode_flexible
extension Stripe.Shared {
    public struct Flexible: Codable, Hashable, Sendable {
        /// Controls how invoices and invoice items display proration amounts and discount amounts.
        public var prorationDiscounts: ProrationDiscounts?

        public init(
            prorationDiscounts: ProrationDiscounts? = nil
        ) {
            self.prorationDiscounts = prorationDiscounts
        }

        /// Controls how invoices and invoice items display proration amounts and discount amounts.
        public enum ProrationDiscounts: String, Codable, Hashable, Sendable {
            case included
            case itemized
        }
    }
}

// treasury_transactions_resource_flow_details
extension Stripe.Shared {
    public struct FlowDetails: Codable, Hashable, Sendable {
        /// Type of the flow that created the Transaction.
        public var `type`: Type?
        /// The payload `type` selects.
        public var details: Details

        fileprivate enum CodingKeys: String, CodingKey {
            case `type`
            case creditReversal
            case debitReversal
            case inboundTransfer
            case issuingAuthorization
            case outboundPayment
            case outboundTransfer
            case receivedCredit
            case receivedDebit
        }

        public init(
            `type`: Type? = nil,
            details: Details
        ) {
            self.`type` = `type`
            self.details = details
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.`type` = try container.decodeIfPresent(Type.self, forKey: .`type`)
            self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(`type`, forKey: .`type`)
            try details.encode(into: &container)
        }

        /// Type of the flow that created the Transaction.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case creditReversal = "credit_reversal"
            case debitReversal = "debit_reversal"
            case inboundTransfer = "inbound_transfer"
            case issuingAuthorization = "issuing_authorization"
            case other
            case outboundPayment = "outbound_payment"
            case outboundTransfer = "outbound_transfer"
            case receivedCredit = "received_credit"
            case receivedDebit = "received_debit"
        }

        /// The payload `type` selects; `unknown` carries a type this package does not model.
        public indirect enum Details: Hashable, Sendable {
            case creditReversal(Stripe.Treasury.CreditReversal)
            case debitReversal(Stripe.Treasury.DebitReversal)
            case inboundTransfer(Stripe.Treasury.InboundTransfer)
            case issuingAuthorization(Authorization)
            case outboundPayment(Stripe.Treasury.OutboundPayment)
            case outboundTransfer(Stripe.Treasury.OutboundTransfer)
            case receivedCredit(Stripe.Treasury.ReceivedCredit)
            case receivedDebit(Stripe.Treasury.ReceivedDebit)
            case other
            case unknown(type: String)

            public var creditReversal: Stripe.Treasury.CreditReversal? {
                if case .creditReversal(let value) = self { return value }
                return nil
            }
            public var debitReversal: Stripe.Treasury.DebitReversal? {
                if case .debitReversal(let value) = self { return value }
                return nil
            }
            public var inboundTransfer: Stripe.Treasury.InboundTransfer? {
                if case .inboundTransfer(let value) = self { return value }
                return nil
            }
            public var issuingAuthorization: Authorization? {
                if case .issuingAuthorization(let value) = self { return value }
                return nil
            }
            public var outboundPayment: Stripe.Treasury.OutboundPayment? {
                if case .outboundPayment(let value) = self { return value }
                return nil
            }
            public var outboundTransfer: Stripe.Treasury.OutboundTransfer? {
                if case .outboundTransfer(let value) = self { return value }
                return nil
            }
            public var receivedCredit: Stripe.Treasury.ReceivedCredit? {
                if case .receivedCredit(let value) = self { return value }
                return nil
            }
            public var receivedDebit: Stripe.Treasury.ReceivedDebit? {
                if case .receivedDebit(let value) = self { return value }
                return nil
            }

            fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                switch type {
                case "credit_reversal":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.CreditReversal.self, forKey: .creditReversal) {
                        self = .creditReversal(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "debit_reversal":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.DebitReversal.self, forKey: .debitReversal) {
                        self = .debitReversal(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "inbound_transfer":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.InboundTransfer.self, forKey: .inboundTransfer) {
                        self = .inboundTransfer(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "issuing_authorization":
                    if let value = try container.decodeIfPresent(Authorization.self, forKey: .issuingAuthorization) {
                        self = .issuingAuthorization(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "outbound_payment":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.OutboundPayment.self, forKey: .outboundPayment) {
                        self = .outboundPayment(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "outbound_transfer":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.OutboundTransfer.self, forKey: .outboundTransfer) {
                        self = .outboundTransfer(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "received_credit":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.ReceivedCredit.self, forKey: .receivedCredit) {
                        self = .receivedCredit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "received_debit":
                    if let value = try container.decodeIfPresent(Stripe.Treasury.ReceivedDebit.self, forKey: .receivedDebit) {
                        self = .receivedDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "other": self = .other
                default: self = .unknown(type: type)
                }
            }

            fileprivate func encode(into container: inout KeyedEncodingContainer<CodingKeys>) throws {
                switch self {
                case .creditReversal(let value): try container.encode(value, forKey: .creditReversal)
                case .debitReversal(let value): try container.encode(value, forKey: .debitReversal)
                case .inboundTransfer(let value): try container.encode(value, forKey: .inboundTransfer)
                case .issuingAuthorization(let value): try container.encode(value, forKey: .issuingAuthorization)
                case .outboundPayment(let value): try container.encode(value, forKey: .outboundPayment)
                case .outboundTransfer(let value): try container.encode(value, forKey: .outboundTransfer)
                case .receivedCredit(let value): try container.encode(value, forKey: .receivedCredit)
                case .receivedDebit(let value): try container.encode(value, forKey: .receivedDebit)
                default: break
                }
            }
        }
    }
}

// payment_method_details_fpx
extension Stripe.Shared {
    public struct Fpx: Codable, Hashable, Sendable {
        /// Account holder type, if provided.
        public var accountHolderType: AccountHolderType?
        /// The customer's bank.
        public var bank: Bank?
        /// Unique transaction id generated by FPX for every request from the merchant.
        public var transactionId: String?

        public init(
            accountHolderType: AccountHolderType? = nil,
            bank: Bank? = nil,
            transactionId: String? = nil
        ) {
            self.accountHolderType = accountHolderType
            self.bank = bank
            self.transactionId = transactionId
        }

        /// Account holder type, if provided.
        public enum AccountHolderType: String, Codable, Hashable, Sendable {
            case company
            case individual
        }

        /// The customer's bank.
        public enum Bank: String, Codable, Hashable, Sendable {
            case affinBank = "affin_bank"
            case agrobank
            case allianceBank = "alliance_bank"
            case ambank
            case bankIslam = "bank_islam"
            case bankMuamalat = "bank_muamalat"
            case bankOfChina = "bank_of_china"
            case bankRakyat = "bank_rakyat"
            case bnpParibas = "bnp_paribas"
            case bsn
            case cimb
            case citibank
            case deutscheBank = "deutsche_bank"
            case hongLeongBank = "hong_leong_bank"
            case hsbc
            case kfh
            case maybank2e
            case maybank2u
            case mbsbBank = "mbsb_bank"
            case ocbc
            case pbEnterprise = "pb_enterprise"
            case publicBank = "public_bank"
            case rhb
            case standardChartered = "standard_chartered"
            case uob
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_amazon_pay_details_resource_funding
extension Stripe.Shared {
    public struct Funding: Codable, Hashable, Sendable {
        public var card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodAmazonPayDetailsResourceFundingResourceFundingCard?
        /// funding type of the underlying payment method.
        public var `type`: String?

        public init(
            card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodAmazonPayDetailsResourceFundingResourceFundingCard? = nil,
            `type`: String? = nil
        ) {
            self.card = card
            self.`type` = `type`
        }
    }
}

// payment_method_card_generated_card
extension Stripe.Shared {
    public struct GeneratedFrom: Codable, Hashable, Sendable {
        /// The charge that created this object.
        public var charge: String?
        /// Transaction-specific details of the payment method used in the payment.
        public var paymentMethodDetails: Stripe.Shared.PaymentMethodDetails?
        /// The ID of the SetupAttempt that generated this PaymentMethod, if any.
        @Expandable<Stripe.Setup.Attempt, String> public var setupAttempt: String?

        public init(
            charge: String? = nil,
            paymentMethodDetails: Stripe.Shared.PaymentMethodDetails? = nil,
            setupAttempt: String? = nil
        ) {
            self.charge = charge
            self.paymentMethodDetails = paymentMethodDetails
            self._setupAttempt = Expandable(id: setupAttempt)
        }
    }
}

// payment_method_giropay
extension Stripe.Shared {
    public struct Giropay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_card_wallet_google_pay
extension Stripe.Shared {
    public struct GooglePay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_grabpay
extension Stripe.Shared {
    public struct Grabpay: Codable, Hashable, Sendable {
        /// Unique transaction id generated by GrabPay.
        public var transactionId: String?

        public init(
            transactionId: String? = nil
        ) {
            self.transactionId = transactionId
        }
    }
}

// funding_instructions_bank_transfer_iban_record
extension Stripe.Shared {
    /// Iban Records contain E.U.
    public struct Iban: Codable, Hashable, Sendable {
        public var accountHolderAddress: Address?
        /// The name of the person or business that owns the bank account.
        public var accountHolderName: String?
        public var bankAddress: Address?
        /// The BIC/SWIFT code of the account.
        public var bic: String?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String?
        /// The IBAN of the account.
        public var iban: String?

        public init(
            accountHolderAddress: Address? = nil,
            accountHolderName: String? = nil,
            bankAddress: Address? = nil,
            bic: String? = nil,
            country: String? = nil,
            iban: String? = nil
        ) {
            self.accountHolderAddress = accountHolderAddress
            self.accountHolderName = accountHolderName
            self.bankAddress = bankAddress
            self.bic = bic
            self.country = country
            self.iban = iban
        }
    }
}

// payment_method_ideal
extension Stripe.Shared {
    public struct Ideal: Codable, Hashable, Sendable {
        /// The customer's bank, if provided.
        public var bank: Bank?
        /// The Bank Identifier Code of the customer's bank, if the bank was provided.
        public var bic: Bic?

        public init(
            bank: Bank? = nil,
            bic: Bic? = nil
        ) {
            self.bank = bank
            self.bic = bic
        }

        /// The customer's bank, if provided.
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

        /// The Bank Identifier Code of the customer's bank, if the bank was provided.
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
}

// treasury_shared_resource_initiating_payment_method_details_initiating_payment_method_details
extension Stripe.Shared {
    public struct InitiatingPaymentMethodDetails: Codable, Hashable, Sendable {
        /// Set when `type` is `balance`.
        public var balance: String?
        public var billingDetails: Stripe.Shared.TreasurySharedResourceBillingDetails?
        public var financialAccount: Stripe.Shared.FinancialAccount?
        /// Set when `type` is `issuing_card`.
        public var issuingCard: String?
        /// Polymorphic type matching the originating money movement's source.
        public var `type`: Type?
        public var usBankAccount: Stripe.Shared.TreasurySharedResourceInitiatingPaymentMethodDetailsUsBankAccount?

        public init(
            balance: String? = nil,
            billingDetails: Stripe.Shared.TreasurySharedResourceBillingDetails? = nil,
            financialAccount: Stripe.Shared.FinancialAccount? = nil,
            issuingCard: String? = nil,
            `type`: Type? = nil,
            usBankAccount: Stripe.Shared.TreasurySharedResourceInitiatingPaymentMethodDetailsUsBankAccount? = nil
        ) {
            self.balance = balance
            self.billingDetails = billingDetails
            self.financialAccount = financialAccount
            self.issuingCard = issuingCard
            self.`type` = `type`
            self.usBankAccount = usBankAccount
        }

        /// Polymorphic type matching the originating money movement's source.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case balance
            case financialAccount = "financial_account"
            case issuingCard = "issuing_card"
            case stripe
            case usBankAccount = "us_bank_account"
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_alma_details_resource_installments
extension Stripe.Shared {
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

// payment_method_details_interac_present
extension Stripe.Shared {
    public struct InteracPresent: Codable, Hashable, Sendable {
        /// Card brand.
        public var brand: String?
        /// The cardholder name as read from the card, in ISO 7813 format.
        public var cardholderName: String?
        /// Two-letter ISO code representing the country of the card.
        public var country: String?
        /// A high-level description of the type of cards issued in this range.
        public var description: String?
        /// Authorization response cryptogram.
        public var emvAuthData: String?
        /// Two-digit number representing the card's expiration month.
        public var expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public var expYear: Int?
        /// Uniquely identifies this particular card number.
        public var fingerprint: String?
        /// Card funding type.
        public var funding: String?
        /// ID of a card PaymentMethod generated from the card_present PaymentMethod that may be attached to a Customer for.
        public var generatedCard: String?
        /// Issuer identification number of the card.
        public var iin: String?
        /// The name of the card's issuing bank.
        public var issuer: String?
        /// The last four digits of the card.
        public var last4: String?
        /// ID of the location that this transaction's reader is assigned to.
        public var location: String?
        /// Identifies which network this charge was processed on.
        public var network: String?
        /// This is used by the financial networks to identify a transaction.
        public var networkTransactionId: String?
        /// The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card.
        public var preferredLocales: [String]?
        /// How card details were read in this transaction.
        public var readMethod: ReadMethod?
        /// ID of the reader this transaction was made on.
        public var reader: String?
        /// A collection of fields required to be displayed on receipts.
        public var receipt: Stripe.Shared.PaymentMethodDetailsInteracPresentReceipt?

        public init(
            brand: String? = nil,
            cardholderName: String? = nil,
            country: String? = nil,
            description: String? = nil,
            emvAuthData: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            fingerprint: String? = nil,
            funding: String? = nil,
            generatedCard: String? = nil,
            iin: String? = nil,
            issuer: String? = nil,
            last4: String? = nil,
            location: String? = nil,
            network: String? = nil,
            networkTransactionId: String? = nil,
            preferredLocales: [String]? = nil,
            readMethod: ReadMethod? = nil,
            reader: String? = nil,
            receipt: Stripe.Shared.PaymentMethodDetailsInteracPresentReceipt? = nil
        ) {
            self.brand = brand
            self.cardholderName = cardholderName
            self.country = country
            self.description = description
            self.emvAuthData = emvAuthData
            self.expMonth = expMonth
            self.expYear = expYear
            self.fingerprint = fingerprint
            self.funding = funding
            self.generatedCard = generatedCard
            self.iin = iin
            self.issuer = issuer
            self.last4 = last4
            self.location = location
            self.network = network
            self.networkTransactionId = networkTransactionId
            self.preferredLocales = preferredLocales
            self.readMethod = readMethod
            self.reader = reader
            self.receipt = receipt
        }

        /// How card details were read in this transaction.
        public enum ReadMethod: String, Codable, Hashable, Sendable {
            case contactEmv = "contact_emv"
            case contactlessEmv = "contactless_emv"
            case contactlessMagstripeMode = "contactless_magstripe_mode"
            case magneticStripeFallback = "magnetic_stripe_fallback"
            case magneticStripeTrack2 = "magnetic_stripe_track2"
        }
    }
}

// invoice_mandate_options_payto
extension Stripe.Shared {
    public struct InvoiceMandateOptionsPayto: Codable, Hashable, Sendable {
        /// The maximum amount that can be collected in a single invoice.
        public var amount: Int?
        /// Only `maximum` is supported.
        public var amountType: AmountType?
        /// The purpose for which payments are made.
        public var purpose: Purpose?

        public init(
            amount: Int? = nil,
            amountType: AmountType? = nil,
            purpose: Purpose? = nil
        ) {
            self.amount = amount
            self.amountType = amountType
            self.purpose = purpose
        }

        /// Only `maximum` is supported.
        public enum AmountType: String, Codable, Hashable, Sendable {
            case fixed
            case maximum
        }

        /// The purpose for which payments are made.
        public enum Purpose: String, Codable, Hashable, Sendable {
            case dependantSupport = "dependant_support"
            case government
            case loan
            case mortgage
            case other
            case pension
            case personal
            case retail
            case salary
            case tax
            case utility
        }
    }
}

// invoice_payment_method_options_acss_debit_mandate_options
extension Stripe.Shared {
    public struct InvoicePaymentMethodOptionsAcssDebitMandateOptions: Codable, Hashable, Sendable {
        /// Transaction type of the mandate.
        public var transactionType: TransactionType?

        public init(
            transactionType: TransactionType? = nil
        ) {
            self.transactionType = transactionType
        }

        /// Transaction type of the mandate.
        public enum TransactionType: String, Codable, Hashable, Sendable {
            case business
            case personal
        }
    }
}

// invoice_payment_method_options_customer_balance_bank_transfer_eu_bank_transfer
extension Stripe.Shared {
    public struct InvoicePaymentMethodOptionsCustomerBalanceBankTransferEuBankTransfer: Codable, Hashable, Sendable {
        /// The desired country code of the bank account information.
        public var country: Country?

        public init(
            country: Country? = nil
        ) {
            self.country = country
        }

        /// The desired country code of the bank account information.
        public enum Country: String, Codable, Hashable, Sendable {
            case BE
            case DE
            case ES
            case FR
            case IE
            case NL
        }
    }
}

// invoice_payment_method_options_mandate_options_upi
extension Stripe.Shared {
    public struct InvoicePaymentMethodOptionsMandateOptionsUpi: Codable, Hashable, Sendable {
        /// Amount to be charged for future payments.
        public var amount: Int?
        /// One of `fixed` or `maximum`.
        public var amountType: AmountType?
        /// A description of the mandate or subscription that is meant to be displayed to the customer.
        public var description: String?
        /// End date of the mandate or subscription.
        public var endDate: Date?

        public init(
            amount: Int? = nil,
            amountType: AmountType? = nil,
            description: String? = nil,
            endDate: Date? = nil
        ) {
            self.amount = amount
            self.amountType = amountType
            self.description = description
            self.endDate = endDate
        }

        /// One of `fixed` or `maximum`.
        public enum AmountType: String, Codable, Hashable, Sendable {
            case fixed
            case maximum
        }
    }
}

// invoices_resource_pretax_credit_amount
extension Stripe.Shared {
    public struct InvoicesResourcePretaxCreditAmount: Codable, Hashable, Sendable {
        /// The amount, in cents (or local equivalent), of the pretax credit amount.
        public var amount: Int?
        /// The credit balance transaction that was applied to get this pretax credit amount.
        @Expandable<Stripe.Billing.Credit.Balance.Transaction, String> public var creditBalanceTransaction: String?
        /// The discount that was applied to get this pretax credit amount.
        @Expandable<Stripe.Shared.Discount, String> public var discount: String?
        /// Type of the pretax credit amount referenced.
        public var `type`: Type?

        public init(
            amount: Int? = nil,
            creditBalanceTransaction: String? = nil,
            discount: String? = nil,
            `type`: Type? = nil
        ) {
            self.amount = amount
            self._creditBalanceTransaction = Expandable(id: creditBalanceTransaction)
            self._discount = Expandable(id: discount)
            self.`type` = `type`
        }

        /// Type of the pretax credit amount referenced.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case creditBalanceTransaction = "credit_balance_transaction"
            case discount
        }
    }
}

// tax_product_resource_jurisdiction
extension Stripe.Shared {
    public struct Jurisdiction: Codable, Hashable, Sendable {
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String?
        /// A human-readable name for the jurisdiction imposing the tax.
        public var displayName: String?
        /// Indicates the level of the jurisdiction imposing the tax.
        public var level: Level?
        /// ISO 3166-2 subdivision code, without country prefix.
        public var state: String?

        public init(
            country: String? = nil,
            displayName: String? = nil,
            level: Level? = nil,
            state: String? = nil
        ) {
            self.country = country
            self.displayName = displayName
            self.level = level
            self.state = state
        }

        /// Indicates the level of the jurisdiction imposing the tax.
        public enum Level: String, Codable, Hashable, Sendable {
            case city
            case country
            case county
            case district
            case state
        }
    }
}

// payment_method_kakao_pay
extension Stripe.Shared {
    public struct KakaoPay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_klarna
extension Stripe.Shared {
    public struct Klarna: Codable, Hashable, Sendable {
        /// The customer's date of birth, if provided.
        public var dob: Stripe.Shared.Dob?

        public init(
            dob: Stripe.Shared.Dob? = nil
        ) {
            self.dob = dob
        }
    }
}

// invoice_payment_method_options_konbini
extension Stripe.Shared {
    public struct Konbini: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_kr_card
extension Stripe.Shared {
    public struct KrCard: Codable, Hashable, Sendable {
        /// The local credit or debit card brand.
        public var brand: Brand?
        /// A unique identifier for the buyer as determined by the local payment processor.
        public var buyerId: String?
        /// The last four digits of the card.
        public var last4: String?
        /// The Korean Card transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            brand: Brand? = nil,
            buyerId: String? = nil,
            last4: String? = nil,
            transactionId: String? = nil
        ) {
            self.brand = brand
            self.buyerId = buyerId
            self.last4 = last4
            self.transactionId = transactionId
        }

        /// The local credit or debit card brand.
        public enum Brand: String, Codable, Hashable, Sendable {
            case bc
            case citi
            case hana
            case hyundai
            case jeju
            case jeonbuk
            case kakaobank
            case kbank
            case kdbbank
            case kookmin
            case kwangju
            case lotte
            case mg
            case nh
            case post
            case samsung
            case savingsbank
            case shinhan
            case shinhyup
            case suhyup
            case tossbank
            case woori
        }
    }
}

// legal_entity_japan_address
extension Stripe.Shared {
    public struct LegalEntityJapanAddress: Codable, Hashable, Sendable {
        /// City/Ward.
        public var city: String?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String?
        /// Block/Building number.
        public var line1: String?
        /// Building details.
        public var line2: String?
        /// ZIP or postal code.
        public var postalCode: String?
        /// Prefecture.
        public var state: String?
        /// Town/cho-me.
        public var town: String?

        public init(
            city: String? = nil,
            country: String? = nil,
            line1: String? = nil,
            line2: String? = nil,
            postalCode: String? = nil,
            state: String? = nil,
            town: String? = nil
        ) {
            self.city = city
            self.country = country
            self.line1 = line1
            self.line2 = line2
            self.postalCode = postalCode
            self.state = state
            self.town = town
        }
    }
}

// payment_method_card_wallet_link
extension Stripe.Shared {
    public struct Link: Codable, Hashable, Sendable {
        public init() {}
    }
}

// linked_account_options_common
extension Stripe.Shared {
    public struct LinkedAccountOptionsCommon: Codable, Hashable, Sendable {
        public var filters: Stripe.Shared.PaymentFlowsPrivatePaymentMethodsFinancialConnectionsCommonLinkedAccountOptionsFilters?
        /// The list of permissions to request.
        public var permissions: [Permissions]?
        /// Data features requested to be retrieved upon account creation.
        public var prefetch: [Prefetch]?
        /// For webview integrations only.
        public var returnUrl: String?

        public init(
            filters: Stripe.Shared.PaymentFlowsPrivatePaymentMethodsFinancialConnectionsCommonLinkedAccountOptionsFilters? = nil,
            permissions: [Permissions]? = nil,
            prefetch: [Prefetch]? = nil,
            returnUrl: String? = nil
        ) {
            self.filters = filters
            self.permissions = permissions
            self.prefetch = prefetch
            self.returnUrl = returnUrl
        }

        public enum Permissions: String, Codable, Hashable, Sendable {
            case balances
            case ownership
            case paymentMethod = "payment_method"
            case transactions
        }

        public enum Prefetch: String, Codable, Hashable, Sendable {
            case balances
            case ownership
            case transactions
        }
    }
}

// payment_pages_checkout_session_managed_payments
extension Stripe.Shared {
    public struct ManagedPayments: Codable, Hashable, Sendable {
        /// Set to `true` to enable Managed Payments, Stripe's merchant of record solution, for this session.
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

// payment_method_options_mandate_options_pix
extension Stripe.Shared {
    public struct MandateOptions: Codable, Hashable, Sendable {
        /// Amount to be charged for future payments.
        public var amount: Int?
        /// Determines if the amount includes the IOF tax.
        public var amountIncludesIof: AmountIncludesIof?
        /// Type of amount.
        public var amountType: AmountType?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// Date when the mandate expires and no further payments will be charged, in `YYYY-MM-DD`.
        public var endDate: String?
        /// Schedule at which the future payments will be charged.
        public var paymentSchedule: PaymentSchedule?
        /// Subscription name displayed to buyers in their bank app.
        public var reference: String?
        /// Start date of the mandate, in `YYYY-MM-DD`.
        public var startDate: String?

        public init(
            amount: Int? = nil,
            amountIncludesIof: AmountIncludesIof? = nil,
            amountType: AmountType? = nil,
            currency: Stripe.Currency? = nil,
            endDate: String? = nil,
            paymentSchedule: PaymentSchedule? = nil,
            reference: String? = nil,
            startDate: String? = nil
        ) {
            self.amount = amount
            self.amountIncludesIof = amountIncludesIof
            self.amountType = amountType
            self.currency = currency
            self.endDate = endDate
            self.paymentSchedule = paymentSchedule
            self.reference = reference
            self.startDate = startDate
        }

        /// Determines if the amount includes the IOF tax.
        public enum AmountIncludesIof: String, Codable, Hashable, Sendable {
            case always
            case never
        }

        /// Type of amount.
        public enum AmountType: String, Codable, Hashable, Sendable {
            case fixed
            case maximum
        }

        /// Schedule at which the future payments will be charged.
        public enum PaymentSchedule: String, Codable, Hashable, Sendable {
            case halfyearly
            case monthly
            case quarterly
            case weekly
            case yearly
        }
    }
}

// payment_method_card_wallet_masterpass
extension Stripe.Shared {
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
}

// payment_method_mb_way
extension Stripe.Shared {
    public struct MbWay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// issuing_authorization_merchant_data
extension Stripe.Shared {
    public struct MerchantData: Codable, Hashable, Sendable {
        /// A categorization of the seller's type of business.
        public var category: String?
        /// The merchant category code for the seller’s business.
        public var categoryCode: String?
        /// City where the seller is located.
        public var city: String?
        /// Country where the seller is located.
        public var country: String?
        /// Name of the seller.
        public var name: String?
        /// Identifier assigned to the seller by the card network.
        public var networkId: String?
        /// Postal code where the seller is located.
        public var postalCode: String?
        /// State where the seller is located.
        public var state: String?
        /// The seller's tax identification number.
        public var taxId: String?
        /// An ID assigned by the seller to the location of the sale.
        public var terminalId: String?
        /// URL provided by the merchant on a 3DS request.
        public var url: String?

        public init(
            category: String? = nil,
            categoryCode: String? = nil,
            city: String? = nil,
            country: String? = nil,
            name: String? = nil,
            networkId: String? = nil,
            postalCode: String? = nil,
            state: String? = nil,
            taxId: String? = nil,
            terminalId: String? = nil,
            url: String? = nil
        ) {
            self.category = category
            self.categoryCode = categoryCode
            self.city = city
            self.country = country
            self.name = name
            self.networkId = networkId
            self.postalCode = postalCode
            self.state = state
            self.taxId = taxId
            self.terminalId = terminalId
            self.url = url
        }
    }
}

// payment_method_mobilepay
extension Stripe.Shared {
    public struct Mobilepay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// billing_credit_grants_resource_monetary_amount
extension Stripe.Shared {
    public struct Monetary: Codable, Hashable, Sendable {
        /// Three-letter ISO currency code, in lowercase.
        public var currency: String?
        /// A positive integer representing the amount.
        public var value: Int?

        public init(
            currency: String? = nil,
            value: Int? = nil
        ) {
            self.currency = currency
            self.value = value
        }
    }
}

// payment_method_multibanco
extension Stripe.Shared {
    public struct Multibanco: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_naver_pay
extension Stripe.Shared {
    public struct NaverPay: Codable, Hashable, Sendable {
        /// Uniquely identifies this particular Naver Pay account.
        public var buyerId: String?
        /// Whether to fund this transaction with Naver Pay points or a card.
        public var funding: Funding?

        public init(
            buyerId: String? = nil,
            funding: Funding? = nil
        ) {
            self.buyerId = buyerId
            self.funding = funding
        }

        /// Whether to fund this transaction with Naver Pay points or a card.
        public enum Funding: String, Codable, Hashable, Sendable {
            case card
            case points
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_network_token
extension Stripe.Shared {
    public struct NetworkToken: Codable, Hashable, Sendable {
        /// Indicates if Stripe used a network token, either user provided or Stripe managed when processing the transaction.
        public var used: Bool?

        public init(
            used: Bool? = nil
        ) {
            self.used = used
        }
    }
}

// networks
extension Stripe.Shared {
    public struct Networks: Codable, Hashable, Sendable {
        /// All networks available for selection via payment_method_options.card.network.
        public var available: [String]?
        /// The preferred network for co-branded cards.
        public var preferred: String?

        public init(
            available: [String]? = nil,
            preferred: String? = nil
        ) {
            self.available = available
            self.preferred = preferred
        }
    }
}

// payment_method_nz_bank_account
extension Stripe.Shared {
    public struct NzBankAccount: Codable, Hashable, Sendable {
        /// The name on the bank account.
        public var accountHolderName: String?
        /// The numeric code for the bank account's bank.
        public var bankCode: String?
        /// The name of the bank.
        public var bankName: String?
        /// The numeric code for the bank account's bank branch.
        public var branchCode: String?
        /// Last four digits of the bank account number.
        public var last4: String?
        /// The suffix of the bank account number.
        public var suffix: String?

        public init(
            accountHolderName: String? = nil,
            bankCode: String? = nil,
            bankName: String? = nil,
            branchCode: String? = nil,
            last4: String? = nil,
            suffix: String? = nil
        ) {
            self.accountHolderName = accountHolderName
            self.bankCode = bankCode
            self.bankName = bankName
            self.branchCode = branchCode
            self.last4 = last4
            self.suffix = suffix
        }
    }
}

// payment_method_details_card_present_offline
extension Stripe.Shared {
    public struct Offline: Codable, Hashable, Sendable {
        /// Time at which the payment was collected while offline.
        public var storedAt: Date?
        /// The method used to process this payment method offline.
        public var `type`: String?

        public init(
            storedAt: Date? = nil,
            `type`: String? = nil
        ) {
            self.storedAt = storedAt
            self.`type` = `type`
        }
    }
}

// payment_method_oxxo
extension Stripe.Shared {
    public struct Oxxo: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_p24
extension Stripe.Shared {
    public struct P24: Codable, Hashable, Sendable {
        /// The customer's bank, if provided.
        public var bank: Bank?

        public init(
            bank: Bank? = nil
        ) {
            self.bank = bank
        }

        /// The customer's bank, if provided.
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
}

// payment_method_pay_by_bank
extension Stripe.Shared {
    public struct PayByBank: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_payco
extension Stripe.Shared {
    public struct Payco: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payments_primitives_payment_records_resource_payment_method_klarna_details_resource_payer_details
extension Stripe.Shared {
    public struct PayerDetails: Codable, Hashable, Sendable {
        /// The payer's address.
        public var address:
            Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodKlarnaDetailsResourcePayerDetailsResourcePayerDetailsAddress?

        public init(
            address: Stripe.Shared
                .PaymentsPrimitivesPaymentRecordsResourcePaymentMethodKlarnaDetailsResourcePayerDetailsResourcePayerDetailsAddress? = nil
        ) {
            self.address = address
        }
    }
}

// payment_flows_private_payment_methods_financial_connections_common_linked_account_options_filters
extension Stripe.Shared {
    public struct PaymentFlowsPrivatePaymentMethodsFinancialConnectionsCommonLinkedAccountOptionsFilters: Codable, Hashable, Sendable {
        /// The account subcategories to use to filter for possible accounts to link.
        public var accountSubcategories: [AccountSubcategories]?

        public init(
            accountSubcategories: [AccountSubcategories]? = nil
        ) {
            self.accountSubcategories = accountSubcategories
        }

        public enum AccountSubcategories: String, Codable, Hashable, Sendable {
            case checking
            case savings
        }
    }
}

// payment_intent_next_action_upiqr_code
extension Stripe.Shared {
    public struct PaymentIntentNextActionUpiqrCode: Codable, Hashable, Sendable {
        /// The date (unix timestamp) when the QR code expires.
        public var expiresAt: Date?
        /// The image_url_png string used to render QR code.
        public var imageUrlPng: String?
        /// The image_url_svg string used to render QR code.
        public var imageUrlSvg: String?

        public init(
            expiresAt: Date? = nil,
            imageUrlPng: String? = nil,
            imageUrlSvg: String? = nil
        ) {
            self.expiresAt = expiresAt
            self.imageUrlPng = imageUrlPng
            self.imageUrlSvg = imageUrlSvg
        }
    }
}

// payment_method_acss_debit
extension Stripe.Shared {
    public struct PaymentMethodAcssDebit: Codable, Hashable, Sendable {
        /// Name of the bank associated with the bank account.
        public var bankName: String?
        /// Uniquely identifies this particular bank account.
        public var fingerprint: String?
        /// Institution number of the bank account.
        public var institutionNumber: String?
        /// Last four digits of the bank account number.
        public var last4: String?
        /// Transit number of the bank account.
        public var transitNumber: String?

        public init(
            bankName: String? = nil,
            fingerprint: String? = nil,
            institutionNumber: String? = nil,
            last4: String? = nil,
            transitNumber: String? = nil
        ) {
            self.bankName = bankName
            self.fingerprint = fingerprint
            self.institutionNumber = institutionNumber
            self.last4 = last4
            self.transitNumber = transitNumber
        }
    }
}

// payment_method_bancontact
extension Stripe.Shared {
    public struct PaymentMethodBancontact: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_card_present
extension Stripe.Shared {
    public struct PaymentMethodCardPresent: Codable, Hashable, Sendable {
        /// Card brand.
        public var brand: String?
        /// The product code that identifies the specific program or product associated with a card.
        public var brandProduct: String?
        /// The cardholder name as read from the card, in ISO 7813 format.
        public var cardholderName: String?
        /// Two-letter ISO code representing the country of the card.
        public var country: String?
        /// A high-level description of the type of cards issued in this range.
        public var description: String?
        /// Two-digit number representing the card's expiration month.
        public var expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public var expYear: Int?
        /// Uniquely identifies this particular card number.
        public var fingerprint: String?
        /// Card funding type.
        public var funding: String?
        /// Issuer identification number of the card.
        public var iin: String?
        /// The name of the card's issuing bank.
        public var issuer: String?
        /// The last four digits of the card.
        public var last4: String?
        /// Contains information about card networks that can be used to process the payment.
        public var networks: Stripe.Shared.PaymentMethodCardPresentNetworks?
        /// Details about payment methods collected offline.
        public var offline: Stripe.Shared.Offline?
        /// The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card.
        public var preferredLocales: [String]?
        /// How card details were read in this transaction.
        public var readMethod: ReadMethod?
        public var wallet: Stripe.Shared.Wallet?

        public init(
            brand: String? = nil,
            brandProduct: String? = nil,
            cardholderName: String? = nil,
            country: String? = nil,
            description: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            fingerprint: String? = nil,
            funding: String? = nil,
            iin: String? = nil,
            issuer: String? = nil,
            last4: String? = nil,
            networks: Stripe.Shared.PaymentMethodCardPresentNetworks? = nil,
            offline: Stripe.Shared.Offline? = nil,
            preferredLocales: [String]? = nil,
            readMethod: ReadMethod? = nil,
            wallet: Stripe.Shared.Wallet? = nil
        ) {
            self.brand = brand
            self.brandProduct = brandProduct
            self.cardholderName = cardholderName
            self.country = country
            self.description = description
            self.expMonth = expMonth
            self.expYear = expYear
            self.fingerprint = fingerprint
            self.funding = funding
            self.iin = iin
            self.issuer = issuer
            self.last4 = last4
            self.networks = networks
            self.offline = offline
            self.preferredLocales = preferredLocales
            self.readMethod = readMethod
            self.wallet = wallet
        }

        /// How card details were read in this transaction.
        public enum ReadMethod: String, Codable, Hashable, Sendable {
            case contactEmv = "contact_emv"
            case contactlessEmv = "contactless_emv"
            case contactlessMagstripeMode = "contactless_magstripe_mode"
            case magneticStripeFallback = "magnetic_stripe_fallback"
            case magneticStripeTrack2 = "magnetic_stripe_track2"
        }
    }
}

// payment_method_card_present_networks
extension Stripe.Shared {
    public struct PaymentMethodCardPresentNetworks: Codable, Hashable, Sendable {
        /// All networks available for selection via payment_method_options.card.network.
        public var available: [String]?
        /// The preferred network for the card.
        public var preferred: String?

        public init(
            available: [String]? = nil,
            preferred: String? = nil
        ) {
            self.available = available
            self.preferred = preferred
        }
    }
}

// payment_method_card_wallet
extension Stripe.Shared {
    public struct PaymentMethodCardWallet: Codable, Hashable, Sendable {
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

        /// The payload `type` selects; `unknown` carries a type this package does not model.
        public indirect enum Details: Hashable, Sendable {
            case amexExpressCheckout(Stripe.Shared.AmexExpressCheckout)
            case applePay(Stripe.Shared.PaymentMethodCardWalletApplePay)
            case googlePay(Stripe.Shared.PaymentMethodCardWalletGooglePay)
            case link(Stripe.Shared.Link)
            case masterpass(Stripe.Shared.Masterpass)
            case samsungPay(Stripe.Shared.SamsungPay)
            case visaCheckout(Stripe.Shared.VisaCheckout)
            case unknown(type: String)

            public var amexExpressCheckout: Stripe.Shared.AmexExpressCheckout? {
                if case .amexExpressCheckout(let value) = self { return value }
                return nil
            }
            public var applePay: Stripe.Shared.PaymentMethodCardWalletApplePay? {
                if case .applePay(let value) = self { return value }
                return nil
            }
            public var googlePay: Stripe.Shared.PaymentMethodCardWalletGooglePay? {
                if case .googlePay(let value) = self { return value }
                return nil
            }
            public var link: Stripe.Shared.Link? {
                if case .link(let value) = self { return value }
                return nil
            }
            public var masterpass: Stripe.Shared.Masterpass? {
                if case .masterpass(let value) = self { return value }
                return nil
            }
            public var samsungPay: Stripe.Shared.SamsungPay? {
                if case .samsungPay(let value) = self { return value }
                return nil
            }
            public var visaCheckout: Stripe.Shared.VisaCheckout? {
                if case .visaCheckout(let value) = self { return value }
                return nil
            }

            fileprivate init(type: String, from container: KeyedDecodingContainer<CodingKeys>) throws {
                switch type {
                case "amex_express_checkout":
                    if let value = try container.decodeIfPresent(Stripe.Shared.AmexExpressCheckout.self, forKey: .amexExpressCheckout) {
                        self = .amexExpressCheckout(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "apple_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodCardWalletApplePay.self, forKey: .applePay) {
                        self = .applePay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "google_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodCardWalletGooglePay.self, forKey: .googlePay) {
                        self = .googlePay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "link":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Link.self, forKey: .link) {
                        self = .link(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "masterpass":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Masterpass.self, forKey: .masterpass) {
                        self = .masterpass(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "samsung_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.SamsungPay.self, forKey: .samsungPay) {
                        self = .samsungPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "visa_checkout":
                    if let value = try container.decodeIfPresent(Stripe.Shared.VisaCheckout.self, forKey: .visaCheckout) {
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

// payment_method_card_wallet_apple_pay
extension Stripe.Shared {
    public struct PaymentMethodCardWalletApplePay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_card_wallet_google_pay
extension Stripe.Shared {
    public struct PaymentMethodCardWalletGooglePay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_config_biz_payment_method_configuration_details
extension Stripe.Shared {
    public struct PaymentMethodConfigurationDetails: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// ID of the parent payment method configuration used.
        public var parent: String?

        public init(
            id: ID,
            parent: String? = nil
        ) {
            self.id = id
            self.parent = parent
        }
    }
}

// payment_method_crypto
extension Stripe.Shared {
    public struct PaymentMethodCrypto: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_customer_balance
extension Stripe.Shared {
    public struct PaymentMethodCustomerBalance: Codable, Hashable, Sendable {
        public init() {}
    }
}

// card_generated_from_payment_method_details
extension Stripe.Shared {
    public struct PaymentMethodDetails: Codable, Hashable, Sendable {
        public var cardPresent: Stripe.Shared.CardPresent?
        /// The type of payment method transaction-specific details from the transaction that generated this `card` payment.
        public var `type`: String?

        public init(
            cardPresent: Stripe.Shared.CardPresent? = nil,
            `type`: String? = nil
        ) {
            self.cardPresent = cardPresent
            self.`type` = `type`
        }
    }
}

// payment_method_details_card_installments_plan
extension Stripe.Shared {
    public struct PaymentMethodDetailsCardInstallmentsPlan: Codable, Hashable, Sendable {
        /// For `fixed_count` installment plans, this is the number of installment payments your customer will make to their.
        public var count: Int?
        /// For `fixed_count` installment plans, this is the interval between installment payments your customer will make to.
        public var interval: String?
        /// Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
        public var `type`: Type?

        public init(
            count: Int? = nil,
            interval: String? = nil,
            `type`: Type? = nil
        ) {
            self.count = count
            self.interval = interval
            self.`type` = `type`
        }

        /// Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case bonus
            case fixedCount = "fixed_count"
            case revolving
        }
    }
}

// payment_method_details_customer_balance
extension Stripe.Shared {
    public struct PaymentMethodDetailsCustomerBalance: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_interac_present_receipt
extension Stripe.Shared {
    public struct PaymentMethodDetailsInteracPresentReceipt: Codable, Hashable, Sendable {
        /// The type of account being debited or credited.
        public var accountType: AccountType?
        /// The Application Cryptogram, a unique value generated by the card to authenticate the transaction with issuers.
        public var applicationCryptogram: String?
        /// The Application Identifier (AID) on the card used to determine which networks are eligible to process the transaction.
        public var applicationPreferredName: String?
        /// Identifier for this transaction.
        public var authorizationCode: String?
        /// EMV tag 8A.
        public var authorizationResponseCode: String?
        /// Describes the method used by the cardholder to verify ownership of the card.
        public var cardholderVerificationMethod: String?
        /// Similar to the application_preferred_name, identifying the applications (AIDs) available on the card.
        public var dedicatedFileName: String?
        /// A 5-byte string that records the checks and validations that occur between the card and the terminal.
        public var terminalVerificationResults: String?
        /// An indication of which steps were completed during the card read process.
        public var transactionStatusInformation: String?

        public init(
            accountType: AccountType? = nil,
            applicationCryptogram: String? = nil,
            applicationPreferredName: String? = nil,
            authorizationCode: String? = nil,
            authorizationResponseCode: String? = nil,
            cardholderVerificationMethod: String? = nil,
            dedicatedFileName: String? = nil,
            terminalVerificationResults: String? = nil,
            transactionStatusInformation: String? = nil
        ) {
            self.accountType = accountType
            self.applicationCryptogram = applicationCryptogram
            self.applicationPreferredName = applicationPreferredName
            self.authorizationCode = authorizationCode
            self.authorizationResponseCode = authorizationResponseCode
            self.cardholderVerificationMethod = cardholderVerificationMethod
            self.dedicatedFileName = dedicatedFileName
            self.terminalVerificationResults = terminalVerificationResults
            self.transactionStatusInformation = transactionStatusInformation
        }

        /// The type of account being debited or credited.
        public enum AccountType: String, Codable, Hashable, Sendable {
            case checking
            case savings
            case unknown
        }
    }
}

// payment_method_details_payment_record_acss_debit
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAcssDebit: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_affirm
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAffirm: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_afterpay_clearpay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAfterpayClearpay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_alipay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAlipay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_alma
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAlma: Codable, Hashable, Sendable {
        public var installments: Stripe.Shared.Installments?
        /// The Alma transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            installments: Stripe.Shared.Installments? = nil,
            transactionId: String? = nil
        ) {
            self.installments = installments
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_amazon_pay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAmazonPay: Codable, Hashable, Sendable {
        public var funding: Stripe.Shared.Funding?
        /// The Amazon Pay transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            funding: Stripe.Shared.Funding? = nil,
            transactionId: String? = nil
        ) {
            self.funding = funding
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_au_becs_debit
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordAuBecsDebit: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_bacs_debit
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordBacsDebit: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_bancontact
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordBancontact: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_billie
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordBillie: Codable, Hashable, Sendable {
        /// The Billie transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            transactionId: String? = nil
        ) {
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_bizum
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordBizum: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_blik
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordBlik: Codable, Hashable, Sendable {
        /// A unique and immutable identifier assigned by BLIK to every buyer.
        public var buyerId: String?

        public init(
            buyerId: String? = nil
        ) {
            self.buyerId = buyerId
        }
    }
}

// payment_method_details_payment_record_boleto
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordBoleto: Codable, Hashable, Sendable {
        /// The tax ID of the customer (CPF for individuals consumers or CNPJ for businesses consumers).
        public var taxId: String?

        public init(
            taxId: String? = nil
        ) {
            self.taxId = taxId
        }
    }
}

// payment_method_details_payment_record_cashapp
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordCashapp: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_eps
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordEps: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_giropay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordGiropay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_ideal
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordIdeal: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_kakao_pay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordKakaoPay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_klarna
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordKlarna: Codable, Hashable, Sendable {
        /// ID of the location that this transaction's reader is assigned to.
        public var location: String?
        /// The payer details for this transaction.
        public var payerDetails: Stripe.Shared.PayerDetails?
        /// The Klarna payment method used for this transaction.
        public var paymentMethodCategory: String?
        /// Preferred language of the Klarna authorization page that the customer is redirected to.
        public var preferredLocale: String?
        /// ID of the reader this transaction was made on.
        public var reader: String?

        public init(
            location: String? = nil,
            payerDetails: Stripe.Shared.PayerDetails? = nil,
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
    }
}

// payment_method_details_payment_record_konbini
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordKonbini: Codable, Hashable, Sendable {
        /// If the payment succeeded, this contains the details of the convenience store where the payment was completed.
        public var store: Stripe.Shared.Store?

        public init(
            store: Stripe.Shared.Store? = nil
        ) {
            self.store = store
        }
    }
}

// payment_method_details_payment_record_link
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordLink: Codable, Hashable, Sendable {
        /// Two-letter ISO code representing the funding source country beneath the Link payment.
        public var country: String?

        public init(
            country: String? = nil
        ) {
            self.country = country
        }
    }
}

// payment_method_details_payment_record_mb_way
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordMbWay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_payment_record_mobilepay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordMobilepay: Codable, Hashable, Sendable {
        /// Internal card details.
        public var card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodMobilepayDetailsResourceCard?

        public init(
            card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodMobilepayDetailsResourceCard? = nil
        ) {
            self.card = card
        }
    }
}

// payment_method_details_payment_record_multibanco
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordMultibanco: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_naver_pay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordNaverPay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_nz_bank_account
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordNzBankAccount: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_oxxo
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordOxxo: Codable, Hashable, Sendable {
        /// OXXO reference number.
        public var number: String?

        public init(
            number: String? = nil
        ) {
            self.number = number
        }
    }
}

// payment_method_details_payment_record_p24
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordP24: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_pay_by_bank
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordPayByBank: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_payment_record_payco
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordPayco: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_paynow
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordPaynow: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_payto
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordPayto: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_pix
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordPix: Codable, Hashable, Sendable {
        /// Unique transaction id generated by BCB.
        public var bankTransactionId: String?
        /// ID of the multi use Mandate generated by the PaymentIntent or SetupIntent.
        public var mandate: String?

        public init(
            bankTransactionId: String? = nil,
            mandate: String? = nil
        ) {
            self.bankTransactionId = bankTransactionId
            self.mandate = mandate
        }
    }
}

// payment_method_details_payment_record_promptpay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordPromptpay: Codable, Hashable, Sendable {
        /// Bill reference generated by PromptPay.
        public var reference: String?

        public init(
            reference: String? = nil
        ) {
            self.reference = reference
        }
    }
}

// payment_method_details_payment_record_revolut_pay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordRevolutPay: Codable, Hashable, Sendable {
        public var funding: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodRevolutPayDetailsResourceFunding?
        /// The Revolut Pay transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            funding: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodRevolutPayDetailsResourceFunding? = nil,
            transactionId: String? = nil
        ) {
            self.funding = funding
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_samsung_pay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordSamsungPay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_satispay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordSatispay: Codable, Hashable, Sendable {
        /// The Satispay transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            transactionId: String? = nil
        ) {
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_scalapay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordScalapay: Codable, Hashable, Sendable {
        /// The Scalapay transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            transactionId: String? = nil
        ) {
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_sepa_debit
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordSepaDebit: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_sofort
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordSofort: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_sunbit
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordSunbit: Codable, Hashable, Sendable {
        /// The Sunbit transaction ID associated with this payment.
        public var transactionId: String?

        public init(
            transactionId: String? = nil
        ) {
            self.transactionId = transactionId
        }
    }
}

// payment_method_details_payment_record_swish
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordSwish: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_twint
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordTwint: Codable, Hashable, Sendable {
        /// ID of the multi use Mandate generated by the PaymentIntent or SetupIntent.
        public var mandate: String?

        public init(
            mandate: String? = nil
        ) {
            self.mandate = mandate
        }
    }
}

// payment_method_details_payment_record_upi
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordUpi: Codable, Hashable, Sendable {
        /// Customer's unique Virtual Payment Address.
        public var vpa: String?

        public init(
            vpa: String? = nil
        ) {
            self.vpa = vpa
        }
    }
}

// payment_method_details_payment_record_us_bank_account
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordUsBankAccount: Codable, Hashable, Sendable {
        /// The type of entity that holds the account.
        public var accountHolderType: AccountHolderType?
        /// The type of the bank account.
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
        /// The ACH payment reference for this transaction.
        public var paymentReference: String?
        /// The routing number for the bank account.
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

        /// The type of entity that holds the account.
        public enum AccountHolderType: String, Codable, Hashable, Sendable {
            case company
            case individual
        }

        /// The type of the bank account.
        public enum AccountType: String, Codable, Hashable, Sendable {
            case checking
            case savings
        }
    }
}

// payment_method_details_payment_record_wechat_pay
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordWechatPay: Codable, Hashable, Sendable {
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
}

// payment_method_details_payment_record_zip
extension Stripe.Shared {
    public struct PaymentMethodDetailsPaymentRecordZip: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_fpx
extension Stripe.Shared {
    public struct PaymentMethodFpx: Codable, Hashable, Sendable {
        /// Account holder type, if provided.
        public var accountHolderType: AccountHolderType?
        /// The customer's bank, if provided.
        public var bank: Bank?

        public init(
            accountHolderType: AccountHolderType? = nil,
            bank: Bank? = nil
        ) {
            self.accountHolderType = accountHolderType
            self.bank = bank
        }

        /// Account holder type, if provided.
        public enum AccountHolderType: String, Codable, Hashable, Sendable {
            case company
            case individual
        }

        /// The customer's bank, if provided.
        public enum Bank: String, Codable, Hashable, Sendable {
            case affinBank = "affin_bank"
            case agrobank
            case allianceBank = "alliance_bank"
            case ambank
            case bankIslam = "bank_islam"
            case bankMuamalat = "bank_muamalat"
            case bankOfChina = "bank_of_china"
            case bankRakyat = "bank_rakyat"
            case bnpParibas = "bnp_paribas"
            case bsn
            case cimb
            case citibank
            case deutscheBank = "deutsche_bank"
            case hongLeongBank = "hong_leong_bank"
            case hsbc
            case kfh
            case maybank2e
            case maybank2u
            case mbsbBank = "mbsb_bank"
            case ocbc
            case pbEnterprise = "pb_enterprise"
            case publicBank = "public_bank"
            case rhb
            case standardChartered = "standard_chartered"
            case uob
        }
    }
}

// payment_method_grabpay
extension Stripe.Shared {
    public struct PaymentMethodGrabpay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_interac_present
extension Stripe.Shared {
    public struct PaymentMethodInteracPresent: Codable, Hashable, Sendable {
        /// Card brand.
        public var brand: String?
        /// The cardholder name as read from the card, in ISO 7813 format.
        public var cardholderName: String?
        /// Two-letter ISO code representing the country of the card.
        public var country: String?
        /// A high-level description of the type of cards issued in this range.
        public var description: String?
        /// Two-digit number representing the card's expiration month.
        public var expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public var expYear: Int?
        /// Uniquely identifies this particular card number.
        public var fingerprint: String?
        /// Card funding type.
        public var funding: String?
        /// Issuer identification number of the card.
        public var iin: String?
        /// The name of the card's issuing bank.
        public var issuer: String?
        /// The last four digits of the card.
        public var last4: String?
        /// Contains information about card networks that can be used to process the payment.
        public var networks: Stripe.Shared.PaymentMethodCardPresentNetworks?
        /// The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card.
        public var preferredLocales: [String]?
        /// How card details were read in this transaction.
        public var readMethod: ReadMethod?

        public init(
            brand: String? = nil,
            cardholderName: String? = nil,
            country: String? = nil,
            description: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            fingerprint: String? = nil,
            funding: String? = nil,
            iin: String? = nil,
            issuer: String? = nil,
            last4: String? = nil,
            networks: Stripe.Shared.PaymentMethodCardPresentNetworks? = nil,
            preferredLocales: [String]? = nil,
            readMethod: ReadMethod? = nil
        ) {
            self.brand = brand
            self.cardholderName = cardholderName
            self.country = country
            self.description = description
            self.expMonth = expMonth
            self.expYear = expYear
            self.fingerprint = fingerprint
            self.funding = funding
            self.iin = iin
            self.issuer = issuer
            self.last4 = last4
            self.networks = networks
            self.preferredLocales = preferredLocales
            self.readMethod = readMethod
        }

        /// How card details were read in this transaction.
        public enum ReadMethod: String, Codable, Hashable, Sendable {
            case contactEmv = "contact_emv"
            case contactlessEmv = "contactless_emv"
            case contactlessMagstripeMode = "contactless_magstripe_mode"
            case magneticStripeFallback = "magnetic_stripe_fallback"
            case magneticStripeTrack2 = "magnetic_stripe_track2"
        }
    }
}

// payment_method_konbini
extension Stripe.Shared {
    public struct PaymentMethodKonbini: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_kr_card
extension Stripe.Shared {
    public struct PaymentMethodKrCard: Codable, Hashable, Sendable {
        /// The local credit or debit card brand.
        public var brand: Brand?
        /// The last four digits of the card.
        public var last4: String?

        public init(
            brand: Brand? = nil,
            last4: String? = nil
        ) {
            self.brand = brand
            self.last4 = last4
        }

        /// The local credit or debit card brand.
        public enum Brand: String, Codable, Hashable, Sendable {
            case bc
            case citi
            case hana
            case hyundai
            case jeju
            case jeonbuk
            case kakaobank
            case kbank
            case kdbbank
            case kookmin
            case kwangju
            case lotte
            case mg
            case nh
            case post
            case samsung
            case savingsbank
            case shinhan
            case shinhyup
            case suhyup
            case tossbank
            case woori
        }
    }
}

// payment_method_link
extension Stripe.Shared {
    public struct PaymentMethodLink: Codable, Hashable, Sendable {
        /// Account owner's email address.
        public var email: String?
        /// [Deprecated] This is a legacy parameter that no longer has any function.
        public var persistentToken: String?

        public init(
            email: String? = nil,
            persistentToken: String? = nil
        ) {
            self.email = email
            self.persistentToken = persistentToken
        }
    }
}

// payment_method_options_us_bank_account_mandate_options
extension Stripe.Shared {
    public struct PaymentMethodOptionsUsBankAccountMandateOptions: Codable, Hashable, Sendable {
        /// Mandate collection method.
        public var collectionMethod: String?

        public init(
            collectionMethod: String? = nil
        ) {
            self.collectionMethod = collectionMethod
        }
    }
}

// payment_method_paypal
extension Stripe.Shared {
    public struct PaymentMethodPaypal: Codable, Hashable, Sendable {
        /// Two-letter ISO code representing the buyer's country.
        public var country: String?
        /// Owner's email.
        public var payerEmail: String?
        /// PayPal account PayerID.
        public var payerId: String?

        public init(
            country: String? = nil,
            payerEmail: String? = nil,
            payerId: String? = nil
        ) {
            self.country = country
            self.payerEmail = payerEmail
            self.payerId = payerId
        }
    }
}

// payment_method_payto
extension Stripe.Shared {
    public struct PaymentMethodPayto: Codable, Hashable, Sendable {
        /// Bank-State-Branch number of the bank account.
        public var bsbNumber: String?
        /// Last four digits of the bank account number.
        public var last4: String?
        /// The PayID alias for the bank account.
        public var payId: String?

        public init(
            bsbNumber: String? = nil,
            last4: String? = nil,
            payId: String? = nil
        ) {
            self.bsbNumber = bsbNumber
            self.last4 = last4
            self.payId = payId
        }
    }
}

// payment_method_samsung_pay
extension Stripe.Shared {
    public struct PaymentMethodSamsungPay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_sepa_debit
extension Stripe.Shared {
    public struct PaymentMethodSepaDebit: Codable, Hashable, Sendable {
        /// Bank code of bank associated with the bank account.
        public var bankCode: String?
        /// Branch code of bank associated with the bank account.
        public var branchCode: String?
        /// Two-letter ISO code representing the country the bank account is located in.
        public var country: String?
        /// Uniquely identifies this particular bank account.
        public var fingerprint: String?
        /// Information about the object that generated this PaymentMethod.
        public var generatedFrom: Stripe.Shared.SepaDebitGeneratedFrom?
        /// Last four characters of the IBAN.
        public var last4: String?

        public init(
            bankCode: String? = nil,
            branchCode: String? = nil,
            country: String? = nil,
            fingerprint: String? = nil,
            generatedFrom: Stripe.Shared.SepaDebitGeneratedFrom? = nil,
            last4: String? = nil
        ) {
            self.bankCode = bankCode
            self.branchCode = branchCode
            self.country = country
            self.fingerprint = fingerprint
            self.generatedFrom = generatedFrom
            self.last4 = last4
        }
    }
}

// payment_method_upi
extension Stripe.Shared {
    public struct PaymentMethodUpi: Codable, Hashable, Sendable {
        /// Customer's unique Virtual Payment Address.
        public var vpa: String?

        public init(
            vpa: String? = nil
        ) {
            self.vpa = vpa
        }
    }
}

// payment_method_us_bank_account
extension Stripe.Shared {
    public struct PaymentMethodUsBankAccount: Codable, Hashable, Sendable {
        /// Account holder type: individual or company.
        public var accountHolderType: AccountHolderType?
        /// Account type: checkings or savings.
        public var accountType: AccountType?
        /// The name of the bank.
        public var bankName: String?
        /// The ID of the Financial Connections Account used to create the payment method.
        public var financialConnectionsAccount: String?
        /// Uniquely identifies this particular bank account.
        public var fingerprint: String?
        /// Last four digits of the bank account number.
        public var last4: String?
        /// Contains information about US bank account networks that can be used.
        public var networks: Stripe.Shared.UsBankAccountNetworks?
        /// Routing number of the bank account.
        public var routingNumber: String?
        /// Contains information about the future reusability of this PaymentMethod.
        public var statusDetails: Stripe.Shared.StatusDetails?

        public init(
            accountHolderType: AccountHolderType? = nil,
            accountType: AccountType? = nil,
            bankName: String? = nil,
            financialConnectionsAccount: String? = nil,
            fingerprint: String? = nil,
            last4: String? = nil,
            networks: Stripe.Shared.UsBankAccountNetworks? = nil,
            routingNumber: String? = nil,
            statusDetails: Stripe.Shared.StatusDetails? = nil
        ) {
            self.accountHolderType = accountHolderType
            self.accountType = accountType
            self.bankName = bankName
            self.financialConnectionsAccount = financialConnectionsAccount
            self.fingerprint = fingerprint
            self.last4 = last4
            self.networks = networks
            self.routingNumber = routingNumber
            self.statusDetails = statusDetails
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
}

// payments_primitives_payment_records_resource_address
extension Stripe.Shared {
    /// A representation of a physical address.
    public struct PaymentsPrimitivesPaymentRecordsResourceAddress: Codable, Hashable, Sendable {
        /// City, district, suburb, town, or village.
        public var city: String?
        /// Two-letter country code (ISO 3166-1 alpha-2).
        public var country: String?
        /// Address line 1, such as the street, PO Box, or company name.
        public var line1: String?
        /// Address line 2, such as the apartment, suite, unit, or building.
        public var line2: String?
        /// ZIP or postal code.
        public var postalCode: String?
        /// State, county, province, or region (ISO 3166-2).
        public var state: String?

        public init(
            city: String? = nil,
            country: String? = nil,
            line1: String? = nil,
            line2: String? = nil,
            postalCode: String? = nil,
            state: String? = nil
        ) {
            self.city = city
            self.country = country
            self.line1 = line1
            self.line2 = line2
            self.postalCode = postalCode
            self.state = state
        }
    }
}

// payments_primitives_payment_records_resource_amount
extension Stripe.Shared {
    /// A representation of an amount of money, consisting of an amount and a currency.
    public struct PaymentsPrimitivesPaymentRecordsResourceAmount: Codable, Hashable, Sendable {
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// A positive integer representing the amount in the currency's minor unit.
        public var value: Int?

        public init(
            currency: Stripe.Currency? = nil,
            value: Int? = nil
        ) {
            self.currency = currency
            self.value = value
        }
    }
}

// payments_primitives_payment_records_resource_billing_details
extension Stripe.Shared {
    /// Billing details used by the customer for this payment.
    public struct PaymentsPrimitivesPaymentRecordsResourceBillingDetails: Codable, Hashable, Sendable {
        public var address: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAddress?
        /// The billing email associated with the method of payment.
        public var email: String?
        /// The billing name associated with the method of payment.
        public var name: String?
        /// The billing phone number associated with the method of payment.
        public var phone: String?

        public init(
            address: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAddress? = nil,
            email: String? = nil,
            name: String? = nil,
            phone: String? = nil
        ) {
            self.address = address
            self.email = email
            self.name = name
            self.phone = phone
        }
    }
}

// payments_primitives_payment_records_resource_customer_details
extension Stripe.Shared {
    /// Information about the customer for this payment.
    public struct PaymentsPrimitivesPaymentRecordsResourceCustomerDetails: Codable, Hashable, Sendable {
        /// ID of the Stripe Customer associated with this payment.
        public var customer: String?
        /// The customer's email address.
        public var email: String?
        /// The customer's name.
        public var name: String?
        /// The customer's phone number.
        public var phone: String?

        public init(
            customer: String? = nil,
            email: String? = nil,
            name: String? = nil,
            phone: String? = nil
        ) {
            self.customer = customer
            self.email = email
            self.name = name
            self.phone = phone
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_amazon_pay_details_resource_funding_resource_funding_card
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodAmazonPayDetailsResourceFundingResourceFundingCard: Codable, Hashable, Sendable
    {
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

// payments_primitives_payment_records_resource_payment_method_card_details
extension Stripe.Shared {
    /// Details of the card used for this payment attempt.
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetails: Codable, Hashable, Sendable {
        /// The authorization code of the payment.
        public var authorizationCode: String?
        /// Card brand.
        public var brand: Brand?
        /// When using manual capture, a future timestamp at which the charge will be automatically refunded if uncaptured.
        public var captureBefore: Date?
        /// Check results by Card networks on Card address and CVC at time of payment.
        public var checks: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceChecks?
        /// Two-letter ISO code representing the country of the card.
        public var country: String?
        /// A high-level description of the type of cards issued in this range.
        public var description: String?
        /// Two-digit number representing the card's expiration month.
        public var expMonth: Int?
        /// Four-digit number representing the card's expiration year.
        public var expYear: Int?
        /// Uniquely identifies this particular card number.
        public var fingerprint: String?
        /// Card funding type.
        public var funding: Funding?
        /// Issuer identification number of the card.
        public var iin: String?
        /// Installment details for this payment.
        public var installments: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceInstallments?
        /// The name of the card's issuing bank.
        public var issuer: String?
        /// The last four digits of the card.
        public var last4: String?
        /// True if this payment was marked as MOTO and out of scope for SCA.
        public var moto: Bool?
        /// Identifies which network this charge was processed on.
        public var network: Network?
        /// Advice code from the card network for the failed payment.
        public var networkAdviceCode: String?
        /// Decline code from the card network for the failed payment.
        public var networkDeclineCode: String?
        /// If this card has network token credentials, this contains the details of the network token credentials.
        public var networkToken: Stripe.Shared.NetworkToken?
        /// This is used by the financial networks to identify a transaction.
        public var networkTransactionId: String?
        /// Populated if this transaction used 3D Secure authentication.
        public var threeDSecure: Stripe.Shared.ThreeDSecure?
        /// If this Card is part of a card wallet, this contains the details of the card wallet.
        public var wallet: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWallet?

        public init(
            authorizationCode: String? = nil,
            brand: Brand? = nil,
            captureBefore: Date? = nil,
            checks: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceChecks? = nil,
            country: String? = nil,
            description: String? = nil,
            expMonth: Int? = nil,
            expYear: Int? = nil,
            fingerprint: String? = nil,
            funding: Funding? = nil,
            iin: String? = nil,
            installments: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceInstallments? = nil,
            issuer: String? = nil,
            last4: String? = nil,
            moto: Bool? = nil,
            network: Network? = nil,
            networkAdviceCode: String? = nil,
            networkDeclineCode: String? = nil,
            networkToken: Stripe.Shared.NetworkToken? = nil,
            networkTransactionId: String? = nil,
            threeDSecure: Stripe.Shared.ThreeDSecure? = nil,
            wallet: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWallet? = nil
        ) {
            self.authorizationCode = authorizationCode
            self.brand = brand
            self.captureBefore = captureBefore
            self.checks = checks
            self.country = country
            self.description = description
            self.expMonth = expMonth
            self.expYear = expYear
            self.fingerprint = fingerprint
            self.funding = funding
            self.iin = iin
            self.installments = installments
            self.issuer = issuer
            self.last4 = last4
            self.moto = moto
            self.network = network
            self.networkAdviceCode = networkAdviceCode
            self.networkDeclineCode = networkDeclineCode
            self.networkToken = networkToken
            self.networkTransactionId = networkTransactionId
            self.threeDSecure = threeDSecure
            self.wallet = wallet
        }

        /// Card brand.
        public enum Brand: String, Codable, Hashable, Sendable {
            case amex
            case cartesBancaires = "cartes_bancaires"
            case diners
            case discover
            case eftposAu = "eftpos_au"
            case interac
            case jcb
            case link
            case mastercard
            case unionpay
            case unknown
            case visa
        }

        /// Card funding type.
        public enum Funding: String, Codable, Hashable, Sendable {
            case credit
            case debit
            case prepaid
            case unknown
        }

        /// Identifies which network this charge was processed on.
        public enum Network: String, Codable, Hashable, Sendable {
            case amex
            case cartesBancaires = "cartes_bancaires"
            case diners
            case discover
            case eftposAu = "eftpos_au"
            case interac
            case jcb
            case link
            case mastercard
            case unionpay
            case unknown
            case visa
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_checks
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceChecks: Codable, Hashable, Sendable {
        /// If you provide a value for `address.line1`, the check result is one of `pass`, `fail`, `unavailable`, or `unchecked`.
        public var addressLine1Check: AddressLine1Check?
        /// If you provide a address postal code, the check result is one of `pass`, `fail`, `unavailable`, or `unchecked`.
        public var addressPostalCodeCheck: AddressPostalCodeCheck?
        /// If you provide a CVC, the check results is one of `pass`, `fail`, `unavailable`, or `unchecked`.
        public var cvcCheck: CvcCheck?

        public init(
            addressLine1Check: AddressLine1Check? = nil,
            addressPostalCodeCheck: AddressPostalCodeCheck? = nil,
            cvcCheck: CvcCheck? = nil
        ) {
            self.addressLine1Check = addressLine1Check
            self.addressPostalCodeCheck = addressPostalCodeCheck
            self.cvcCheck = cvcCheck
        }

        /// If you provide a value for `address.line1`, the check result is one of `pass`, `fail`, `unavailable`, or `unchecked`.
        public enum AddressLine1Check: String, Codable, Hashable, Sendable {
            case fail
            case pass
            case unavailable
            case unchecked
        }

        /// If you provide a address postal code, the check result is one of `pass`, `fail`, `unavailable`, or `unchecked`.
        public enum AddressPostalCodeCheck: String, Codable, Hashable, Sendable {
            case fail
            case pass
            case unavailable
            case unchecked
        }

        /// If you provide a CVC, the check results is one of `pass`, `fail`, `unavailable`, or `unchecked`.
        public enum CvcCheck: String, Codable, Hashable, Sendable {
            case fail
            case pass
            case unavailable
            case unchecked
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_installments
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceInstallments: Codable, Hashable, Sendable {
        /// Installment plan selected for the payment.
        public var plan: Stripe.Shared.Plan?

        public init(
            plan: Stripe.Shared.Plan? = nil
        ) {
            self.plan = plan
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_wallet
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWallet: Codable, Hashable, Sendable {
        public var applePay: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWalletResourceApplePay?
        /// The last four digits of the device account number.
        public var dynamicLast4: String?
        public var googlePay: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWalletResourceGooglePay?
        /// The type of the card wallet, one of `apple_pay` or `google_pay`.
        public var `type`: String?

        public init(
            applePay: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWalletResourceApplePay? = nil,
            dynamicLast4: String? = nil,
            googlePay: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWalletResourceGooglePay? = nil,
            `type`: String? = nil
        ) {
            self.applePay = applePay
            self.dynamicLast4 = dynamicLast4
            self.googlePay = googlePay
            self.`type` = `type`
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_wallet_resource_apple_pay
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWalletResourceApplePay: Codable, Hashable, Sendable {
        /// Type of the apple_pay transaction, one of `apple_pay` or `apple_pay_later`.
        public var `type`: String?

        public init(
            `type`: String? = nil
        ) {
            self.`type` = `type`
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_wallet_resource_google_pay
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetailsResourceWalletResourceGooglePay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payments_primitives_payment_records_resource_payment_method_details
extension Stripe.Shared {
    /// Details about the Payment Method used in this payment attempt.
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodDetails: Codable, Hashable, Sendable {
        /// ID of the Stripe PaymentMethod used to make this payment.
        public var paymentMethod: String?
        /// The type of transaction-specific details of the payment method used in the payment.
        public var `type`: String?
        /// The payload `type` selects.
        public var details: Details

        fileprivate enum CodingKeys: String, CodingKey {
            case paymentMethod
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
            case billingDetails
            case bizum
            case blik
            case boleto
            case card
            case cardPresent
            case cashapp
            case crypto
            case custom
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
            paymentMethod: String? = nil,
            `type`: String? = nil,
            details: Details
        ) {
            self.paymentMethod = paymentMethod
            self.`type` = `type`
            self.details = details
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.paymentMethod = try container.decodeIfPresent(String.self, forKey: .paymentMethod)
            self.`type` = try container.decodeIfPresent(String.self, forKey: .`type`)
            self.details = try Details(type: try container.decodeIfPresent(String.self, forKey: .type) ?? "", from: container)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(paymentMethod, forKey: .paymentMethod)
            try container.encodeIfPresent(`type`, forKey: .`type`)
            try details.encode(into: &container)
        }

        /// The payload `type` selects; `unknown` carries a type this package does not model.
        public indirect enum Details: Hashable, Sendable {
            case achCreditTransfer(Stripe.Shared.AchCreditTransfer)
            case achDebit(Stripe.Shared.AchDebit)
            case acssDebit(Stripe.Shared.PaymentMethodDetailsPaymentRecordAcssDebit)
            case affirm(Stripe.Shared.PaymentMethodDetailsPaymentRecordAffirm)
            case afterpayClearpay(Stripe.Shared.PaymentMethodDetailsPaymentRecordAfterpayClearpay)
            case alipay(Stripe.Shared.PaymentMethodDetailsPaymentRecordAlipay)
            case alma(Stripe.Shared.PaymentMethodDetailsPaymentRecordAlma)
            case amazonPay(Stripe.Shared.PaymentMethodDetailsPaymentRecordAmazonPay)
            case auBecsDebit(Stripe.Shared.PaymentMethodDetailsPaymentRecordAuBecsDebit)
            case bacsDebit(Stripe.Shared.PaymentMethodDetailsPaymentRecordBacsDebit)
            case bancontact(Stripe.Shared.PaymentMethodDetailsPaymentRecordBancontact)
            case billie(Stripe.Shared.PaymentMethodDetailsPaymentRecordBillie)
            case billingDetails(Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceBillingDetails)
            case bizum(Stripe.Shared.PaymentMethodDetailsPaymentRecordBizum)
            case blik(Stripe.Shared.PaymentMethodDetailsPaymentRecordBlik)
            case boleto(Stripe.Shared.PaymentMethodDetailsPaymentRecordBoleto)
            case card(Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetails)
            case cardPresent(Stripe.Shared.CardPresent)
            case cashapp(Stripe.Shared.PaymentMethodDetailsPaymentRecordCashapp)
            case crypto(Stripe.Shared.Crypto)
            case custom(Stripe.Shared.Custom)
            case customerBalance(Stripe.Shared.PaymentMethodDetailsCustomerBalance)
            case eps(Stripe.Shared.PaymentMethodDetailsPaymentRecordEps)
            case fpx(Stripe.Shared.Fpx)
            case giropay(Stripe.Shared.PaymentMethodDetailsPaymentRecordGiropay)
            case grabpay(Stripe.Shared.Grabpay)
            case ideal(Stripe.Shared.PaymentMethodDetailsPaymentRecordIdeal)
            case interacPresent(Stripe.Shared.InteracPresent)
            case kakaoPay(Stripe.Shared.PaymentMethodDetailsPaymentRecordKakaoPay)
            case klarna(Stripe.Shared.PaymentMethodDetailsPaymentRecordKlarna)
            case konbini(Stripe.Shared.PaymentMethodDetailsPaymentRecordKonbini)
            case krCard(Stripe.Shared.KrCard)
            case link(Stripe.Shared.PaymentMethodDetailsPaymentRecordLink)
            case mbWay(Stripe.Shared.PaymentMethodDetailsPaymentRecordMbWay)
            case mobilepay(Stripe.Shared.PaymentMethodDetailsPaymentRecordMobilepay)
            case multibanco(Stripe.Shared.PaymentMethodDetailsPaymentRecordMultibanco)
            case naverPay(Stripe.Shared.PaymentMethodDetailsPaymentRecordNaverPay)
            case nzBankAccount(Stripe.Shared.PaymentMethodDetailsPaymentRecordNzBankAccount)
            case oxxo(Stripe.Shared.PaymentMethodDetailsPaymentRecordOxxo)
            case p24(Stripe.Shared.PaymentMethodDetailsPaymentRecordP24)
            case payByBank(Stripe.Shared.PaymentMethodDetailsPaymentRecordPayByBank)
            case payco(Stripe.Shared.PaymentMethodDetailsPaymentRecordPayco)
            case paynow(Stripe.Shared.PaymentMethodDetailsPaymentRecordPaynow)
            case paypal(Stripe.Shared.Paypal)
            case payto(Stripe.Shared.PaymentMethodDetailsPaymentRecordPayto)
            case pix(Stripe.Shared.PaymentMethodDetailsPaymentRecordPix)
            case promptpay(Stripe.Shared.PaymentMethodDetailsPaymentRecordPromptpay)
            case revolutPay(Stripe.Shared.PaymentMethodDetailsPaymentRecordRevolutPay)
            case samsungPay(Stripe.Shared.PaymentMethodDetailsPaymentRecordSamsungPay)
            case satispay(Stripe.Shared.PaymentMethodDetailsPaymentRecordSatispay)
            case scalapay(Stripe.Shared.PaymentMethodDetailsPaymentRecordScalapay)
            case sepaCreditTransfer(Stripe.Shared.SepaCreditTransfer)
            case sepaDebit(Stripe.Shared.PaymentMethodDetailsPaymentRecordSepaDebit)
            case sofort(Stripe.Shared.PaymentMethodDetailsPaymentRecordSofort)
            case stripeAccount(Stripe.Shared.StripeAccount)
            case sunbit(Stripe.Shared.PaymentMethodDetailsPaymentRecordSunbit)
            case swish(Stripe.Shared.PaymentMethodDetailsPaymentRecordSwish)
            case twint(Stripe.Shared.PaymentMethodDetailsPaymentRecordTwint)
            case upi(Stripe.Shared.PaymentMethodDetailsPaymentRecordUpi)
            case usBankAccount(Stripe.Shared.PaymentMethodDetailsPaymentRecordUsBankAccount)
            case wechat(Stripe.Shared.Wechat)
            case wechatPay(Stripe.Shared.PaymentMethodDetailsPaymentRecordWechatPay)
            case zip(Stripe.Shared.PaymentMethodDetailsPaymentRecordZip)
            case unknown(type: String)

            public var achCreditTransfer: Stripe.Shared.AchCreditTransfer? {
                if case .achCreditTransfer(let value) = self { return value }
                return nil
            }
            public var achDebit: Stripe.Shared.AchDebit? {
                if case .achDebit(let value) = self { return value }
                return nil
            }
            public var acssDebit: Stripe.Shared.PaymentMethodDetailsPaymentRecordAcssDebit? {
                if case .acssDebit(let value) = self { return value }
                return nil
            }
            public var affirm: Stripe.Shared.PaymentMethodDetailsPaymentRecordAffirm? {
                if case .affirm(let value) = self { return value }
                return nil
            }
            public var afterpayClearpay: Stripe.Shared.PaymentMethodDetailsPaymentRecordAfterpayClearpay? {
                if case .afterpayClearpay(let value) = self { return value }
                return nil
            }
            public var alipay: Stripe.Shared.PaymentMethodDetailsPaymentRecordAlipay? {
                if case .alipay(let value) = self { return value }
                return nil
            }
            public var alma: Stripe.Shared.PaymentMethodDetailsPaymentRecordAlma? {
                if case .alma(let value) = self { return value }
                return nil
            }
            public var amazonPay: Stripe.Shared.PaymentMethodDetailsPaymentRecordAmazonPay? {
                if case .amazonPay(let value) = self { return value }
                return nil
            }
            public var auBecsDebit: Stripe.Shared.PaymentMethodDetailsPaymentRecordAuBecsDebit? {
                if case .auBecsDebit(let value) = self { return value }
                return nil
            }
            public var bacsDebit: Stripe.Shared.PaymentMethodDetailsPaymentRecordBacsDebit? {
                if case .bacsDebit(let value) = self { return value }
                return nil
            }
            public var bancontact: Stripe.Shared.PaymentMethodDetailsPaymentRecordBancontact? {
                if case .bancontact(let value) = self { return value }
                return nil
            }
            public var billie: Stripe.Shared.PaymentMethodDetailsPaymentRecordBillie? {
                if case .billie(let value) = self { return value }
                return nil
            }
            public var billingDetails: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceBillingDetails? {
                if case .billingDetails(let value) = self { return value }
                return nil
            }
            public var bizum: Stripe.Shared.PaymentMethodDetailsPaymentRecordBizum? {
                if case .bizum(let value) = self { return value }
                return nil
            }
            public var blik: Stripe.Shared.PaymentMethodDetailsPaymentRecordBlik? {
                if case .blik(let value) = self { return value }
                return nil
            }
            public var boleto: Stripe.Shared.PaymentMethodDetailsPaymentRecordBoleto? {
                if case .boleto(let value) = self { return value }
                return nil
            }
            public var card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetails? {
                if case .card(let value) = self { return value }
                return nil
            }
            public var cardPresent: Stripe.Shared.CardPresent? {
                if case .cardPresent(let value) = self { return value }
                return nil
            }
            public var cashapp: Stripe.Shared.PaymentMethodDetailsPaymentRecordCashapp? {
                if case .cashapp(let value) = self { return value }
                return nil
            }
            public var crypto: Stripe.Shared.Crypto? {
                if case .crypto(let value) = self { return value }
                return nil
            }
            public var custom: Stripe.Shared.Custom? {
                if case .custom(let value) = self { return value }
                return nil
            }
            public var customerBalance: Stripe.Shared.PaymentMethodDetailsCustomerBalance? {
                if case .customerBalance(let value) = self { return value }
                return nil
            }
            public var eps: Stripe.Shared.PaymentMethodDetailsPaymentRecordEps? {
                if case .eps(let value) = self { return value }
                return nil
            }
            public var fpx: Stripe.Shared.Fpx? {
                if case .fpx(let value) = self { return value }
                return nil
            }
            public var giropay: Stripe.Shared.PaymentMethodDetailsPaymentRecordGiropay? {
                if case .giropay(let value) = self { return value }
                return nil
            }
            public var grabpay: Stripe.Shared.Grabpay? {
                if case .grabpay(let value) = self { return value }
                return nil
            }
            public var ideal: Stripe.Shared.PaymentMethodDetailsPaymentRecordIdeal? {
                if case .ideal(let value) = self { return value }
                return nil
            }
            public var interacPresent: Stripe.Shared.InteracPresent? {
                if case .interacPresent(let value) = self { return value }
                return nil
            }
            public var kakaoPay: Stripe.Shared.PaymentMethodDetailsPaymentRecordKakaoPay? {
                if case .kakaoPay(let value) = self { return value }
                return nil
            }
            public var klarna: Stripe.Shared.PaymentMethodDetailsPaymentRecordKlarna? {
                if case .klarna(let value) = self { return value }
                return nil
            }
            public var konbini: Stripe.Shared.PaymentMethodDetailsPaymentRecordKonbini? {
                if case .konbini(let value) = self { return value }
                return nil
            }
            public var krCard: Stripe.Shared.KrCard? {
                if case .krCard(let value) = self { return value }
                return nil
            }
            public var link: Stripe.Shared.PaymentMethodDetailsPaymentRecordLink? {
                if case .link(let value) = self { return value }
                return nil
            }
            public var mbWay: Stripe.Shared.PaymentMethodDetailsPaymentRecordMbWay? {
                if case .mbWay(let value) = self { return value }
                return nil
            }
            public var mobilepay: Stripe.Shared.PaymentMethodDetailsPaymentRecordMobilepay? {
                if case .mobilepay(let value) = self { return value }
                return nil
            }
            public var multibanco: Stripe.Shared.PaymentMethodDetailsPaymentRecordMultibanco? {
                if case .multibanco(let value) = self { return value }
                return nil
            }
            public var naverPay: Stripe.Shared.PaymentMethodDetailsPaymentRecordNaverPay? {
                if case .naverPay(let value) = self { return value }
                return nil
            }
            public var nzBankAccount: Stripe.Shared.PaymentMethodDetailsPaymentRecordNzBankAccount? {
                if case .nzBankAccount(let value) = self { return value }
                return nil
            }
            public var oxxo: Stripe.Shared.PaymentMethodDetailsPaymentRecordOxxo? {
                if case .oxxo(let value) = self { return value }
                return nil
            }
            public var p24: Stripe.Shared.PaymentMethodDetailsPaymentRecordP24? {
                if case .p24(let value) = self { return value }
                return nil
            }
            public var payByBank: Stripe.Shared.PaymentMethodDetailsPaymentRecordPayByBank? {
                if case .payByBank(let value) = self { return value }
                return nil
            }
            public var payco: Stripe.Shared.PaymentMethodDetailsPaymentRecordPayco? {
                if case .payco(let value) = self { return value }
                return nil
            }
            public var paynow: Stripe.Shared.PaymentMethodDetailsPaymentRecordPaynow? {
                if case .paynow(let value) = self { return value }
                return nil
            }
            public var paypal: Stripe.Shared.Paypal? {
                if case .paypal(let value) = self { return value }
                return nil
            }
            public var payto: Stripe.Shared.PaymentMethodDetailsPaymentRecordPayto? {
                if case .payto(let value) = self { return value }
                return nil
            }
            public var pix: Stripe.Shared.PaymentMethodDetailsPaymentRecordPix? {
                if case .pix(let value) = self { return value }
                return nil
            }
            public var promptpay: Stripe.Shared.PaymentMethodDetailsPaymentRecordPromptpay? {
                if case .promptpay(let value) = self { return value }
                return nil
            }
            public var revolutPay: Stripe.Shared.PaymentMethodDetailsPaymentRecordRevolutPay? {
                if case .revolutPay(let value) = self { return value }
                return nil
            }
            public var samsungPay: Stripe.Shared.PaymentMethodDetailsPaymentRecordSamsungPay? {
                if case .samsungPay(let value) = self { return value }
                return nil
            }
            public var satispay: Stripe.Shared.PaymentMethodDetailsPaymentRecordSatispay? {
                if case .satispay(let value) = self { return value }
                return nil
            }
            public var scalapay: Stripe.Shared.PaymentMethodDetailsPaymentRecordScalapay? {
                if case .scalapay(let value) = self { return value }
                return nil
            }
            public var sepaCreditTransfer: Stripe.Shared.SepaCreditTransfer? {
                if case .sepaCreditTransfer(let value) = self { return value }
                return nil
            }
            public var sepaDebit: Stripe.Shared.PaymentMethodDetailsPaymentRecordSepaDebit? {
                if case .sepaDebit(let value) = self { return value }
                return nil
            }
            public var sofort: Stripe.Shared.PaymentMethodDetailsPaymentRecordSofort? {
                if case .sofort(let value) = self { return value }
                return nil
            }
            public var stripeAccount: Stripe.Shared.StripeAccount? {
                if case .stripeAccount(let value) = self { return value }
                return nil
            }
            public var sunbit: Stripe.Shared.PaymentMethodDetailsPaymentRecordSunbit? {
                if case .sunbit(let value) = self { return value }
                return nil
            }
            public var swish: Stripe.Shared.PaymentMethodDetailsPaymentRecordSwish? {
                if case .swish(let value) = self { return value }
                return nil
            }
            public var twint: Stripe.Shared.PaymentMethodDetailsPaymentRecordTwint? {
                if case .twint(let value) = self { return value }
                return nil
            }
            public var upi: Stripe.Shared.PaymentMethodDetailsPaymentRecordUpi? {
                if case .upi(let value) = self { return value }
                return nil
            }
            public var usBankAccount: Stripe.Shared.PaymentMethodDetailsPaymentRecordUsBankAccount? {
                if case .usBankAccount(let value) = self { return value }
                return nil
            }
            public var wechat: Stripe.Shared.Wechat? {
                if case .wechat(let value) = self { return value }
                return nil
            }
            public var wechatPay: Stripe.Shared.PaymentMethodDetailsPaymentRecordWechatPay? {
                if case .wechatPay(let value) = self { return value }
                return nil
            }
            public var zip: Stripe.Shared.PaymentMethodDetailsPaymentRecordZip? {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordAcssDebit.self, forKey: .acssDebit) {
                        self = .acssDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "affirm":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordAffirm.self, forKey: .affirm) {
                        self = .affirm(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "afterpay_clearpay":
                    if let value = try container.decodeIfPresent(
                        Stripe.Shared.PaymentMethodDetailsPaymentRecordAfterpayClearpay.self,
                        forKey: .afterpayClearpay
                    ) {
                        self = .afterpayClearpay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "alipay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordAlipay.self, forKey: .alipay) {
                        self = .alipay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "alma":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordAlma.self, forKey: .alma) {
                        self = .alma(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "amazon_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordAmazonPay.self, forKey: .amazonPay) {
                        self = .amazonPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "au_becs_debit":
                    if let value = try container.decodeIfPresent(
                        Stripe.Shared.PaymentMethodDetailsPaymentRecordAuBecsDebit.self,
                        forKey: .auBecsDebit
                    ) {
                        self = .auBecsDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "bacs_debit":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordBacsDebit.self, forKey: .bacsDebit) {
                        self = .bacsDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "bancontact":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordBancontact.self, forKey: .bancontact)
                    {
                        self = .bancontact(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "billie":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordBillie.self, forKey: .billie) {
                        self = .billie(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "billing_details":
                    if let value = try container.decodeIfPresent(
                        Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceBillingDetails.self,
                        forKey: .billingDetails
                    ) {
                        self = .billingDetails(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "bizum":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordBizum.self, forKey: .bizum) {
                        self = .bizum(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "blik":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordBlik.self, forKey: .blik) {
                        self = .blik(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "boleto":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordBoleto.self, forKey: .boleto) {
                        self = .boleto(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "card":
                    if let value = try container.decodeIfPresent(
                        Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodCardDetails.self,
                        forKey: .card
                    ) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordCashapp.self, forKey: .cashapp) {
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
                case "custom":
                    if let value = try container.decodeIfPresent(Stripe.Shared.Custom.self, forKey: .custom) {
                        self = .custom(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "customer_balance":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsCustomerBalance.self, forKey: .customerBalance) {
                        self = .customerBalance(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "eps":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordEps.self, forKey: .eps) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordGiropay.self, forKey: .giropay) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordIdeal.self, forKey: .ideal) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordKakaoPay.self, forKey: .kakaoPay) {
                        self = .kakaoPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "klarna":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordKlarna.self, forKey: .klarna) {
                        self = .klarna(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "konbini":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordKonbini.self, forKey: .konbini) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordLink.self, forKey: .link) {
                        self = .link(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "mb_way":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordMbWay.self, forKey: .mbWay) {
                        self = .mbWay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "mobilepay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordMobilepay.self, forKey: .mobilepay) {
                        self = .mobilepay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "multibanco":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordMultibanco.self, forKey: .multibanco)
                    {
                        self = .multibanco(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "naver_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordNaverPay.self, forKey: .naverPay) {
                        self = .naverPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "nz_bank_account":
                    if let value = try container.decodeIfPresent(
                        Stripe.Shared.PaymentMethodDetailsPaymentRecordNzBankAccount.self,
                        forKey: .nzBankAccount
                    ) {
                        self = .nzBankAccount(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "oxxo":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordOxxo.self, forKey: .oxxo) {
                        self = .oxxo(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "p24":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordP24.self, forKey: .p24) {
                        self = .p24(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "pay_by_bank":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordPayByBank.self, forKey: .payByBank) {
                        self = .payByBank(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "payco":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordPayco.self, forKey: .payco) {
                        self = .payco(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "paynow":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordPaynow.self, forKey: .paynow) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordPayto.self, forKey: .payto) {
                        self = .payto(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "pix":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordPix.self, forKey: .pix) {
                        self = .pix(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "promptpay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordPromptpay.self, forKey: .promptpay) {
                        self = .promptpay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "revolut_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordRevolutPay.self, forKey: .revolutPay)
                    {
                        self = .revolutPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "samsung_pay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordSamsungPay.self, forKey: .samsungPay)
                    {
                        self = .samsungPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "satispay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordSatispay.self, forKey: .satispay) {
                        self = .satispay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "scalapay":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordScalapay.self, forKey: .scalapay) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordSepaDebit.self, forKey: .sepaDebit) {
                        self = .sepaDebit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "sofort":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordSofort.self, forKey: .sofort) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordSunbit.self, forKey: .sunbit) {
                        self = .sunbit(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "swish":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordSwish.self, forKey: .swish) {
                        self = .swish(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "twint":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordTwint.self, forKey: .twint) {
                        self = .twint(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "upi":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordUpi.self, forKey: .upi) {
                        self = .upi(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "us_bank_account":
                    if let value = try container.decodeIfPresent(
                        Stripe.Shared.PaymentMethodDetailsPaymentRecordUsBankAccount.self,
                        forKey: .usBankAccount
                    ) {
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
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordWechatPay.self, forKey: .wechatPay) {
                        self = .wechatPay(value)
                    } else {
                        self = .unknown(type: type)
                    }
                case "zip":
                    if let value = try container.decodeIfPresent(Stripe.Shared.PaymentMethodDetailsPaymentRecordZip.self, forKey: .zip) {
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
                case .billingDetails(let value): try container.encode(value, forKey: .billingDetails)
                case .bizum(let value): try container.encode(value, forKey: .bizum)
                case .blik(let value): try container.encode(value, forKey: .blik)
                case .boleto(let value): try container.encode(value, forKey: .boleto)
                case .card(let value): try container.encode(value, forKey: .card)
                case .cardPresent(let value): try container.encode(value, forKey: .cardPresent)
                case .cashapp(let value): try container.encode(value, forKey: .cashapp)
                case .crypto(let value): try container.encode(value, forKey: .crypto)
                case .custom(let value): try container.encode(value, forKey: .custom)
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
}

// payments_primitives_payment_records_resource_payment_method_klarna_details_resource_payer_details_resource_payer_details_address
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodKlarnaDetailsResourcePayerDetailsResourcePayerDetailsAddress: Codable,
        Hashable, Sendable
    {
        /// The payer address country.
        public var country: String?

        public init(
            country: String? = nil
        ) {
            self.country = country
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_mobilepay_details_resource_card
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodMobilepayDetailsResourceCard: Codable, Hashable, Sendable {
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

// payments_primitives_payment_records_resource_payment_method_revolut_pay_details_resource_funding
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodRevolutPayDetailsResourceFunding: Codable, Hashable, Sendable {
        public var card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodRevolutPayDetailsResourceFundingResourceFundingCard?
        /// Funding type of the underlying payment method.
        public var `type`: String?

        public init(
            card: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourcePaymentMethodRevolutPayDetailsResourceFundingResourceFundingCard? = nil,
            `type`: String? = nil
        ) {
            self.card = card
            self.`type` = `type`
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_revolut_pay_details_resource_funding_resource_funding_card
extension Stripe.Shared {
    public struct PaymentsPrimitivesPaymentRecordsResourcePaymentMethodRevolutPayDetailsResourceFundingResourceFundingCard: Codable, Hashable,
        Sendable
    {
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

// payments_primitives_payment_records_resource_processor_details_resource_custom_details
extension Stripe.Shared {
    /// Custom processors represent payment processors not modeled directly in the Stripe API.
    public struct PaymentsPrimitivesPaymentRecordsResourceProcessorDetailsResourceCustomDetails: Codable, Hashable, Sendable {
        /// An opaque string for manual reconciliation of this payment, for example a check number or a payment processor ID.
        public var paymentReference: String?

        public init(
            paymentReference: String? = nil
        ) {
            self.paymentReference = paymentReference
        }
    }
}

// payment_method_paynow
extension Stripe.Shared {
    public struct Paynow: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_details_paypal
extension Stripe.Shared {
    public struct Paypal: Codable, Hashable, Sendable {
        /// Two-letter ISO code representing the buyer's country.
        public var country: String?
        /// Owner's email.
        public var payerEmail: String?
        /// PayPal account PayerID.
        public var payerId: String?
        /// Owner's full name.
        public var payerName: String?
        /// The level of protection offered as defined by PayPal Seller Protection for Merchants, for this transaction.
        public var sellerProtection: Stripe.Shared.SellerProtection?
        /// A unique ID generated by PayPal for this transaction.
        public var transactionId: String?

        public init(
            country: String? = nil,
            payerEmail: String? = nil,
            payerId: String? = nil,
            payerName: String? = nil,
            sellerProtection: Stripe.Shared.SellerProtection? = nil,
            transactionId: String? = nil
        ) {
            self.country = country
            self.payerEmail = payerEmail
            self.payerId = payerId
            self.payerName = payerName
            self.sellerProtection = sellerProtection
            self.transactionId = transactionId
        }
    }
}

// invoice_payment_method_options_payto
extension Stripe.Shared {
    public struct Payto: Codable, Hashable, Sendable {
        public var mandateOptions: Stripe.Shared.InvoiceMandateOptionsPayto?

        public init(
            mandateOptions: Stripe.Shared.InvoiceMandateOptionsPayto? = nil
        ) {
            self.mandateOptions = mandateOptions
        }
    }
}

// invoice_line_item_period
extension Stripe.Shared {
    public struct Period: Codable, Hashable, Sendable {
        /// The end of the period, which must be greater than or equal to the start.
        public var end: Date?
        /// The start of the period.
        public var start: Date?

        public init(
            end: Date? = nil,
            start: Date? = nil
        ) {
            self.end = end
            self.start = start
        }
    }
}

// payment_method_pix
extension Stripe.Shared {
    public struct Pix: Codable, Hashable, Sendable {
        /// Uniquely identifies this particular Pix account.
        public var fingerprint: String?

        public init(
            fingerprint: String? = nil
        ) {
            self.fingerprint = fingerprint
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_installment_plan
extension Stripe.Shared {
    public struct Plan: Codable, Hashable, Sendable {
        /// For `fixed_count` installment plans, this is the number of installment payments your customer will make to their.
        public var count: Int?
        /// For `fixed_count` installment plans, this is the interval between installment payments your customer will make to.
        public var interval: String?
        /// Type of installment plan, one of `fixed_count`, `revolving`, or `bonus`.
        public var `type`: Type?

        public init(
            count: Int? = nil,
            interval: String? = nil,
            `type`: Type? = nil
        ) {
            self.count = count
            self.interval = interval
            self.`type` = `type`
        }

        /// Type of installment plan, one of `fixed_count`, `revolving`, or `bonus`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case bonus
            case fixedCount = "fixed_count"
            case revolving
        }
    }
}

// payment_flows_payment_intent_presentment_details
extension Stripe.Shared {
    public struct PresentmentDetails: Codable, Hashable, Sendable {
        /// Amount intended to be collected by this payment, denominated in `presentment_currency`.
        public var presentmentAmount: Int?
        /// Currency presented to the customer during payment.
        public var presentmentCurrency: String?

        public init(
            presentmentAmount: Int? = nil,
            presentmentCurrency: String? = nil
        ) {
            self.presentmentAmount = presentmentAmount
            self.presentmentCurrency = presentmentCurrency
        }
    }
}

// credit_notes_pretax_credit_amount
extension Stripe.Shared {
    public struct PretaxCreditAmounts: Codable, Hashable, Sendable {
        /// The amount, in cents (or local equivalent), of the pretax credit amount.
        public var amount: Int?
        /// The credit balance transaction that was applied to get this pretax credit amount.
        @Expandable<Stripe.Billing.Credit.Balance.Transaction, String> public var creditBalanceTransaction: String?
        /// The discount that was applied to get this pretax credit amount.
        @Expandable<Stripe.Shared.Discount, String> public var discount: String?
        /// Type of the pretax credit amount referenced.
        public var `type`: Type?

        public init(
            amount: Int? = nil,
            creditBalanceTransaction: String? = nil,
            discount: String? = nil,
            `type`: Type? = nil
        ) {
            self.amount = amount
            self._creditBalanceTransaction = Expandable(id: creditBalanceTransaction)
            self._discount = Expandable(id: discount)
            self.`type` = `type`
        }

        /// Type of the pretax credit amount referenced.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case creditBalanceTransaction = "credit_balance_transaction"
            case discount
        }
    }
}

// billing_bill_resource_invoicing_pricing_pricing_price_details
extension Stripe.Shared {
    public struct PriceDetails: Codable, Hashable, Sendable {
        /// The ID of the price this item is associated with.
        @Expandable<Stripe.Products.Price, String> public var price: String?
        /// The ID of the product this item is associated with.
        public var product: String?

        public init(
            price: String? = nil,
            product: String? = nil
        ) {
            self._price = Expandable(id: price)
            self.product = product
        }
    }
}

// billing_bill_resource_invoicing_pricing_pricing
extension Stripe.Shared {
    public struct Pricing: Codable, Hashable, Sendable {
        public var priceDetails: Stripe.Shared.PriceDetails?
        /// The type of the pricing details.
        public var `type`: String?
        /// The unit amount (in the `currency` specified) of the item which contains a decimal value with at most 12 decimal.
        public var unitAmountDecimal: String?

        public init(
            priceDetails: Stripe.Shared.PriceDetails? = nil,
            `type`: String? = nil,
            unitAmountDecimal: String? = nil
        ) {
            self.priceDetails = priceDetails
            self.`type` = `type`
            self.unitAmountDecimal = unitAmountDecimal
        }
    }
}

// payments_primitives_payment_records_resource_processor_details
extension Stripe.Shared {
    /// Processor information associated with this payment.
    public struct ProcessorDetails: Codable, Hashable, Sendable {
        public var custom: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceProcessorDetailsResourceCustomDetails?
        /// The processor used for this payment attempt.
        public var `type`: String?

        public init(
            custom: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceProcessorDetailsResourceCustomDetails? = nil,
            `type`: String? = nil
        ) {
            self.custom = custom
            self.`type` = `type`
        }
    }
}

// payment_method_promptpay
extension Stripe.Shared {
    public struct Promptpay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_intent_next_action_cashapp_qr_code
extension Stripe.Shared {
    public struct QrCode: Codable, Hashable, Sendable {
        /// The date (unix timestamp) when the QR code expires.
        public var expiresAt: Date?
        /// The image_url_png string used to render QR code.
        public var imageUrlPng: String?
        /// The image_url_svg string used to render QR code.
        public var imageUrlSvg: String?

        public init(
            expiresAt: Date? = nil,
            imageUrlPng: String? = nil,
            imageUrlSvg: String? = nil
        ) {
            self.expiresAt = expiresAt
            self.imageUrlPng = imageUrlPng
            self.imageUrlSvg = imageUrlSvg
        }
    }
}

// radar_radar_options
extension Stripe.Shared {
    /// Options to configure Radar.
    public struct RadarOptions: Codable, Hashable, Sendable {
        /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate.
        public var session: String?

        public init(
            session: String? = nil
        ) {
            self.session = session
        }
    }
}

// payment_method_details_card_present_receipt
extension Stripe.Shared {
    public struct Receipt: Codable, Hashable, Sendable {
        /// The type of account being debited or credited.
        public var accountType: AccountType?
        /// The Application Cryptogram, a unique value generated by the card to authenticate the transaction with issuers.
        public var applicationCryptogram: String?
        /// The Application Identifier (AID) on the card used to determine which networks are eligible to process the transaction.
        public var applicationPreferredName: String?
        /// Identifier for this transaction.
        public var authorizationCode: String?
        /// EMV tag 8A.
        public var authorizationResponseCode: String?
        /// Describes the method used by the cardholder to verify ownership of the card.
        public var cardholderVerificationMethod: String?
        /// Similar to the application_preferred_name, identifying the applications (AIDs) available on the card.
        public var dedicatedFileName: String?
        /// A 5-byte string that records the checks and validations that occur between the card and the terminal.
        public var terminalVerificationResults: String?
        /// An indication of which steps were completed during the card read process.
        public var transactionStatusInformation: String?

        public init(
            accountType: AccountType? = nil,
            applicationCryptogram: String? = nil,
            applicationPreferredName: String? = nil,
            authorizationCode: String? = nil,
            authorizationResponseCode: String? = nil,
            cardholderVerificationMethod: String? = nil,
            dedicatedFileName: String? = nil,
            terminalVerificationResults: String? = nil,
            transactionStatusInformation: String? = nil
        ) {
            self.accountType = accountType
            self.applicationCryptogram = applicationCryptogram
            self.applicationPreferredName = applicationPreferredName
            self.authorizationCode = authorizationCode
            self.authorizationResponseCode = authorizationResponseCode
            self.cardholderVerificationMethod = cardholderVerificationMethod
            self.dedicatedFileName = dedicatedFileName
            self.terminalVerificationResults = terminalVerificationResults
            self.transactionStatusInformation = transactionStatusInformation
        }

        /// The type of account being debited or credited.
        public enum AccountType: String, Codable, Hashable, Sendable {
            case checking
            case credit
            case prepaid
            case unknown
        }
    }
}

// reserves_reserve_holds_resources_release_detail
extension Stripe.Shared {
    public struct ReleaseDetails: Codable, Hashable, Sendable {
        /// The amount released by the ReserveRelease from this ReserveHold.
        public var amount: Int?
        /// The ReserveRelease which released funds from this ReserveHold (e.g., resrel_123).
        public var reserveRelease: String?

        public init(
            amount: Int? = nil,
            reserveRelease: String? = nil
        ) {
            self.amount = amount
            self.reserveRelease = reserveRelease
        }
    }
}

// reserves_reserve_holds_resources_release_schedule
extension Stripe.Shared {
    public struct ReleaseSchedule: Codable, Hashable, Sendable {
        /// The time after which the ReserveHold is requested to be released.
        public var releaseAfter: Date?
        /// The time at which the ReserveHold is scheduled to be released, automatically set to midnight UTC of the day after.
        public var scheduledRelease: Date?

        public init(
            releaseAfter: Date? = nil,
            scheduledRelease: Date? = nil
        ) {
            self.releaseAfter = releaseAfter
            self.scheduledRelease = scheduledRelease
        }
    }
}

// invoice_setting_checkout_rendering_options
extension Stripe.Shared {
    public struct RenderingOptions: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?
        /// ID of the invoice rendering template to be used for the generated invoice.
        public var template: String?

        public init(
            amountTaxDisplay: String? = nil,
            template: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
            self.template = template
        }
    }
}

// reserve.plan
extension Stripe.Shared {
    /// ReservePlans are used to automatically place holds on a merchant's funds until the plan expires.
    public struct ReservePlan: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        public let id: ID
        /// String representing the object's type.
        public let object: String
        /// Time at which the object was created.
        public var created: Date?
        /// Indicates which party created this ReservePlan.
        public var createdBy: CreatedBy?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// Time at which the ReservePlan was disabled.
        public var disabledAt: Date?
        public var fixedRelease: Stripe.Shared.FixedRelease?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The percent of each Charge to reserve.
        public var percent: Int?
        public var rollingRelease: Stripe.Shared.RollingRelease?
        /// The current status of the ReservePlan.
        public var status: Status?
        /// The type of the ReservePlan.
        public var `type`: Type?

        public init(
            id: ID,
            object: String,
            created: Date? = nil,
            createdBy: CreatedBy? = nil,
            currency: Stripe.Currency? = nil,
            disabledAt: Date? = nil,
            fixedRelease: Stripe.Shared.FixedRelease? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            percent: Int? = nil,
            rollingRelease: Stripe.Shared.RollingRelease? = nil,
            status: Status? = nil,
            `type`: Type? = nil
        ) {
            self.id = id
            self.object = object
            self.created = created
            self.createdBy = createdBy
            self.currency = currency
            self.disabledAt = disabledAt
            self.fixedRelease = fixedRelease
            self.livemode = livemode
            self.metadata = metadata
            self.percent = percent
            self.rollingRelease = rollingRelease
            self.status = status
            self.`type` = `type`
        }

        /// Indicates which party created this ReservePlan.
        public enum CreatedBy: String, Codable, Hashable, Sendable {
            case application
            case stripe
        }

        /// The current status of the ReservePlan.
        public enum Status: String, Codable, Hashable, Sendable {
            case active
            case disabled
            case expired
        }

        /// The type of the ReservePlan.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case fixedRelease = "fixed_release"
            case rollingRelease = "rolling_release"
        }
    }
}

// payment_method_revolut_pay
extension Stripe.Shared {
    public struct RevolutPay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// reserves_reserve_plans_resources_rolling_release
extension Stripe.Shared {
    public struct RollingRelease: Codable, Hashable, Sendable {
        /// The number of days to reserve funds before releasing.
        public var daysAfterCharge: Int?
        /// The time at which the ReservePlan expires.
        public var expiresOn: Int?

        public init(
            daysAfterCharge: Int? = nil,
            expiresOn: Int? = nil
        ) {
            self.daysAfterCharge = daysAfterCharge
            self.expiresOn = expiresOn
        }
    }
}

// payment_method_card_wallet_samsung_pay
extension Stripe.Shared {
    public struct SamsungPay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_satispay
extension Stripe.Shared {
    public struct Satispay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_scalapay
extension Stripe.Shared {
    public struct Scalapay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// paypal_seller_protection
extension Stripe.Shared {
    public struct SellerProtection: Codable, Hashable, Sendable {
        /// An array of conditions that are covered for the transaction, if applicable.
        public var disputeCategories: [DisputeCategories]?
        /// Indicates whether the transaction is eligible for PayPal's seller protection.
        public var status: Status?

        public init(
            disputeCategories: [DisputeCategories]? = nil,
            status: Status? = nil
        ) {
            self.disputeCategories = disputeCategories
            self.status = status
        }

        public enum DisputeCategories: String, Codable, Hashable, Sendable {
            case fraudulent
            case productNotReceived = "product_not_received"
        }

        /// Indicates whether the transaction is eligible for PayPal's seller protection.
        public enum Status: String, Codable, Hashable, Sendable {
            case eligible
            case notEligible = "not_eligible"
            case partiallyEligible = "partially_eligible"
        }
    }
}

// payment_method_details_sepa_credit_transfer
extension Stripe.Shared {
    public struct SepaCreditTransfer: Codable, Hashable, Sendable {
        /// Name of the bank associated with the bank account.
        public var bankName: String?
        /// Bank Identifier Code of the bank associated with the bank account.
        public var bic: String?
        /// IBAN of the bank account to transfer funds to.
        public var iban: String?

        public init(
            bankName: String? = nil,
            bic: String? = nil,
            iban: String? = nil
        ) {
            self.bankName = bankName
            self.bic = bic
            self.iban = iban
        }
    }
}

// invoice_payment_method_options_sepa_debit
extension Stripe.Shared {
    public struct SepaDebit: Codable, Hashable, Sendable {
        public init() {}
    }
}

// sepa_debit_generated_from
extension Stripe.Shared {
    public struct SepaDebitGeneratedFrom: Codable, Hashable, Sendable {
        /// The ID of the Charge that generated this PaymentMethod, if any.
        @Expandable<Stripe.Charges.Charge, String> public var charge: String?
        /// The ID of the SetupAttempt that generated this PaymentMethod, if any.
        @Expandable<Stripe.Setup.Attempt, String> public var setupAttempt: String?

        public init(
            charge: String? = nil,
            setupAttempt: String? = nil
        ) {
            self._charge = Expandable(id: charge)
            self._setupAttempt = Expandable(id: setupAttempt)
        }
    }
}

// tax_product_resource_ship_from_details
extension Stripe.Shared {
    public struct ShipFromDetails: Codable, Hashable, Sendable {
        public var address: Stripe.Shared.Address?

        public init(
            address: Stripe.Shared.Address? = nil
        ) {
            self.address = address
        }
    }
}

// invoices_resource_shipping_cost
extension Stripe.Shared {
    public struct ShippingCost: Codable, Hashable, Sendable {
        /// Total shipping cost before any taxes are applied.
        public var amountSubtotal: Int?
        /// Total tax amount applied due to shipping costs.
        public var amountTax: Int?
        /// Total shipping cost after taxes are applied.
        public var amountTotal: Int?
        /// The ID of the ShippingRate for this invoice.
        @Expandable<Stripe.Products.Shipping.Rate, String> public var shippingRate: String?
        /// The taxes applied to the shipping rate.
        public var taxes: [Stripe.Shared.Taxes]?

        public init(
            amountSubtotal: Int? = nil,
            amountTax: Int? = nil,
            amountTotal: Int? = nil,
            shippingRate: String? = nil,
            taxes: [Stripe.Shared.Taxes]? = nil
        ) {
            self.amountSubtotal = amountSubtotal
            self.amountTax = amountTax
            self.amountTotal = amountTotal
            self._shippingRate = Expandable(id: shippingRate)
            self.taxes = taxes
        }
    }
}

// payments_primitives_payment_records_resource_shipping_details
extension Stripe.Shared {
    /// The customer's shipping information associated with this payment.
    public struct ShippingDetails: Codable, Hashable, Sendable {
        public var address: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAddress?
        /// The shipping recipient's name.
        public var name: String?
        /// The shipping recipient's phone number.
        public var phone: String?

        public init(
            address: Stripe.Shared.PaymentsPrimitivesPaymentRecordsResourceAddress? = nil,
            name: String? = nil,
            phone: String? = nil
        ) {
            self.address = address
            self.name = name
            self.phone = phone
        }
    }
}

// smor_resource_managed_payments
extension Stripe.Shared {
    public struct SmorResourceManagedPayments: Codable, Hashable, Sendable {
        /// Set to `true` to enable Managed Payments, Stripe's merchant of record solution, for this session.
        public var enabled: Bool?

        public init(
            enabled: Bool? = nil
        ) {
            self.enabled = enabled
        }
    }
}

// payment_method_sofort
extension Stripe.Shared {
    public struct Sofort: Codable, Hashable, Sendable {
        /// Two-letter ISO code representing the country the bank account is located in.
        public var country: String?

        public init(
            country: String? = nil
        ) {
            self.country = country
        }
    }
}

// funding_instructions_bank_transfer_sort_code_record
extension Stripe.Shared {
    /// Sort Code Records contain U.K.
    public struct SortCode: Codable, Hashable, Sendable {
        public var accountHolderAddress: Address?
        /// The name of the person or business that owns the bank account.
        public var accountHolderName: String?
        /// The account number.
        public var accountNumber: String?
        public var bankAddress: Address?
        /// The six-digit sort code.
        public var sortCode: String?

        public init(
            accountHolderAddress: Address? = nil,
            accountHolderName: String? = nil,
            accountNumber: String? = nil,
            bankAddress: Address? = nil,
            sortCode: String? = nil
        ) {
            self.accountHolderAddress = accountHolderAddress
            self.accountHolderName = accountHolderName
            self.accountNumber = accountNumber
            self.bankAddress = bankAddress
            self.sortCode = sortCode
        }
    }
}

// discount_source
extension Stripe.Shared {
    public struct Source: Codable, Hashable, Sendable {
        /// The coupon that was redeemed to create this discount.
        @Expandable<Stripe.Products.Coupon, String> public var coupon: String?
        /// The source type of the discount.
        public var `type`: String?

        public init(
            coupon: String? = nil,
            `type`: String? = nil
        ) {
            self._coupon = Expandable(id: coupon)
            self.`type` = `type`
        }
    }
}

// funding_instructions_bank_transfer_spei_record
extension Stripe.Shared {
    /// SPEI Records contain Mexico bank account details per the SPEI format.
    public struct Spei: Codable, Hashable, Sendable {
        public var accountHolderAddress: Address?
        /// The account holder name.
        public var accountHolderName: String?
        public var bankAddress: Address?
        /// The three-digit bank code.
        public var bankCode: String?
        /// The short banking institution name.
        public var bankName: String?
        /// The CLABE number.
        public var clabe: String?

        public init(
            accountHolderAddress: Address? = nil,
            accountHolderName: String? = nil,
            bankAddress: Address? = nil,
            bankCode: String? = nil,
            bankName: String? = nil,
            clabe: String? = nil
        ) {
            self.accountHolderAddress = accountHolderAddress
            self.accountHolderName = accountHolderName
            self.bankAddress = bankAddress
            self.bankCode = bankCode
            self.bankName = bankName
            self.clabe = clabe
        }
    }
}

// payment_method_us_bank_account_status_details
extension Stripe.Shared {
    public struct StatusDetails: Codable, Hashable, Sendable {
        public var blocked: Stripe.Shared.Blocked?

        public init(
            blocked: Stripe.Shared.Blocked? = nil
        ) {
            self.blocked = blocked
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_konbini_details_resource_store
extension Stripe.Shared {
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

// payment_method_details_stripe_account
extension Stripe.Shared {
    public struct StripeAccount: Codable, Hashable, Sendable {
        public init() {}
    }
}

// subscription_item_billing_thresholds
extension Stripe.Shared {
    public struct SubscriptionItemBillingThresholds: Codable, Hashable, Sendable {
        /// Usage threshold that triggers the subscription to create an invoice.
        public var usageGte: Int?

        public init(
            usageGte: Int? = nil
        ) {
            self.usageGte = usageGte
        }
    }
}

// payment_method_sunbit
extension Stripe.Shared {
    public struct Sunbit: Codable, Hashable, Sendable {
        public init() {}
    }
}

// funding_instructions_bank_transfer_swift_record
extension Stripe.Shared {
    /// SWIFT Records contain U.S.
    public struct Swift: Codable, Hashable, Sendable {
        public var accountHolderAddress: Address?
        /// The account holder name.
        public var accountHolderName: String?
        /// The account number.
        public var accountNumber: String?
        /// The account type.
        public var accountType: String?
        public var bankAddress: Address?
        /// The bank name.
        public var bankName: String?
        /// The SWIFT code.
        public var swiftCode: String?

        public init(
            accountHolderAddress: Address? = nil,
            accountHolderName: String? = nil,
            accountNumber: String? = nil,
            accountType: String? = nil,
            bankAddress: Address? = nil,
            bankName: String? = nil,
            swiftCode: String? = nil
        ) {
            self.accountHolderAddress = accountHolderAddress
            self.accountHolderName = accountHolderName
            self.accountNumber = accountNumber
            self.accountType = accountType
            self.bankAddress = bankAddress
            self.bankName = bankName
            self.swiftCode = swiftCode
        }
    }
}

// payment_method_swish
extension Stripe.Shared {
    public struct Swish: Codable, Hashable, Sendable {
        public init() {}
    }
}

// tax_product_resource_line_item_tax_breakdown
extension Stripe.Shared {
    public struct TaxBreakdown: Codable, Hashable, Sendable {
        /// The amount of tax, in the smallest currency unit.
        public var amount: Int?
        public var jurisdiction: Stripe.Shared.Jurisdiction?
        /// Indicates whether the jurisdiction was determined by the origin (merchant's address) or destination (customer's.
        public var sourcing: Sourcing?
        /// Details regarding the rate for this tax.
        public var taxRateDetails: Stripe.Shared.TaxProductResourceLineItemTaxRateDetails?
        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public var taxabilityReason: TaxabilityReason?
        /// The amount on which tax is calculated, in the smallest currency unit.
        public var taxableAmount: Int?

        public init(
            amount: Int? = nil,
            jurisdiction: Stripe.Shared.Jurisdiction? = nil,
            sourcing: Sourcing? = nil,
            taxRateDetails: Stripe.Shared.TaxProductResourceLineItemTaxRateDetails? = nil,
            taxabilityReason: TaxabilityReason? = nil,
            taxableAmount: Int? = nil
        ) {
            self.amount = amount
            self.jurisdiction = jurisdiction
            self.sourcing = sourcing
            self.taxRateDetails = taxRateDetails
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
        }

        /// Indicates whether the jurisdiction was determined by the origin (merchant's address) or destination (customer's.
        public enum Sourcing: String, Codable, Hashable, Sendable {
            case destination
            case origin
        }

        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public enum TaxabilityReason: String, Codable, Hashable, Sendable {
            case customerExempt = "customer_exempt"
            case notCollecting = "not_collecting"
            case notSubjectToTax = "not_subject_to_tax"
            case notSupported = "not_supported"
            case portionProductExempt = "portion_product_exempt"
            case portionReducedRated = "portion_reduced_rated"
            case portionStandardRated = "portion_standard_rated"
            case productExempt = "product_exempt"
            case productExemptHoliday = "product_exempt_holiday"
            case proportionallyRated = "proportionally_rated"
            case reducedRated = "reduced_rated"
            case reverseCharge = "reverse_charge"
            case standardRated = "standard_rated"
            case taxableBasisReduced = "taxable_basis_reduced"
            case zeroRated = "zero_rated"
        }
    }
}

// tax_product_resource_customer_details_resource_tax_id
extension Stripe.Shared {
    public struct TaxIds: Codable, Hashable, Sendable {
        /// The type of the tax ID, one of `ad_nrt`, `ar_cuit`, `eu_vat`, `bo_tin`, `br_cnpj`, `br_cpf`, `cn_tin`, `co_nit`.
        public var `type`: Type?
        /// The value of the tax ID.
        public var value: String?

        public init(
            `type`: Type? = nil,
            value: String? = nil
        ) {
            self.`type` = `type`
            self.value = value
        }

        /// The type of the tax ID, one of `ad_nrt`, `ar_cuit`, `eu_vat`, `bo_tin`, `br_cnpj`, `br_cpf`, `cn_tin`, `co_nit`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case adNrt = "ad_nrt"
            case aeTrn = "ae_trn"
            case alTin = "al_tin"
            case amTin = "am_tin"
            case aoTin = "ao_tin"
            case arCuit = "ar_cuit"
            case auAbn = "au_abn"
            case auArn = "au_arn"
            case awTin = "aw_tin"
            case azTin = "az_tin"
            case baTin = "ba_tin"
            case bbTin = "bb_tin"
            case bdBin = "bd_bin"
            case bfIfu = "bf_ifu"
            case bgUic = "bg_uic"
            case bhVat = "bh_vat"
            case bjIfu = "bj_ifu"
            case boTin = "bo_tin"
            case brCnpj = "br_cnpj"
            case brCpf = "br_cpf"
            case bsTin = "bs_tin"
            case byTin = "by_tin"
            case caBn = "ca_bn"
            case caGstHst = "ca_gst_hst"
            case caPstBc = "ca_pst_bc"
            case caPstMb = "ca_pst_mb"
            case caPstSk = "ca_pst_sk"
            case caQst = "ca_qst"
            case cdNif = "cd_nif"
            case chUid = "ch_uid"
            case chVat = "ch_vat"
            case clTin = "cl_tin"
            case cmNiu = "cm_niu"
            case cnTin = "cn_tin"
            case coNit = "co_nit"
            case crTin = "cr_tin"
            case cvNif = "cv_nif"
            case deStn = "de_stn"
            case doRcn = "do_rcn"
            case ecRuc = "ec_ruc"
            case egTin = "eg_tin"
            case esCif = "es_cif"
            case etTin = "et_tin"
            case euOssVat = "eu_oss_vat"
            case euVat = "eu_vat"
            case foVat = "fo_vat"
            case gbVat = "gb_vat"
            case geVat = "ge_vat"
            case giTin = "gi_tin"
            case gnNif = "gn_nif"
            case hkBr = "hk_br"
            case hrOib = "hr_oib"
            case huTin = "hu_tin"
            case icNif = "ic_nif"
            case idNpwp = "id_npwp"
            case ilVat = "il_vat"
            case inGst = "in_gst"
            case isVat = "is_vat"
            case itCf = "it_cf"
            case jpCn = "jp_cn"
            case jpRn = "jp_rn"
            case jpTrn = "jp_trn"
            case kePin = "ke_pin"
            case kgTin = "kg_tin"
            case khTin = "kh_tin"
            case krBrn = "kr_brn"
            case kzBin = "kz_bin"
            case laTin = "la_tin"
            case liUid = "li_uid"
            case liVat = "li_vat"
            case lkVat = "lk_vat"
            case maVat = "ma_vat"
            case mdVat = "md_vat"
            case mePib = "me_pib"
            case mkVat = "mk_vat"
            case mrNif = "mr_nif"
            case mxRfc = "mx_rfc"
            case myFrp = "my_frp"
            case myItn = "my_itn"
            case mySst = "my_sst"
            case ngTin = "ng_tin"
            case noVat = "no_vat"
            case noVoec = "no_voec"
            case npPan = "np_pan"
            case nzGst = "nz_gst"
            case omVat = "om_vat"
            case peRuc = "pe_ruc"
            case phTin = "ph_tin"
            case plNip = "pl_nip"
            case pyRuc = "py_ruc"
            case roTin = "ro_tin"
            case rsPib = "rs_pib"
            case ruInn = "ru_inn"
            case ruKpp = "ru_kpp"
            case saVat = "sa_vat"
            case sgGst = "sg_gst"
            case sgUen = "sg_uen"
            case siTin = "si_tin"
            case snNinea = "sn_ninea"
            case srFin = "sr_fin"
            case svNit = "sv_nit"
            case thVat = "th_vat"
            case tjTin = "tj_tin"
            case trTin = "tr_tin"
            case twVat = "tw_vat"
            case tzVat = "tz_vat"
            case uaVat = "ua_vat"
            case ugTin = "ug_tin"
            case unknown
            case usEin = "us_ein"
            case uyRuc = "uy_ruc"
            case uzTin = "uz_tin"
            case uzVat = "uz_vat"
            case veRif = "ve_rif"
            case vnTin = "vn_tin"
            case zaVat = "za_vat"
            case zmTin = "zm_tin"
            case zwTin = "zw_tin"
        }
    }
}

// tax_product_resource_line_item_tax_rate_details
extension Stripe.Shared {
    public struct TaxProductResourceLineItemTaxRateDetails: Codable, Hashable, Sendable {
        /// A localized display name for tax type, intended to be human-readable.
        public var displayName: String?
        /// The tax rate percentage as a string.
        public var percentageDecimal: String?
        /// The tax type, such as `vat` or `sales_tax`.
        public var taxType: TaxType?

        public init(
            displayName: String? = nil,
            percentageDecimal: String? = nil,
            taxType: TaxType? = nil
        ) {
            self.displayName = displayName
            self.percentageDecimal = percentageDecimal
            self.taxType = taxType
        }

        /// The tax type, such as `vat` or `sales_tax`.
        public enum TaxType: String, Codable, Hashable, Sendable {
            case amusementTax = "amusement_tax"
            case communicationsTax = "communications_tax"
            case gst
            case hst
            case igst
            case jct
            case leaseTax = "lease_tax"
            case massTransitParkingTax = "mass_transit_parking_tax"
            case parkingTax = "parking_tax"
            case pst
            case qst
            case retailDeliveryFee = "retail_delivery_fee"
            case rst
            case salesTax = "sales_tax"
            case serviceTax = "service_tax"
            case vat
        }
    }
}

// billing_bill_resource_invoicing_taxes_tax_rate_details
extension Stripe.Shared {
    public struct TaxRateDetails: Codable, Hashable, Sendable {
        /// ID of the tax rate.
        @Expandable<Stripe.Tax.Rate, String> public var taxRate: String?

        public init(
            taxRate: String? = nil
        ) {
            self._taxRate = Expandable(id: taxRate)
        }
    }
}

// line_items_tax_amount
extension Stripe.Shared {
    public struct Taxes: Codable, Hashable, Sendable {
        /// Amount of tax applied for this rate.
        public var amount: Int?
        @Boxed public var rate: Stripe.Tax.Rate?
        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public var taxabilityReason: TaxabilityReason?
        /// The amount on which tax is calculated, in cents (or local equivalent).
        public var taxableAmount: Int?

        public init(
            amount: Int? = nil,
            rate: Stripe.Tax.Rate? = nil,
            taxabilityReason: TaxabilityReason? = nil,
            taxableAmount: Int? = nil
        ) {
            self.amount = amount
            self._rate = Boxed(wrappedValue: rate)
            self.taxabilityReason = taxabilityReason
            self.taxableAmount = taxableAmount
        }

        /// The reasoning behind this tax, for example, if the product is tax exempt.
        public enum TaxabilityReason: String, Codable, Hashable, Sendable {
            case customerExempt = "customer_exempt"
            case notCollecting = "not_collecting"
            case notSubjectToTax = "not_subject_to_tax"
            case notSupported = "not_supported"
            case portionProductExempt = "portion_product_exempt"
            case portionReducedRated = "portion_reduced_rated"
            case portionStandardRated = "portion_standard_rated"
            case productExempt = "product_exempt"
            case productExemptHoliday = "product_exempt_holiday"
            case proportionallyRated = "proportionally_rated"
            case reducedRated = "reduced_rated"
            case reverseCharge = "reverse_charge"
            case standardRated = "standard_rated"
            case taxableBasisReduced = "taxable_basis_reduced"
            case zeroRated = "zero_rated"
        }
    }
}

// payments_primitives_payment_records_resource_payment_method_card_details_resource_three_d_secure
extension Stripe.Shared {
    public struct ThreeDSecure: Codable, Hashable, Sendable {
        /// For authenticated transactions: Indicates how the issuing bank authenticated the customer.
        public var authenticationFlow: AuthenticationFlow?
        /// The Electronic Commerce Indicator (ECI).
        public var electronicCommerceIndicator: ElectronicCommerceIndicator?
        /// The exemption requested via 3DS and accepted by the issuer at authentication time.
        public var exemptionIndicator: ExemptionIndicator?
        /// Whether Stripe requested the value of `exemption_indicator` in the transaction.
        public var exemptionIndicatorApplied: Bool?
        /// Indicates the outcome of 3D Secure authentication.
        public var result: Result?
        /// Additional information about why 3D Secure succeeded or failed, based on the `result`.
        public var resultReason: ResultReason?
        /// The version of 3D Secure that was used.
        public var version: Version?

        public init(
            authenticationFlow: AuthenticationFlow? = nil,
            electronicCommerceIndicator: ElectronicCommerceIndicator? = nil,
            exemptionIndicator: ExemptionIndicator? = nil,
            exemptionIndicatorApplied: Bool? = nil,
            result: Result? = nil,
            resultReason: ResultReason? = nil,
            version: Version? = nil
        ) {
            self.authenticationFlow = authenticationFlow
            self.electronicCommerceIndicator = electronicCommerceIndicator
            self.exemptionIndicator = exemptionIndicator
            self.exemptionIndicatorApplied = exemptionIndicatorApplied
            self.result = result
            self.resultReason = resultReason
            self.version = version
        }

        /// For authenticated transactions: Indicates how the issuing bank authenticated the customer.
        public enum AuthenticationFlow: String, Codable, Hashable, Sendable {
            case challenge
            case frictionless
        }

        /// The Electronic Commerce Indicator (ECI).
        public enum ElectronicCommerceIndicator: String, Codable, Hashable, Sendable {
            case value01 = "01"
            case value02 = "02"
            case value03 = "03"
            case value04 = "04"
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

        /// Additional information about why 3D Secure succeeded or failed, based on the `result`.
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
        }
    }
}

// three_d_secure_usage
extension Stripe.Shared {
    public struct ThreeDSecureUsage: Codable, Hashable, Sendable {
        /// Whether 3D Secure is supported on this card.
        public var supported: Bool?

        public init(
            supported: Bool? = nil
        ) {
            self.supported = supported
        }
    }
}

// subscription_transfer_data
extension Stripe.Shared {
    public struct TransferData: Codable, Hashable, Sendable {
        /// A non-negative decimal between 0 and 100, with at most two decimal places.
        public var amountPercent: Double?
        /// The account where funds from the payment will be transferred to upon payment success.
        @Expandable<Stripe.Connect.Account, String> public var destination: String?

        public init(
            amountPercent: Double? = nil,
            destination: String? = nil
        ) {
            self.amountPercent = amountPercent
            self._destination = Expandable(id: destination)
        }
    }
}

// treasury_shared_resource_billing_details
extension Stripe.Shared {
    public struct TreasurySharedResourceBillingDetails: Codable, Hashable, Sendable {
        public var address: Address?
        /// Email address.
        public var email: String?
        /// Full name.
        public var name: String?

        public init(
            address: Address? = nil,
            email: String? = nil,
            name: String? = nil
        ) {
            self.address = address
            self.email = email
            self.name = name
        }
    }
}

// treasury_shared_resource_initiating_payment_method_details_us_bank_account
extension Stripe.Shared {
    public struct TreasurySharedResourceInitiatingPaymentMethodDetailsUsBankAccount: Codable, Hashable, Sendable {
        /// Bank name.
        public var bankName: String?
        /// The last four digits of the bank account number.
        public var last4: String?
        /// The routing number for the bank account.
        public var routingNumber: String?

        public init(
            bankName: String? = nil,
            last4: String? = nil,
            routingNumber: String? = nil
        ) {
            self.bankName = bankName
            self.last4 = last4
            self.routingNumber = routingNumber
        }
    }
}

// payment_method_twint
extension Stripe.Shared {
    public struct Twint: Codable, Hashable, Sendable {
        public init() {}
    }
}

// invoice_payment_method_options_upi
extension Stripe.Shared {
    public struct Upi: Codable, Hashable, Sendable {
        public var mandateOptions: Stripe.Shared.InvoicePaymentMethodOptionsMandateOptionsUpi?

        public init(
            mandateOptions: Stripe.Shared.InvoicePaymentMethodOptionsMandateOptionsUpi? = nil
        ) {
            self.mandateOptions = mandateOptions
        }
    }
}

// payment_intent_next_action_upi_handle_redirect_or_display_qr_code
extension Stripe.Shared {
    public struct UpiHandleRedirectOrDisplayQrCode: Codable, Hashable, Sendable {
        /// The URL to the hosted UPI instructions page, which allows customers to view the QR code.
        public var hostedInstructionsUrl: String?
        public var qrCode: Stripe.Shared.PaymentIntentNextActionUpiqrCode?

        public init(
            hostedInstructionsUrl: String? = nil,
            qrCode: Stripe.Shared.PaymentIntentNextActionUpiqrCode? = nil
        ) {
            self.hostedInstructionsUrl = hostedInstructionsUrl
            self.qrCode = qrCode
        }
    }
}

// invoice_payment_method_options_us_bank_account
extension Stripe.Shared {
    public struct UsBankAccount: Codable, Hashable, Sendable {
        public var financialConnections: Stripe.Shared.FinancialConnections?
        /// Bank account verification method.
        public var verificationMethod: VerificationMethod?

        public init(
            financialConnections: Stripe.Shared.FinancialConnections? = nil,
            verificationMethod: VerificationMethod? = nil
        ) {
            self.financialConnections = financialConnections
            self.verificationMethod = verificationMethod
        }

        /// Bank account verification method.
        public enum VerificationMethod: String, Codable, Hashable, Sendable {
            case automatic
            case instant
            case microdeposits
        }
    }
}

// us_bank_account_networks
extension Stripe.Shared {
    public struct UsBankAccountNetworks: Codable, Hashable, Sendable {
        /// The preferred network.
        public var preferred: String?
        /// All supported networks.
        public var supported: [Supported]?

        public init(
            preferred: String? = nil,
            supported: [Supported]? = nil
        ) {
            self.preferred = preferred
            self.supported = supported
        }

        public enum Supported: String, Codable, Hashable, Sendable {
            case ach
            case usDomesticWire = "us_domestic_wire"
        }
    }
}

// payment_method_card_wallet_visa_checkout
extension Stripe.Shared {
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
}

// payment_flows_private_payment_methods_card_present_common_wallet
extension Stripe.Shared {
    public struct Wallet: Codable, Hashable, Sendable {
        /// The type of mobile wallet, one of `apple_pay`, `google_pay`, `samsung_pay`, or `unknown`.
        public var `type`: Type?

        public init(
            `type`: Type? = nil
        ) {
            self.`type` = `type`
        }

        /// The type of mobile wallet, one of `apple_pay`, `google_pay`, `samsung_pay`, or `unknown`.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case applePay = "apple_pay"
            case googlePay = "google_pay"
            case samsungPay = "samsung_pay"
            case unknown
        }
    }
}

// payment_method_details_wechat
extension Stripe.Shared {
    public struct Wechat: Codable, Hashable, Sendable {
        public init() {}
    }
}

// payment_method_wechat_pay
extension Stripe.Shared {
    public struct WechatPay: Codable, Hashable, Sendable {
        public init() {}
    }
}

// funding_instructions_bank_transfer_zengin_record
extension Stripe.Shared {
    /// Zengin Records contain Japan bank account details per the Zengin format.
    public struct Zengin: Codable, Hashable, Sendable {
        public var accountHolderAddress: Address?
        /// The account holder name.
        public var accountHolderName: String?
        /// The account number.
        public var accountNumber: String?
        /// The bank account type.
        public var accountType: String?
        public var bankAddress: Address?
        /// The bank code of the account.
        public var bankCode: String?
        /// The bank name of the account.
        public var bankName: String?
        /// The branch code of the account.
        public var branchCode: String?
        /// The branch name of the account.
        public var branchName: String?

        public init(
            accountHolderAddress: Address? = nil,
            accountHolderName: String? = nil,
            accountNumber: String? = nil,
            accountType: String? = nil,
            bankAddress: Address? = nil,
            bankCode: String? = nil,
            bankName: String? = nil,
            branchCode: String? = nil,
            branchName: String? = nil
        ) {
            self.accountHolderAddress = accountHolderAddress
            self.accountHolderName = accountHolderName
            self.accountNumber = accountNumber
            self.accountType = accountType
            self.bankAddress = bankAddress
            self.bankCode = bankCode
            self.bankName = bankName
            self.branchCode = branchCode
            self.branchName = branchName
        }
    }
}

// payment_method_zip
extension Stripe.Shared {
    public struct Zip: Codable, Hashable, Sendable {
        public init() {}
    }
}
