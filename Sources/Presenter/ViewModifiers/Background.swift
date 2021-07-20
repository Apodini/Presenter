
internal struct Background: CodableViewModifier {

    // MARK: Stored Properties

    let background: CoderView

}

// MARK: - CustomStringConvertible

extension Background: CustomStringConvertible {

    var description: String {
        "background(\(background))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Background {

    public func body<Content: SwiftUI.View>(for content: Content) -> View {
        background.modifier(Modifier(foreground: content))
    }

}

private struct Modifier<Foreground: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {

    let foreground: Foreground

    func body(content: Content) -> some SwiftUI.View {
        foreground.background(content)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func background(_ view: View) -> View {
        modifier(Background(background: CoderView(view)))
    }

}
