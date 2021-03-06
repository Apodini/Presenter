
struct ArrayView: SwiftUIView {

    // MARK: Stored Properties

    let content: [CoderView]

    // MARK: Initialization

    public init(content: [_CodableView]) {
        self.content = content.flatMap { contentView -> [CoderView] in
            if let arrayView = contentView as? ArrayView {
                return arrayView.content
            } else {
                return [CoderView(contentView)]
            }
        }
    }

}

// MARK: - CustomStringConvertible

extension ArrayView: CustomStringConvertible {

    public var description: String {
        content.description
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension ArrayView {

    public var view: some SwiftUI.View {
        ForEach(content.indices) { index in
            self.content[index].eraseToAnyView()
        }
    }

}

#endif
