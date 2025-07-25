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

        .package(
            url: "https://github.com/sloik/Onion.git",
            branch: "main"
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
            url: "https://github.com/sloik/SweetBool.git",
            from: "1.1.3"
        ),

        .package(
            url: "https://github.com/sloik/SweetURL.git",
            from: "0.0.7"
        ),

        .package(
            url: "https://github.com/sloik/Zippy.git",
            from: "0.0.7"
        ),

        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "1.4.0"
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

                .product(
                    name: "HTTPTypes",
                    package: "swift-http-types"
                ),
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

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(.enableExperimentalFeature("StrictConcurrency"))
  target.swiftSettings = settings
}
