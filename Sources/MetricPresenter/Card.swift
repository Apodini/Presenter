struct Card: CodableViewModifier {
    // MARK: Stored Properties

    var radius: CGFloat?
}

extension Card: CustomStringConvertible {
    var description: String {
        "card(cornerRadius: \(radius?.description ?? "nil"))"
    }
}

#if canImport(SwiftUI)

extension Card: SwiftUI.ViewModifier {
    #if os(macOS)

    func body(content: Content) -> some SwiftUI.View {
        content
            .background(SwiftUI.Color(.textBackgroundColor))
            .cornerRadius(radius ?? 8)
            .shadow(color: SwiftUI.Color.primary.opacity(0.2), radius: 4)
    }

    #else

    func body(content: Content) -> some SwiftUI.View {
        content
            .background(SwiftUI.Color(.systemBackground))
            .cornerRadius(radius ?? 8)
            .shadow(color: SwiftUI.Color.primary.opacity(0.2), radius: 4)
    }

    #endif
}

extension SwiftUI.View {
    public func card(cornerRadius: CGFloat? = nil) -> some SwiftUI.View {
        modifier(Card(radius: cornerRadius))
    }
}

#endif

extension View {
    public func card(cornerRadius: CGFloat? = nil) -> View {
        modifier(Card(radius: cornerRadius))
    }
}
