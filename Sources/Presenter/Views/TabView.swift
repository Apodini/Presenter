
public struct TabView: SwiftUIView {

    // MARK: Stored Properties

    private let selection: Binding<String>?
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        selection: Binding<String>? = nil,
        content: Content
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

extension TabView {

    #if !os(macOS) && !targetEnvironment(macCatalyst) && !os(watchOS)

    public var view: some SwiftUI.View {
        ModelView { model in
            SwiftUI.TabView(
                selection: selection.map(model.binding),
                content: content.eraseToAnyView
            )
        }
    }

    #elseif os(watchOS)

    public var view: some SwiftUI.View {
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

    public var view: some SwiftUI.View {
        SwiftUI.EmptyView()
    }

    #endif

}

#endif
