
public struct Gradient: Codable {

    // MARK: Nested Types

    public struct Stop: Codable {

        // MARK: Stored Properties

        public var colorCode: ColorCode
        public var location: CGFloat

        // MARK: Computed Properties

        public var color: Color {
            get {
                colorCode.color
            }
            set {
                colorCode = .init(newValue)
            }
        }

        // MARK: Initialization

        public init(color: Color, location: CGFloat) {
            self.colorCode = ColorCode(color)
            self.location = location
        }

    }

    // MARK: Stored Properties

    public var stops: [Stop]

    // MARK: Initialization

    public init(colors: [Color]) {
        self.stops = colors.indices.map { index in
            Stop(color: colors[index], location: CGFloat(index) / CGFloat(colors.count - 1))
        }
    }

    public init(stops: [Stop]) {
        self.stops = stops
    }

}

#if canImport(SwiftUI)

extension Gradient {

    var swiftUIValue: SwiftUI.Gradient {
        .init(stops: stops.map(\.swiftUIValue))
    }

}

extension Gradient.Stop {

    var swiftUIValue: SwiftUI.Gradient.Stop {
        .init(color: color.view, location: location)
    }

}

#endif
