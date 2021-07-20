internal struct ForegroundColor: CodableViewModifier {
    // MARK: Stored Properties

    let color: ColorCode
}

// MARK: - CustomStringConvertible

extension ForegroundColor: CustomStringConvertible {
    var description: String {
        "foregroundColor(\(color))"
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension ForegroundColor: SwiftUI.ViewModifier {
    func body(content: Content) -> some SwiftUI.View {
        content.foregroundColor(color.color.body)
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func foregroundColor(_ color: Color) -> View {
        modifier(ForegroundColor(color: ColorCode(color)))
    }
}
