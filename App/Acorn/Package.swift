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

        .package(
            url: "https://github.com/sloik/SweetBool.git",
            from: "1.1.3"
        ),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "5.2.0"
        ),

        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "1.3.0"
        ),

        .package(
            url: "https://github.com/sloik/Onion.git",
            branch: "main"
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
                "OptionalAPI",

                .product(
                    name: "HTTPTypes",
                    package: "swift-http-types"
                ),
            ]
        ),
        .testTarget(
            name: "AcornTests",
            dependencies: ["Acorn"]),
    ]
)

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(.enableExperimentalFeature("StrictConcurrency"))
  target.swiftSettings = settings
}
