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
            targets: ["Tomatos"]
        ),
    ],

    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.7.3"
        ),
    ],


    targets: [
        .target(
            name: "Tomatos",

            dependencies: [
                
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
            ]
        ),
        
        .testTarget(
            name: "TomatosTests",
            dependencies: ["Tomatos"]
        ),
    ]
)
