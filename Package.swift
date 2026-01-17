// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC25",
    dependencies: [
        .package(url: "https://github.com/TeamAtomicMedia/Parser-iOS.git", from: "2.0.0")
    ], targets: [
        .executableTarget(
            name: "D1",
            dependencies: [.product(name: "Parser", package: "Parser-iOS")],
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")],
        ),
        .executableTarget(
            name: "D2",
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")]
        ),
        .executableTarget(
            name: "D3",
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")],
        ),
        .executableTarget(
            name: "D4",
            dependencies: [.product(name: "Parser", package: "Parser-iOS")],
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")],
        ),
        .executableTarget(
            name: "D5",
            dependencies: [.product(name: "Parser", package: "Parser-iOS")],
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")],
		),
        .executableTarget(
            name: "D6",
            dependencies: [.product(name: "Parser", package: "Parser-iOS")],
            resources: [.copy("Data/input.txt"), .copy("Data/test.txt")],
        ),
        .testTarget(
            name: "Tests",
            dependencies: [.product(name: "Parser", package: "Parser-iOS"), "D1", "D3", "D6"],
        ),
    ]
)

