//
// Message.swift
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

public struct Message: Equatable {
    fileprivate enum CodingKeys: String {
        case subtype
        case ts
        case threadTs = "thread_ts"
        case parentUserId = "parent_user_id"
        case replyCount = "reply_count"
        case replies
        case user
        case channel
        case hidden
        case text
        case botID = "bot_id"
        case username
        case icons
        case deletedTs = "deleted_ts"
        case purpose
        case topic
        case name
        case members
        case oldName = "old_name"
        case upload
        case itemType = "item_type"
        case isStarred = "is_starred"
        case pinnedTo = "pinned_to"
        case comment
        case files
        case reactions
        case attachments
        case responseType = "response_type"
        case replaceOriginal = "replace_original"
        case deleteOriginal = "delete_original"
        case edited
    }
    
    public let type = "message"
    public let subtype: String?
    public var ts: String?
    public var threadTs: String?
    public let parentUserId: String?
    public var replyCount: Int?
    public var replies: [Reply]?
    public let user: String?
    public let channel: String?
    public var hidden: Bool?
    public var text: String?
    public let botID: String?
    public let username: String?
    public let icons: [String: String]?
    public let deletedTs: String?
    public var purpose: String?
    public var topic: String?
    public var name: String?
    public var members: [String]?
    public var oldName: String?
    public let upload: Bool?
    public let itemType: String?
    public var isStarred: Bool?
    public var pinnedTo: [String]?
    public let comment: Comment?
    public var files: [File]?
    public var reactions = [Reaction]()
    public var attachments: [Attachment]?
    public var responseType: MessageResponseType?
    public var replaceOriginal: Bool?
    public var deleteOriginal: Bool?
    public let edited: Edited?

    public init(dictionary: [String: Any]?) {
        subtype = dictionary?["subtype"] as? String
        ts = dictionary?["ts"] as? String
        threadTs = dictionary?["thread_ts"] as? String
        parentUserId = dictionary?["parent_user_id"] as? String
        replyCount = dictionary?["reply_count"] as? Int
        replies = (dictionary?["replies"] as? [[String: Any]])?.map({ Reply(reply: $0) })
        user = dictionary?["user"] as? String
        channel = dictionary?["channel"] as? String
        hidden = dictionary?["hidden"] as? Bool
        text = dictionary?["text"] as? String
        botID = dictionary?["bot_id"] as? String
        username = dictionary?["username"] as? String
        icons = dictionary?["icons"] as? [String: String]
        deletedTs = dictionary?["deleted_ts"] as? String
        purpose = dictionary?["purpose"] as? String
        topic = dictionary?["topic"] as? String
        name = dictionary?["name"] as? String
        members = dictionary?["members"] as? [String]
        oldName = dictionary?["old_name"] as? String
        upload = dictionary?["upload"] as? Bool
        itemType = dictionary?["item_type"] as? String
        isStarred = dictionary?["is_starred"] as? Bool
        pinnedTo = dictionary?["pinned_to"] as? [String]
        comment = Comment(comment: dictionary?["comment"] as? [String: Any])
        files = (dictionary?["files"] as? [[String: Any]])?.map { File(file: $0) }
        reactions = Reaction.reactionsFromArray(dictionary?["reactions"] as? [[String: Any]])
        attachments = (dictionary?["attachments"] as? [[String: Any]])?.map { Attachment(attachment: $0) }
        responseType = MessageResponseType(rawValue: dictionary?["response_type"] as? String ?? "")
        replaceOriginal = dictionary?["replace_original"] as? Bool
        deleteOriginal = dictionary?["delete_original"] as? Bool
        edited = Edited(edited:dictionary?["edited"] as? [String: Any])
    }

    public init(ts: String?) {
        self.ts = ts
        threadTs = nil
        parentUserId = nil
        subtype = nil
        user = nil
        channel = nil
        botID = nil
        username = nil
        icons = nil
        deletedTs = nil
        upload = nil
        itemType = nil
        comment = nil
        edited = nil
    }

    public static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.ts == rhs.ts && lhs.threadTs == rhs.threadTs && lhs.user == rhs.user && lhs.text == rhs.text
    }
}

extension Message: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        ts = try values.decodeIfPresent(String.self, forKey: .ts)
        threadTs = try values.decodeIfPresent(String.self, forKey: .threadTs)
        parentUserId = try values.decodeIfPresent(String.self, forKey: .parentUserId)
        replyCount = try values.decodeIfPresent(Int.self, forKey: .replyCount)
        replies = try values.decodeIfPresent([Reply].self, forKey: .replies)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        channel = try values.decodeIfPresent(String.self, forKey: .channel)
        hidden = try values.decodeIfPresent(Bool.self, forKey: .hidden)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        botID = try values.decodeIfPresent(String.self, forKey: .botID)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        icons = try values.decodeIfPresent([String: String].self, forKey: .icons)
        deletedTs = try values.decodeIfPresent(String.self, forKey: .deletedTs)
        purpose = try values.decodeIfPresent(String.self, forKey: .purpose)
        topic = try values.decodeIfPresent(String.self, forKey: .topic)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        members = try values.decodeIfPresent([String].self, forKey: .members)
        oldName = try values.decodeIfPresent(String.self, forKey: .oldName)
        upload = try values.decodeIfPresent(Bool.self, forKey: .upload)
        itemType = try values.decodeIfPresent(String.self, forKey: .itemType)
        isStarred = try values.decodeIfPresent(Bool.self, forKey: .isStarred)
        pinnedTo = try values.decodeIfPresent([String].self, forKey: .pinnedTo)
        comment = nil
        files = nil
        reactions = []
        attachments = nil
        responseType = nil
//        comment = try values.decodeIfPresent(Comment.self, forKey: .comment)
//        files = try values.decodeIfPresent([File].self, forKey: .files)
//        reactions = try values.decodeIfPresent([Reaction].self, forKey: .reactions)
//        attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
//        responseType = try values.decodeIfPresent(MessageResponse.self, forKey: .responseType)
        replaceOriginal = try values.decodeIfPresent(Bool.self, forKey: .replaceOriginal)
        deleteOriginal = try values.decodeIfPresent(Bool.self, forKey: .deleteOriginal)
        edited = try values.decodeIfPresent(Edited.self, forKey: .edited)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(subtype, forKey: .subtype)
        try container.encode(ts, forKey: .ts)
        try container.encode(threadTs, forKey: .threadTs)
        try container.encode(parentUserId, forKey: .parentUserId)
        try container.encode(replyCount, forKey: .replyCount)
        try container.encode(replies, forKey: .replies)
        try container.encode(user, forKey: .user)
        try container.encode(channel, forKey: .channel)
        try container.encode(hidden, forKey: .hidden)
        try container.encode(text, forKey: .text)
        try container.encode(botID, forKey: .botID)
        try container.encode(username, forKey: .username)
        try container.encode(icons, forKey: .icons)
        try container.encode(deletedTs, forKey: .deletedTs)
        try container.encode(purpose, forKey: .purpose)
        try container.encode(topic, forKey: .topic)
        try container.encode(name, forKey: .name)
        try container.encode(members, forKey: .members)
        try container.encode(oldName, forKey: .oldName)
        try container.encode(upload, forKey: .upload)
        try container.encode(itemType, forKey: .itemType)
        try container.encode(isStarred, forKey: .isStarred)
        try container.encode(pinnedTo, forKey: .pinnedTo)
//        try container.encode(comment, forKey: .comment)
//        try container.encode(files, forKey: .files)
//        try container.encode(reactions, forKey: .reactions)
//        try container.encode(attachments, forKey: .attachments)
        try container.encode(responseType, forKey: .responseType)
        try container.encode(replaceOriginal, forKey: .replaceOriginal)
        try container.encode(deleteOriginal, forKey: .deleteOriginal)
        try container.encode(edited, forKey: .edited)

    }

}

extension Message.CodingKeys: CodingKey { }

