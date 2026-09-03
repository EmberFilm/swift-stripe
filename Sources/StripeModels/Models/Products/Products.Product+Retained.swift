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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/products/object.md

/// The [Product Object](https://stripe.com/docs/api/products/object) .

// The Product struct is generated (Models/Generated). These are the nested types the request
// layer still names under `Stripe.Products.Product` that the generator spells differently.

public enum Marketing {}

extension Marketing {
    public struct Feature: Codable, Hashable, Sendable {
        public var name: String?

        public init(
            name: String? = nil
        ) {
            self.name = name
        }
    }
}
