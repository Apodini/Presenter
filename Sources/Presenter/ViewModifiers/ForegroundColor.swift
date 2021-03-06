
internal struct ForegroundColor: AnyViewModifying {

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

extension ForegroundColor: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.foregroundColor(color.color.view)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func foregroundColor(_ color: Color) -> some View {
        modified(using: ForegroundColor(color: ColorCode(color)))
    }

}
