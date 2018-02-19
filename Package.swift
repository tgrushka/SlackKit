// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SlackKit",
    products: [
        .library(name: "SlackKit", targets: ["SlackKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/SlackKit/SKCore", .upToNextMinor(from: "4.1.0")),
        .package(url: "https://github.com/SlackKit/SKClient", .upToNextMinor(from: "4.1.0")),
        .package(url: "https://github.com/SlackKit/SKRTMAPI", .upToNextMinor(from: "4.1.0")),
        .package(url: "https://github.com/SlackKit/SKServer", .upToNextMinor(from: "4.1.0"))
    ],
    targets: [
        .target(name: "SlackKit",
        dependencies: ["SKCore", "SKClient", "SKRTMAPI", "SKServer"],
                path: "Sources")
    ]
)
