
internal struct LayoutPriority: AnyViewModifying {

    // MARK: Stored Properties

    let value: Double

}

// MARK: - CustomStringConvertible

extension LayoutPriority: CustomStringConvertible {

    var description: String {
        "layoutPriority(\(value))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension LayoutPriority: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.layoutPriority(value)
    }
}

#endif

// MARK: - View Extensions

extension View {

    public func layoutPriority(_ value: Double) -> some View {
        modified(using: LayoutPriority(value: value))
    }

}
