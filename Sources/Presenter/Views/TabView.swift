
public struct TabView: CodableView {

    // MARK: Stored Properties

    private let selection: Binding<String>?
    private let content: CoderView

    // MARK: Initialization

    public init(
        selection: Binding<String>? = nil,
        content: View
    ) {
        self.selection = selection
        self.content = CoderView(content)
    }

}

// MARK: - CustomStringConvertible

extension TabView: CustomStringConvertible {

    public var description: String {
        "TabView(selection: \(selection.map { "\($0)" } ?? "nil"), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension TabView: SwiftUI.View {

    #if !os(macOS) && !targetEnvironment(macCatalyst) && !os(watchOS)

    public var body: some SwiftUI.View {
        ModelView { model in
            SwiftUI.TabView(
                selection: selection.map(model.binding),
                content: content.eraseToAnyView
            )
        }
    }

    #elseif os(watchOS)

    public var body: some SwiftUI.View {
        if #available(watchOS 7.0, *) {
            ModelView { model in
                SwiftUI.TabView(
                    selection: selection.map(model.binding),
                    content: content.eraseToAnyView
                )
            }
        } else {
            SwiftUI.EmptyView()
        }
    }

    #else

    public var body: some SwiftUI.View {
        SwiftUI.EmptyView()
    }

    #endif

}

#endif
