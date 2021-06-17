
public struct Color: SwiftUIView {

    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case code
    }

    // MARK: Stored Properties

    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double

    // MARK: Initialization

    public init(red: Double, green: Double, blue: Double, opacity: Double = 1) {
        precondition((0...1).contains(red))
        precondition((0...1).contains(green))
        precondition((0...1).contains(blue))
        precondition((0...1).contains(opacity))

        self.red = red
        self.blue = blue
        self.green = green
        self.opacity = opacity
    }

    public init(from decoder: Decoder) throws {
        let string = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .code)

        self = try ColorCode(string: string).color
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ColorCode(self).description, forKey: .code)
    }

}

// MARK: - CustomStringConvertible

extension Color: CustomStringConvertible {

    public var description: String {
        "Color(\(ColorCode(self))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Color {

    public var view: SwiftUI.Color {
        SwiftUI.Color(red: red, green: green, blue: blue, opacity: opacity)
    }

}

#endif
