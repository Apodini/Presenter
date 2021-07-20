
public struct SecureField: CodableView {

    // MARK: Stored Properties

    private let title: Value<String>
    private let text: Binding<String>
    private let onCommit: CoderAction?

    // MARK: Initialization

    public init(_ title: String, text: Binding<String>,
                onCommit: Action? = nil) {
        self.init(.static(title), text: text, onCommit: onCommit)
    }

    public init(_ title: Value<String>, text: Binding<String>,
                onCommit: Action? = nil) {
        self.title = title
        self.text = text
        self.onCommit = onCommit.map(CoderAction.init)
    }

}

// MARK: - CustomStringConvertible

extension SecureField: CustomStringConvertible {

    public var description: String {
        "SecureField(\"\(title)\", text: \(text))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension SecureField: SwiftUI.View {

    public var body: some SwiftUI.View {
        ModelView { model in
            SwiftUI.SecureField(
                self.title.get(from: model),
                text: model.binding(for: self.text),
                onCommit: model.action(for: self.onCommit)
            )
        }
    }

}

#endif
