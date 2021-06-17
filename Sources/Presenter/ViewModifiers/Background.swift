
internal struct Background: AnyViewModifying {

    // MARK: Stored Properties

    let view: CoderView

}

// MARK: - CustomStringConvertible

extension Background: CustomStringConvertible {

    var description: String {
        "background(\(view))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Background: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.background(view.eraseToAnyView())
    }

}

#endif

// MARK: - View Extensions

extension View where Self: Codable {

    public func background<V: View>(_ view: V) -> some View {
        modified(using: Background(view: CoderView(view)))
    }

}
