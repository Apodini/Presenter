
public struct NavigationLink: InternalView, Codable {

    // MARK: Stored Properties

    private let destination: CoderView
    private let isActive: Binding<Bool>
    private let label: CoderView

    // MARK: Initialization

    public init<Destination: View, Label: View>(
        destination: Destination,
        isActive: Binding<Bool>,
        label: Label
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

    public var view: _View {
        destination.apply(Modifier1(label: label, isActive: isActive))
    }

}

private struct Modifier1: ViewModifier {

    let label: CoderView
    let isActive: Binding<Bool>

    func body(content: Content) -> some SwiftUI.View {
        label
            .apply(Modifier2(destination: content, isActive: isActive))
            .eraseToAnyView()
    }

}

private struct Modifier2<Destination: SwiftUI.View>: ViewModifier {

    var destination: Destination
    let isActive: Binding<Bool>

    init(destination: Destination, isActive: Binding<Bool>) {
        self.destination = destination
        self.isActive = isActive
    }

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            SwiftUI.NavigationLink(
                destination: destination,
                isActive: model.binding(for: self.isActive),
                label: { content }
            )
        }
    }

}

#endif
