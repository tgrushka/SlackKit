//
// Topic.swift
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

public struct Topic {
    fileprivate enum CodingKeys: String {
        case value
        case creator
        case lastSet = "last_set"
    }
    
    public let value: String?
    public let creator: String?
    public let lastSet: Int?

    public init(topic: [String: Any]?) {
        value = topic?[CodingKeys.value] as? String
        creator = topic?[CodingKeys.creator] as? String
        lastSet = topic?[CodingKeys.lastSet] as? Int
    }
}

extension Topic: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        creator = try values.decodeIfPresent(String.self, forKey: .creator)
        lastSet = try values.decodeIfPresent(Int.self, forKey: .lastSet)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(creator, forKey: .creator)
        try container.encode(lastSet, forKey: .lastSet)
    }
}

extension Topic.CodingKeys: CodingKey { }
