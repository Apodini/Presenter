
internal struct CornerRadius: AnyViewModifying {

    // MARK: Stored Properties

    let value: CGFloat
    let antialiased: Bool?

}

// MARK: - CustomStringConvertible

extension CornerRadius: CustomStringConvertible {

    var description: String {
        "cornerRadius(\(value), antialiased: \(antialiased ?? true))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension CornerRadius: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.cornerRadius(value, antialiased: antialiased ?? true)
    }
}

#endif

// MARK: - View Extensions

extension View {

    public func cornerRadius(_ value: CGFloat, antialiased: Bool? = nil) -> some View {
        modified(using: CornerRadius(value: value, antialiased: antialiased))
    }

}
