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

public struct DeletedObject<Object>: Codable, Hashable, Sendable {
    public var id: String
    public var object: String
    public var deleted: Bool

    public init(
        id: String,
        object: String,
        deleted: Bool
    ) {
        self.id = id
        self.object = object
        self.deleted = deleted
    }
}
