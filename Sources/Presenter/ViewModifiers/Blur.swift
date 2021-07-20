
internal struct Blur: CodableViewModifier {

    // MARK: Stored Properties

    let radius: CGFloat
    let opaque: Bool?

}

// MARK: - CustomStringConvertible

extension Blur: CustomStringConvertible {

    var description: String {
        "blur(radius: \(radius), opaque: \(opaque ?? false))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Blur: SwiftUI.ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.blur(radius: radius, opaque: opaque ?? false)
    }
}

#endif

// MARK: - View Extensions

extension View {

    public func blur(radius: CGFloat, opaque: Bool? = nil) -> View {
        modifier(Blur(radius: radius, opaque: opaque))
    }

}
