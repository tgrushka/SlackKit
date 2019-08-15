//
// CustomProfileField.swift
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

public struct CustomProfileField {
    fileprivate enum CodingKeys: String {
        case id
        case alt
        case value
        case hidden = "is_hidden"
        case hint
        case label
        case options
        case ordering
        case possibleValues = "possible_values"
        case type
    }
    
    public var id: String?
    public var alt: String?
    public var value: String?
    public var hidden: Bool?
    public var hint: String?
    public var label: String?
    public var options: String?
    public var ordering: Int?
    public var possibleValues: [String]?
    public var type: String?

    public init(field: [String: Any]?) {
        id = field?[CodingKeys.id] as? String
        alt = field?[CodingKeys.alt] as? String
        value = field?[CodingKeys.value] as? String
        hidden = field?[CodingKeys.hidden] as? Bool
        hint = field?[CodingKeys.hint] as? String
        label = field?[CodingKeys.label] as? String
        options = field?[CodingKeys.options] as? String
        ordering = field?[CodingKeys.ordering] as? Int
        possibleValues = field?[CodingKeys.possibleValues] as? [String]
        type = field?[CodingKeys.type] as? String
    }

    public init(id: String?) {
        self.id = id
    }

    public mutating func updateProfileField(_ profile: CustomProfileField?) {
        id = profile?.id != nil ? profile?.id : id
        alt = profile?.alt != nil ? profile?.alt : alt
        value = profile?.value != nil ? profile?.value : value
        hidden = profile?.hidden != nil ? profile?.hidden : hidden
        hint = profile?.hint != nil ? profile?.hint : hint
        label = profile?.label != nil ? profile?.label : label
        options = profile?.options != nil ? profile?.options : options
        ordering = profile?.ordering != nil ? profile?.ordering : ordering
        possibleValues = profile?.possibleValues != nil ? profile?.possibleValues : possibleValues
        type = profile?.type != nil ? profile?.type : type
    }
}

extension CustomProfileField: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        alt = try values.decodeIfPresent(String.self, forKey: .alt)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        hidden = try values.decodeIfPresent(Bool.self, forKey: .hidden)
        hint = try values.decodeIfPresent(String.self, forKey: .hint)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        options = try values.decodeIfPresent(String.self, forKey: .options)
        ordering = try values.decodeIfPresent(Int.self, forKey: .ordering)
        possibleValues = try values.decodeIfPresent([String].self, forKey: .possibleValues)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(alt, forKey: .alt)
        try container.encode(value, forKey: .value)
        try container.encode(hidden, forKey: .hidden)
        try container.encode(hint, forKey: .hint)
        try container.encode(label, forKey: .label)
        try container.encode(options, forKey: .options)
        try container.encode(ordering, forKey: .ordering)
        try container.encode(possibleValues, forKey: .possibleValues)
        try container.encode(type, forKey: .type)
    }
}

extension CustomProfileField.CodingKeys: CodingKey { }
