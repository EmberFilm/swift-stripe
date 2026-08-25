//
//  PaymentIntentNextAction.swift
//
//
//  Created by Andrew Edwards on 3/9/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.PaymentIntents.PaymentIntent {
    public struct NextAction: Codable, Hashable, Sendable {
        /// Contains instructions for authenticating a payment by redirecting your customer to Alipay App or website.
        public var alipayHandleRedirect:
            Stripe.PaymentIntents.PaymentIntent.NextAction.Alipay.HandleRedirect?
        /// Contains Boleto details necessary for the customer to complete the payment.
        public var boletoDisplaydetails:
            Stripe.PaymentIntents.PaymentIntent.NextAction.Boleto.DisplayDetails?
        /// Contains instructions for processing off session recurring payments with Indian issued cards.
        public var cardAwaitNotification:
            Stripe.PaymentIntents.PaymentIntent.NextAction.Card.AwaitNotification?
        // TODO: - Add suppport for Bank display once out of preview
        // https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-display_bank_transfer_instructions
        /// Contains Konbini details necessary for the customer to complete the payment.
        public var konbiniDisplayDetails:
            Stripe.PaymentIntents.PaymentIntent.NextAction.Konbini.DisplayDetails?
        /// Contains OXXO details necessary for the customer to complete the payment.
        public var oxxoDisplayDetails:
            Stripe.PaymentIntents.PaymentIntent.NextAction.OXXO.DisplayDetails?
        /// The field that contains PayNow QR code info
        public var paynowDisplayQrCode:
            Stripe.PaymentIntents.PaymentIntent.NextAction.Paynow.DisplayQRCode?
        // The field that contains Pix QR code info
        // public var pixDisplayQrCode: Stripe.PaymentIntents.PaymentIntent.NextAction.PaynowDisplayQRCode? TODO: - Add preview feature when it's ready.https://stripe.com/docs/api/payment_intents/object#payment_intent_object-next_action-pix_display_qr_code
        /// The field that contains PromptPay QR code info
        public var promptpayDisplayQrCode:
            Stripe.PaymentIntents.PaymentIntent.NextAction.PromptPay.DisplayQRCode?
        /// Contains instructions for authenticating a payment by redirecting your customer to another page or application.
        public var redirectToUrl: Stripe.PaymentIntents.PaymentIntent.NextAction.RedirectToUrl?
        /// Type of the next action to perform, one of `redirect_to_url` or `use_stripe_sdk`, `alipay_handle_redirect`, `oxxo_display_details` or `verify_with_microdeposits`.
        public var type: Stripe.PaymentIntents.PaymentIntent.NextAction.`Type`?
        /// Contains details describing microdeposits verification flow.
        public var verifyWithMicrodeposits:
            Stripe.PaymentIntents.PaymentIntent.NextAction.VerifyWithMicrodeposits?
        /// The field that contains Wechat Pay QR code info
        public var wechatPayDisplayQrCode:
            Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay.QRCode?
        /// Info required for android app to app redirect
        public var wechatPayRedirectToAndroidApp:
            Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay.AndroidApp?
        /// Info required for iOS app to app redirect
        public var wechatPayRedirectToIosApp:
            Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay.IOSApp?

        public init(
            alipayHandleRedirect: Stripe.PaymentIntents.PaymentIntent.NextAction.Alipay
                .HandleRedirect? =
                nil,
            boletoDisplaydetails: Stripe.PaymentIntents.PaymentIntent.NextAction.Boleto
                .DisplayDetails? =
                nil,
            cardAwaitNotification: Stripe.PaymentIntents.PaymentIntent.NextAction.Card
                .AwaitNotification? = nil,
            konbiniDisplayDetails: Stripe.PaymentIntents.PaymentIntent.NextAction.Konbini
                .DisplayDetails? = nil,
            oxxoDisplayDetails: Stripe.PaymentIntents.PaymentIntent.NextAction.OXXO
                .DisplayDetails? = nil,
            paynowDisplayQrCode: Stripe.PaymentIntents.PaymentIntent.NextAction.Paynow
                .DisplayQRCode? =
                nil,
            promptpayDisplayQrCode: Stripe.PaymentIntents.PaymentIntent.NextAction.PromptPay
                .DisplayQRCode? = nil,
            redirectToUrl: Stripe.PaymentIntents.PaymentIntent.NextAction.RedirectToUrl? = nil,
            type: Stripe.PaymentIntents.PaymentIntent.NextAction.`Type`? = nil,
            verifyWithMicrodeposits: Stripe.PaymentIntents.PaymentIntent.NextAction
                .VerifyWithMicrodeposits? = nil,
            wechatPayDisplayQrCode: Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay
                .QRCode? =
                nil,
            wechatPayRedirectToAndroidApp: Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay
                .AndroidApp? = nil,
            wechatPayRedirectToIosApp: Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay
                .IOSApp? =
                nil
        ) {
            self.alipayHandleRedirect = alipayHandleRedirect
            self.boletoDisplaydetails = boletoDisplaydetails
            self.cardAwaitNotification = cardAwaitNotification
            self.konbiniDisplayDetails = konbiniDisplayDetails
            self.oxxoDisplayDetails = oxxoDisplayDetails
            self.paynowDisplayQrCode = paynowDisplayQrCode
            self.promptpayDisplayQrCode = promptpayDisplayQrCode
            self.redirectToUrl = redirectToUrl
            self.type = type
            self.verifyWithMicrodeposits = verifyWithMicrodeposits
            self.wechatPayDisplayQrCode = wechatPayDisplayQrCode
            self.wechatPayRedirectToAndroidApp = wechatPayRedirectToAndroidApp
            self.wechatPayRedirectToIosApp = wechatPayRedirectToIosApp
        }
    }
}

// MARK: - Alipay
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum Alipay {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.Alipay {
    public struct HandleRedirect: Codable, Hashable, Sendable {
        /// The native data to be used with Alipay SDK you must redirect your customer to in order to authenticate the payment in an Android App.
        public var nativeData: String?
        /// The native URL you must redirect your customer to in order to authenticate the payment in an iOS App.
        public var nativeUrl: String?
        /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
        public var returnUrl: String?
        /// The URL you must redirect your customer to in order to authenticate the payment.
        public var url: String?

        public init(
            nativeData: String? = nil,
            nativeUrl: String? = nil,
            returnUrl: String? = nil,
            url: String? = nil
        ) {
            self.nativeData = nativeData
            self.nativeUrl = nativeUrl
            self.returnUrl = returnUrl
            self.url = url
        }
    }
}

// MARK: - Boleto
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum Boleto {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.Boleto {
    public struct DisplayDetails: Codable, Hashable, Sendable {
        /// The timestamp after which the boleto expires.
        public var expiresAt: Date?
        /// The URL to the hosted boleto voucher page, which allows customers to view the boleto voucher.
        public var hostedVoucherUrl: String?
        /// The boleto number.
        public var number: String?
        /// The URL to the downloadable boleto voucher PDF.
        public var pdf: String?

        public init(
            expiresAt: Date? = nil,
            hostedVoucherUrl: String? = nil,
            number: String? = nil,
            pdf: String? = nil
        ) {
            self.expiresAt = expiresAt
            self.hostedVoucherUrl = hostedVoucherUrl
            self.number = number
            self.pdf = pdf
        }
    }
}

// MARK: - Card
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum Card {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.Card {
    public struct AwaitNotification: Codable, Hashable, Sendable {
        /// The time that payment will be attempted. If customer approval is required, they need to provide approval before this time.
        public var chargeAttemptAt: Date?
        /// For payments greater than INR 15000, the customer must provide explicit approval of the payment with their bank. For payments of lower amount, no customer action is required.
        public var customerApprovalRequired: Bool?

        public init(
            chargeAttemptAt: Date? = nil,
            customerApprovalRequired: Bool? = nil
        ) {
            self.chargeAttemptAt = chargeAttemptAt
            self.customerApprovalRequired = customerApprovalRequired
        }
    }
}

// MARK: - Konbini
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum Konbini {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.Konbini {
    public struct DisplayDetails: Codable, Hashable, Sendable {
        /// The timestamp at which the pending Konbini payment expires.
        public var expiresAt: Date?
        /// The URL for the Konbini payment instructions page, which allows customers to view and print a Konbini voucher.
        public var hostedVoucherUrl: String?
        /// Payment instruction details grouped by convenience store chain.
        public var stores: Stores?

        public init(
            expiresAt: Date? = nil,
            hostedVoucherUrl: String? = nil,
            stores: Stores? = nil
        ) {
            self.expiresAt = expiresAt
            self.hostedVoucherUrl = hostedVoucherUrl
            self.stores = stores
        }
    }

    public struct Stores: Codable, Hashable, Sendable {
        /// FamilyMart instruction details.
        public var familymart: StoreDetails?
        /// Lawson instruction details.
        public var lawson: StoreDetails?
        /// Ministop instruction details.
        public var ministop: StoreDetails?
        /// Seicomart instruction details.
        public var seicomart: StoreDetails?

        public init(
            familymart: StoreDetails? = nil,
            lawson: StoreDetails? = nil,
            ministop: StoreDetails? = nil,
            seicomart: StoreDetails? = nil
        ) {
            self.familymart = familymart
            self.lawson = lawson
            self.ministop = ministop
            self.seicomart = seicomart
        }
    }

    public struct StoreDetails: Codable, Hashable, Sendable {
        /// The confirmation number.
        public var confirmationNumber: String?
        /// The payment code
        public var paymentCode: String?

        public init(
            confirmationNumber: String? = nil,
            paymentCode: String? = nil
        ) {
            self.confirmationNumber = confirmationNumber
            self.paymentCode = paymentCode
        }
    }
}

// MARK: - OXXO
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum OXXO {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.OXXO {
    public struct DisplayDetails: Codable, Hashable, Sendable {
        /// The timestamp after which the OXXO voucher expires.
        public var expiresAfter: Date?
        /// The URL for the hosted OXXO voucher page, which allows customers to view and print an OXXO voucher.
        public var hostedVoucherUrl: String?
        /// OXXO reference number.
        public var number: String?

        public init(
            expiresAfter: Date? = nil,
            hostedVoucherUrl: String? = nil,
            number: String? = nil
        ) {
            self.expiresAfter = expiresAfter
            self.hostedVoucherUrl = hostedVoucherUrl
            self.number = number
        }
    }
}

// MARK: - Paynow
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum Paynow {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.Paynow {
    public struct DisplayQRCode: Codable, Hashable, Sendable {
        /// The raw data string used to generate QR code, it should be used together with QR code library.
        public var data: String?
        /// The URL to the hosted PayNow instructions page, which allows customers to view the PayNow QR code.
        public var hostedInstructionsUrl: String?
        /// The `image_url_png` string used to render QR code
        public var imageUrlPng: String?
        /// The `image_url_svg` string used to render QR code
        public var imageUrlSvg: String?

        public init(
            data: String? = nil,
            hostedInstructionsUrl: String? = nil,
            imageUrlPng: String? = nil,
            imageUrlSvg: String? = nil
        ) {
            self.data = data
            self.hostedInstructionsUrl = hostedInstructionsUrl
            self.imageUrlPng = imageUrlPng
            self.imageUrlSvg = imageUrlSvg
        }
    }
}

// MARK: - PromptPay
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum PromptPay {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.PromptPay {
    public struct DisplayQRCode: Codable, Hashable, Sendable {
        /// The raw data string used to generate QR code, it should be used together with QR code library.
        public var data: String?
        /// The URL to the hosted PromptPay instructions page, which allows customers to view the PromptPay QR code.
        public var hostedInstructionsUrl: String?
        /// The PNG path used to render the QR code, can be used as the source in an HTML img tag
        public var imageUrlPng: String?
        /// The SVG path used to render the QR code, can be used as the source in an HTML img tag
        public var imageUrlSvg: String?

        public init(
            data: String? = nil,
            hostedInstructionsUrl: String? = nil,
            imageUrlPng: String? = nil,
            imageUrlSvg: String? = nil
        ) {
            self.data = data
            self.hostedInstructionsUrl = hostedInstructionsUrl
            self.imageUrlPng = imageUrlPng
            self.imageUrlSvg = imageUrlSvg
        }
    }
}

// MARK: - RedirectToUrl
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public struct RedirectToUrl: Codable, Hashable, Sendable {
        /// If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
        public var returnUrl: String?
        /// The URL you must redirect your customer to in order to authenticate the payment.
        public var url: String?

        public init(
            returnUrl: String? = nil,
            url: String? = nil
        ) {
            self.returnUrl = returnUrl
            self.url = url
        }
    }
}

// MARK: - Type
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum `Type`: String, Codable, Sendable {
        case redirectToUrl = "redirect_to_url"
        case useStripeSDK = "use_stripe_sdk"
        case alipayHandleRedirect = "alipay_handle_redirect"
        case oxxoDisplayDetails = "oxxo_display_details"
        case verifyWithMicrodeposits = "verify_with_microdeposits"
    }
}

// MARK: - VerifyWithMicrodeposits
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public struct VerifyWithMicrodeposits: Codable, Hashable, Sendable {
        /// The timestamp when the microdeposits are expected to land.
        public var arrivalDate: Date?
        /// The URL for the hosted verification page, which allows customers to verify their bank account.
        public var hostedVerificationUrl: String?
        /// The type of the microdeposit sent to the customer. Used to distinguish between different verification methods.
        public var microdepositType: MicrodepositType?

        public init(
            arrivalDate: Date? = nil,
            hostedVerificationUrl: String? = nil,
            microdepositType: MicrodepositType? = nil
        ) {
            self.arrivalDate = arrivalDate
            self.hostedVerificationUrl = hostedVerificationUrl
            self.microdepositType = microdepositType
        }
    }
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.VerifyWithMicrodeposits {
    public enum MicrodepositType: String, Codable, Sendable {
        case descriptorCode = "descriptor_code"
        case amounts
    }
}

// MARK: - WechatPay
extension Stripe.PaymentIntents.PaymentIntent.NextAction {
    public enum WechatPay {}
}

extension Stripe.PaymentIntents.PaymentIntent.NextAction.WechatPay {
    public struct QRCode: Codable, Hashable, Sendable {
        /// The data being used to generate QR code
        public var data: String?
        /// The URL to the hosted WeChat Pay instructions page, which allows customers to view the WeChat Pay QR code.
        public var hostedInstructionsUrl: String?
        /// The base64 image data for a pre-generated QR code
        public var imageDataUrl: String?
        /// The `image_url_png` string used to render QR code
        public var imageUrlPng: String?
        /// The `image_url_svg` string used to render QR code
        public var imageUrlSvg: String?

        public init(
            data: String? = nil,
            hostedInstructionsUrl: String? = nil,
            imageDataUrl: String? = nil,
            imageUrlPng: String? = nil,
            imageUrlSvg: String? = nil
        ) {
            self.data = data
            self.hostedInstructionsUrl = hostedInstructionsUrl
            self.imageDataUrl = imageDataUrl
            self.imageUrlPng = imageUrlPng
            self.imageUrlSvg = imageUrlSvg
        }
    }

    public struct AndroidApp: Codable, Hashable, Sendable {
        /// `app_id` is the APP ID registered on WeChat open platform
        public var appId: String?
        /// `nonce_str` is a random string
        public var nonceStr: String?
        /// Package is static value
        public var package: String?
        /// A unique merchant ID assigned by Wechat Pay
        public var partnerId: String?
        /// A unique trading ID assigned by Wechat Pay
        public var prepayId: String?
        /// A signature
        public var sign: String?
        /// Specifies the current time in epoch format
        public var timestamp: String?

        public init(
            appId: String? = nil,
            nonceStr: String? = nil,
            package: String? = nil,
            partnerId: String? = nil,
            prepayId: String? = nil,
            sign: String? = nil,
            timestamp: String? = nil
        ) {
            self.appId = appId
            self.nonceStr = nonceStr
            self.package = package
            self.partnerId = partnerId
            self.prepayId = prepayId
            self.sign = sign
            self.timestamp = timestamp
        }
    }

    public struct IOSApp: Codable, Hashable, Sendable {
        /// An universal link that redirect to Wechat Pay APP
        public var nativeUrl: String?

        public init(
            nativeUrl: String? = nil
        ) {
            self.nativeUrl = nativeUrl
        }
    }
}
