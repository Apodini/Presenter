public struct Circle: CodableView {
    // MARK: Initialization

    public init() {}
}

// MARK: - CustomStringConvertible

extension Circle: CustomStringConvertible {
    public var description: String {
        "Circle()"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension Circle: SwiftUI.View {
    public var body: some SwiftUI.View {
        SwiftUI.Circle()
    }
}

#endif
