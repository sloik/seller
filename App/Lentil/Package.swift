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

        .package(path: "../Utilities"),

        .package(path: "../KeychainWrapper"),

        .package(path: "../Onion"),

        .package(
            url: "https://github.com/sloik/AliasWonderland.git",
            from: "3.6.0"
        ),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.1.1"
        ),

        .package(
            url: "https://github.com/sloik/SweetBool.git",
            from: "1.1.2"
        ),

        .package(
            url: "https://github.com/sloik/SweetURL.git",
            from: "0.0.6"
        ),

        .package(
            url: "https://github.com/sloik/Zippy.git",
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
                "Utilities",
                "Zippy",
                "KeychainWrapper",
                "Onion",
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
