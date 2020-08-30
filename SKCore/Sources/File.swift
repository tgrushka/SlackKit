//
// File.swift
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

public struct File: Equatable {
    fileprivate enum CodingKeys: String {
        case id
        case created
        case name
        case title
        case mimeType = "mime_type"
        case fileType = "file_type"
        case prettyType = "pretty_type"
        case user
        case mode
        case editable
        case isExternal = "is_external"
        case externalType = "external_type"
        case size
        case urlPrivate = "url_private"
        case urlPrivateDownload = "url_private_download"
        case thumb64 = "thumb_64"
        case thumb80 = "thumb_80"
        case thumb360 = "thumb_360"
        case thumb360gif = "thumb_360gif"
        case thumb360w = "thumb_360w"
        case thumb360h = "thumb_360h"
        case thumb480 = "thumb_480"
        case thumb480gif = "thumb_480gif"
        case thumb480w = "thumb_480w"
        case thumb480h = "thumb_480h"
        case thumb720 = "thumb_720"
        case thumb720gif = "thumb_720gif"
        case thumb720w = "thumb_720w"
        case thumb720h = "thumb_720h"
        case thumb960 = "thumb_960"
        case thumb960gif = "thumb_960gif"
        case thumb960w = "thumb_960w"
        case thumb960h = "thumb_960h"
        case thumb1024 = "thumb_1024"
        case thumb1024gif = "thumb1024_gif"
        case thumb1024w = "thumb_1024w"
        case thumb1024h = "thumb_1024h"
        case permalink
        case editLink = "edit_link"
        case preview
        case previewHighlight = "preview_highlight"
        case lines
        case linesMore = "lines_more"
        case isPublic = "is_public"
        case publicSharedURL = "public_shared_url"
        case channels
        case groups
        case ims
        case initialComment = "initial_comment"
        case stars
        case isStarred = "is_starred"
        case pinnedTo = "pinned_to"
        case comments
        case reactions
    }
    
    public let id: String?
    public let created: Int?
    public let name: String?
    public let title: String?
    public let mimeType: String?
    public let fileType: String?
    public let prettyType: String?
    public let user: String?
    public let mode: String?
    public var editable: Bool?
    public let isExternal: Bool?
    public let externalType: String?
    public let size: Int?
    public let urlPrivate: String?
    public let urlPrivateDownload: String?
    public let thumb64: String?
    public let thumb80: String?
    public let thumb360: String?
    public let thumb360gif: String?
    public let thumb360w: String?
    public let thumb360h: String?
    public let thumb480: String?
    public let thumb480gif: String?
    public let thumb480w: String?
    public let thumb480h: String?
    public let thumb720: String?
    public let thumb720gif: String?
    public let thumb720w: String?
    public let thumb720h: String?
    public let thumb960: String?
    public let thumb960gif: String?
    public let thumb960w: String?
    public let thumb960h: String?
    public let thumb1024: String?
    public let thumb1024gif: String?
    public let thumb1024w: String?
    public let thumb1024h: String?
    public let permalink: String?
    public let editLink: String?
    public let preview: String?
    public let previewHighlight: String?
    public let lines: Int?
    public let linesMore: Int?
    public var isPublic: Bool?
    public var publicSharedURL: Bool?
    public var channels: [String]?
    public var groups: [String]?
    public var ims: [String]?
    public let initialComment: Comment?
    public var stars: Int?
    public var isStarred: Bool?
    public var pinnedTo: [String]?
    public var comments = [String: Comment]()
    public var reactions = [Reaction]()

    //swiftlint:disable function_body_length
    public init(file: [String: Any]?) {
        id = file?["id"] as? String
        created = file?["created"] as? Int
        name = file?["name"] as? String
        title = file?["title"] as? String
        mimeType = file?["mimetype"] as? String
        fileType = file?["filetype"] as? String
        prettyType = file?["pretty_type"] as? String
        user = file?["user"] as? String
        mode = file?["mode"] as? String
        editable = file?["editable"] as? Bool
        isExternal = file?["is_external"] as? Bool
        externalType = file?["external_type"] as? String
        size = file?["size"] as? Int
        urlPrivate = file?["url_private"] as? String
        urlPrivateDownload = file?["url_private_download"] as? String
        thumb64 = file?["thumb_64"] as? String
        thumb80 = file?["thumb_80"] as? String
        thumb360 = file?["thumb_360"] as? String
        thumb360gif = file?["thumb_360_gif"] as? String
        thumb360w = file?["thumb_360_w"] as? String
        thumb360h = file?["thumb_360_h"] as? String
        thumb480 = file?["thumb_480"] as? String
        thumb480gif = file?["thumb_480_gif"] as? String
        thumb480w = file?["thumb_480_w"] as? String
        thumb480h = file?["thumb_480_h"] as? String
        thumb720 = file?["thumb_720"] as? String
        thumb720gif = file?["thumb_720_gif"] as? String
        thumb720w = file?["thumb_720_w"] as? String
        thumb720h = file?["thumb_720_h"] as? String
        thumb960 = file?["thumb_960"] as? String
        thumb960gif = file?["thumb_960_gif"] as? String
        thumb960w = file?["thumb_960_w"] as? String
        thumb960h = file?["thumb_960_h"] as? String
        thumb1024 = file?["thumb_1024"] as? String
        thumb1024gif = file?["thumb_1024_gif"] as? String
        thumb1024w = file?["thumb_1024_w"] as? String
        thumb1024h = file?["thumb_1024_h"] as? String
        permalink = file?["permalink"] as? String
        editLink = file?["edit_link"] as? String
        preview = file?["preview"] as? String
        previewHighlight = file?["preview_highlight"] as? String
        lines = file?["lines"] as? Int
        linesMore = file?["lines_more"] as? Int
        isPublic = file?["is_public"] as? Bool
        publicSharedURL = file?["public_url_shared"] as? Bool
        channels = file?["channels"] as? [String]
        groups = file?["groups"] as? [String]
        ims = file?["ims"] as? [String]
        initialComment = Comment(comment: file?["initial_comment"] as? [String: Any])
        stars = file?["num_stars"] as? Int
        isStarred = file?["is_starred"] as? Bool
        pinnedTo = file?["pinned_to"] as? [String]
        reactions = Reaction.reactionsFromArray(file?["reactions"] as? [[String: Any]])
    }

    public init(id: String?) {
        self.id = id
        created = nil
        name = nil
        title = nil
        mimeType = nil
        fileType = nil
        prettyType = nil
        user = nil
        mode = nil
        isExternal = nil
        externalType = nil
        size = nil
        urlPrivate = nil
        urlPrivateDownload = nil
        thumb64 = nil
        thumb80 = nil
        thumb360 = nil
        thumb360gif = nil
        thumb360w = nil
        thumb360h = nil
        thumb480 = nil
        thumb480gif = nil
        thumb480w = nil
        thumb480h = nil
        thumb720 = nil
        thumb720gif = nil
        thumb720w = nil
        thumb720h = nil
        thumb960 = nil
        thumb960gif = nil
        thumb960w = nil
        thumb960h = nil
        thumb1024 = nil
        thumb1024gif = nil
        thumb1024w = nil
        thumb1024h = nil
        permalink = nil
        editLink = nil
        preview = nil
        previewHighlight = nil
        lines = nil
        linesMore = nil
        initialComment = nil
    }

    public static func == (lhs: File, rhs: File) -> Bool {
        return lhs.id == rhs.id
    }
}

extension File: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        mimeType = try values.decodeIfPresent(String.self, forKey: .mimeType)
        fileType = try values.decodeIfPresent(String.self, forKey: .fileType)
        prettyType = try values.decodeIfPresent(String.self, forKey: .prettyType)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        mode = try values.decodeIfPresent(String.self, forKey: .mode)
        editable = try values.decodeIfPresent(Bool.self, forKey: .editable)
        isExternal = try values.decodeIfPresent(Bool.self, forKey: .isExternal)
        externalType = try values.decodeIfPresent(String.self, forKey: .externalType)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        urlPrivate = try values.decodeIfPresent(String.self, forKey: .urlPrivate)
        urlPrivateDownload = try values.decodeIfPresent(String.self, forKey: .urlPrivateDownload)
        thumb64 = try values.decodeIfPresent(String.self, forKey: .thumb64)
        thumb80 = try values.decodeIfPresent(String.self, forKey: .thumb80)
        thumb360 = try values.decodeIfPresent(String.self, forKey: .thumb360)
        thumb360gif = try values.decodeIfPresent(String.self, forKey: .thumb360gif)
        thumb360w = try values.decodeIfPresent(String.self, forKey: .thumb360w)
        thumb360h = try values.decodeIfPresent(String.self, forKey: .thumb360h)
        thumb480 = try values.decodeIfPresent(String.self, forKey: .thumb480)
        thumb480gif = try values.decodeIfPresent(String.self, forKey: .thumb480gif)
        thumb480w = try values.decodeIfPresent(String.self, forKey: .thumb480w)
        thumb480h = try values.decodeIfPresent(String.self, forKey: .thumb480h)
        thumb720 = try values.decodeIfPresent(String.self, forKey: .thumb720)
        thumb720gif = try values.decodeIfPresent(String.self, forKey: .thumb720gif)
        thumb720w = try values.decodeIfPresent(String.self, forKey: .thumb720w)
        thumb720h = try values.decodeIfPresent(String.self, forKey: .thumb720h)
        thumb960 = try values.decodeIfPresent(String.self, forKey: .thumb960)
        thumb960gif = try values.decodeIfPresent(String.self, forKey: .thumb960gif)
        thumb960w = try values.decodeIfPresent(String.self, forKey: .thumb960w)
        thumb960h = try values.decodeIfPresent(String.self, forKey: .thumb960h)
        thumb1024 = try values.decodeIfPresent(String.self, forKey: .thumb1024)
        thumb1024gif = try values.decodeIfPresent(String.self, forKey: .thumb1024gif)
        thumb1024w = try values.decodeIfPresent(String.self, forKey: .thumb1024w)
        thumb1024h = try values.decodeIfPresent(String.self, forKey: .thumb1024h)
        permalink = try values.decodeIfPresent(String.self, forKey: .permalink)
        editLink = try values.decodeIfPresent(String.self, forKey: .editLink)
        preview = try values.decodeIfPresent(String.self, forKey: .preview)
        previewHighlight = try values.decodeIfPresent(String.self, forKey: .previewHighlight)
        lines = try values.decodeIfPresent(Int.self, forKey: .lines)
        linesMore = try values.decodeIfPresent(Int.self, forKey: .linesMore)
        isPublic = try values.decodeIfPresent(Bool.self, forKey: .isPublic)
        publicSharedURL = try values.decodeIfPresent(Bool.self, forKey: .publicSharedURL)
        channels = try values.decodeIfPresent([String].self, forKey: .channels)
        groups = try values.decodeIfPresent([String].self, forKey: .groups)
        ims = try values.decodeIfPresent([String].self, forKey: .ims)
        initialComment = try values.decodeIfPresent(Comment.self, forKey: .initialComment)
        stars = try values.decodeIfPresent(Int.self, forKey: .stars)
        isStarred = try values.decodeIfPresent(Bool.self, forKey: .isStarred)
        pinnedTo = try values.decodeIfPresent([String].self, forKey: .pinnedTo)
        reactions = try values.decodeIfPresent([Reaction].self, forKey: .reactions) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(created, forKey: .created)
        try container.encode(name, forKey: .name)
        try container.encode(title, forKey: .title)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encode(fileType, forKey: .fileType)
        try container.encode(prettyType, forKey: .prettyType)
        try container.encode(user, forKey: .user)
        try container.encode(mode, forKey: .mode)
        try container.encode(editable, forKey: .editable)
        try container.encode(isExternal, forKey: .isExternal)
        try container.encode(externalType, forKey: .externalType)
        try container.encode(size, forKey: .size)
        try container.encode(urlPrivate, forKey: .urlPrivate)
        try container.encode(urlPrivateDownload, forKey: .urlPrivateDownload)
        try container.encode(thumb64, forKey: .thumb64)
        try container.encode(thumb80, forKey: .thumb80)
        try container.encode(thumb360, forKey: .thumb360)
        try container.encode(thumb360gif, forKey: .thumb360gif)
        try container.encode(thumb360w, forKey: .thumb360w)
        try container.encode(thumb360h, forKey: .thumb360h)
        try container.encode(thumb480, forKey: .thumb480)
        try container.encode(thumb480gif, forKey: .thumb480gif)
        try container.encode(thumb480w, forKey: .thumb480w)
        try container.encode(thumb480h, forKey: .thumb480h)
        try container.encode(thumb720, forKey: .thumb720)
        try container.encode(thumb720gif, forKey: .thumb720gif)
        try container.encode(thumb720w, forKey: .thumb720w)
        try container.encode(thumb720h, forKey: .thumb720h)
        try container.encode(thumb960, forKey: .thumb960)
        try container.encode(thumb960gif, forKey: .thumb960gif)
        try container.encode(thumb960w, forKey: .thumb960w)
        try container.encode(thumb960h, forKey: .thumb960h)
        try container.encode(thumb1024, forKey: .thumb1024)
        try container.encode(thumb1024gif, forKey: .thumb1024gif)
        try container.encode(thumb1024w, forKey: .thumb1024w)
        try container.encode(thumb1024h, forKey: .thumb1024h)
        try container.encode(permalink, forKey: .permalink)
        try container.encode(editLink, forKey: .editLink)
        try container.encode(preview, forKey: .preview)
        try container.encode(previewHighlight, forKey: .previewHighlight)
        try container.encode(lines, forKey: .lines)
        try container.encode(linesMore, forKey: .linesMore)
        try container.encode(isPublic, forKey: .isPublic)
        try container.encode(publicSharedURL, forKey: .publicSharedURL)
        try container.encode(channels, forKey: .channels)
        try container.encode(groups, forKey: .groups)
        try container.encode(ims, forKey: .ims)
        try container.encode(initialComment, forKey: .initialComment)
        try container.encode(stars, forKey: .stars)
        try container.encode(isStarred, forKey: .isStarred)
        try container.encode(pinnedTo, forKey: .pinnedTo)
        try container.encode(comments, forKey: .comments)
        try container.encode(reactions, forKey: .reactions)
    }
}

extension File.CodingKeys: CodingKey { }

