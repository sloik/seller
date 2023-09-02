// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lentil",
    products: [
        .library(
            name: "Lentil",
            type: .dynamic,
            targets: ["Lentil"]
        ),
    ],
    targets: [
        .target(
            name: "Lentil"
        ),
        .testTarget(
            name: "LentilTests",
            dependencies: ["Lentil"]
        ),
    ]
)
