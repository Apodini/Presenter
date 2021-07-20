public struct Chart: CodableView {
    // MARK: Stored Properties

    public let data: [[Double]]
    public let style: Style

    // MARK: Initialization

    public init(data: [Double], style: Style) {
        self.data = data.map { [$0] }
        self.style = style
    }

    public init(data: [[Double]], style: Style) {
        self.data = data
        self.style = style
    }
}

// MARK: - CustomStringConvertible

extension Chart: CustomStringConvertible {
    public var description: String {
        "Chart(data: \(data), style: \(style))"
    }
}

#if canImport(Charts)

extension Chart: SwiftUI.View {
    public var body: some SwiftUI.View {
        style.chart(for: data)
    }
}

#elseif canImport(SwiftUI)

extension Chart: SwiftUI.View {
    public var body: some SwiftUI.View {
        EmptyView()
    }
}

#endif
