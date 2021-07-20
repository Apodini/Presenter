
public struct HStack: CodableWrapperView {

    // MARK: Stored Properties

    private let alignment: VerticalAlignment?
    private let spacing: CGFloat?
    private let content: CoderView

    // MARK: Initialization

    public init(
        alignment: VerticalAlignment? = nil,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> View
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

    public var body: View {
        content
            .modifier(Modifier(alignment: alignment?.swiftUIValue ?? .center, spacing: spacing))
    }

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    let alignment: SwiftUI.VerticalAlignment
    let spacing: CGFloat?

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.HStack(alignment: alignment, spacing: spacing) {
            content
        }
    }

}

#endif

