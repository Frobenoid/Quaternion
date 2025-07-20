// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Quaternion",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Quaternion",
            targets: ["Quaternion"]
        )
    ],
    targets: [
        .target(
            name: "Quaternion"
        ),
        .testTarget(
            name: "QuaternionTests",
            dependencies: ["Quaternion"]
        ),
    ]
)
