//
//  ConfirmationToken.swift
//  Stripe Types
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/confirmation_tokens/object.md

// The ConfirmationToken struct is generated (Models/Generated). These are the nested types the
// request layer still names under `ConfirmationToken` that the generator spells differently.

// MARK: - Nested Types

extension ConfirmationToken {

    public struct OnlineAcceptance: Codable, Hashable, Sendable {
        /// The IP address from which the Mandate was accepted by the customer.
        public var ipAddress: String?
        /// The user agent of the browser from which the Mandate was accepted by the customer.
        public var userAgent: String?

        private enum CodingKeys: String, CodingKey {
            case ipAddress
            case userAgent
        }

        public init(ipAddress: String? = nil, userAgent: String? = nil) {
            self.ipAddress = ipAddress
            self.userAgent = userAgent
        }
    }

    public enum AcceptanceType: String, Codable, Sendable {
        case offline
        case online
    }
}
