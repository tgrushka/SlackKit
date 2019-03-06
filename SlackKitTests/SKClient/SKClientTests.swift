//
//  SKClientTests.swift
//  SlackKitTests
//
//  Created by Peter Zignego on 3/5/19.
//  Copyright © 2019 Peter Zignego. All rights reserved.
//

import XCTest
@testable import SKClient

final class SKClientTests: XCTestCase {

    static var rootPath: String {
        #if Xcode
        return Bundle(for: self).resourcePath!
        #else
        return "SlackKitTests/Resources"
        #endif
    }

    struct JSONData {
        static let rtm_start             = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/rtm.start.json"))
        static let member_joined_channel = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/member_joined_channel.json"))
        static let member_left_channel   = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/member_left_channel.json"))
    }

    static var allTests = [
        ("testMemberJoinedChannel", testMemberJoinedChannel),
        ("testMemberLeftChannel", testMemberLeftChannel)
    ]

    var client: Client!

    override func setUp() {
        client = Client()
        client.initialSetup(JSON: try! JSONSerialization.jsonObject(with: JSONData.rtm_start, options: []) as! [String: Any])
    }

    func testMemberJoinedChannel() {
        let channelId = "C0CHZA86Q"
        let userId = "U0CJ1TWKX"
        let json = try! JSONSerialization.jsonObject(with: JSONData.member_joined_channel, options: []) as! [String: Any]
        client.memberJoinedChannel(Event(json))
        if let contains = client.channels[channelId]?.members?.contains(userId) {
            XCTAssertTrue(contains)
        } else {
            XCTFail()
        }
    }

    func testMemberLeftChannel() {
        let channelId = "C0CJ25PDM"
        let userId = "U0CJ5PC7L"
        let json = try! JSONSerialization.jsonObject(with: JSONData.member_left_channel, options: []) as! [String: Any]
        client.memberLeftChannel(Event(json))
        if let contains = client.channels[channelId]?.members?.contains(userId) {
            XCTAssertFalse(contains)
        } else {
            XCTFail()
        }
    }
}
