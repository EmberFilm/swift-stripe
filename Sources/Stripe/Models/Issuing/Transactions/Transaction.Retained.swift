//
//  Transaction.Retained.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/19.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/issuing/transactions/object.md

public struct TransactionAmountDetails: Codable, Hashable, Sendable {
    /// The fee charged by the ATM for the cash withdrawal.
    public var atmFee: Int?

    public init(
        atmFee: Int? = nil
    ) {
        self.atmFee = atmFee
    }
}

public struct TransactionList: Codable, Hashable, Sendable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [Transaction]?

    public init(
        object: String,
        hasMore: Bool? = nil,
        url: String? = nil,
        data: [Transaction]? = nil
    ) {
        self.object = object
        self.hasMore = hasMore
        self.url = url
        self.data = data
    }
}

public enum TransactionType: String, Codable, Sendable {
    /// Funds were captured by the acquirer. `amount` will be negative as funds are moving out of your balance. Not all captures will be linked to an authorization, as acquirers can force capture in some cases.
    case capture
    /// An acquirer initiated a refund. This transaction might not be linked to an original capture, for example credits are original transactions. `amount` will be positive for refunds and negative for refund reversals.
    case refund
}

public struct TransactionPurchaseDetails: Codable, Hashable, Sendable {
    /// Information about the flight that was purchased with this transaction.
    public var flight: TransactionPurchaseDetailsFlight?
    /// Information about fuel that was purchased with this transaction.
    public var fuel: TransactionPurchaseDetailsFuel?
    /// Information about lodging that was purchased with this transaction.
    public var lodging: TransactionPurchaseDetailsLodging?
    /// The line items in the purchase.
    public var receipt: [TransactionPurchaseDetailsReceipt]?
    /// A merchant-specific order number.
    public var reference: String?

    public init(
        flight: TransactionPurchaseDetailsFlight? = nil,
        fuel: TransactionPurchaseDetailsFuel? = nil,
        lodging: TransactionPurchaseDetailsLodging? = nil,
        receipt: [TransactionPurchaseDetailsReceipt]? = nil,
        reference: String? = nil
    ) {
        self.flight = flight
        self.fuel = fuel
        self.lodging = lodging
        self.receipt = receipt
        self.reference = reference
    }
}

public struct TransactionPurchaseDetailsFlight: Codable, Hashable, Sendable {
    /// The time that the flight departed.
    public var departureAt: Int?
    /// The name of the passenger.
    public var passengerName: String?
    /// Whether the ticket is refundable.
    public var refundable: Bool?
    /// The legs of the trip.
    public var segments: [TransactionPurchaseDetailsFlightSegment]?
    /// The travel agency that issued the ticket.
    public var travelAgency: String?

    public init(
        departureAt: Int? = nil,
        passengerName: String? = nil,
        refundable: Bool? = nil,
        segments: [TransactionPurchaseDetailsFlightSegment]? = nil,
        travelAgency: String? = nil
    ) {
        self.departureAt = departureAt
        self.passengerName = passengerName
        self.refundable = refundable
        self.segments = segments
        self.travelAgency = travelAgency
    }
}

public struct TransactionPurchaseDetailsFlightSegment: Codable, Hashable, Sendable {
    /// The three-letter IATA airport code of the flight’s destination.
    public var arrivalAirportCode: String?
    /// The airline carrier code.
    public var carrier: String?
    /// The three-letter IATA airport code that the flight departed from.
    public var departureAirportCode: String?
    /// The flight number.
    public var flightNumber: String?
    /// The flight’s service class.
    public var serviceCLass: String?
    /// Whether a stopover is allowed on this flight.
    public var stopoverAllowed: Bool?

    public init(
        arrivalAirportCode: String? = nil,
        carrier: String? = nil,
        departureAirportCode: String? = nil,
        flightNumber: String? = nil,
        serviceCLass: String? = nil,
        stopoverAllowed: Bool? = nil
    ) {
        self.arrivalAirportCode = arrivalAirportCode
        self.carrier = carrier
        self.departureAirportCode = departureAirportCode
        self.flightNumber = flightNumber
        self.serviceCLass = serviceCLass
        self.stopoverAllowed = stopoverAllowed
    }
}

public struct TransactionPurchaseDetailsFuel: Codable, Hashable, Sendable {
    /// The type of fuel that was purchased. One of `diesel`, `unleaded_plus`, `unleaded_regular`, `unleaded_super`, or `other`.
    public var type: TransactionPurchaseDetailsFuelType?
    /// The units for `volume_decimal`. One of `us_gallon` or `liter`.
    public var unit: TransactionPurchaseDetailsFuelUnit?
    /// The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
    public var unitCostDecimal: String?
    /// The volume of the fuel that was pumped, represented as a decimal string with at most 12 decimal places.
    public var volumeDecimal: String?

    public init(
        type: TransactionPurchaseDetailsFuelType? = nil,
        unit: TransactionPurchaseDetailsFuelUnit? = nil,
        unitCostDecimal: String? = nil,
        volumeDecimal: String? = nil
    ) {
        self.type = type
        self.unit = unit
        self.unitCostDecimal = unitCostDecimal
        self.volumeDecimal = volumeDecimal
    }
}

public enum TransactionPurchaseDetailsFuelType: String, Codable, Sendable {
    case diesel
    case unleadedPlus = "unleaded_plus"
    case unleadedRegular = "unleaded_regular"
    case unleadedSuper = "unleaded_super"
    case other
}

public enum TransactionPurchaseDetailsFuelUnit: String, Codable, Sendable {
    case usGallon = "us_gallon"
    case liter
}

public struct TransactionPurchaseDetailsLodging: Codable, Hashable, Sendable {
    /// The time of checking into the lodging.
    public var checkInAt: Int?
    /// The number of nights stayed at the lodging.
    public var nights: Int?

    public init(
        checkInAt: Int? = nil,
        nights: Int? = nil
    ) {
        self.checkInAt = checkInAt
        self.nights = nights
    }
}

public struct TransactionPurchaseDetailsReceipt: Codable, Hashable, Sendable {
    /// The description of the item. The maximum length of this field is 26 characters.
    public var description: String?
    /// The quantity of the item.
    public var quantity: Decimal?
    /// The total for this line item in cents.
    public var total: Int?
    /// The unit cost of the item in cents.
    public var unitCost: Int?

    public init(
        description: String? = nil,
        quantity: Decimal? = nil,
        total: Int? = nil,
        unitCost: Int? = nil
    ) {
        self.description = description
        self.quantity = quantity
        self.total = total
        self.unitCost = unitCost
    }
}

public enum TransactionWallet: String, Codable, Sendable {
    case applePay = "apple_pay"
    case googlePay = "google_pay"
    case samsungPay = "samsung_pay"
}

// The Transaction struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Transaction` that the generator spells differently.

