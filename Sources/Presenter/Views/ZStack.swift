
public struct ZStack: CodableWrapperView {

    // MARK: Stored Properties

    private let alignment: Alignment?
    private let content: CoderView

    // MARK: Initialization

    public init(
        alignment: Alignment? = nil,
        @ViewBuilder content: () -> View
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

    public var body: View {
        content.modifier(Modifier(alignment: alignment?.swiftUIValue ?? .center))
    }

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    let alignment: SwiftUI.Alignment

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.ZStack(alignment: alignment) {
            content
        }
    }

}

#endif

