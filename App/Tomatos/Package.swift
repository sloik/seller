// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tomatos",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "Tomatos",
            type: .dynamic,
            targets: ["Tomatos"]
        ),
    ],

    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.8.2"
        ),

        .package(path: "../Onion"),
        .package(path: "../Utilities"),

        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "1.0.2"
        ),

        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.15.3"
        ),

        .package(
            url: "https://github.com/sloik/AliasWonderland.git",
            from: "4.0.1"
        ),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.2.0"
        ),

        .package(
            url: "https://github.com/sloik/ExTests.git",
            from: "0.1.2"
        ),
    ],


    targets: [
        .target(
            name: "Tomatos",

            dependencies: [

                "AliasWonderland",
                "Onion",
                "OptionalAPI",
                "Utilities",

                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),

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
            name: "TomatosTests",
            dependencies: [
                "Tomatos",

                "AliasWonderland",
                "Onion",
                "OptionalAPI",
                "Utilities",
                "ExTests",
                
                .product(
                    name: "InlineSnapshotTesting",
                    package: "swift-snapshot-testing"
                ),
            ]
        ),
    ]
)
