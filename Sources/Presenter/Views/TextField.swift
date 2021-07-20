public struct TextField: CodableView {
    // MARK: Stored Properties

    private let title: Value<String>
    private let text: Binding<String>
    private let onCommit: CoderAction?
    private let onEditingChanged: CoderAction?

    // MARK: Initialization

    public init(_ title: String, text: Binding<String>,
                onCommit: Action? = nil, onEditingChanged: Action? = nil) {
        self.init(
            .static(title),
            text: text,
            onCommit: onCommit,
            onEditingChanged: onEditingChanged
        )
    }

    public init(_ title: Value<String>, text: Binding<String>,
                onCommit: Action? = nil, onEditingChanged: Action? = nil) {
        self.title = title
        self.text = text
        self.onCommit = onCommit.map(CoderAction.init)
        self.onEditingChanged = onEditingChanged.map(CoderAction.init)
    }
}

// MARK: - CustomStringConvertible

extension TextField: CustomStringConvertible {
    public var description: String {
        "TextField(\"\(title)\", text: \(text))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension TextField: SwiftUI.View {
    public var body: some SwiftUI.View {
        ModelView { model in
            SwiftUI.TextField(
                self.title.get(from: model),
                text: model.binding(for: self.text),
                onEditingChanged: model.action(for: self.onEditingChanged),
                onCommit: model.action(for: self.onCommit)
            )
        }
    }
}

#endif
