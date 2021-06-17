
internal struct AccentColor: AnyViewModifying {

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

extension AccentColor: ViewModifier {

    #if os(macOS)

    func body(content: Content) -> some SwiftUI.View {
        content
    }

    #else

    func body(content: Content) -> some SwiftUI.View {
        content.accentColor(color.color.view)
    }

    #endif
}

#endif

// MARK: - View Extensions

extension View {

    public func accentColor(_ color: Color) -> some View {
        modified(using: AccentColor(color: ColorCode(color)))
    }

}
