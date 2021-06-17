
public struct Section: SwiftUIView {

    // MARK: Stored Properties

    private let header: CoderView?
    private let footer: CoderView?
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        @ViewBuilder content: () -> Content
    ) {
        self.header = nil
        self.footer = nil
        self.content = CoderView(content())
    }

    public init<Header: View, Content: View>(
        header: Header,
        @ViewBuilder content: () -> Content
    ) {
        self.header = CoderView(header)
        self.footer = nil
        self.content = CoderView(content())
    }

    public init<Footer: View, Content: View>(
        footer: Footer,
        @ViewBuilder content: () -> Content
    ) {
        self.header = nil
        self.footer = CoderView(footer)
        self.content = CoderView(content())
    }

    public init<Header: View, Footer: View, Content: View>(
        header: Header,
        footer: Footer,
        @ViewBuilder content: () -> Content
    ) {
        self.header = CoderView(header)
        self.footer = CoderView(footer)
        self.content = CoderView(content())
    }

}

// MARK: - CustomStringConvertible

extension Section: CustomStringConvertible {

    public var description: String {
        "Section(header: \(header.map { "\($0)" } ?? "nil")), footer: \(footer.map { "\($0)" } ?? "nil"), content: \(content))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Section {

    @SwiftUI.ViewBuilder
    public var view: some SwiftUI.View {
        switch (header, footer) {
        case let (.some(header), .some(footer)):
            SwiftUI.Section(header: header.eraseToAnyView(),
                            footer: footer.eraseToAnyView(),
                            content: content.eraseToAnyView)
        case let (.none, .some(footer)):
            SwiftUI.Section(footer: footer.eraseToAnyView(),
                            content: content.eraseToAnyView)
        case let (.some(header), .none):
            SwiftUI.Section(header: header.eraseToAnyView(),
                            content: content.eraseToAnyView)
        case (.none, .none):
            SwiftUI.Section(content: content.eraseToAnyView)
        }
    }

}

#endif
