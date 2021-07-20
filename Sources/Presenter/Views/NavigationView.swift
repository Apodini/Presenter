
public struct NavigationView: CodableWrapperView {

    // MARK: Stored Properties

    private let content: CoderView

    // MARK: Initialization

    public init(
        @ViewBuilder content: () -> View
    ) {
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension NavigationView: CustomStringConvertible {

    public var description: String {
        "NavigationView(content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension NavigationView {

    public var body: View {
        content.modifier(Modifier())
    }

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.NavigationView {
            content
        }
    }

}

#endif
