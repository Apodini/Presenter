public struct Angle {
    // MARK: Stored Properties

    public var radians: Double

    // MARK: Computed Properties

    public var degrees: Double {
        get {
            radians * 180 / .pi
        }
        set {
            radians = newValue * .pi / 180
        }
    }

    // MARK: Initialization

    public init(radians: Double) {
        self.radians = radians
    }

    public init(degrees: Double) {
        self.radians = degrees * .pi / 180
    }

    // MARK: Static Properties

    public static var zero: Angle {
        .init(radians: 0)
    }
}

extension Angle: Codable {
    public init(from decoder: Decoder) throws {
        self.init(radians: try .init(from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try radians.encode(to: encoder)
    }
}

#if canImport(SwiftUI)

extension Angle {
    var swiftUIValue: SwiftUI.Angle {
        .init(radians: radians)
    }
}

#endif
