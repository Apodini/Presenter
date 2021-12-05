public struct NavigationLink: CodableWrapperView {
    // MARK: Stored Properties

    private let destination: CoderView
    private let isActive: Binding<Bool>
    private let label: CoderView

    // MARK: Initialization

    public init(
        destination: View,
        isActive: Binding<Bool>,
        label: View
    ) {
        self.destination = CoderView(destination)
        self.isActive = isActive
        self.label = CoderView(label)
    }
}

// MARK: - CustomStringConvertible

extension NavigationLink: CustomStringConvertible {
    public var description: String {
        "NavigationLink(destination: \(destination), isActive: \(isActive), label: \(label))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension NavigationLink {
    public var body: View {
        destination.modifier(Modifier1(label: label, isActive: isActive))
    }
}

private struct Modifier1: ViewModifier {
    let label: CoderView
    let isActive: Binding<Bool>

    func body<Content: SwiftUI.View>(for content: Content) -> View {
        label.modifier(Modifier2(destination: content, isActive: isActive))
    }
}

private struct Modifier2<Destination: SwiftUI.View>: ViewModifier, SwiftUI.ViewModifier {
    var destination: Destination
    let isActive: Binding<Bool>

    init(destination: Destination, isActive: Binding<Bool>) {
        self.destination = destination
        self.isActive = isActive
    }

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            SwiftUI.ZStack {
                SwiftUI.NavigationLink(
                    destination: destination,
                    isActive: model.binding(for: self.isActive),
                    label: { content }
                )

                SwiftUI.NavigationLink(
                    destination: EmptyView(),
                    label: { EmptyView() }
                )
            }
        }
    }
}

#endif
