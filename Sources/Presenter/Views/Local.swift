
public struct Local: SwiftUIView {

    // MARK: Stored Properties

    private let key: String

    // MARK: Initialization

    public init(key: String) {
        self.key = key
    }

}

// MARK: - CustomStringConvertible

extension Local: CustomStringConvertible {

    public var description: String {
        "Local(key: \(key))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Local {

    public var view: some SwiftUI.View {
        ModelView { model in
            view(for: model.state[self.key])
        }
    }

    @SwiftUI.ViewBuilder
    private func view(for value: Any?) -> some SwiftUI.View {
        if let view = value as? _View {
            view.eraseToAnyView()
        } else if let view = value as? AnyView {
            view
        }
    }

}

#endif
