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
            resources: [.copy("Data/rotations.txt"), .copy("Data/tests.txt")],
        ),
        .executableTarget(
            name: "D2",
            resources: [.copy("Data/ids.txt"), .copy("Data/test.txt")]
        ),
        .executableTarget(
            name: "D3",
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")],
		),
        .testTarget(
            name: "Tests",
            dependencies: ["Parser", "D1", "D3"],
        ),
    ]
)

