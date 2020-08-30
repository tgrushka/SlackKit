//
// Comment.swift
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

public struct Comment: Equatable {
    fileprivate enum CodingKeys: String {
        case id
        case user
        case created
        case comment
        case starred
        case stars
        case reactions
    }
    
    public let id: String?
    public let user: String?
    public var created: Int?
    public var comment: String?
    public var starred: Bool?
    public var stars: Int?
    public var reactions = [Reaction]()

    public init(comment: [String: Any]?) {
        self.comment = comment?["comment"] as? String
        id = comment?["id"] as? String
        created = comment?["created"] as? Int
        user = comment?["user"] as? String
        starred = comment?["is_starred"] as? Bool
        stars = comment?["num_stars"] as? Int
        reactions = Reaction.reactionsFromArray(comment?["reactions"] as? [[String: Any]])
    }

    public init(id: String?) {
        self.id = id
        self.user = nil
    }

    public static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Comment: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        starred = try values.decodeIfPresent(Bool.self, forKey: .starred)
        stars = try values.decodeIfPresent(Int.self, forKey: .stars)
        reactions = try values.decodeIfPresent([Reaction].self, forKey: .reactions) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(user, forKey: .user)
        try container.encode(created, forKey: .created)
        try container.encode(comment, forKey: .comment)
        try container.encode(starred, forKey: .starred)
        try container.encode(stars, forKey: .stars)
        try container.encode(reactions, forKey: .reactions)
    }
}

extension Comment.CodingKeys: CodingKey { }
