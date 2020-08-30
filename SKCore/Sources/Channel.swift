//
// Channel.swift
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

public struct Channel {
    fileprivate enum CodingKeys: String {
        case id
        case created
        case creator
        case name
        case isArchived = "is_archived"
        case isGeneral = "is_general"
        case isGroup = "is_group"
        case isIM = "is_im"
        case isMPIM = "is_mpim"
        case user
        case isUserDeleted = "is_user_deleted"
        case isOpen = "is_open"
        case topic
        case purpose
        case isMember = "is_member"
        case lastRead = "last_read"
        case latest
        case unread
        case unreadCountDisplay = "unread_count_display"
        case hasPins = "has_pins"
        case members
        // Client use
        case pinnedItems = "pinned_items"
        case usersTyping = "users_typing"
        case messages
    }

    public let id: String?
    public let created: Int?
    public let creator: String?
    public var name: String?
    public var isArchived: Bool?
    public var isGeneral: Bool?
    public let isGroup: Bool?
    public let isIM: Bool?
    public let isMPIM: Bool?
    public var user: String?
    public var isUserDeleted: Bool?
    public var isOpen: Bool?
    public var topic: Topic?
    public var purpose: Topic?
    public var isMember: Bool?
    public var lastRead: String?
    public var latest: Message?
    public var unread: Int?
    public var unreadCountDisplay: Int?
    public var hasPins: Bool?
    public var members: [String]?
    // Client use
    public var pinnedItems = [Item]()
    public var usersTyping = [String]()
    public var messages = [String: Message]()

    public init(channel: [String: Any]?) {
        id = channel?["id"] as? String
        name = channel?["name"] as? String
        created = channel?["created"] as? Int
        creator = channel?["creator"] as? String
        isArchived = channel?["is_archived"] as? Bool
        isGeneral = channel?["is_general"] as? Bool
        isGroup = channel?["is_group"] as? Bool
        isIM = channel?["is_im"] as? Bool
        isMPIM = channel?["is_mpim"] as? Bool
        isUserDeleted = channel?["is_user_deleted"] as? Bool
        user = channel?["user"] as? String
        isOpen = channel?["is_open"] as? Bool
        topic = Topic(topic: channel?["topic"] as? [String: Any])
        purpose = Topic(topic: channel?["purpose"] as? [String: Any])
        isMember = channel?["is_member"] as? Bool
        lastRead = channel?["last_read"] as? String
        unread = channel?["unread_count"] as? Int
        unreadCountDisplay = channel?["unread_count_display"] as? Int
        hasPins = channel?["has_pins"] as? Bool
        members = channel?["members"] as? [String]

        if let latestMesssageDictionary = channel?["latest"] as? [String: Any] {
            latest = Message(dictionary: latestMesssageDictionary)
        } else {
            latest = Message(ts: channel?["latest"] as? String)
        }
    }

    public init(id: String?) {
        self.id = id
        created = nil
        creator = nil
        isGroup = false
        isIM = false
        isMPIM = false
    }
}

extension Channel: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        creator = try values.decodeIfPresent(String.self, forKey: .creator)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        isArchived = try values.decodeIfPresent(Bool.self, forKey: .isArchived)
        isGeneral = try values.decodeIfPresent(Bool.self, forKey: .isGeneral)
        isGroup = try values.decodeIfPresent(Bool.self, forKey: .isGroup)
        isIM = try values.decodeIfPresent(Bool.self, forKey: .isIM)
        isMPIM = try values.decodeIfPresent(Bool.self, forKey: .isMPIM)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        isUserDeleted = try values.decodeIfPresent(Bool.self, forKey: .isUserDeleted)
        isOpen = try values.decodeIfPresent(Bool.self, forKey: .isOpen)
        topic = try values.decodeIfPresent(Topic.self, forKey: .topic)
        purpose = try values.decodeIfPresent(Topic.self, forKey: .purpose)
        isMember = try values.decodeIfPresent(Bool.self, forKey: .isMember)
        lastRead = try values.decodeIfPresent(String.self, forKey: .lastRead)
        latest = try values.decodeIfPresent(Message.self, forKey: .latest)
        unread = try values.decodeIfPresent(Int.self, forKey: .unread)
        unreadCountDisplay = try values.decodeIfPresent(Int.self, forKey: .unreadCountDisplay)
        hasPins = try values.decodeIfPresent(Bool.self, forKey: .hasPins)
        members = try values.decodeIfPresent([String].self, forKey: .members)
        // Client use
        pinnedItems = try values.decodeIfPresent([Item].self, forKey: .pinnedItems) ?? []
        usersTyping = try values.decodeIfPresent([String].self, forKey: .usersTyping) ?? []
        messages = try values.decodeIfPresent([String: Message].self, forKey: .messages) ?? [:]
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
    }
}

extension Channel.CodingKeys: CodingKey { }

