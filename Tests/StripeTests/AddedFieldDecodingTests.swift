//
//  AddedFieldDecodingTests.swift
//  swift-stripe
//
//  Every field closed out of the model-drift report, decoded from the wire.
//
//  Declaring a property is not enough: where a type has an explicit `CodingKeys`, a property
//  missing from it compiles, reports no drift, and still decodes to nil forever. These assert
//  the value actually arrives.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing

@testable import Stripe

@Suite("Added field decoding")
struct AddedFieldDecodingTests {

    private static func decode<T: Decodable>(_ type: T.Type, _ json: String) throws -> T {
        try StripeAPI.decoder.decode(type, from: Data(json.utf8))
    }

    @Test("subscription gains its 2026 fields")
    func subscription() throws {
        let sub = try Self.decode(Stripe.Billing.Subscription.self, #"""
        {"id":"sub_1","object":"subscription","created":1,"customer_account":"acct_1",
         "managed_payments":{"enabled":true},
         "presentment_details":{"presentment_currency":"eur"},
         "billing_schedules":[{"key":"bs_1","applies_to":[{"type":"price","price":"price_1"}],
                               "bill_until":{"computed_timestamp":1700000000,
                                             "duration":{"interval":"month","interval_count":3}}}]}
        """#)

        #expect(sub.customerAccount == "acct_1")
        #expect(sub.managedPayments?.enabled == true)
        #expect(sub.presentmentDetails?.presentmentCurrency == "eur")
        let schedule = try #require(sub.billingSchedules?.first)
        #expect(schedule.key == "bs_1")
        #expect(schedule.appliesTo?.first?.price == "price_1")
        #expect(schedule.appliesTo?.first?.type == "price")   // single-value spec enum, kept as a string
        #expect(schedule.billUntil?.duration?.interval == .month)
        #expect(schedule.billUntil?.duration?.intervalCount == 3)
        #expect(schedule.billUntil?.computedTimestamp == Date(timeIntervalSince1970: 1_700_000_000))
    }

    @Test("subscription item reports how far it has billed")
    func subscriptionItem() throws {
        let item = try Self.decode(Stripe.Billing.Subscription.Item.self, #"""
        {"id":"si_1","object":"subscription_item","created":1,"billed_until":1700000000}
        """#)
        #expect(item.billedUntil == Date(timeIntervalSince1970: 1_700_000_000))
    }

    @Test("customer gains names, account and tax")
    func customer() throws {
        let customer = try Self.decode(Stripe.Customers.Customer.self, #"""
        {"id":"cus_1","object":"customer","created":1,"business_name":"Ada Ltd",
         "individual_name":"Ada Lovelace","customer_account":"acct_1",
         "tax":{"automatic_tax":"supported","ip_address":"1.2.3.4","provider":"stripe"}}
        """#)

        #expect(customer.businessName == "Ada Ltd")
        #expect(customer.individualName == "Ada Lovelace")
        #expect(customer.customerAccount == "acct_1")
        #expect(customer.tax?.automaticTax == .supported)
        #expect(customer.tax?.ipAddress == "1.2.3.4")
        #expect(customer.tax?.provider == .stripe)
    }

    @Test("charge gains authorization code, level 3 and presentment")
    func charge() throws {
        let charge = try Self.decode(Stripe.Charges.Charge.self, #"""
        {"id":"ch_1","object":"charge","created":1,"authorization_code":"A1B2C3",
         "presentment_details":{"presentment_amount":1200,"presentment_currency":"gbp"},
         "level3":{"merchant_reference":"m_1","shipping_amount":500,
                   "line_items":[{"product_code":"p_1","quantity":2,"unit_cost":250}]}}
        """#)

        #expect(charge.authorizationCode == "A1B2C3")
        #expect(charge.presentmentDetails?.presentmentAmount == 1200)
        #expect(charge.presentmentDetails?.presentmentCurrency == "gbp")
        #expect(charge.level3?.merchantReference == "m_1")
        #expect(charge.level3?.shippingAmount == 500)
        #expect(charge.level3?.lineItems?.first?.unitCost == 250)
    }

    @Test("payment intent gains its 2026 fields")
    func paymentIntent() throws {
        let intent = try Self.decode(Stripe.PaymentIntents.PaymentIntent.self, #"""
        {"id":"pi_1","object":"payment_intent","created":1,"amount":1000,"currency":"usd",
         "customer_account":"acct_1",
         "allowed_payment_method_types":["card"],
         "excluded_payment_method_types":["acss_debit"],
         "hooks":{"inputs":{"tax":{"calculation":"taxcalc_1"}}},
         "managed_payments":{"enabled":false},
         "payment_details":{"customer_reference":"cr_1","order_reference":"or_1"},
         "payment_method_configuration_details":{"id":"pmc_1","parent":"pmc_0"},
         "presentment_details":{"presentment_amount":900,"presentment_currency":"eur"}}
        """#)

        #expect(intent.customerAccount == "acct_1")
        #expect(intent.allowedPaymentMethodTypes == [.card])   // spec enum, so typed
        #expect(intent.excludedPaymentMethodTypes == [.acssDebit])   // link is not excludable; the enum says so
        #expect(intent.hooks?.inputs?.tax?.calculation == "taxcalc_1")
        #expect(intent.managedPayments?.enabled == false)
        #expect(intent.paymentDetails?.customerReference == "cr_1")
        #expect(intent.paymentDetails?.orderReference == "or_1")
        #expect(intent.paymentMethodConfigurationDetails?.id == "pmc_1")
        #expect(intent.paymentMethodConfigurationDetails?.parent == "pmc_0")
        #expect(intent.presentmentDetails?.presentmentAmount == 900)
    }

    @Test("event carries its fetch context")
    func event() throws {
        let event = try Self.decode(Stripe.Events.Event.self, #"""
        {"id":"evt_1","object":"event","created":1,"type":"charge.succeeded","context":"acct_1"}
        """#)
        #expect(event.context == "acct_1")
    }

    @Test("checkout session gains its 2026 fields")
    func checkoutSession() throws {
        let session = try Self.decode(Stripe.Checkout.Session.self, #"""
        {"id":"cs_1","object":"checkout.session","created":1,
         "adaptive_pricing":{"enabled":true},
         "branding_settings":{"background_color":"#ffffff","border_style":"rounded",
                              "button_color":"#0d6b5e","display_name":"EmberFilm","font_family":"Inter",
                              "icon":{"type":"file","file":"file_1"},
                              "logo":{"type":"url","url":"https://x/logo.png"}},
         "client_secret":"cs_1_secret_abc",
         "collected_information":{"business_name":"Ada Ltd","individual_name":"Ada",
                                  "shipping_details":{"name":"Ada","address":{"city":"London","country":"GB"}}},
         "customer_account":"acct_1",
         "discounts":[{"coupon":"co_1","promotion_code":"promo_1"}],
         "excluded_payment_method_types":["acss_debit"],
         "integration_identifier":"emberfilm-web",
         "managed_payments":{"enabled":false},
         "name_collection":{"business":{"enabled":true,"optional":false},
                            "individual":{"enabled":true,"optional":true}},
         "optional_items":[{"price":"price_2","quantity":1,
                            "adjustable_quantity":{"enabled":true,"maximum":5,"minimum":1}}],
         "origin_context":"mobile_app",
         "payment_method_configuration_details":{"id":"pmc_1","parent":"pmc_0"},
         "permissions":{"update_shipping_details":"server_only"},
         "presentment_details":{"presentment_amount":999,"presentment_currency":"eur"},
         "redirect_on_completion":"if_required",
         "return_url":"https://x/return",
         "saved_payment_method_options":{"allow_redisplay_filters":["always"],
                                         "payment_method_remove":"enabled","payment_method_save":"disabled"},
         "ui_mode":"embedded_page",
         "wallet_options":{"link":{"display":"never"}}}
        """#)

        #expect(session.adaptivePricing?.enabled == true)
        #expect(session.brandingSettings?.borderStyle == .rounded)
        #expect(session.brandingSettings?.displayName == "EmberFilm")
        #expect(session.brandingSettings?.icon?.type == .file)
        #expect(session.brandingSettings?.icon?.file == "file_1")
        #expect(session.brandingSettings?.logo?.type == .url)
        #expect(session.brandingSettings?.logo?.url == "https://x/logo.png")
        #expect(session.clientSecret == "cs_1_secret_abc")
        #expect(session.collectedInformation?.businessName == "Ada Ltd")
        #expect(session.collectedInformation?.individualName == "Ada")
        #expect(session.collectedInformation?.shippingDetails?.name == "Ada")
        #expect(session.collectedInformation?.shippingDetails?.address?.country == "GB")
        #expect(session.customerAccount == "acct_1")
        #expect(session.discounts?.first?.coupon == "co_1")
        #expect(session.discounts?.first?.promotionCode == "promo_1")
        #expect(session.excludedPaymentMethodTypes == ["acss_debit"])
        #expect(session.integrationIdentifier == "emberfilm-web")
        #expect(session.managedPayments?.enabled == false)
        #expect(session.nameCollection?.business?.optional == false)
        #expect(session.nameCollection?.individual?.optional == true)
        #expect(session.optionalItems?.first?.price == "price_2")
        #expect(session.optionalItems?.first?.adjustableQuantity?.maximum == 5)
        #expect(session.originContext == .mobileApp)
        #expect(session.paymentMethodConfigurationDetails?.parent == "pmc_0")
        #expect(session.permissions?.updateShippingDetails == .serverOnly)
        #expect(session.presentmentDetails?.presentmentAmount == 999)
        #expect(session.redirectOnCompletion == .ifRequired)
        #expect(session.returnUrl == "https://x/return")
        #expect(session.savedPaymentMethodOptions?.allowRedisplayFilters == [.always])   // spec enum, so typed
        #expect(session.savedPaymentMethodOptions?.paymentMethodRemove == .enabled)
        #expect(session.savedPaymentMethodOptions?.paymentMethodSave == .disabled)
        #expect(session.uiMode == .embeddedPage)
        #expect(session.walletOptions?.link?.display == .never)
    }

    @Test("an expanded discount decodes as the object, not just its id")
    func expandedDiscount() throws {
        let session = try Self.decode(Stripe.Checkout.Session.self, #"""
        {"id":"cs_1","object":"checkout.session","created":1,
         "discounts":[{"coupon":{"id":"co_1","object":"coupon","created":1,"percent_off":25,"valid":true}}]}
        """#)
        let discount = try #require(session.discounts?.first)
        #expect(discount.$coupon?.id == "co_1")
        #expect(discount.$coupon?.percentOff == 25)
    }

    @Test("the create request sends the UI mode Stripe accepts")
    func requestUIMode() throws {
        // `ui_mode` was typed as `Session.Mode` (payment/setup/subscription), which Stripe rejects.
        let request = Stripe.Checkout.Session.Create.Request(
            mode: .payment, successUrl: "https://x/ok", uiMode: .hostedPage
        )
        let pairs = Dictionary(uniqueKeysWithValues: try StripeFormEncoder().pairs(of: request))
        #expect(pairs["ui_mode"] == "hosted_page")
    }


    @Test("invoice gains its 2026 fields")
    func invoice() throws {
        let invoice = try Self.decode(Stripe.Billing.Invoice.self, #"""
        {"object":"invoice","created":1,
         "amount_overpaid":50,"amount_paid_off_stripe":200,
         "automatically_finalizes_at":1700000000,"effective_at":1700001000,
         "confirmation_secret":{"client_secret":"in_1_secret_x","type":"payment_intent"},
         "customer_account":"acct_c",
         "discounts":["di_1","di_2"],
         "issuer":{"type":"account","account":"acct_i"},
         "rendering":{"amount_tax_display":"exclude_tax","template":"inrtem_1","template_version":3,
                      "pdf":{"page_size":"a4"}},
         "shipping_details":{"name":"Ada","carrier":"DHL","tracking_number":"T1",
                             "address":{"city":"London","country":"GB"}},
         "total_pretax_credit_amounts":[{"amount":100,"type":"discount","discount":"di_1"}],
         "total_taxes":[{"amount":120,"tax_behavior":"exclusive","taxable_amount":600,
                         "taxability_reason":"standard_rated","type":"tax_rate_details",
                         "tax_rate_details":{"tax_rate":"txr_1"}}],
         "payments":{"object":"list","has_more":false,"url":"/v1/invoice_payments",
                     "data":[{"id":"inpay_1","object":"invoice_payment","created":1,"currency":"gbp",
                              "amount_paid":600,"amount_requested":600,"is_default":true,
                              "invoice":"in_1","status":"paid",
                              "payment":{"type":"payment_intent","payment_intent":"pi_1"},
                              "status_transitions":{"paid_at":1700002000}}]}}
        """#)

        #expect(invoice.amountOverpaid == 50)
        #expect(invoice.amountPaidOffStripe == 200)
        #expect(invoice.automaticallyFinalizesAt == Date(timeIntervalSince1970: 1_700_000_000))
        #expect(invoice.effectiveAt == Date(timeIntervalSince1970: 1_700_001_000))
        #expect(invoice.confirmationSecret?.clientSecret == "in_1_secret_x")
        #expect(invoice.customerAccount == "acct_c")
        #expect(invoice.discounts == ["di_1", "di_2"])
        #expect(invoice.issuer?.type == .account)
        #expect(invoice.issuer?.account == "acct_i")
        #expect(invoice.rendering?.template == "inrtem_1")
        #expect(invoice.rendering?.templateVersion == 3)
        #expect(invoice.rendering?.pdf?.pageSize == .a4)
        #expect(invoice.shippingDetails?.carrier == "DHL")
        #expect(invoice.shippingDetails?.address?.country == "GB")
        #expect(invoice.totalPretaxCreditAmounts?.first?.type == .discount)
        #expect(invoice.totalPretaxCreditAmounts?.first?.discount == "di_1")
        let tax = try #require(invoice.totalTaxes?.first)
        #expect(tax.amount == 120)
        #expect(tax.taxBehavior == .exclusive)
        #expect(tax.taxabilityReason == .standardRated)
        #expect(tax.taxRateDetails?.taxRate == "txr_1")
        let payment = try #require(invoice.payments?.data?.first)
        #expect(payment.id == "inpay_1")
        #expect(payment.amountPaid == 600)
        #expect(payment.status == "paid")
        #expect(payment.isDefault == true)
        #expect(payment.payment?.type == .paymentIntent)
        #expect(payment.payment?.paymentIntent == "pi_1")
        #expect(payment.statusTransitions?.paidAt == Date(timeIntervalSince1970: 1_700_002_000))
    }

    @Test("an invoice issued by the requesting account reads as self")
    func invoiceIssuerSelf() throws {
        let invoice = try Self.decode(Stripe.Billing.Invoice.self, #"""
        {"object":"invoice","created":1,"issuer":{"type":"self"}}
        """#)
        #expect(invoice.issuer?.type == .self)
        #expect(invoice.issuer?.account == nil)
    }

}
