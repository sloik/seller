// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Utilities",
            type: .dynamic,
            targets: ["Utilities"]
        ),
    ],

    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.18.9"
        ),

        .package(
            url: "https://github.com/sloik/SweetBool.git",
            from: "1.1.3"
        ),

        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "6.1.0"
        ),
    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Utilities",
            dependencies: [
                "SweetBool",
                "OptionalAPI",
            ]
        ),

        .testTarget(
            name: "UtilitiesTests",
            dependencies: [
                "Utilities",
                .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(.enableExperimentalFeature("StrictConcurrency"))
  target.swiftSettings = settings
}
