//
//  TerminalHardwareSKU.swift
//
//
//  Created by Andrew Edwards on 5/17/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/terminal/hardware_skus/object.md

public struct TerminalHardwareSKU: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    /// Unique identifier for the object.
    public var id: ID
    /// The price of this SKU.
    public var amount: Int?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: Stripe.Currency?
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The country in which this SKU is available.
    public var country: String?
    /// The maximum quantity of this TerminalHardwareSKU that can be ordered. This will change over time due to inventory and other constraints.
    public var orderable: Int?
    /// ID of the product for this SKU.
    @ExpandableOf<TerminalHardwareProduct> public var product
    /// The SKU’s status.
    public var status: TerminalHardwareSKUStatus?
    /// A UNIX timestamp, after which time this SKU has a status of unavailable and it can’t be used for order creation. If absent, we have no plans to make this SKU unavailable.
    public var unavailableAfter: Date?

    public init(
        id: ID,
        amount: Int? = nil,
        currency: Stripe.Currency? = nil,
        object: String,
        country: String? = nil,
        orderable: Int? = nil,
        product: TerminalHardwareProduct.ID? = nil,
        status: TerminalHardwareSKUStatus? = nil,
        unavailableAfter: Date? = nil
    ) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.object = object
        self.country = country
        self.orderable = orderable
        self._product = Expandable(id: product)
        self.status = status
        self.unavailableAfter = unavailableAfter
    }
}

public enum TerminalHardwareSKUStatus: String, Codable, Sendable {
    /// Available for new orders.
    case available
    /// Can no longer be used for order creation.
    case unavailable
}

public struct TerminalHardwareSKUList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [TerminalHardwareSKU]?

    public init(
        object: String,
        hasMore: Bool? = nil,
        url: String? = nil,
        data: [TerminalHardwareSKU]? = nil
    ) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}
