
public struct HGrid: SwiftUIView {

    // MARK: Stored Properties

    private let rows: [GridItem]
    private let alignment: VerticalAlignment?
    private let spacing: CGFloat?
    private let pinnedViews: PinnedScrollableViews
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        rows: [GridItem],
        alignment: VerticalAlignment? = nil,
        spacing: CGFloat? = nil,
        pinnedViews: PinnedScrollableViews,
        @ViewBuilder content: () -> Content
    ) {
        self.rows = rows
        self.alignment = alignment
        self.spacing = spacing
        self.pinnedViews = pinnedViews
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension HGrid: CustomStringConvertible {

    public var description: String {
        "HGrid(rows: \(rows), alignment: \(alignment.map { "\($0)" } ?? "nil"), spacing: \(spacing.map(\.description) ?? "nil"), pinnedViews: \(pinnedViews), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension HGrid {

    #if !os(macOS) && !targetEnvironment(macCatalyst)

    @SwiftUI.ViewBuilder
    public var view: some SwiftUI.View {
        if #available(iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
            content.apply(
                Modifier(
                    rows: rows.map(\.swiftUIValue),
                    alignment: alignment?.swiftUIValue ?? .center,
                    spacing: spacing,
                    pinnedViews: pinnedViews.swiftUIValue
                )
            ).eraseToAnyView()
        } else {
            SwiftUI.EmptyView()
        }
    }

    #else

    public var view: some SwiftUI.View  {
        SwiftUI.EmptyView()
    }

    #endif

}

@available(iOS 14.0, macOS 11.0, *)
private struct Modifier: ViewModifier {

    let rows: [SwiftUI.GridItem]
    let alignment: SwiftUI.VerticalAlignment
    let spacing: CGFloat?
    let pinnedViews: SwiftUI.PinnedScrollableViews

    func body(content: Content) -> some SwiftUI.View {
        SwiftUI.LazyHGrid(
            rows: rows,
            alignment: alignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: { content }
        )
    }

}

#endif

