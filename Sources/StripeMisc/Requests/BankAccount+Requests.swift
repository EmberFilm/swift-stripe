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

import StripeCheckout
import StripeCore
import StripeIssuing
import StripeModels
import StripePromotion
import StripeReporting

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension BankAccount {
    public enum Verify {}
}

// POST /v1/customers/{customer}/sources/{id}/verify
extension BankAccount.Verify {
    public struct Request: Codable, Hashable, Sendable {
        /// Two positive integers, in *cents*, equal to the values of the microdeposits sent to the bank account.
        public var amounts: [Int]?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            amounts: [Int]? = nil,
            expand: [String]? = nil
        ) {
            self.amounts = amounts
            self.expand = expand
        }
    }

    public typealias Response = BankAccount
}
