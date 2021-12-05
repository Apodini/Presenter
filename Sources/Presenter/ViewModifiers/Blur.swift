internal struct Blur: CodableViewModifier {
    // MARK: Stored Properties

    let radius: CGFloat
    let opaque: Bool? // swiftlint:disable:this discouraged_optional_boolean
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
        if let opaque = opaque {
            content.blur(radius: radius, opaque: opaque)
        } else {
            content.blur(radius: radius)
        }
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func blur(radius: CGFloat,
                     opaque: Bool? = nil) -> View { // swiftlint:disable:this discouraged_optional_boolean
        modifier(Blur(radius: radius, opaque: opaque))
    }
}
