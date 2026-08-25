//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The Customer struct is generated (Models/Generated). These are the nested types the request
// layer still names under `Stripe.Customers.Customer` that the generator spells differently.

// The CustomerCashBalance struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Customers.CustomerCashBalance` that the generator spells differently.

extension Stripe.Customers.Customer {
    public enum Sessions: Sendable {}
}

extension Stripe.Customers {
    public struct CustomerCashBalanceSettings: Codable, Hashable, Sendable {
        /// The configuration for how funds that land in the customer cash balance are reconciled
        public var reconciliationMode: String?
        /// A flag to indicate if reconciliation mode returned is the user’s default or is specific to this customer cash balance
        public var usingMerchantDefault: Bool?

        public init(
            reconciliationMode: String? = nil,
            usingMerchantDefault: Bool? = nil
        ) {
            self.reconciliationMode = reconciliationMode
            self.usingMerchantDefault = usingMerchantDefault
        }
    }
}

extension Stripe.Customers {
    public struct CustomerInvoiceSettings: Codable, Hashable, Sendable {
        /// Default custom fields to be displayed on invoices for this customer.
        public var customFields: [Stripe.Customers.CustomerInvoiceSettingsCustomFields]?
        /// ID of the default payment method used for subscriptions and invoices for the customer.
        @ExpandableOf<Stripe.PaymentMethods.PaymentMethod> public var defaultPaymentMethod:
            Stripe.PaymentMethods.PaymentMethod.ID?
        /// Default footer to be displayed on invoices for this customer.
        public var footer: String?
        /// Default options for invoice PDF rendering for this customer.
        public var renderingOptions: Stripe.Customers.CustomerInvoiceSettingsRenderingOptions?

        public init(
            customFields: [Stripe.Customers.CustomerInvoiceSettingsCustomFields]? = nil,
            defaultPaymentMethod: Stripe.PaymentMethods.PaymentMethod.ID? = nil,
            footer: String? = nil,
            renderingOptions: Stripe.Customers.CustomerInvoiceSettingsRenderingOptions? = nil
        ) {
            self.customFields = customFields
            self._defaultPaymentMethod = Expandable(id: defaultPaymentMethod)
            self.footer = footer
            self.renderingOptions = renderingOptions
        }
    }
}

extension Stripe.Customers {
    public struct CustomerInvoiceSettingsCustomFields: Codable, Hashable, Sendable {
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

extension Stripe.Customers {
    public struct CustomerInvoiceSettingsRenderingOptions: Codable, Hashable, Sendable {
        /// How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        public var amountTaxDisplay: String?

        public init(
            amountTaxDisplay: String? = nil
        ) {
            self.amountTaxDisplay = amountTaxDisplay
        }
    }
}

extension Stripe.Customers {
    public enum CustomerTaxExempt: String, Codable, Sendable {
        case none
        case exempt
        case reverse
    }
}

extension Stripe.Customers {
    public struct CustomerList: Codable, Hashable, Sendable {
        public var object: String
        public var hasMore: Bool?
        public var url: String?
        public var data: [Stripe.Customers.Customer]?

        public init(
            object: String,
            hasMore: Bool? = nil,
            url: String? = nil,
            data: [Stripe.Customers.Customer]? = nil
        ) {
            self.object = object
            self.hasMore = hasMore
            self.url = url
            self.data = data
        }
    }
}

extension Stripe.Customers {
    public struct CustomerSearchResult: Codable, Hashable, Sendable {
        /// A string describing the object type returned.
        public var object: String
        /// A list of customers, paginated by any request parameters.
        public var data: [Stripe.Customers.Customer]?
        /// Whether or not there are more elements available after this set.
        public var hasMore: Bool?
        /// The URL for accessing this list.
        public var url: String?
        /// The URL for accessing the next page in search results.
        public var nextPage: String?
        /// The total count of entries in the search result, not just the current page.
        public var totalCount: Int?

        public init(
            object: String,
            data: [Stripe.Customers.Customer]? = nil,
            hasMore: Bool? = nil,
            url: String? = nil,
            nextPage: String? = nil,
            totalCount: Int? = nil
        ) {
            self.object = object
            self.data = data
            self.hasMore = hasMore
            self.url = url
            self.nextPage = nextPage
            self.totalCount = totalCount
        }
    }
}

// MARK: - Tax
