
public struct VGrid: CodableWrapperView {

    // MARK: Stored Properties

    private let columns: [GridItem]
    private let alignment: HorizontalAlignment?
    private let spacing: CGFloat?
    private let pinnedViews: PinnedScrollableViews
    private let content: CoderView

    // MARK: Initialization

    public init(
        columns: [GridItem],
        alignment: HorizontalAlignment? = nil,
        spacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews,
        @ViewBuilder content: () -> View
     ) {

        self.columns = columns
        self.alignment = alignment
        self.spacing = spacing
        self.pinnedViews = pinnedViews
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension VGrid: CustomStringConvertible {

    public var description: String {
        "VGrid(columns: \(columns), alignment: \(alignment.map { "\($0)" } ?? "nil"), spacing: \(spacing.map(\.description) ?? "nil"), pinnedViews: \(pinnedViews), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension VGrid {

    #if !os(macOS) && !targetEnvironment(macCatalyst)

    public var body: View {
        if #available(iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
            return content.modifier(
                Modifier(columns: columns.map(\.swiftUIValue),
                         alignment: alignment?.swiftUIValue ?? .center,
                         spacing: spacing,
                         pinnedViews: pinnedViews.swiftUIValue)
            )
        } else {
            return Nil()
        }
    }

    #else

    public var body: View {
        Nil()
    }

    #endif

}

@available(iOS 14.0, macOS 11.0, *)
private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    let columns: [SwiftUI.GridItem]
    let alignment: SwiftUI.HorizontalAlignment
    let spacing: CGFloat?
    let pinnedViews: SwiftUI.PinnedScrollableViews

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.LazyVGrid(
            columns: columns,
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: { content }
        )
    }

}

#endif

