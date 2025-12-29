// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC25",
    dependencies: [
        .package(name: "Parser", path: "../../Tools/Parser")
    ], targets: [
        .executableTarget(
            name: "D1",
            dependencies: ["Parser"],
            exclude: ["Test"], resources: [.copy("Data/rotations.txt"), .copy("Data/tests.txt")]
        ),
        .testTarget(
            name: "D1Tests",
            dependencies: ["Parser", "D1"],
        ),
        .executableTarget(name: "D2"),
    ]
)

