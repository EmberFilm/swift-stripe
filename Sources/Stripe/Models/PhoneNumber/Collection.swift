//
//  File.swift
//  swift-stripe
//
//  Created by Coen ten Thije Boonkkamp on 08/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

public enum PhoneNumber {}

extension PhoneNumber {
    public struct Collection: Codable, Hashable, Sendable {
        /// Indicates whether phone number collection is enabled
        public var enabled: Bool

        public init(
            enabled: Bool
        ) {
            self.enabled = enabled
        }
    }
}
