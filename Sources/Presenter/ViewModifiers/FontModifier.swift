internal struct FontModifier: CodableViewModifier {
    // MARK: Stored Properties

    let font: Font?
}

// MARK: - CustomStringConvertible

extension FontModifier: CustomStringConvertible {
    var description: String {
        "font(\(font?.description ?? "nil"))"
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension FontModifier: SwiftUI.ViewModifier {
    func body(content: Content) -> some SwiftUI.View {
        content.font(font?.swiftUIValue)
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func font(_ font: Font?) -> View {
        modifier(FontModifier(font: font))
    }
}
