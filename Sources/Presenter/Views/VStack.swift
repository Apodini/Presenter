
public struct VStack: InternalView, Codable {

    // MARK: Stored Properties

    private let alignment: HorizontalAlignment?
    private let spacing: CGFloat?
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        alignment: HorizontalAlignment? = nil,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {

        self.alignment = alignment
        self.spacing = spacing
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension VStack: CustomStringConvertible {

    public var description: String {
        "VStack(alignment: .\((alignment ?? .center).rawValue), spacing: \(spacing.map { $0.description } ?? "nil"), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension VStack {

    public var view: _View {
        content
            .apply(Modifier(alignment: alignment?.swiftUIValue ?? .center, spacing: spacing))
    }

}

private struct Modifier: ViewModifier {

    let alignment: SwiftUI.HorizontalAlignment
    let spacing: CGFloat?

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.VStack(alignment: alignment, spacing: spacing) {
            content
        }
    }

}

#endif

