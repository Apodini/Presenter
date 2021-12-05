public struct LinearGradient: CodableView {
    // MARK: Stored Properties

    private let gradient: Gradient
    private let startPoint: UnitPoint
    private let endPoint: UnitPoint

    // MARK: Initialization

    public init(gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint) {
        self.gradient = gradient
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}

// MARK: - CustomStringConvertible

extension LinearGradient: CustomStringConvertible {
    public var description: String {
        "LinearGradient(gradient: \(gradient), startPoint: \(startPoint), endPoint: \(endPoint))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension LinearGradient: SwiftUI.View {
    public var body: some SwiftUI.View {
        SwiftUI.LinearGradient(
            gradient: gradient.swiftUIValue,
            startPoint: startPoint.unitPoint,
            endPoint: endPoint.unitPoint
        )
    }
}

#endif
