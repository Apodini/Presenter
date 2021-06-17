
public struct ZStack: InternalView, Codable {

    // MARK: Stored Properties

    private let alignment: Alignment?
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        alignment: Alignment? = nil,
        @ViewBuilder content: () -> Content
    ) {

        self.alignment = alignment
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension ZStack: CustomStringConvertible {

    public var description: String {
        "ZStack(alignment: .\((alignment ?? .center).rawValue), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension ZStack {

    public var view: _View {
        content.apply(Modifier(alignment: alignment?.swiftUIValue ?? .center))
    }

}

private struct Modifier: ViewModifier {

    let alignment: SwiftUI.Alignment

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.ZStack(alignment: alignment) {
            content
        }
    }

}

#endif

