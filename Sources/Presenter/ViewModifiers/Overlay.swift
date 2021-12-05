internal struct Overlay: CodableViewModifier {
    // MARK: Stored Properties

    let overlay: CoderView
    let alignment: Alignment?
}

// MARK: - CustomStringConvertible

extension Overlay: CustomStringConvertible {
    var description: String {
        "overlay(\(overlay), alignment: \(alignment ?? .center))"
    }
}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Overlay {
    public func body<Content: SwiftUI.View>(for content: Content) -> View {
        overlay.modifier(
            Modifier(foreground: content,
                     alignment: alignment?.swiftUIValue ?? .center)
        )
    }
}

private struct Modifier<Foreground: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {
    let foreground: Foreground
    let alignment: SwiftUI.Alignment

    func body(content: Content) -> some SwiftUI.View {
        foreground.overlay(content, alignment: alignment)
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func overlay(_ overlay: View, alignment: Alignment? = nil) -> View {
        modifier(Overlay(overlay: CoderView(overlay), alignment: alignment))
    }
}
