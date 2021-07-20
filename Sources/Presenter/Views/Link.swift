
public struct Link: CodableWrapperView {

    // MARK: Stored Properties

    private let label: CoderView
    private let destination: String

    // MARK: Initialization

    public init(label: View, destination: String) {
        self.label = CoderView(label)
        self.destination = destination
    }

}

// MARK: - CustomStringConvertible

extension Link: CustomStringConvertible {

    public var description: String {
        "Link(\(label), destination: \(destination))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Link {

    public var body: View {
        label.modifier(Modifier(destination: destination))
    }

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    let destination: String

    func body(content: Content) -> some SwiftUI.View {
        if #available(iOS 14.0, *), let url = URL(string: destination) {
            SwiftUI.Link(destination: url) { content }
        } else {
            content
        }
    }

}

#endif
