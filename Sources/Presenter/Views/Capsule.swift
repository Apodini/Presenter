public struct Capsule: CodableView {
    // MARK: Stored Properties

    private let style: RoundedCornerStyle

    // MARK: Initialization

    public init(style: RoundedCornerStyle) {
        self.style = style
    }
}

// MARK: - CustomStringConvertible

extension Capsule: CustomStringConvertible {
    public var description: String {
        "Capsule(style: \(style))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension Capsule: SwiftUI.View {
    public var body: some SwiftUI.View {
        SwiftUI.Capsule(style: style.swiftUIValue)
    }
}

#endif
