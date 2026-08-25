#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

public struct BillingDetails: Codable, Equatable, Sendable {
    public let address: Address?
    public let email: String?
    public let name: String?
    public let phone: String?

    public init(
        address: Address? = nil,
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
