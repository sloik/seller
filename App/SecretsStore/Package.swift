// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SecretsStore",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SecretsStore",
            type: .dynamic,
            targets: ["SecretsStore"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SecretsStore",
            dependencies: []),
        .testTarget(
            name: "SecretsStoreTests",
            dependencies: ["SecretsStore"]),
    ]
)
