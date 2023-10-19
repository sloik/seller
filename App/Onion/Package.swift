// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onion",

    products: [
        .library(
            name: "Onion",
            type: .dynamic,
            targets: ["Onion"]
        ),
    ],

    dependencies: [
        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "0.1.0"
        ),
    ],

    targets: [
        .target(
            name: "Onion",
            dependencies: [
                .product(
                    name: "HTTPTypesFoundation",
                    package: "swift-http-types"
                ),
            ]
        ),

        .testTarget(
            name: "OnionTests",
            dependencies: [
                "Onion",
            ]
        ),
    ]
)
