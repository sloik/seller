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
        .package(path: "../Utilities"),
        .package(path: "../Onion"),
        .package(path: "../SecretsStore"),
        .package(path: "../Lettuce"),
        .package(path: "../Acorn"),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.2.0"
        ),
    ],
    targets: [
        .target(
            name: "Seller",
            dependencies: [
                "Utilities",    // Utilities
                "Onion",        // Networking
                "SecretsStore", // Secrets
                "Lettuce",      // Messages
                "Acorn",        // Account / User Profile

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
