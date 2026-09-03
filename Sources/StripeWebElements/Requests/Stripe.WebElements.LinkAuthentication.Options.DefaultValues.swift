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

import StripeCore
import StripeModels

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Stripe.WebElements {
    /// Link Authentication Element for Link payment method.
    ///
    /// See: https://docs.stripe.com/payments/elements/link-authentication-element
    public struct LinkAuthentication: Codable, Hashable, Sendable {
        public let options: Options?

        public init(options: Options? = nil) {
            self.options = options
        }

        public struct Options: Codable, Hashable, Sendable {
            public let defaultValues: DefaultValues?

            public init(defaultValues: DefaultValues? = nil) {
                self.defaultValues = defaultValues
            }
        }
    }
}

extension Stripe.WebElements.LinkAuthentication.Options {
    public struct DefaultValues: Codable, Hashable, Sendable {
        public let email: String?

        public init(email: String? = nil) {
            self.email = email
        }
    }
}
