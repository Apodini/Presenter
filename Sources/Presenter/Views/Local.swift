public struct Local: CodableView {
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

extension Local: SwiftUI.View {
    public var body: some SwiftUI.View {
        ModelView { model in
            view(for: model.get(key))
        }
    }

    @SwiftUI.ViewBuilder
    private func view(for value: Any?) -> some SwiftUI.View {
        if let view = value as? View {
            view.eraseToAnyView()
        } else if let view = value as? AnyView {
            view
        }
    }
}

#endif
