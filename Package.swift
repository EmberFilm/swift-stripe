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
        .package(url: "https://github.com/apple/swift-configuration.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "Stripe",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "Configuration", package: "swift-configuration"),
            ]
        ),
        .testTarget(name: "StripeTests", dependencies: ["Stripe"]),
    ],
    swiftLanguageModes: [.v6]
)
