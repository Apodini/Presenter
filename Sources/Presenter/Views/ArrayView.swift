struct ArrayView: CodableView {
    // MARK: Stored Properties

    let content: [CoderView]

    // MARK: Initialization

    public init(content: [View]) {
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

extension ArrayView: SwiftUI.View {
    public var body: some SwiftUI.View {
        ForEach(content.indices) { index in
            self.content[index].eraseToAnyView()
        }
    }
}

#endif
