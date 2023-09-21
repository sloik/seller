// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lentil",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "Lentil",
            type: .dynamic,
            targets: ["Lentil"]
        ),
    ],
    dependencies: [
        .package(path: "../SecretsStore"),

        .package(
            url: "https://github.com/sloik/AliasWonderland.git",
            from: "3.5.11"
        ),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.0.3"
        ),

        .package(
            url: "https://github.com/sloik/SweetBool.git",
            from: "1.1.2"
        ),

        .package(
            url: "https://github.com/sloik/SweetURL.git",
            from: "0.0.6"
        ),

    ],
    
    targets: [
        .target(
            name: "Lentil",
            dependencies: [
                "Cumin",
                "Yuca",
                "AliasWonderland",
            ]
        ),

        // Models, DTOs etc.
        .target(
            name: "Cumin",
            dependencies: [
                "AliasWonderland",
                "SecretsStore",
                "OptionalAPI",
                "SweetBool",
                "SweetURL",
            ]
        ),

        // UI
        .target(
            name: "Yuca",
            dependencies: [
                "AliasWonderland",
                "OptionalAPI",
                "Cumin",
            ]
        ),

        .testTarget(
            name: "LentilTests",
            dependencies: [
                "Lentil",
            ]
        ),
    ]
)
