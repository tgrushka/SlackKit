//
// User.swift
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

public struct User: Equatable {
    fileprivate enum CodingKeys: String {
        case id
        case name
        case deleted
        case profile
        case doNotDisturbStatus = "do_not_disturb_status"
        case presence
        case color
        case isBot = "is_bot"
        case isAdmin = "is_admin"
        case isOwner = "is_owner"
        case isPrimaryOwner = "is_primary_owner"
        case isRestricted = "is_restricted"
        case isUltraRestricted = "is_ultra_restricted"
        case has2fa = "has_2fa"
        case hasFiles = "has_files"
        case status
        case timeZone = "time_zone"
        case timeZoneLabel = "time_zone_label"
        case timeZoneOffSet = "time_zone_offset"
        case preferences
        case userGroups = "user_groups"
    }

    public struct Profile {
        fileprivate enum CodingKeys: String {
            case firstName = "first_name"
            case lastName = "last_name"
            case realName = "real_name"
            case email
            case phone
            case image24 = "image_24"
            case image32 = "image_32"
            case image48 = "image_48"
            case image72 = "image_72"
            case image192 = "image_192"
            case customProfile = "custom_profile"
            case statusText = "status_text"
            case statusEmoji = "status_emoji"
            case statusExpiration = "status_expiration"
        }
        
        public var firstName: String?
        public var lastName: String?
        public var realName: String?
        public var email: String?
        public var phone: String?
        public var image24: String?
        public var image32: String?
        public var image48: String?
        public var image72: String?
        public var image192: String?
        public var customProfile: CustomProfile?
        public var statusText: String?
        public var statusEmoji: String?
        public var statusExpiration: Int?

        public init(profile: [String: Any]?) {
            firstName = profile?["first_name"] as? String
            lastName = profile?["last_name"] as? String
            realName = profile?["real_name"] as? String
            email = profile?["email"] as? String
            phone = profile?["phone"] as? String
            image24 = profile?["image_24"] as? String
            image32 = profile?["image_32"] as? String
            image48 = profile?["image_48"] as? String
            image72 = profile?["image_72"] as? String
            image192 = profile?["image_192"] as? String
            customProfile = CustomProfile(customFields: profile?["fields"] as? [String: Any])
            statusText = profile?["status_text"] as? String
            statusEmoji = profile?["status_emoji"] as? String
            statusExpiration = profile?["status_expiration"] as? Int
        }
    }

    public let id: String?
    public var name: String?
    public var deleted: Bool?
    public var profile: Profile?
    public var doNotDisturbStatus: DoNotDisturbStatus?
    public var presence: String?
    public var color: String?
    public let isBot: Bool?
    public var isAdmin: Bool?
    public var isOwner: Bool?
    public var isPrimaryOwner: Bool?
    public var isRestricted: Bool?
    public var isUltraRestricted: Bool?
    public var has2fa: Bool?
    public var hasFiles: Bool?
    public var status: String?
    public var timeZone: String?
    public var timeZoneLabel: String?
    public var timeZoneOffSet: Int?
    public var preferences: [String: String]?
    // Client properties
    public var userGroups: [String: String]?

    public init(user: [String: Any]?) {
        id = user?["id"] as? String
        name = user?["name"] as? String
        deleted = user?["deleted"] as? Bool
        profile = Profile(profile: user?["profile"] as? [String: Any])
        color = user?["color"] as? String
        isAdmin = user?["is_admin"] as? Bool
        isOwner = user?["is_owner"] as? Bool
        isPrimaryOwner = user?["is_primary_owner"] as? Bool
        isRestricted = user?["is_restricted"] as? Bool
        isUltraRestricted = user?["is_ultra_restricted"] as? Bool
        has2fa = user?["has_2fa"] as? Bool
        hasFiles = user?["has_files"] as? Bool
        isBot = user?["is_bot"] as? Bool
        presence = user?["presence"] as? String
        status = user?["status"] as? String
        timeZone = user?["tz"] as? String
        timeZoneLabel = user?["tz_label"] as? String
        timeZoneOffSet = user?["tz_offset"] as? Int
    }

    public init(id: String?) {
        self.id = id
        self.isBot = nil
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User.Profile: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        realName = try values.decodeIfPresent(String.self, forKey: .realName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        image24 = try values.decodeIfPresent(String.self, forKey: .image24)
        image32 = try values.decodeIfPresent(String.self, forKey: .image32)
        image48 = try values.decodeIfPresent(String.self, forKey: .image48)
        image72 = try values.decodeIfPresent(String.self, forKey: .image72)
        image192 = try values.decodeIfPresent(String.self, forKey: .image192)
        customProfile = try values.decodeIfPresent(CustomProfile.self, forKey: .customProfile)
        statusText = try values.decodeIfPresent(String.self, forKey: .statusText)
        statusEmoji = try values.decodeIfPresent(String.self, forKey: .statusEmoji)
        statusExpiration = try values.decodeIfPresent(Int.self, forKey: .statusExpiration)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(realName, forKey: .realName)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(image24, forKey: .image24)
        try container.encode(image32, forKey: .image32)
        try container.encode(image48, forKey: .image48)
        try container.encode(image72, forKey: .image72)
        try container.encode(image192, forKey: .image192)
        try container.encode(customProfile, forKey: .customProfile)
        try container.encode(statusText, forKey: .statusText)
        try container.encode(statusEmoji, forKey: .statusEmoji)
        try container.encode(statusExpiration, forKey: .statusExpiration)

    }
}

extension User.Profile.CodingKeys: CodingKey { }

extension User: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted)
        profile = try values.decodeIfPresent(Profile.self, forKey: .profile)
        doNotDisturbStatus = try values.decodeIfPresent(DoNotDisturbStatus.self, forKey: .doNotDisturbStatus)
        presence = try values.decodeIfPresent(String.self, forKey: .presence)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        isBot = try values.decodeIfPresent(Bool.self, forKey: .isBot)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
        isOwner = try values.decodeIfPresent(Bool.self, forKey: .isOwner)
        isPrimaryOwner = try values.decodeIfPresent(Bool.self, forKey: .isPrimaryOwner)
        isRestricted = try values.decodeIfPresent(Bool.self, forKey: .isRestricted)
        isUltraRestricted = try values.decodeIfPresent(Bool.self, forKey: .isUltraRestricted)
        has2fa = try values.decodeIfPresent(Bool.self, forKey: .has2fa)
        hasFiles = try values.decodeIfPresent(Bool.self, forKey: .hasFiles)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone)
        timeZoneLabel = try values.decodeIfPresent(String.self, forKey: .timeZoneLabel)
        timeZoneOffSet = try values.decodeIfPresent(Int.self, forKey: .timeZoneOffSet)
        preferences = try values.decodeIfPresent([String: String].self, forKey: .preferences)
//        userGroups = try values.decodeIfPresent([String: Any].self, forKey: .userGroups)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(deleted, forKey: .deleted)
        try container.encode(profile, forKey: .profile)
        try container.encode(doNotDisturbStatus, forKey: .doNotDisturbStatus)
        try container.encode(presence, forKey: .presence)
        try container.encode(color, forKey: .color)
        try container.encode(isBot, forKey: .isBot)
        try container.encode(isAdmin, forKey: .isAdmin)
        try container.encode(isOwner, forKey: .isOwner)
        try container.encode(isPrimaryOwner, forKey: .isPrimaryOwner)
        try container.encode(isRestricted, forKey: .isRestricted)
        try container.encode(isUltraRestricted, forKey: .isUltraRestricted)
        try container.encode(has2fa, forKey: .has2fa)
        try container.encode(hasFiles, forKey: .hasFiles)
        try container.encode(status, forKey: .status)
        try container.encode(timeZone, forKey: .timeZone)
        try container.encode(timeZoneLabel, forKey: .timeZoneLabel)
        try container.encode(timeZoneOffSet, forKey: .timeZoneOffSet)
        try container.encode(preferences, forKey: .preferences)
        try container.encode(userGroups, forKey: .userGroups)
    }
}

extension User.CodingKeys: CodingKey { }
