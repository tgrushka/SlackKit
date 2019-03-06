# SKClient
Create a custom SlackKit client.

## Installation

### CocoaPods

Add SKClient to your `Podfile`:

```
use_frameworks!
pod 'SlackKit/SKClient'
```

### Carthage

Add SlackKit to your Cartfile:

```
github "pvzig/SlackKit"
```
and run

```
carthage bootstrap
```

Drag the built `SKClient.framework` and it's dependency `SKCore.framework` into your Xcode project.

### Swift Package Manager

Add SlackKit as a dependency to your `Package.swift` and specify `SKClient` as a target dependency:

```swift
import PackageDescription
  
let package = Package(
    name: "SampleApp",
    products: [
        .executable(
            name: "SampleApp",
            targets: ["SampleApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pvzig/SlackKit.git", .upToNextMinor(from: "4.2.0")),
    ],
    targets: [
        .target(
            name: "SampleApp",
            dependencies: ["SKClient"])
    ]
)

```

## Usage
To use the library in your project import it:

#### Carthage & SPM

```swift
import SKClient
```

#### CocoaPods

```swift
import SlackKit
```

### The Basics
Subclass `Client` to create a custom SlackKit client.

```
class MyClient: Client {

    override func notificationForEvent(_ event: Event, type: EventType) {
    …
    }

	override func initialSetup(JSON: [String: Any]) {
	…
	}
}
```

Pass your custom client to [`SlackKit`](https://www.github.com/pvzig/SlackKit) when adding an RTM bot:

```
let bot = SlackKit()
bot.addRTMBotWithAPIToken(“xoxb-SLACK_AUTH_TOKEN”, client: MyClient())
```
