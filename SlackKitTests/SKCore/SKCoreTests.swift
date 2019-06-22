//
// SKCoreTests.swift
//
// Copyright © 2017 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
@testable import SKCore

final class SKCoreTests: XCTestCase {

    static var rootPath: String {
        #if Xcode
        return Bundle(for: self).resourcePath!
        #else
        return "SlackKitTests/Resources"
        #endif
    }

    struct JSONData {
        static let channel          = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/channel.json"))
        static let conversation     = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/conversation.json"))
        static let file             = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/file.json"))
        static let group            = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/group.json"))
        static let im               = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/im.json"))
        static let mpim             = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/mpim.json"))
        static let user             = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/user.json"))
        static let usergroup        = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/usergroup.json"))
        static let events           = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/events.json"))
        static let attachmentfield  = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/attachmentfield.json"))
        static let reply            = try! Data(contentsOf: URL(fileURLWithPath: "\(rootPath)/reply.json"))
    }

    static var allTests = [
        ("testChannel", testChannel),
        ("testConversation", testConversation),
        ("testFile", testFile),
        ("testGroup", testGroup),
        ("testIm", testIm),
        ("TestMpim", testMpim),
        ("testUser", testUser),
        ("testUserGroup", testUserGroup),
        ("testEvents", testEvents)
    ]
  
  func testEvents() {
    let eventsKeys = [
        // Bot Event
        "bot_added","bot_changed",
        // Channel Event
        "channel_archive","channel_created","channel_deleted",
        "channel_joined", "channel_left", "channel_marked",
        "channel_rename","channel_unarchive",
        // Group Event
        "group_archive","group_close","group_joined",
        "group_left", "group_marked","group_rename","group_unarchive",
        // Im Event
        "im_close","im_created","im_marked","im_open", "manual_presence_change",
        // Message Event
        "message::channel_join", "message::channel_leave", "message::channel_name",
        "message::group_join", "message::group_name", "message::group_unarchive",
        "message::message_changed", "message::message_deleted",
        // Preference Event
        "pref_change", "presence_change",
        // Reaction Event
        "reaction_added", "reaction_removed",
        // Team Event
        "team_domain_change", "team_join", "team_pref_change",
        "team_rename",
        // User Event
        "user_change", "user_typing"
    ]

    let data = JSONData.events
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    _ = eventsKeys.map { json[$0] as! [String: Any] }.map { Event($0) }
  }
  
  func testChannel() {
    let data = JSONData.channel
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
    let channel = Channel(channel: json)
    XCTAssertNotNil(channel)
  }
  
  func testConversation() {
    let data = JSONData.conversation
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
    let channel = Channel(channel: json["channel"] as?[String : Any])
    XCTAssertNotNil(channel)
  }
  
  func testFile() {
    let data = JSONData.file
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
    let file = File(file: json)
    XCTAssertNotNil(file)
  }
  
  func testGroup() {
    let data = JSONData.group
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let channel = Channel(channel: json)
    XCTAssertNotNil(channel)
  }
  
  func testIm() {
    let data = JSONData.im
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let channel = Channel(channel: json)
    XCTAssertNotNil(channel)
  }
  
  func testMpim() {
    let data = JSONData.mpim
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let channel = Channel(channel: json)
    XCTAssertNotNil(channel)
  }
  
  func testUser() {
    let data = JSONData.user
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let user = User(user: json)
    XCTAssertNotNil(user)
  }
  
  func testUserGroup() {
    let data = JSONData.usergroup
    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let userGroup = UserGroup(userGroup: json)
    XCTAssertNotNil(userGroup)
  }
  
  func testAttachmentFieldCodable() {
    let data = JSONData.attachmentfield
    let decoder = JSONDecoder()
    let attachmentField = try? decoder.decode(AttachmentField.self, from: data)
    XCTAssertNotNil(attachmentField)
    XCTAssertNotNil(attachmentField!.title)
    XCTAssertNotNil(attachmentField!.value)
    XCTAssertNotNil(attachmentField!.short)
    let encoder = JSONEncoder()
    let jsonData = try? encoder.encode(attachmentField!)
    XCTAssertNotNil(jsonData)
    XCTAssertEqual(data, jsonData!)
  }
    
  func testReplyCodable() {
    let data = JSONData.reply
    let decoder = JSONDecoder()
    let reply = try? decoder.decode(Reply.self, from: data)
    XCTAssertNotNil(reply)
    XCTAssertNotNil(reply!.user)
    XCTAssertNotNil(reply!.ts)
    let encoder = JSONEncoder()
    let jsonData = try? encoder.encode(reply!)
    XCTAssertNotNil(jsonData)
    XCTAssertEqual(data, jsonData!)
  }
}
