#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe {
    // https://docs.stripe.com/api/confirmation_tokens/retrieve.md
    public struct ConfirmationToken: Sendable, Hashable, Identifiable {
        public typealias ID = String

        public let id: ID

        public init(id: ID) {
            self.id = id
        }
    }
}

extension Stripe.ConfirmationToken {
    enum Retrieve {

    }
}
