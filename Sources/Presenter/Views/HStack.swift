
public struct HStack: InternalView, Codable {

    // MARK: Stored Properties

    private let alignment: VerticalAlignment?
    private let spacing: CGFloat?
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        alignment: VerticalAlignment? = nil,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension HStack: CustomStringConvertible {

    public var description: String {
        "HStack(alignment: .\((alignment ?? .center).rawValue), spacing: \(spacing.map { $0.description } ?? "nil"), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension HStack {

    public var view: _View {
        content
            .apply(Modifier(alignment: alignment?.swiftUIValue ?? .center, spacing: spacing))
    }

}

private struct Modifier: ViewModifier {

    let alignment: SwiftUI.VerticalAlignment
    let spacing: CGFloat?

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.HStack(alignment: alignment, spacing: spacing) {
            content
        }
    }

}

#endif

