// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "Quaternion",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Quaternion",
            targets: ["Quaternion"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-syntax",
            from: "509.0.0"
        )
    ],
    targets: [
        .macro(
            name: "QuaternionMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "Quaternion",
            dependencies: ["QuaternionMacros"]
        ),
        .testTarget(
            name: "QuaternionTests",
            dependencies: [
                "Quaternion",
                "QuaternionMacros",
            ]
        ),
    ],
)
