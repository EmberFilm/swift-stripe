//
//  Application.swift
//
//
//  Created by Andrew Morris on 26/04/2024.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/application/object.md

extension Stripe.Connect {
    /// The [Application Object](https://stripe.com/docs/api/application/object)
    public struct Application: Codable, Hashable, Sendable, Identifiable {
        public typealias ID = String
        /// Unique identifier for the object.
        public var id: ID
        /// The name of the application.
        public var name: String?
        /// String representing the object’s type. Objects of the same type share the same value.
        public var object: String

        public init(
            id: ID,
            name: String? = nil,
            object: String
        ) {
            self.id = id
            self.name = name
            self.object = object
        }
    }
}
