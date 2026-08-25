//
//  Session.swift
//
//
//  Created by Andrew Edwards on 5/14/23.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/account_sessions/object.md

extension Stripe.Connect.Account {
    public struct Session: Codable, Hashable, Sendable {
        /// The ID of the account the Session was created for
        public var account: String
        /// The client secret of this Session. Used on the client to set up secure access to the given account.
        /// The client secret can be used to provide access to account from your frontend. It should not be stored, logged, or exposed to anyone other than the connected account. Make sure that you have TLS enabled on any page that includes the client secret.
        /// Refer to our docs to setup Connect embedded components and learn about how `client_secret` should be handled.
        public var clientSecret: String?
        /// Details about the configured components in this session.
        public var components: Components?
        /// The timestamp at which this Session will expire.
        public var expiresAt: Date?
        /// String representing the object's type. Objects of the same type share the same value.
        public var object: String
        /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
        public var livemode: Bool

        private enum CodingKeys: String, CodingKey {
            case account
            case clientSecret
            case components
            case expiresAt
            case object
            case livemode
        }

        public init(
            account: String,
            clientSecret: String? = nil,
            components: Components? = nil,
            expiresAt: Date? = nil,
            object: String,
            livemode: Bool
        ) {
            self.account = account
            self.clientSecret = clientSecret
            self.components = components
            self.expiresAt = expiresAt
            self.object = object
            self.livemode = livemode
        }

        // Components structure for the response
        public struct Components: Codable, Hashable, Sendable {
            // Note: This is a simplified representation. The actual response
            // contains detailed configuration for each enabled component.
            // We're using a dictionary to handle the dynamic nature of the response.
            // Each key is a component name, and the value contains enabled status and features.
        }
    }
}
