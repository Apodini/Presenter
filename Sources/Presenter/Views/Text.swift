
public struct Text: SwiftUIView {

    // MARK: Stored Properties

    private let text: Value<String>

    // MARK: Initialization

    public init(_ text: String) {
        self.text = .static(text)
    }

    public init(_ text: Value<String>) {
        self.text = text
    }

}

// MARK: - CustomStringConvertible

extension Text: CustomStringConvertible {

    public var description: String {
        "Text(\(text))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Text {

    public var view: some SwiftUI.View {
        ModelView { model in
            SwiftUI.Text(self.text.get(from: model))
        }
    }

}

#endif
