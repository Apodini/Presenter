public enum ContentMode: String, Codable {
    case fit
    case fill
}

internal struct AspectRatio: CodableViewModifier {
    // MARK: Stored Properties

    var ratio: CGFloat?
    var contentMode: ContentMode
}

// MARK: - CustomStringConvertible

extension AspectRatio: CustomStringConvertible {
    var description: String {
        if let ratio = ratio {
            return "aspectRatio(\(ratio), contentMode: \(contentMode))"
        }

        switch contentMode {
        case .fit:
            return "scaledToFit()"
        case .fill:
            return "scaledToFill()"
        }
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension AspectRatio: SwiftUI.ViewModifier {
    func body(content: Content) -> some SwiftUI.View {
        content.aspectRatio(ratio, contentMode: contentMode.swiftUIValue)
    }
}

extension ContentMode {
    fileprivate var swiftUIValue: SwiftUI.ContentMode {
        switch self {
        case .fill:
            return .fill
        case .fit:
            return .fit
        }
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func aspectRatio(_ ratio: CGSize, contentMode: ContentMode) -> View {
        modifier(AspectRatio(ratio: ratio.width / ratio.height, contentMode: contentMode))
    }

    public func aspectRatio(_ ratio: CGFloat?, contentMode: ContentMode) -> View {
        modifier(AspectRatio(ratio: ratio, contentMode: contentMode))
    }

    public func scaledToFit() -> View {
        modifier(AspectRatio(ratio: nil, contentMode: .fit))
    }

    public func scaledToFill() -> View {
        modifier(AspectRatio(ratio: nil, contentMode: .fill))
    }
}
