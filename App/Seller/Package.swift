// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Seller",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "Seller",
            type: .dynamic,
            targets: ["Seller"]
        ),

        .library(
            name: "SellerDebug",
            type: .dynamic,
            targets: ["SellerDebug"]
        ),
    ],
    dependencies: [
        .package(path: "../Lentil"),
        .package(path: "../Utilities"),
        .package(path: "../Onion"),
        .package(path: "../SecretsStore"),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.1.1"
        ),
    ],
    targets: [
        .target(
            name: "Seller",
            dependencies: [
                "Lentil",       // Login functionality
                "Utilities",    // Utilities
                "Onion",        // Networking
                "SecretsStore",  // Secrets

                "OptionalAPI",
            ]
        ),

        .target(
            name: "SellerDebug",
            dependencies: [
                "Seller",
            ]
        ),

        .testTarget(
            name: "SellerTests",
            dependencies: ["Seller"]
        ),
    ]
)
