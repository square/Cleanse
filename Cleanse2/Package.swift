// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cleanse2",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50100.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Cleanse2",
            dependencies: ["ArgumentParser", "SwiftSyntax"]),
        .target(
	    name: "CleanseCore",
            dependencies: []),
        .target(
            name: "Sandbox",
            dependencies: ["Cleanse2", "CleanseCore"]),
    ]
)
