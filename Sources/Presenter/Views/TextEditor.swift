
public struct TextEditor: SwiftUIView {

    // MARK: Stored Properties

    private let text: Binding<String>

    // MARK: Initialization

    public init(text: Binding<String>) {
        self.text = text
    }

}

// MARK: - CustomStringConvertible

extension TextEditor: CustomStringConvertible {

    public var description: String {
        "TextEditor(text: \(text))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension TextEditor {

    #if !os(watchOS) && !os(macOS) && !os(tvOS) && !targetEnvironment(macCatalyst)

    @SwiftUI.ViewBuilder
    public var view: some SwiftUI.View {
        if #available(iOS 14.0, *) {
            ModelView { model in
                SwiftUI.TextEditor(text: model.binding(for: text))
            }
        } else {
            SwiftUI.EmptyView()
        }

    }

    #else

    public var view: some SwiftUI.View {
        SwiftUI.EmptyView()
    }

    #endif

}

#endif
