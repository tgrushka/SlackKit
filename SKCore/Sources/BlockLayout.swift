public protocol Block {
    var dictionary: [String: Any] { get }
}

public enum BlockType: String, CaseIterable {
    case actions
    case button
    case context
    case datePicker = "datepicker"
    case divider
    case image
    case markdown = "mrkdwn"
    case overflow
    case plainText = "plain_text"
    case section

    // Selects

    case channelSelect = "channels_select"
    case converstationSelect = "conversations_select"
    case externalSelect = "external_select"
    case staticSelect = "static_select"
    case usersSelect = "users_select"
}

/// Defined by https://api.slack.com/reference/messaging/blocks#section
public struct SectionBlock: Block {
    /// Type will always be section.
    public let type: BlockType
    public let text: TextComposition
    public let blockId: String?
    public let fields: [TextComposition]?
    public let accessory: SectionElement?

    public init(type: BlockType = .section,
                text: TextComposition,
                blockId: String? = nil,
                fields: [TextComposition]? = nil,
                accessory: SectionElement? = nil) {
        self.type = type
        self.text = text
        self.blockId = blockId
        self.fields = fields
        self.accessory = accessory
    }

    public var dictionary: [String: Any] {
        var block = [String: Any]()
        block["type"] = type.rawValue
        block["text"] = text.dictionary
        block["block_id"] = blockId
        block["fields"] = fields?.map { $0.dictionary }
        block["accessory"] = accessory?.dictionary
        return block
    }
}

/// Defined by https://api.slack.com/reference/messaging/blocks#divider
public struct DividerBlock: Block {
    /// Type will always be divider.
    public let type: BlockType
    public let blockId: String?

    public init(type: BlockType = .divider,
                blockId: String? = nil) {
        self.type = type
        self.blockId = blockId
    }

    public var dictionary: [String: Any] {
        var block = [String: Any]()
        block["type"] = type
        block["block_id"] = blockId
        return block
    }
}

/// Defined by https://api.slack.com/reference/messaging/blocks#image
public struct ImageBlock: Block {
    /// Type will always be image.
    public let type: BlockType
    public let imageURL: String
    public let altText: String
    public let title: String?
    public let blockId: String?

    public init(type: BlockType = .image,
                imageURL: String,
                altText: String,
                title: String? = nil,
                blockId: String? = nil) {
        self.type = type
        self.imageURL = imageURL
        self.altText = altText
        self.title = title
        self.blockId = blockId
    }

    public var dictionary: [String: Any] {
        var block = [String: Any]()
        block["type"] = type.rawValue
        block["image_url"] = imageURL
        block["alt_text"] = altText
        block["title"] = title
        block["block_id"] = blockId
        return block
    }
}

/// Defined by https://api.slack.com/reference/messaging/blocks#actions
public struct ActionsBlock: Block {
    /// Type will always be actions.
    public let type: BlockType
    public let elements: [ActionsElement]
    public let blockId: String?

    public init(type: BlockType = .actions,
                elements: [ActionsElement],
                blockId: String? = nil) {
        self.type = type
        self.elements = elements
        self.blockId = blockId
    }

    public var dictionary: [String: Any] {
        var block = [String: Any]()
        block["type"] = type.rawValue
        block["elements"] = elements.map { $0.dictionary }
        block["block_id"] = blockId
        return block
    }
}

/// Defined by https://api.slack.com/reference/messaging/blocks#context
public struct ContextBlock: Block {
    /// Type will always be actions.
    public let type: BlockType
    public let elements: [ContextElement]
    public let blockId: String?

    public init(type: BlockType = .context,
                elements: [ContextElement],
                blockId: String? = nil) {
        self.type = type
        self.elements = elements
        self.blockId = blockId
    }

    public var dictionary: [String: Any] {
        var block = [String: Any]()
        block["type"] = type.rawValue
        block["elements"] = elements.map { $0.dictionary }
        block["block_id"] = blockId
        return block
    }
}
