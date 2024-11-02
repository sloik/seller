// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lettuce",

    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],

    products: [
        .library(
            name: "Lettuce",
            type: .dynamic,
            targets: ["Lettuce"]
        ),
    ],

    dependencies: [

        .package(path: "../Utilities"),

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
            url: "https://github.com/sloik/Zippy.git",
            from: "0.0.7"
        ),

        .package(
            url: "https://github.com/sloik/SweetURL.git",
            from: "0.0.7"
        ),

        .package(
            url: "https://github.com/apple/swift-http-types.git",
            from: "1.3.0"
        ),

        .package(
          url: "https://github.com/apple/swift-collections.git",
          .upToNextMajor(from: "1.1.4")
        ),

    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Lettuce",
            dependencies: [
                "Utilities",
                "Onion",

                "AliasWonderland",
                "OptionalAPI",
                "SweetBool",
                "Zippy",
                "SweetURL",

                .product(
                    name: "HTTPTypes",
                    package: "swift-http-types"
                ),

                .product(
                    name: "Collections", 
                    package: "swift-collections"
                )
            ]
        ),
        .testTarget(
            name: "LettuceTests",
            dependencies: ["Lettuce"]
        ),
    ]
)

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(.enableExperimentalFeature("StrictConcurrency"))
  target.swiftSettings = settings
}
