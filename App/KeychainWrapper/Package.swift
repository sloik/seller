// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeychainWrapper",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "KeychainWrapper",
            type: .dynamic,
            targets: ["KeychainWrapper"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/sloik/OptionalAPI.git",
            from: "6.1.0"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "KeychainWrapper",
            dependencies: [
                "OptionalAPI",
            ]
        ),
        .testTarget(
            name: "KeychainWrapperTests",
            dependencies: ["KeychainWrapper"]),
    ]
)

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(.enableExperimentalFeature("StrictConcurrency"))
  target.swiftSettings = settings
}
