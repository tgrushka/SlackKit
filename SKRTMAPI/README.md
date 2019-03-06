# SKRTMAPI

Connect to the [Slack Real Time Messaging API](https://api.slack.com/rtm) in Swift.

## Installation
<details>
  <summary><strong>Swift Package Manager</strong></summary>
Add SlackKit as a dependency to your `Package.swift` and specify `SKRTMAPI` as a target dependency:

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
            dependencies: ["SKRTMAPI"])
    ]
)

```

**When built using Swift Package Manager, SKRTMAPI includes the [vapor websocket framework](https://github.com/vapor/websocket) by default which requires libressl.**

You can install it with [homebrew](https://brew.sh): `brew install libressl`

If you'd like to use SPM _without vapor websocket_, you can modify the [Package.swift](https://github.com/pvzig/SlackKit/blob/master/Package.swift#L18) file to exclude it:

```swift
let SKRTMAPI: Target = .target(name: "SKRTMAPI",
                               path: "SKRTMAPI/Sources",
                               exclude: ["Conformers/VaporEngineRTM.swift"])

#if os(macOS)
SKRTMAPI.dependencies = [
    "SKCore",
    "SKWebAPI",
    "Starscream"
]
```
</details>
<details>
  <summary><strong>Carthage</strong></summary>
Add SlackKit to your `Cartfile`:

```
github "pvzig/SlackKit"
```
and run

```
carthage bootstrap
```

Drag the built `SKRTMAPI.framework` and it's dependencies `SKCore.framework`, `SKWebAPI.framework`, and `Starscream.framework` into your Xcode project.
</details>
<details>
  <summary><strong>CocoaPods</strong></summary>
Add SKRTMAPI to your `Podfile`:

```
use_frameworks!
pod 'SlackKit/SKRTMAPI'
```
</details>

## Usage
To use the library in your project import it:

#### Carthage & SPM

```swift
import SKRTMAPI
```

#### CocoaPods

```swift
import SlackKit
```

### The Basics
Initialize an instance of `SKRTMAPI` with a Slack auth token:

```swift
let rtm = SKRTMAPI(token: "xoxb-SLACK_AUTH_TOKEN")
rtm.connect()
```

If your bot doesn't need any state information when you connect, pass `false` for the `withInfo` parameter:

```swift
let rtm = SKRTMAPI(token: "xoxb-SLACK_AUTH_TOKEN")
rtm.connect(withInfo: false)
```

Customize the connection with `RTMOptions`:

```swift
let options = RTMOptions(simpleLatest: false, noUnreads: false, mpimAware: true, pingInterval: 30, timeout: 300, reconnect: true)
let rtm = SKRTMAPI(token: "xoxb-SLACK_AUTH_TOKEN", options: options)
rtm.connect()
```

Provide your own web socket implementation by conforming to `RTMWebSocket`:

```swift
public protocol RTMWebSocket {
    init()
    var delegate: RTMDelegate? { get set }
    func connect(url: URL)
    func disconnect()
    func sendMessage(_ message: String) throws
}
```

```swift
let rtmWebSocket = YourRTMWebSocket()
let rtm = SKRTMAPI(token: "xoxb-SLACK_AUTH_TOKEN", rtm: rtmWebSocket)
rtm.connect()
```
