
public struct Section: CodableWrapperView {

    // MARK: Stored Properties

    private let header: CoderView?
    private let footer: CoderView?
    private let content: CoderView

    // MARK: Initialization

    public init(
        header: View? = nil,
        footer: View? = nil,
        @ViewBuilder content: () -> View
    ) {
        self.header = header.map(CoderView.init)
        self.footer = footer.map(CoderView.init)
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

    public var body: View {
        content.modifier(Modifier1(header: header, footer: footer))
    }

}

private struct Modifier1: ViewModifier {

    let header: CoderView?
    let footer: CoderView?

    func body<Content: SwiftUI.View>(for content: Content) -> View {
        (header?.body ?? Nil()).modifier(Modifier2(footer: footer, section: content))
    }

}

private struct Modifier2<Section: SwiftUI.View>: ViewModifier {

    let footer: CoderView?
    let section: Section

    func body<Header: SwiftUI.View>(for header: Header) -> View {
        (footer?.body ?? Nil()).modifier(Modifier3(header: header, section: section))
    }

}

private struct Modifier3<Header: SwiftUI.View, Section: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {

    let header: Header
    let section: Section

    func body(content footer: Content) -> some SwiftUI.View {
        SwiftUI.Section(header: header, footer: footer) { section }
    }

}

#endif
