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

extension Stripe.Billing {
    /// Invoices are statements of amounts owed by a customer, and are either generated one-off, or generated periodically.
    public struct Invoice: Codable, Hashable, Sendable {
        public typealias ID = String
        public var id: ID?
        /// String representing the object's type.
        public let object: String
        /// The country of the business associated with this invoice, most often the business creating the invoice.
        public var accountCountry: String?
        /// The public name of the business associated with this invoice, most often the business creating the invoice.
        public var accountName: String?
        /// The account tax IDs associated with the invoice.
        @ExpandableCollection<Stripe.Tax.ID> public var accountTaxIds: [String]?
        /// Final amount due at this time for this invoice.
        public var amountDue: Int?
        /// Amount that was overpaid on the invoice.
        public var amountOverpaid: Int?
        /// The amount, in cents (or local equivalent), that was paid.
        public var amountPaid: Int?
        /// Amount, in cents (or local equivalent), that was paid on the invoice outside of Stripe.
        public var amountPaidOffStripe: Int?
        /// The difference between amount_due and amount_paid, in cents (or local equivalent).
        public var amountRemaining: Int?
        /// This is the sum of all the shipping amounts.
        public var amountShipping: Int?
        /// ID of the Connect Application that created the invoice.
        @Expandable<Stripe.Shared.Application, String> public var application: String?
        /// Number of payment attempts made for this invoice, from the perspective of the payment retry schedule.
        public var attemptCount: Int?
        /// Whether an attempt has been made to pay the invoice.
        public var attempted: Bool?
        /// Controls whether Stripe performs automatic collection of the invoice.
        public var autoAdvance: Bool?
        public var automaticTax: AutomaticTax?
        /// The time when this invoice is currently scheduled to be automatically finalized.
        public var automaticallyFinalizesAt: Date?
        /// Indicates the reason why the invoice was created.
        public var billingReason: BillingReason?
        /// Either `charge_automatically`, or `send_invoice`.
        public var collectionMethod: CollectionMethod?
        /// The confirmation secret associated with this invoice.
        public var confirmationSecret: ConfirmationSecret?
        /// Time at which the object was created.
        public var created: Date?
        /// Three-letter ISO currency code, in lowercase.
        public var currency: Stripe.Currency?
        /// Custom fields displayed on the invoice.
        public var customFields: [Stripe.Shared.CustomFields]?
        /// The ID of the customer to bill.
        @Expandable<Stripe.Customers.Customer, String> public var customer: String?
        /// The ID of the account representing the customer to bill.
        public var customerAccount: String?
        /// The customer's address.
        public var customerAddress: Address?
        /// The customer's email.
        public var customerEmail: String?
        /// The customer's name.
        public var customerName: String?
        /// The customer's phone number.
        public var customerPhone: String?
        /// The customer's shipping information.
        public var customerShipping: ShippingLabel?
        /// The customer's tax exempt status.
        public var customerTaxExempt: CustomerTaxExempt?
        /// The customer's tax IDs.
        public var customerTaxIds: [CustomerTaxIds]?
        /// ID of the default payment method for the invoice.
        @Expandable<Stripe.PaymentMethods.PaymentMethod, String> public var defaultPaymentMethod: String?
        /// ID of the default payment source for the invoice.
        @Expandable<Stripe.PaymentSource, String> public var defaultSource: String?
        /// The tax rates applied to this invoice, if any.
        public var defaultTaxRates: [Stripe.Tax.Rate]?
        /// An arbitrary string attached to the object.
        public var description: String?
        /// The discounts applied to the invoice.
        @ExpandableCollection<Stripe.Shared.Discount> public var discounts: [String]?
        /// The date on which payment for this invoice is due.
        public var dueDate: Date?
        /// The date when this invoice is in effect.
        public var effectiveAt: Date?
        /// Ending customer balance after the invoice is finalized.
        public var endingBalance: Int?
        /// Footer displayed on the invoice.
        public var footer: String?
        /// Details of the invoice that was cloned.
        public var fromInvoice: FromInvoice?
        /// The URL for the hosted invoice page, which allows customers to view and pay an invoice.
        public var hostedInvoiceUrl: String?
        /// The link to download the PDF for the invoice.
        public var invoicePdf: String?
        public var issuer: Stripe.Shared.ConnectAccountReference?
        /// The error encountered during the previous attempt to finalize the invoice.
        public var lastFinalizationError: Stripe.Shared.ApiErrors?
        /// The ID of the most recent non-draft revision of this invoice.
        @Expandable<Stripe.Billing.Invoice, String> public var latestRevision: String?
        /// The individual line items that make up the invoice.
        public var lines: Lines?
        /// If the object exists in live mode, the value is `true`.
        public var livemode: Bool?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: [String: String]?
        /// The time at which payment will next be attempted.
        public var nextPaymentAttempt: Date?
        /// A unique, identifying string that appears on emails sent to the customer for this invoice.
        public var number: String?
        /// The account (if any) for which the funds of the invoice payment are intended.
        @Expandable<Stripe.Connect.Account, String> public var onBehalfOf: String?
        /// The parent that generated this invoice.
        public var parent: Parent?
        public var paymentSettings: PaymentSettings?
        /// Payments for this invoice.
        public var payments: Payments?
        /// The latest timestamp at which invoice items can be associated with this invoice.
        public var periodEnd: Date?
        /// The earliest timestamp at which invoice items can be associated with this invoice.
        public var periodStart: Date?
        /// Total amount of all post-payment credit notes issued for this invoice.
        public var postPaymentCreditNotesAmount: Int?
        /// Total amount of all pre-payment credit notes issued for this invoice.
        public var prePaymentCreditNotesAmount: Int?
        /// This is the transaction number that appears on email receipts sent for this invoice.
        public var receiptNumber: String?
        /// The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and.
        public var rendering: Rendering?
        /// The details of the cost of shipping, including the ShippingRate applied on the invoice.
        public var shippingCost: Stripe.Shared.ShippingCost?
        /// Shipping details for the invoice.
        public var shippingDetails: ShippingLabel?
        /// Starting customer balance before the invoice is finalized.
        public var startingBalance: Int?
        /// Extra information about an invoice for the customer's credit card statement.
        public var statementDescriptor: String?
        /// The status of the invoice, one of `draft`, `open`, `paid`, `uncollectible`, or `void`.
        public var status: Status?
        public var statusTransitions: StatusTransitions?
        @Expandable<Stripe.Billing.Subscription, String> public var subscription: String?
        /// Total of all subscriptions, invoice items, and prorations on the invoice before any invoice level discount or.
        public var subtotal: Int?
        /// The integer amount in cents (or local equivalent) representing the subtotal of the invoice before any invoice level.
        public var subtotalExcludingTax: Int?
        /// ID of the test clock this invoice belongs to.
        @Expandable<Stripe.Billing.TestClocks.TestClock, String> public var testClock: String?
        public var thresholdReason: ThresholdReason?
        /// Total after discounts and taxes.
        public var total: Int?
        /// The aggregate amounts calculated per discount across all line items.
        public var totalDiscountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]?
        /// The integer amount in cents (or local equivalent) representing the total amount of the invoice including all.
        public var totalExcludingTax: Int?
        /// Contains pretax credit amounts (ex: discount, credit grants, etc) that apply to this invoice.
        public var totalPretaxCreditAmounts: [Stripe.Shared.InvoicesResourcePretaxCreditAmount]?
        /// The aggregate tax information of all line items.
        public var totalTaxes: [Stripe.Shared.BillingBillResourceInvoicingTaxesTax]?
        /// Invoices are automatically paid or sent 1 hour after webhooks are delivered, or until all webhook delivery attempts.
        public var webhooksDeliveredAt: Date?

        public init(
            id: ID? = nil,
            object: String,
            accountCountry: String? = nil,
            accountName: String? = nil,
            accountTaxIds: [String]? = nil,
            amountDue: Int? = nil,
            amountOverpaid: Int? = nil,
            amountPaid: Int? = nil,
            amountPaidOffStripe: Int? = nil,
            amountRemaining: Int? = nil,
            amountShipping: Int? = nil,
            application: String? = nil,
            attemptCount: Int? = nil,
            attempted: Bool? = nil,
            autoAdvance: Bool? = nil,
            automaticTax: AutomaticTax? = nil,
            automaticallyFinalizesAt: Date? = nil,
            billingReason: BillingReason? = nil,
            collectionMethod: CollectionMethod? = nil,
            confirmationSecret: ConfirmationSecret? = nil,
            created: Date? = nil,
            currency: Stripe.Currency? = nil,
            customFields: [Stripe.Shared.CustomFields]? = nil,
            customer: String? = nil,
            customerAccount: String? = nil,
            customerAddress: Address? = nil,
            customerEmail: String? = nil,
            customerName: String? = nil,
            customerPhone: String? = nil,
            customerShipping: ShippingLabel? = nil,
            customerTaxExempt: CustomerTaxExempt? = nil,
            customerTaxIds: [CustomerTaxIds]? = nil,
            defaultPaymentMethod: String? = nil,
            defaultSource: String? = nil,
            defaultTaxRates: [Stripe.Tax.Rate]? = nil,
            description: String? = nil,
            discounts: [String]? = nil,
            dueDate: Date? = nil,
            effectiveAt: Date? = nil,
            endingBalance: Int? = nil,
            footer: String? = nil,
            fromInvoice: FromInvoice? = nil,
            hostedInvoiceUrl: String? = nil,
            invoicePdf: String? = nil,
            issuer: Stripe.Shared.ConnectAccountReference? = nil,
            lastFinalizationError: Stripe.Shared.ApiErrors? = nil,
            latestRevision: String? = nil,
            lines: Lines? = nil,
            livemode: Bool? = nil,
            metadata: [String: String]? = nil,
            nextPaymentAttempt: Date? = nil,
            number: String? = nil,
            onBehalfOf: String? = nil,
            parent: Parent? = nil,
            paymentSettings: PaymentSettings? = nil,
            payments: Payments? = nil,
            periodEnd: Date? = nil,
            periodStart: Date? = nil,
            postPaymentCreditNotesAmount: Int? = nil,
            prePaymentCreditNotesAmount: Int? = nil,
            receiptNumber: String? = nil,
            rendering: Rendering? = nil,
            shippingCost: Stripe.Shared.ShippingCost? = nil,
            shippingDetails: ShippingLabel? = nil,
            startingBalance: Int? = nil,
            statementDescriptor: String? = nil,
            status: Status? = nil,
            statusTransitions: StatusTransitions? = nil,
            subscription: String? = nil,
            subtotal: Int? = nil,
            subtotalExcludingTax: Int? = nil,
            testClock: String? = nil,
            thresholdReason: ThresholdReason? = nil,
            total: Int? = nil,
            totalDiscountAmounts: [Stripe.Shared.DiscountsResourceDiscountAmount]? = nil,
            totalExcludingTax: Int? = nil,
            totalPretaxCreditAmounts: [Stripe.Shared.InvoicesResourcePretaxCreditAmount]? = nil,
            totalTaxes: [Stripe.Shared.BillingBillResourceInvoicingTaxesTax]? = nil,
            webhooksDeliveredAt: Date? = nil
        ) {
            self.id = id
            self.object = object
            self.accountCountry = accountCountry
            self.accountName = accountName
            self._accountTaxIds = ExpandableCollection(ids: accountTaxIds)
            self.amountDue = amountDue
            self.amountOverpaid = amountOverpaid
            self.amountPaid = amountPaid
            self.amountPaidOffStripe = amountPaidOffStripe
            self.amountRemaining = amountRemaining
            self.amountShipping = amountShipping
            self._application = Expandable(id: application)
            self.attemptCount = attemptCount
            self.attempted = attempted
            self.autoAdvance = autoAdvance
            self.automaticTax = automaticTax
            self.automaticallyFinalizesAt = automaticallyFinalizesAt
            self.billingReason = billingReason
            self.collectionMethod = collectionMethod
            self.confirmationSecret = confirmationSecret
            self.created = created
            self.currency = currency
            self.customFields = customFields
            self._customer = Expandable(id: customer)
            self.customerAccount = customerAccount
            self.customerAddress = customerAddress
            self.customerEmail = customerEmail
            self.customerName = customerName
            self.customerPhone = customerPhone
            self.customerShipping = customerShipping
            self.customerTaxExempt = customerTaxExempt
            self.customerTaxIds = customerTaxIds
            self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
            self._defaultSource = Expandable(id: defaultSource)
            self.defaultTaxRates = defaultTaxRates
            self.description = description
            self._discounts = ExpandableCollection(ids: discounts)
            self.dueDate = dueDate
            self.effectiveAt = effectiveAt
            self.endingBalance = endingBalance
            self.footer = footer
            self.fromInvoice = fromInvoice
            self.hostedInvoiceUrl = hostedInvoiceUrl
            self.invoicePdf = invoicePdf
            self.issuer = issuer
            self.lastFinalizationError = lastFinalizationError
            self._latestRevision = Expandable(id: latestRevision)
            self.lines = lines
            self.livemode = livemode
            self.metadata = metadata
            self.nextPaymentAttempt = nextPaymentAttempt
            self.number = number
            self._onBehalfOf = Expandable(id: onBehalfOf)
            self.parent = parent
            self.paymentSettings = paymentSettings
            self.payments = payments
            self.periodEnd = periodEnd
            self.periodStart = periodStart
            self.postPaymentCreditNotesAmount = postPaymentCreditNotesAmount
            self.prePaymentCreditNotesAmount = prePaymentCreditNotesAmount
            self.receiptNumber = receiptNumber
            self.rendering = rendering
            self.shippingCost = shippingCost
            self.shippingDetails = shippingDetails
            self.startingBalance = startingBalance
            self.statementDescriptor = statementDescriptor
            self.status = status
            self.statusTransitions = statusTransitions
            self._subscription = Expandable(id: subscription)
            self.subtotal = subtotal
            self.subtotalExcludingTax = subtotalExcludingTax
            self._testClock = Expandable(id: testClock)
            self.thresholdReason = thresholdReason
            self.total = total
            self.totalDiscountAmounts = totalDiscountAmounts
            self.totalExcludingTax = totalExcludingTax
            self.totalPretaxCreditAmounts = totalPretaxCreditAmounts
            self.totalTaxes = totalTaxes
            self.webhooksDeliveredAt = webhooksDeliveredAt
        }

        /// Indicates the reason why the invoice was created.
        public enum BillingReason: String, Codable, Hashable, Sendable {
            case automaticPendingInvoiceItemInvoice = "automatic_pending_invoice_item_invoice"
            case manual
            case quoteAccept = "quote_accept"
            case subscription
            case subscriptionCreate = "subscription_create"
            case subscriptionCycle = "subscription_cycle"
            case subscriptionThreshold = "subscription_threshold"
            case subscriptionUpdate = "subscription_update"
            case upcoming
        }

        /// Either `charge_automatically`, or `send_invoice`.
        public enum CollectionMethod: String, Codable, Hashable, Sendable {
            case chargeAutomatically = "charge_automatically"
            case sendInvoice = "send_invoice"
        }

        /// The customer's tax exempt status.
        public enum CustomerTaxExempt: String, Codable, Hashable, Sendable {
            case exempt
            case none
            case reverse
        }

        /// The status of the invoice, one of `draft`, `open`, `paid`, `uncollectible`, or `void`.
        public enum Status: String, Codable, Hashable, Sendable {
            case draft
            case open
            case paid
            case uncollectible
            case void
        }

        public struct AutomaticTax: Codable, Hashable, Sendable {
            /// If Stripe disabled automatic tax, this enum describes why.
            public var disabledReason: DisabledReason?
            /// Whether Stripe automatically computes tax on this invoice.
            public var enabled: Bool?
            /// The account that's liable for tax.
            public var liability: Stripe.Shared.ConnectAccountReference?
            /// The tax provider powering automatic tax.
            public var provider: String?
            /// The status of the most recent automated tax calculation for this invoice.
            public var status: Status?

            public init(
                disabledReason: DisabledReason? = nil,
                enabled: Bool? = nil,
                liability: Stripe.Shared.ConnectAccountReference? = nil,
                provider: String? = nil,
                status: Status? = nil
            ) {
                self.disabledReason = disabledReason
                self.enabled = enabled
                self.liability = liability
                self.provider = provider
                self.status = status
            }

            /// If Stripe disabled automatic tax, this enum describes why.
            public enum DisabledReason: String, Codable, Hashable, Sendable {
                case finalizationRequiresLocationInputs = "finalization_requires_location_inputs"
                case finalizationSystemError = "finalization_system_error"
            }

            /// The status of the most recent automated tax calculation for this invoice.
            public enum Status: String, Codable, Hashable, Sendable {
                case complete
                case failed
                case requiresLocationInputs = "requires_location_inputs"
            }
        }

        public struct ConfirmationSecret: Codable, Hashable, Sendable {
            /// The client_secret of the payment that Stripe creates for the invoice after finalization.
            public var clientSecret: String?
            /// The type of client_secret.
            public var `type`: String?

            public init(
                clientSecret: String? = nil,
                `type`: String? = nil
            ) {
                self.clientSecret = clientSecret
                self.`type` = `type`
            }
        }

        public struct CustomerTaxIds: Codable, Hashable, Sendable {
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

        public struct FromInvoice: Codable, Hashable, Sendable {
            /// The relation between this invoice and the cloned invoice.
            public var action: String?
            /// The invoice that was cloned.
            @Expandable<Stripe.Billing.Invoice, String> public var invoice: String?

            public init(
                action: String? = nil,
                invoice: String? = nil
            ) {
                self.action = action
                self._invoice = Expandable(id: invoice)
            }
        }

        /// The individual line items that make up the invoice.
        public struct Lines: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [Stripe.Billing.Invoice.LineItem]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [Stripe.Billing.Invoice.LineItem]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }

        public struct Parent: Codable, Hashable, Sendable {
            /// Details about the quote that generated this invoice.
            public var quoteDetails: QuoteDetails?
            /// Details about the subscription that generated this invoice.
            public var subscriptionDetails: SubscriptionDetails?
            /// The type of parent that generated this invoice.
            public var `type`: Type?

            public init(
                quoteDetails: QuoteDetails? = nil,
                subscriptionDetails: SubscriptionDetails? = nil,
                `type`: Type? = nil
            ) {
                self.quoteDetails = quoteDetails
                self.subscriptionDetails = subscriptionDetails
                self.`type` = `type`
            }

            /// The type of parent that generated this invoice.
            public enum `Type`: String, Codable, Hashable, Sendable {
                case quoteDetails = "quote_details"
                case subscriptionDetails = "subscription_details"
            }

            public struct QuoteDetails: Codable, Hashable, Sendable {
                /// The quote that generated this invoice.
                public var quote: String?

                public init(
                    quote: String? = nil
                ) {
                    self.quote = quote
                }
            }

            public struct SubscriptionDetails: Codable, Hashable, Sendable {
                /// Set of key-value pairs defined as subscription metadata when an invoice is created.
                public var metadata: [String: String]?
                /// The subscription that generated this invoice.
                @Expandable<Stripe.Billing.Subscription, String> public var subscription: String?
                /// Only set for upcoming invoices that preview prorations.
                public var subscriptionProrationDate: Date?

                public init(
                    metadata: [String: String]? = nil,
                    subscription: String? = nil,
                    subscriptionProrationDate: Date? = nil
                ) {
                    self.metadata = metadata
                    self._subscription = Expandable(id: subscription)
                    self.subscriptionProrationDate = subscriptionProrationDate
                }
            }
        }

        public struct PaymentSettings: Codable, Hashable, Sendable {
            /// ID of the mandate to be used for this invoice.
            public var defaultMandate: String?
            /// Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
            public var paymentMethodOptions: PaymentMethodOptions?
            /// The list of payment method types (e.g.
            public var paymentMethodTypes: [PaymentMethodTypes]?

            public init(
                defaultMandate: String? = nil,
                paymentMethodOptions: PaymentMethodOptions? = nil,
                paymentMethodTypes: [PaymentMethodTypes]? = nil
            ) {
                self.defaultMandate = defaultMandate
                self.paymentMethodOptions = paymentMethodOptions
                self.paymentMethodTypes = paymentMethodTypes
            }

            public enum PaymentMethodTypes: String, Codable, Hashable, Sendable {
                case achCreditTransfer = "ach_credit_transfer"
                case achDebit = "ach_debit"
                case acssDebit = "acss_debit"
                case affirm
                case alipay
                case amazonPay = "amazon_pay"
                case auBecsDebit = "au_becs_debit"
                case bacsDebit = "bacs_debit"
                case bancontact
                case boleto
                case card
                case cashapp
                case crypto
                case custom
                case customerBalance = "customer_balance"
                case eps
                case fpx
                case giropay
                case grabpay
                case ideal
                case jpCreditTransfer = "jp_credit_transfer"
                case kakaoPay = "kakao_pay"
                case klarna
                case konbini
                case krCard = "kr_card"
                case link
                case mbWay = "mb_way"
                case multibanco
                case naverPay = "naver_pay"
                case nzBankAccount = "nz_bank_account"
                case p24
                case payByBank = "pay_by_bank"
                case payco
                case paynow
                case paypal
                case payto
                case pix
                case promptpay
                case revolutPay = "revolut_pay"
                case satispay
                case sepaCreditTransfer = "sepa_credit_transfer"
                case sepaDebit = "sepa_debit"
                case sofort
                case swish
                case twint
                case upi
                case usBankAccount = "us_bank_account"
                case wechatPay = "wechat_pay"
            }

            public struct PaymentMethodOptions: Codable, Hashable, Sendable {
                /// If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method.
                public var acssDebit: Stripe.Shared.AcssDebit?
                /// If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the.
                public var bancontact: Stripe.Shared.Bancontact?
                /// If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s.
                @Boxed public var card: Card?
                /// If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to.
                public var customerBalance: Stripe.Shared.CustomerBalance?
                /// If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the.
                public var konbini: Stripe.Shared.Konbini?
                /// If paying by `payto`, this sub-hash contains details about the PayTo payment method options to pass to the invoice’s.
                public var payto: Stripe.Shared.Payto?
                /// If paying by `pix`, this sub-hash contains details about the Pix payment method options to pass to the invoice’s.
                public var pix: Pix?
                /// If paying by `sepa_debit`, this sub-hash contains details about the SEPA Direct Debit payment method options to pass.
                public var sepaDebit: Stripe.Shared.SepaDebit?
                /// If paying by `upi`, this sub-hash contains details about the UPI payment method options to pass to the invoice’s.
                public var upi: Stripe.Shared.Upi?
                /// If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to.
                public var usBankAccount: Stripe.Shared.UsBankAccount?

                public init(
                    acssDebit: Stripe.Shared.AcssDebit? = nil,
                    bancontact: Stripe.Shared.Bancontact? = nil,
                    card: Card? = nil,
                    customerBalance: Stripe.Shared.CustomerBalance? = nil,
                    konbini: Stripe.Shared.Konbini? = nil,
                    payto: Stripe.Shared.Payto? = nil,
                    pix: Pix? = nil,
                    sepaDebit: Stripe.Shared.SepaDebit? = nil,
                    upi: Stripe.Shared.Upi? = nil,
                    usBankAccount: Stripe.Shared.UsBankAccount? = nil
                ) {
                    self.acssDebit = acssDebit
                    self.bancontact = bancontact
                    self._card = Boxed(wrappedValue: card)
                    self.customerBalance = customerBalance
                    self.konbini = konbini
                    self.payto = payto
                    self.pix = pix
                    self.sepaDebit = sepaDebit
                    self.upi = upi
                    self.usBankAccount = usBankAccount
                }

                public struct Card: Codable, Hashable, Sendable {
                    public var installments: Installments?
                    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based.
                    public var requestThreeDSecure: RequestThreeDSecure?

                    public init(
                        installments: Installments? = nil,
                        requestThreeDSecure: RequestThreeDSecure? = nil
                    ) {
                        self.installments = installments
                        self.requestThreeDSecure = requestThreeDSecure
                    }

                    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based.
                    public enum RequestThreeDSecure: String, Codable, Hashable, Sendable {
                        case `any`
                        case automatic
                        case challenge
                    }

                    public struct Installments: Codable, Hashable, Sendable {
                        /// Whether Installments are enabled for this Invoice.
                        public var enabled: Bool?

                        public init(
                            enabled: Bool? = nil
                        ) {
                            self.enabled = enabled
                        }
                    }
                }

                public struct Pix: Codable, Hashable, Sendable {
                    /// Determines if the amount includes the IOF tax.
                    public var amountIncludesIof: AmountIncludesIof?
                    /// The number of seconds (between 10 and 1209600) after which Pix payment will expire.
                    public var expiresAfterSeconds: Int?

                    public init(
                        amountIncludesIof: AmountIncludesIof? = nil,
                        expiresAfterSeconds: Int? = nil
                    ) {
                        self.amountIncludesIof = amountIncludesIof
                        self.expiresAfterSeconds = expiresAfterSeconds
                    }

                    /// Determines if the amount includes the IOF tax.
                    public enum AmountIncludesIof: String, Codable, Hashable, Sendable {
                        case always
                        case never
                    }
                }
            }
        }

        /// Payments for this invoice.
        public struct Payments: Codable, Hashable, Sendable {
            /// String representing the object's type.
            public let object: String
            /// Details about each object.
            public var data: [Stripe.Billing.Invoice.Payment]?
            /// True if this list has another page of items after this one that can be fetched.
            public var hasMore: Bool?
            /// The URL where this list can be accessed.
            public var url: String?

            public init(
                object: String,
                data: [Stripe.Billing.Invoice.Payment]? = nil,
                hasMore: Bool? = nil,
                url: String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.url = url
            }
        }

        public struct Rendering: Codable, Hashable, Sendable {
            /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
            public var amountTaxDisplay: String?
            /// Invoice pdf rendering options.
            public var pdf: Pdf?
            /// ID of the rendering template that the invoice is formatted by.
            public var template: String?
            /// Version of the rendering template that the invoice is using.
            public var templateVersion: Int?

            public init(
                amountTaxDisplay: String? = nil,
                pdf: Pdf? = nil,
                template: String? = nil,
                templateVersion: Int? = nil
            ) {
                self.amountTaxDisplay = amountTaxDisplay
                self.pdf = pdf
                self.template = template
                self.templateVersion = templateVersion
            }

            public struct Pdf: Codable, Hashable, Sendable {
                /// Page size of invoice pdf.
                public var pageSize: PageSize?

                public init(
                    pageSize: PageSize? = nil
                ) {
                    self.pageSize = pageSize
                }

                /// Page size of invoice pdf.
                public enum PageSize: String, Codable, Hashable, Sendable {
                    case a4
                    case auto
                    case letter
                }
            }
        }

        public struct StatusTransitions: Codable, Hashable, Sendable {
            /// The time that the invoice draft was finalized.
            public var finalizedAt: Date?
            /// The time that the invoice was marked uncollectible.
            public var markedUncollectibleAt: Date?
            /// The time that the invoice was paid.
            public var paidAt: Date?
            /// The time that the invoice was voided.
            public var voidedAt: Date?

            public init(
                finalizedAt: Date? = nil,
                markedUncollectibleAt: Date? = nil,
                paidAt: Date? = nil,
                voidedAt: Date? = nil
            ) {
                self.finalizedAt = finalizedAt
                self.markedUncollectibleAt = markedUncollectibleAt
                self.paidAt = paidAt
                self.voidedAt = voidedAt
            }
        }

        public struct ThresholdReason: Codable, Hashable, Sendable {
            /// The total invoice amount threshold boundary if it triggered the threshold invoice.
            public var amountGte: Int?
            /// Indicates which line items triggered a threshold invoice.
            public var itemReasons: [ItemReasons]?

            public init(
                amountGte: Int? = nil,
                itemReasons: [ItemReasons]? = nil
            ) {
                self.amountGte = amountGte
                self.itemReasons = itemReasons
            }

            public struct ItemReasons: Codable, Hashable, Sendable {
                /// The IDs of the line items that triggered the threshold invoice.
                public var lineItemIds: [String]?
                /// The quantity threshold boundary that applied to the given line item.
                public var usageGte: Int?

                public init(
                    lineItemIds: [String]? = nil,
                    usageGte: Int? = nil
                ) {
                    self.lineItemIds = lineItemIds
                    self.usageGte = usageGte
                }
            }
        }
    }
}
