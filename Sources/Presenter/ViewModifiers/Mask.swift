
internal struct Mask: CodableViewModifier {

    // MARK: Stored Properties

    let mask: CoderView

}

// MARK: - CustomStringConvertible

extension Mask: CustomStringConvertible {

    var description: String {
        "mask(\(mask))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Mask {

    public func body<Content: SwiftUI.View>(for content: Content) -> View {
        mask.modifier(Modifier(foreground: content))
    }

}

private struct Modifier<Foreground: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {

    let foreground: Foreground

    func body(content: Content) -> some SwiftUI.View {
        foreground.mask(content)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func mask(_ mask: View) -> View {
        modifier(Mask(mask: CoderView(mask)))
    }

}
