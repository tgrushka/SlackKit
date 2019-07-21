/// Defined by https://api.slack.com/reference/messaging/composition-objects#text
public struct TextComposition {
    /// The type of block. Can be one of plainText or markdown.
    public let type: BlockType
    public let text: String
    public let emoji: Bool?
    public let verbatim: Bool?

    public init(type: BlockType,
                text: String,
                emoji: Bool? = nil,
                verbatim: Bool? = nil) {
        self.type = type
        self.text = text
        self.emoji = emoji
        self.verbatim = verbatim
    }

    public var dictionary: [String: Any] {
        var composition = [String: Any]()
        composition["type"] = type.rawValue
        composition["text"] = text
        composition["emoji"] = emoji
        composition["verbatim"] = verbatim
        return composition
    }
}

/// Defined by https://api.slack.com/reference/messaging/composition-objects#option
public struct OptionComposition {
    public let text: TextComposition
    public let value: String
    public let url: String?

    public init(text: TextComposition,
                value: String,
                url: String? = nil) {
        self.text = text
        self.value = value
        self.url = url
    }

    public var dictionary: [String: Any] {
        var composition = [String: Any]()
        composition["text"] = text.dictionary
        composition["value"] = value
        composition["url"] = url
        return composition
    }
}

/// Defined by https://api.slack.com/reference/messaging/composition-objects#option-group
public struct OptionGroupComposition {
    public let label: TextComposition
    public let options: [OptionComposition]

    public init(label: TextComposition,
                options: [OptionComposition]) {
        self.label = label
        self.options = options
    }

    public var dictionary: [String: Any] {
        var composition = [String: Any]()
        composition["label"] = label.dictionary
        composition["options"] = options.map { $0.dictionary }
        return composition
    }
}

/// Defined by https://api.slack.com/reference/messaging/composition-objects#confirm
public struct ConfirmComposition {
    public let title: TextComposition
    public let text: TextComposition
    public let confirm: TextComposition
    public let deny: TextComposition

    public init(title: TextComposition,
                text: TextComposition,
                confirm: TextComposition,
                deny: TextComposition) {
        self.title = title
        self.text = text
        self.confirm = confirm
        self.deny = deny
    }

    public var dictionary: [String: Any] {
        var composition = [String: Any]()
        composition["title"] = title.dictionary
        composition["text"] = text.dictionary
        composition["confirm"] = confirm.dictionary
        composition["deny"] = deny.dictionary
        return composition
    }
}