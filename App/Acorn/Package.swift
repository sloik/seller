// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Acorn",

    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],

    products: [
        .library(
            name: "Acorn",
            targets: ["Acorn"]
        ),
    ],

    dependencies: [
        .package(path: "../Lentil"),
        .package(path: "../Utilities"),
        .package(path: "../Onion"),

        .package(
            url: "https://github.com/sloik/SweetBool.git",
            from: "1.1.3"
        ),
    ],

    targets: [
        .target(
            name: "Acorn",
            dependencies: [
                "Lentil",       // Login functionality
                "Utilities",    // Utilities
                "Onion",        // Networking

                "SweetBool",
            ]
        ),
        .testTarget(
            name: "AcornTests",
            dependencies: ["Acorn"]),
    ]
)
