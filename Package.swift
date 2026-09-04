// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "swift-stripe",
    platforms: [
        .macOS(.v26)
    ],
    products: [
        .library(name: "Stripe", targets: ["Stripe"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.36.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "4.0.0"),
        // No traits: the default `JSON` file provider needs Foundation proper (JSONSerialization),
        // and this package links only FoundationEssentials. A dependent that wants JSON config
        // files enables the trait itself; traits unify across the graph.
        .package(url: "https://github.com/apple/swift-configuration.git", from: "1.2.0", traits: []),
        // Build-time only: the soundness workflow's documentation check and Swift Package Index.
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.0"),
    ],
    targets: [
        .target(name: "StripeModels"),
        .target(
            name: "StripeCore",
            dependencies: [
                "StripeModels",
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "Configuration", package: "swift-configuration"),
            ]
        ),
        .target(name: "StripeBalance", dependencies: ["StripeModels", "StripeCore", "StripeIssuing"]),
        .target(name: "StripeBilling", dependencies: ["StripeModels", "StripeCore", "StripeCheckout", "StripeIssuing", "StripeProducts"]),
        .target(name: "StripeCharges", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeCheckout", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeClimate", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeConnect", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeCustomers", dependencies: ["StripeModels", "StripeCore", "StripePaymentMethods", "StripeProducts", "StripeTax"]),
        .target(name: "StripeDisputes", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeEntitlements", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeEvents", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeFileLinks", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeFiles", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeFinancialConnections", dependencies: ["StripeModels", "StripeCore", "StripeIssuing"]),
        .target(name: "StripeForwarding", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeFraud", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeIdentity", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeIssuing", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeMandates", dependencies: ["StripeModels", "StripeCore"]),
        .target(
            name: "StripeMisc",
            dependencies: ["StripeModels", "StripeCore", "StripeCheckout", "StripeIssuing", "StripePromotion", "StripeReporting"]
        ),
        .target(name: "StripePaymentIntents", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripePaymentMethodConfigurations", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripePaymentMethods", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripePayouts", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeProducts", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripePromotion", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeRefunds", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeReporting", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeSetup", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeTax", dependencies: ["StripeModels", "StripeCore", "StripeIssuing"]),
        .target(name: "StripeTerminal", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeTokens", dependencies: ["StripeModels", "StripeCore"]),
        .target(name: "StripeTreasury", dependencies: ["StripeModels", "StripeCore", "StripeIssuing"]),
        .target(name: "StripeWebElements", dependencies: ["StripeModels", "StripeCore"]),
        .target(
            name: "StripeWebhooks",
            dependencies: [
                "StripeModels", "StripeCore",
                .product(name: "Crypto", package: "swift-crypto"),
            ]
        ),
        .target(
            name: "Stripe",
            dependencies: [
                "StripeModels", "StripeCore", "StripeWebhooks", "StripeBalance", "StripeBilling", "StripeCharges", "StripeCheckout", "StripeClimate",
                "StripeConnect", "StripeCustomers", "StripeDisputes", "StripeEntitlements", "StripeEvents", "StripeFileLinks", "StripeFiles",
                "StripeFinancialConnections", "StripeForwarding", "StripeFraud", "StripeIdentity", "StripeIssuing", "StripeMandates", "StripeMisc",
                "StripePaymentIntents", "StripePaymentMethodConfigurations", "StripePaymentMethods", "StripePayouts", "StripeProducts",
                "StripePromotion", "StripeRefunds", "StripeReporting", "StripeSetup", "StripeTax", "StripeTerminal", "StripeTokens", "StripeTreasury",
                "StripeWebElements",
            ]
        ),
        .testTarget(
            name: "StripeTests",
            dependencies: ["Stripe"],
            resources: [.copy("Fixtures")]
        ),
    ],
    swiftLanguageModes: [.v6]
)
