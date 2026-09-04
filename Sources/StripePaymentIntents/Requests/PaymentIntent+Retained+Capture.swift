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

extension Stripe.PaymentIntents.PaymentIntent.Capture {
    public enum Method: String, Codable, Sendable {
        /// (Default) Stripe automatically captures funds when the customer authorizes the payment.
        case automatic
        case automaticAsync = "automatic_async"
        /// Place a hold on the funds when the customer authorizes the payment, but don’t capture the funds until later.
        ///
        /// (Not all payment methods support this.).
        case manual
    }
}
