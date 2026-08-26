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

//
//  AccountLink.swift
//
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/accountLinks/object.md

extension Stripe.Connect.Account {
    /// The [Account Link Object](https://stripe.com/docs/api/accountLinks/object) .
    public struct Link: Codable, Hashable, Sendable {
        /// String representing the object’s type.
        ///
        /// Objects of the same type share the same value.
        public var object: String
        /// Time at which the object was created.
        ///
        /// Measured in seconds since the Unix epoch.
        public var created: Date
        /// The timestamp at which this account link will expire.
        public var expiresAt: Date?
        /// The URL for the account link.
        public var url: String?

        public init(
            object: String,
            created: Date,
            expiresAt: Date? = nil,
            url: String? = nil
        ) {
            self.object = object
            self.created = created
            self.expiresAt = expiresAt
            self.url = url
        }
    }
}

extension Stripe.Connect.Account.Link {
    public enum CreationType: String, Codable, Sendable {
        /// Provides a form for inputting outstanding requirements.
        ///
        /// Send the user to the form in this mode to just collect the new information you need.
        case accountOnboarding = "account_onboarding"
        /// Displays the fields that are already populated on the account object, and allows your user to edit previously provided information.
        ///
        /// Consider framing this as “edit my profile” or “update my verification information”.
        case accountUpdate = "account_update"
    }
}

extension Stripe.Connect.Account.Link {
    public enum CreationCollectType: String, Codable, Sendable {
        case currentlyDue = "currently_due"
        case eventuallyDue = "eventually_due"
    }
}
