// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Robot or Not Bot",
    products: [
        .executable(name: "Robot or Not Bot", targets: ["Robot or Not Bot"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SlackKit/SlackKit", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(name: "Robot or Not Bot",
        dependencies: ["SlackKit"],
                path: "Sources")
    ]
)
