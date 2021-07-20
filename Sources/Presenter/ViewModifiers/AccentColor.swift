internal struct AccentColor: CodableViewModifier {
    // MARK: Stored Properties

    let color: ColorCode
}

// MARK: - CustomStringConvertible

extension AccentColor: CustomStringConvertible {
    var description: String {
        "accentColor(\(color))"
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension AccentColor: SwiftUI.ViewModifier {
    #if os(macOS)

    func body(content: Content) -> some SwiftUI.View {
        content
    }

    #else

    func body(content: Content) -> some SwiftUI.View {
        content.accentColor(color.color.body)
    }

    #endif
}

#endif

// MARK: - View Extensions

extension View {
    public func accentColor(_ color: Color) -> View {
        modifier(AccentColor(color: ColorCode(color)))
    }
}
