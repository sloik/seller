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

        .package(path: "../Utilities"),

        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "1.0.2"
        ),

        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.15.1"
        ),

        .package(
            url: "https://github.com/sloik/AliasWonderland.git",
            from: "4.0.1"
        ),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.1.2"
        ),

        .package(
            url: "https://github.com/sloik/ExTests.git",
            from: "0.1.2"
        ),
    ],

    targets: [
        .target(
            name: "Onion",
            dependencies: [

                "Utilities",

                .product(
                    name: "HTTPTypes",
                    package: "swift-http-types"
                ),
                .product(
                    name: "HTTPTypesFoundation",
                    package: "swift-http-types"
                ),

                "AliasWonderland",
                "OptionalAPI",
            ]
        ),

        .testTarget(
            name: "OnionTests",
            dependencies: [
                "Onion",
                "ExTests",
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)
