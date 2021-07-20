internal struct Opacity: CodableViewModifier {
    // MARK: Stored Properties

    let value: Double
}

// MARK: - CustomStringConvertible

extension Opacity: CustomStringConvertible {
    var description: String {
        "opacity(\(value))"
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Opacity: SwiftUI.ViewModifier {
    func body(content: Content) -> some SwiftUI.View {
        content.opacity(value)
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func opacity(_ value: Double, antialiased: Bool? = nil) -> View {
        modifier(Opacity(value: value))
    }
}
