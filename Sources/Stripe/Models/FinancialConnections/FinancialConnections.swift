//
//  File.swift
//  swift-stripe
//
//  Created by Coen ten Thije Boonkkamp on 15/01/2025.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/financial_connections/accounts/object.md

public enum FinancialConnections {}

extension FinancialConnections {
    public struct Account: Codable, Hashable, Sendable {}
}
