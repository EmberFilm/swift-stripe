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

extension BillingModel {
    public struct Details: Codable, Hashable, Sendable {
        /// Billing address.
        public var address: Address?
        /// Email address.
        public var email: String?
        /// Full name.
        public var name: String?
        /// Billing phone number (including extension).
        public var phone: String?

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
}
