// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Leaderboard",
    products: [
        .executable(name: "Leaderboard", targets: ["Leaderboard"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SlackKit/SlackKit", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(name: "Leaderboard",
                dependencies: ["SlackKit"],
                path: "Sources")
    ]
)
