// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onion",

    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],

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
            from: "0.2.1"
        ),
    ],

    targets: [
        .target(
            name: "Onion",
            dependencies: [
                .product(
                    name: "HTTPTypes",
                    package: "swift-http-types"
                ),
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
