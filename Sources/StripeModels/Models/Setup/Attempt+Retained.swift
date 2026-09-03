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
//  SetupAttempt.swift
//
//
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://docs.stripe.com/api/setup_attempts/object.md

// The Attempt struct is generated (Models/Generated). These are the nested types the
// request layer still names under `Stripe.Setup.Attempt` that the generator spells differently.

extension Stripe.Setup.Attempt {
    public enum Status: String, Codable, Sendable {
        case requiresConfirmation = "requires_confirmation"
        case requiresAction = "requires_action"
        case processing
        case succeeded
        case failed
        case abandoned
    }
}

extension Stripe.Setup.Attempt {
    public enum Usage: String, Codable, Sendable {
        case offSession = "off_session"
        case onSession = "on_session"
    }
}
