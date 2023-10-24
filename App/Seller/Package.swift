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
    ],
    dependencies: [
        .package(path: "../Lentil"),
        .package(path: "../Utilities"),

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

                "OptionalAPI",
            ]
        ),
        .testTarget(
            name: "SellerTests",
            dependencies: ["Seller"]
        ),
    ]
)
