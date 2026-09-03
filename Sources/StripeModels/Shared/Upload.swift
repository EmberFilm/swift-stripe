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

extension Stripe {
    /// The bytes of a file to upload, with the name and MIME type Stripe records for it.
    public struct Upload: Hashable, Sendable {
        public var data: Data
        public var filename: String
        public var contentType: String

        public init(data: Data, filename: String, contentType: String) {
            self.data = data
            self.filename = filename
            self.contentType = contentType
        }
    }
}
