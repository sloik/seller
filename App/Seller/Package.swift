// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Seller",
    products: [
        .library(
            name: "Seller",
            type: .dynamic,
            targets: ["Seller"]
        ),
    ],
    dependencies: [
        .package(path: "../Lentil"),
    ],
    targets: [
        .target(
            name: "Seller",
            dependencies: [
                "Lentil", // Login functionality
            ]
        ),
        .testTarget(
            name: "SellerTests",
            dependencies: ["Seller"]
        ),
    ]
)
