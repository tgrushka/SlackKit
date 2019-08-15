//
// TeamIcon.swift
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

public struct TeamIcon {
    fileprivate enum CodingKeys: String {
        case image34 = "image_34"
        case image44 = "image_44"
        case image68 = "image_68"
        case image88 = "image_88"
        case image102 = "image_102"
        case image132 = "image_132"
        case imageOriginal = "image_original"
        case imageDefault = "image_default"
    }
    
    public var image34: String?
    public var image44: String?
    public var image68: String?
    public var image88: String?
    public var image102: String?
    public var image132: String?
    public var imageOriginal: String?
    public var imageDefault: Bool?

    public init(icon: [String: Any]?) {
        image34 = icon?[CodingKeys.image34] as? String
        image44 = icon?[CodingKeys.image44] as? String
        image68 = icon?[CodingKeys.image68] as? String
        image88 = icon?[CodingKeys.image88] as? String
        image102 = icon?[CodingKeys.image102] as? String
        image132 = icon?[CodingKeys.image132] as? String
        imageOriginal = icon?[CodingKeys.imageOriginal] as? String
        imageDefault = icon?[CodingKeys.imageDefault] as? Bool
    }
}

extension TeamIcon: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image34 = try values.decodeIfPresent(String.self, forKey: .image34)
        image44 = try values.decodeIfPresent(String.self, forKey: .image44)
        image68 = try values.decodeIfPresent(String.self, forKey: .image68)
        image88 = try values.decodeIfPresent(String.self, forKey: .image88)
        image102 = try values.decodeIfPresent(String.self, forKey: .image102)
        image132 = try values.decodeIfPresent(String.self, forKey: .image132)
        imageOriginal = try values.decodeIfPresent(String.self, forKey: .imageOriginal)
        imageDefault = try values.decodeIfPresent(Bool.self, forKey: .imageDefault)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(image34, forKey: .image34)
        try container.encode(image44, forKey: .image44)
        try container.encode(image68, forKey: .image68)
        try container.encode(image88, forKey: .image88)
        try container.encode(image102, forKey: .image102)
        try container.encode(image132, forKey: .image132)
        try container.encode(imageOriginal, forKey: .imageOriginal)
        try container.encode(imageDefault, forKey: .imageDefault)
    }
}

extension TeamIcon.CodingKeys: CodingKey { }
