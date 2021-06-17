
public struct NavigationView: InternalView, Codable {

    // MARK: Stored Properties

    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        @ViewBuilder content: () -> Content
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

    public var view: _View {
        content.apply(Modifier())
    }

}

private struct Modifier: ViewModifier, AnyViewModifying {

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.NavigationView {
            content
        }
    }

}

#endif
