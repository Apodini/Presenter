
public struct Button: CodableWrapperView {

    // MARK: Stored Properties

    let label: CoderView
    let action: CoderAction

    // MARK: Initialization

    public init(_ label: View, action: Action) {
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

    public var body: View {
        label.modifier(Modifier(action: action))
    }

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

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
