
internal struct Padding: AnyViewModifying {

    // MARK: Stored Properties

    let top: CGFloat?
    let leading: CGFloat?
    let bottom: CGFloat?
    let trailing: CGFloat?

}

// MARK: - CustomStringConvertible

extension Padding: CustomStringConvertible {

    var description: String {
        let values = [("top", top), ("leading", leading), ("bottom", bottom), ("trailing", trailing)]
        let nonOptionalValues = values.filter { $0.1 != nil }
        return "padding(\(nonOptionalValues.map { "\($0.0): \($0.1 ?? 0)" }.joined(separator: ", ")))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Padding: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        let insets = EdgeInsets(top: top ?? 0, leading: leading ?? 0, bottom: bottom ?? 0, trailing: trailing ?? 0)
        return content.padding(insets)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func padding(top: CGFloat? = nil, leading: CGFloat? = nil,
                        bottom: CGFloat? = nil, trailing: CGFloat? = nil) -> some View {
        modified(using: Padding(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    public func padding(_ value: CGFloat) -> some View {
        modified(using: Padding(top: value, leading: value, bottom: value, trailing: value))
    }

}
