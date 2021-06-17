
public struct Toggle: SwiftUIView {

    // MARK: Stored Properties

    private let isOn: Binding<Bool>
    private let label: CoderView

    // MARK: Initialization

    public init<Label: View>(
        isOn: Binding<Bool>,
        label: Label
    ) {
        self.isOn = isOn
        self.label = CoderView(label)
    }

}

// MARK: - CustomStringConvertible

extension Toggle: CustomStringConvertible {

    public var description: String {
        "Toggle(isOn: \(isOn), label: \(label))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Toggle {

    public var view: some SwiftUI.View {
        ModelView { model in
            SwiftUI.Toggle(
                isOn: model.binding(for: self.isOn),
                label: self.label.eraseToAnyView
            )
        }
    }

}

#endif
