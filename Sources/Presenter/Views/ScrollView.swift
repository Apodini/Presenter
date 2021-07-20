public struct ScrollView: CodableWrapperView {
    // MARK: Stored Properties

    private let axis: AxisSet?
    private let showsIndicators: Bool?
    private let content: CoderView

    // MARK: Initialization

    public init(
        _ axis: AxisSet? = nil,
        showsIndicators: Bool? = nil,
        @ViewBuilder content: () -> View
    ) {
        self.axis = axis
        self.showsIndicators = showsIndicators
        self.content = CoderView(content())
    }
}

// MARK: - CustomStringConvertible

extension ScrollView: CustomStringConvertible {
    public var description: String {
        "ScrollView(content: \(content))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension ScrollView {
    public var body: View {
        content.modifier(
            Modifier(axis: axis?.swiftUIValue ?? .vertical,
                     showsIndicators: showsIndicators ?? true)
        )
    }
}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {
    let axis: SwiftUI.Axis.Set
    let showsIndicators: Bool

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.ScrollView(axis, showsIndicators: showsIndicators) {
            content
        }
    }
}

#endif
