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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// The PaymentMethod struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.PaymentMethods.PaymentMethod` that the generator spells differently.

// https://docs.stripe.com/api/paymentMethods/object.md

extension Stripe {
    public typealias PaymentMethod = Stripe.PaymentMethods.PaymentMethod
}

extension Stripe.PaymentMethods.PaymentMethod {
    public struct RadarOptions: Codable, Hashable, Sendable {
        /// A Radar Session is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
        public var session: String?

        public init(
            session: String? = nil
        ) {
            self.session = session
        }
    }
}
