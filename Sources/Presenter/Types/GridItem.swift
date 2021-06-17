
public struct GridItem: Codable {

    // MARK: Nested Types

    public enum Size {

        // MARK: Cases

        case adaptive(minimum: CGFloat, maximum: CGFloat)
        case fixed(CGFloat)
        case flexible(minimum: CGFloat, maximum: CGFloat)

    }

    // MARK: Stored Properties

    public var size: Size
    public var spacing: CGFloat?
    public var alignment: Alignment?

    // MARK: Initialization

    public init(_ size: Size, spacing: CGFloat? = nil, alignment: Alignment? = nil) {
        self.size = size
        self.spacing = spacing
        self.alignment = alignment
    }

}

#if canImport(SwiftUI)

extension GridItem {

    #if !os(macOS) && !targetEnvironment(macCatalyst)

    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    var swiftUIValue: SwiftUI.GridItem {
        .init(size.swiftUIValue, spacing: spacing, alignment: alignment?.swiftUIValue)
    }

    #endif

}

extension GridItem.Size {

    #if !os(macOS) && !targetEnvironment(macCatalyst)

    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    var swiftUIValue: SwiftUI.GridItem.Size {
        switch self {
        case let .adaptive(minimum, maximum):
            return .adaptive(minimum: minimum, maximum: maximum)
        case let .fixed(value):
            return .fixed(value)
        case let .flexible(minimum, maximum):
            return .flexible(minimum: minimum, maximum: maximum)
        }
    }

    #endif

}

#endif

extension GridItem.Size: Codable {

    // MARK: Nested Types

    enum CodingKeys: String, CodingKey {
        case adaptive
        case fixed
        case flexible
        case kind
        case minimum
        case value
        case maximum
    }

    // MARK: Initialization

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(String.self, forKey: .kind) {
        case CodingKeys.adaptive.rawValue:
            self = .adaptive(
                minimum: try container.decode(CGFloat.self, forKey: .minimum),
                maximum: try container.decode(CGFloat.self, forKey: .maximum)
            )
        case CodingKeys.flexible.rawValue:
            self = .flexible(
                minimum: try container.decode(CGFloat.self, forKey: .minimum),
                maximum: try container.decode(CGFloat.self, forKey: .maximum)
            )
        case CodingKeys.fixed.rawValue:
            self = .fixed(
                try container.decode(CGFloat.self, forKey: .value)
            )
        default:
            let context = DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Unknown kind."
            )
            throw DecodingError.keyNotFound(CodingKeys.kind, context)
        }
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .adaptive(minimum, maximum):
            try container.encode(CodingKeys.adaptive.rawValue, forKey: .kind)
            try container.encode(minimum, forKey: .minimum)
            try container.encode(maximum, forKey: .maximum)
        case let .flexible(minimum, maximum):
            try container.encode(CodingKeys.flexible.rawValue, forKey: .kind)
            try container.encode(minimum, forKey: .minimum)
            try container.encode(maximum, forKey: .maximum)
        case let .fixed(value):
            try container.encode(CodingKeys.fixed.rawValue, forKey: .kind)
            try container.encode(value, forKey: .value)
        }
    }

}
