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
            targets: ["Tomatos"]),
    ],
    targets: [
        .target(
            name: "Tomatos"),
        .testTarget(
            name: "TomatosTests",
            dependencies: ["Tomatos"]),
    ]
)
