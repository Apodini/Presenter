public struct Toggle: CodableView {
    // MARK: Stored Properties

    private let isOn: Binding<Bool>
    private let label: CoderView

    // MARK: Initialization

    public init(
        isOn: Binding<Bool>,
        label: View
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

extension Toggle: SwiftUI.View {
    public var body: some SwiftUI.View {
        ModelView { model in
            SwiftUI.Toggle(
                isOn: model.binding(for: self.isOn),
                label: self.label.eraseToAnyView
            )
        }
    }
}

#endif
