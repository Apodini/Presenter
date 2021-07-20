
public struct VStack: CodableWrapperView {

    // MARK: Stored Properties

    private let alignment: HorizontalAlignment?
    private let spacing: CGFloat?
    private let content: CoderView

    // MARK: Initialization

    public init(
        alignment: HorizontalAlignment? = nil,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> View
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

    public var body: View {
        content
            .modifier(Modifier(alignment: alignment?.swiftUIValue ?? .center, spacing: spacing))
    }

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    let alignment: SwiftUI.HorizontalAlignment
    let spacing: CGFloat?

    internal init(alignment: SwiftUI.HorizontalAlignment, spacing: CGFloat?) {
        self.alignment = alignment
        self.spacing = spacing
    }

    init(from decoder: Decoder) throws {
        fatalError() // TODO
    }

    func encode(to encoder: Encoder) throws {
        // TODO
    }

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.VStack(alignment: alignment, spacing: spacing) {
            content
        }
    }

}

#endif

