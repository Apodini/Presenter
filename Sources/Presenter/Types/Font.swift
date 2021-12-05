public struct Font: Codable {
    // MARK: Nested Types

    public enum Style: String, Codable {
        case body, callout, caption
        case footnote, headline, largeTitle
        case subheadline, title
    }

    public enum Design: String, Codable {
        case `default`
        case monospaced
        case rounded
        case serif
    }

    public enum Weight: String, Codable {
        case black
        case bold
        case heavy
        case light
        case medium
        case regular
        case semibold
        case thin
        case ultraLight
    }

    fileprivate enum Styling: String, Codable {
        case italic
        case bold
        case monospacedDigit
        case smallCaps
        case lowercaseSmallCaps
        case uppercaseSmallCaps
    }

    // MARK: Stored Properties

    private var name: String?
    private var style: Style?
    private var size: CGFloat?
    private var weight: Weight?
    private var design: Design?
    private var styling: [Styling]? // swiftlint:disable:this discouraged_optional_collection

    // MARK: Factory Functions - Style

    public static var largeTitle: Font {
        .system(.largeTitle)
    }

    public static var title: Font {
        .system(.title)
    }

    public static var headline: Font {
        .system(.headline)
    }

    public static var subheadline: Font {
        .system(.subheadline)
    }

    public static var body: Font {
        .system(.body)
    }

    public static var callout: Font {
        .system(.callout)
    }

    public static var caption: Font {
        .system(.caption)
    }

    public static var footnote: Font {
        .system(.footnote)
    }

    // MARK: Factory Functions - Advanced

    public static func system(size: CGFloat, weight: Weight? = nil, design: Design? = nil) -> Font {
        .init(size: size, weight: weight, design: design)
    }

    public static func system(_ style: Style, design: Design? = nil) -> Font {
        .init(style: style, design: design)
    }

    public static func custom(_ name: String, size: CGFloat) -> Font {
        .init(name: name, size: size)
    }

    // MARK: Factory Functions - Styling

    public func italic() -> Font {
        var font = self
        font.styling = (font.styling ?? []) + [.italic]
        return font
    }

    public func bold() -> Font {
        var font = self
        font.styling = (font.styling ?? []) + [.bold]
        return font
    }

    public func monospacedDigit() -> Font {
        var font = self
        font.styling = (font.styling ?? []) + [.monospacedDigit]
        return font
    }

    public func smallCaps() -> Font {
        var font = self
        font.styling = (font.styling ?? []) + [.smallCaps]
        return font
    }

    public func lowercaseSmallCaps() -> Font {
        var font = self
        font.styling = (font.styling ?? []) + [.lowercaseSmallCaps]
        return font
    }

    public func uppercaseSmallCaps() -> Font {
        var font = self
        font.styling = (font.styling ?? []) + [.uppercaseSmallCaps]
        return font
    }

    public func weight(_ weight: Weight) -> Font {
        var font = self
        font.weight = weight
        return font
    }
}

extension Font: CustomStringConvertible {
    public var description: String {
        let styling = [weight.map { ".weight(\($0))" }].compactMap { $0 }
            + (self.styling ?? []).map { "." + $0.rawValue + "()" }
        guard !styling.isEmpty else {
            return "." + plainDescription
        }
        return "Font."
            + plainDescription
            + styling.joined()
    }

    private var plainDescription: String {
        if let name = name {
            return "custom(\(name), size: \(size?.description ?? "nil"))"
        } else if let size = size {
            if let design = design {
                return "system(size: \(size), design: \(design))"
            } else {
                return "system(size: \(size))"
            }
        } else {
            if let design = design {
                return "system(.\(style ?? .body), design: \(design))"
            } else {
                return "system(.\(style ?? .body))"
            }
        }
    }
}

#if canImport(SwiftUI)

extension Font {
    public var swiftUIValue: SwiftUI.Font {
        (styling ?? [])
        .reduce(swiftUIValueWithoutStyling.weight(weight?.swiftUIValue ?? .regular)) { $1.apply(to: $0) }
    }

    private var swiftUIValueWithoutStyling: SwiftUI.Font {
        if let name = name {
            precondition(size != nil)
            return .custom(name, size: size ?? 12)
        } else if let size = size {
            return .system(size: size,
                           design: design?.swiftUIValue ?? .default)
        } else {
            return .system(style?.swiftUIValue ?? .body,
                           design: design?.swiftUIValue ?? .default)
        }
    }
}

extension Font.Style {
    fileprivate var swiftUIValue: SwiftUI.Font.TextStyle {
        switch self {
        case .body:
            return .body
        case .callout:
            return .callout
        case .caption:
            return .caption
        case .footnote:
            return .footnote
        case .headline:
            return .headline
        case .largeTitle:
            return .largeTitle
        case .subheadline:
            return .subheadline
        case .title:
            return .title
        }
    }
}

extension Font.Weight {
    fileprivate var swiftUIValue: SwiftUI.Font.Weight {
        switch self {
        case .black:
            return .black
        case .bold:
            return .bold
        case .heavy:
            return .heavy
        case .light:
            return .light
        case .medium:
            return .medium
        case .regular:
            return .regular
        case .semibold:
            return .semibold
        case .thin:
            return .thin
        case .ultraLight:
            return .ultraLight
        }
    }
}

extension Font.Design {
    fileprivate var swiftUIValue: SwiftUI.Font.Design {
        switch self {
        case .default:
            return .default
        case .monospaced:
            #if os(watchOS)
            return .default
            #else
            return .monospaced
            #endif
        case .rounded:
            return .rounded
        case .serif:
            #if os(watchOS)
            return .default
            #else
            return .serif
            #endif
        }
    }
}

extension Font.Styling {
    fileprivate func apply(to font: SwiftUI.Font) -> SwiftUI.Font {
        switch self {
        case .italic:
            return font.italic()
        case .bold:
            return font.bold()
        case .monospacedDigit:
            return font.monospacedDigit()
        case .smallCaps:
            return font.smallCaps()
        case .lowercaseSmallCaps:
            return font.lowercaseSmallCaps()
        case .uppercaseSmallCaps:
            return font.uppercaseSmallCaps()
        }
    }
}

#endif
