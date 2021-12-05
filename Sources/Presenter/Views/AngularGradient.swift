public struct AngularGradient: CodableView {
    // MARK: Stored Properties

    private let gradient: Gradient
    private let center: UnitPoint
    private let startAngle: Angle
    private let endAngle: Angle

    // MARK: Initialization

    public init(gradient: Gradient,
                center: UnitPoint,
                startAngle: Angle = .zero,
                endAngle: Angle = .zero) {
        self.gradient = gradient
        self.center = center
        self.startAngle = startAngle
        self.endAngle = endAngle
    }

    public init(gradient: Gradient,
                center: UnitPoint,
                angle: Angle) {
        self.gradient = gradient
        self.center = center
        self.startAngle = angle
        self.endAngle = angle
    }
}

// MARK: - CustomStringConvertible

extension AngularGradient: CustomStringConvertible {
    public var description: String {
        "AngularGradient(gradient: \(gradient), center: \(center), startAngle: \(startAngle), endAngle: \(endAngle))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension AngularGradient: SwiftUI.View {
    public var body: some SwiftUI.View {
        SwiftUI.AngularGradient(
            gradient: gradient.swiftUIValue,
            center: center.unitPoint,
            startAngle: startAngle.swiftUIValue,
            endAngle: endAngle.swiftUIValue
        )
    }
}

#endif
