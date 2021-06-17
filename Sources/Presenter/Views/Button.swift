
public struct Button: SwiftUIView {

    // MARK: Stored Properties

    let label: CoderView
    let action: CoderAction

    // MARK: Initialization

    public init<Label: View>(_ label: Label, action: Action) {
        self.label = CoderView(label)
        self.action = CoderAction(action)
    }

}

// MARK: - CustomStringConvertible

extension Button: CustomStringConvertible {

    public var description: String {
        "Button(\(label))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Button {

    public var view: some SwiftUI.View {
        label.apply(Modifier1(action: action)).eraseToAnyView()
    }

}

private struct Modifier1: ViewModifier {

    let action: CoderAction

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            SwiftUI.Button(
                action: model.action(for: self.action),
                label: { content }
            )
        }
    }

}

#endif
