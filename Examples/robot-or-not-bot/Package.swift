import PackageDescription

let package = Package(
    name: "robot-or-not-bot",
    dependencies: [
        .Package(url: "https://github.com/SlackKit/SlackKit", majorVersion: 4)
    ]
)
