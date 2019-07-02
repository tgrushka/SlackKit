public protocol BlockElement {
    var dictionary: [String: Any] { get }
}

public protocol SectionElement: BlockElement {}

public protocol ActionsElement: BlockElement {}

public protocol ContextElement: BlockElement {}

/// Defined by https://api.slack.com/reference/messaging/block-elements#image
public struct ImageElement: BlockElement, SectionElement, ContextElement {
    /// Type will always be image.
    public let type: BlockType
    public let imageURL: String
    public let altText: String

    public init(type: BlockType = .image,
                imageURL: String,
                altText: String) {
        self.type = type
        self.imageURL = imageURL
        self.altText = altText
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["image_url"] = imageURL
        element["alt_text"] = altText
        return element
    }
}

/// Custom type to better support Context PlainText
public struct PlainTextElement: BlockElement, ContextElement {
    /// Type will always be image.
    public let type: BlockType
    public let text: String

    public init(type: BlockType = .plainText,
                text: String) {
        self.type = type
        self.text = text
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["text"] = text
        return element
    }
}

/// Custom type to better support Context Markdown Text
public struct MarkdownTextElement: BlockElement, ContextElement {
    /// Type will always be image.
    public let type: BlockType
    public let text: String

    public init(type: BlockType = .markdown,
                text: String) {
        self.type = type
        self.text = text
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["text"] = text
        return element
    }
}

public enum ButtonElementStyle: String, CaseIterable {
    case `default`
    case primary
    case danger
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#button
public struct ButtonElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be button.
    public let type: BlockType
    public let text: TextComposition
    public let actionId: String
    public let url: String?
    public let value: String?
    public let style: ButtonElementStyle?

    public init(type: BlockType = .button,
                text: TextComposition,
                actionId: String,
                url: String? = nil,
                value: String? = nil,
                style: ButtonElementStyle? = nil) {
        self.type = type
        self.text = text
        self.actionId = actionId
        self.url = url
        self.value = value
        self.style = style
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["text"] = text.dictionary
        element["action_id"] = actionId
        element["url"] = url
        element["value"] = value
        element["style"] = style
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#static-select
public struct StaticSelectElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be static_select.
    public let type: BlockType
    public let placeholder: TextComposition
    public let actionId: String
    public let options: [OptionComposition]?
    public let optionGroups: [OptionGroupComposition]?
    public let initialOption: OptionComposition?
    public let initialOptionGroup: OptionGroupComposition?
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .staticSelect,
                placeholder: TextComposition,
                actionId: String,
                options: [OptionComposition]? = nil,
                optionGroups: [OptionGroupComposition]? = nil,
                initialOption: OptionComposition? = nil,
                initialOptionGroup: OptionGroupComposition? = nil,
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.placeholder = placeholder
        self.actionId = actionId
        self.options = options
        self.optionGroups = optionGroups
        self.initialOption = initialOption
        self.initialOptionGroup = initialOptionGroup
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["placeholder"] = placeholder.dictionary
        element["action_id"] = actionId
        element["options"] = options?.map { $0.dictionary }
        element["option_groups"] = optionGroups?.map { $0.dictionary }
        element["initial_option"] = initialOption?.dictionary ?? initialOptionGroup?.dictionary
        element["confirm"] = confirm?.dictionary
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#external-select
public struct ExternalSelectElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be externalSelect.
    public let type: BlockType
    public let placeholder: TextComposition
    public let actionId: String
    public let initialOption: OptionComposition?
    public let initialOptionGroup: OptionGroupComposition?
    public let minQueryLenght: Int?
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .externalSelect,
                placeholder: TextComposition,
                actionId: String,
                initialOption: OptionComposition? = nil,
                initialOptionGroup: OptionGroupComposition? = nil,
                minQueryLenght: Int?,
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.placeholder = placeholder
        self.actionId = actionId
        self.initialOption = initialOption
        self.initialOptionGroup = initialOptionGroup
        self.minQueryLenght = minQueryLenght
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["placeholder"] = placeholder.dictionary
        element["action_id"] = actionId
        element["initial_option"] = initialOption?.dictionary ?? initialOptionGroup?.dictionary
        element["min_query_length"] = minQueryLenght
        element["confirm"] = confirm?.dictionary
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#user-select
public struct UsersSelectElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be usersSelect.
    public let type: BlockType
    public let placeholder: TextComposition
    public let actionId: String
    public let initialUserId: String?
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .usersSelect,
                placeholder: TextComposition,
                actionId: String,
                initialUserId: String?,
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.placeholder = placeholder
        self.actionId = actionId
        self.initialUserId = initialUserId
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["placeholder"] = placeholder.dictionary
        element["action_id"] = actionId
        element["initial_user"] = initialUserId
        element["confirm"] = confirm?.dictionary
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#converstation-select
public struct ConverstationSelectElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be converstationSelect.
    public let type: BlockType
    public let placeholder: TextComposition
    public let actionId: String
    public let initialConverstationId: String?
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .converstationSelect,
                placeholder: TextComposition,
                actionId: String,
                initialConverstationId: String?,
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.placeholder = placeholder
        self.actionId = actionId
        self.initialConverstationId = initialConverstationId
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["placeholder"] = placeholder.dictionary
        element["action_id"] = actionId
        element["initial_conversation"] = initialConverstationId
        element["confirm"] = confirm?.dictionary
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#channel-select
public struct ChannelSelectElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be channelSelect.
    public let type: BlockType
    public let placeholder: TextComposition
    public let actionId: String
    public let initialChannelId: String?
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .channelSelect,
                placeholder: TextComposition,
                actionId: String,
                initialChannelId: String?,
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.placeholder = placeholder
        self.actionId = actionId
        self.initialChannelId = initialChannelId
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["placeholder"] = placeholder.dictionary
        element["action_id"] = actionId
        element["initial_channel"] = initialChannelId
        element["confirm"] = confirm?.dictionary
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#overflow
public struct OverflowElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be overflow.
    public let type: BlockType
    public let actionId: String
    public let options: [OptionComposition]
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .overflow,
                placeholder: TextComposition,
                actionId: String,
                options: [OptionComposition],
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.actionId = actionId
        self.options = options
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["action_id"] = actionId
        element["options"] = options
        element["confirm"] = confirm?.dictionary
        return element
    }
}

/// Defined by https://api.slack.com/reference/messaging/block-elements#overflow
public struct DatePickerElement: BlockElement, SectionElement, ActionsElement {
    /// Type will always be datePicker.
    public let type: BlockType
    public let actionId: String
    public let placeholder: TextComposition?
    public let initialDate: String?
    public let confirm: ConfirmComposition?

    public init(type: BlockType = .datePicker,
                actionId: String,
                placeholder: TextComposition?,
                initialDate: String? = nil,
                confirm: ConfirmComposition? = nil) {
        self.type = type
        self.actionId = actionId
        self.placeholder = placeholder
        self.initialDate = initialDate
        self.confirm = confirm
    }

    public var dictionary: [String: Any] {
        var element = [String: Any]()
        element["type"] = type.rawValue
        element["action_id"] = actionId
        element["placeholder"] = placeholder?.dictionary
        element["initial_date"] = initialDate
        element["confirm"] = confirm?.dictionary
        return element
    }
}
