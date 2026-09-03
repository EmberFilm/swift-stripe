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

public enum PhoneNumber {}

extension PhoneNumber {
    public struct Collection: Codable, Hashable, Sendable {
        /// Indicates whether phone number collection is enabled.
        public var enabled: Bool

        public init(
            enabled: Bool
        ) {
            self.enabled = enabled
        }
    }
}
