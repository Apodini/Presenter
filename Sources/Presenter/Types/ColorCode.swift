
public struct ColorCode: Codable {

    // MARK: Nested Types

    private enum Error: Swift.Error {
        case unknownFormat(String)
    }

    // MARK: Stored Properties

    public let color: Color

    // MARK: Initialization

    public init(_ color: Color) {
        self.color = color
    }

    public init(string: String) throws {
        guard string.count == 8 else {
            throw Error.unknownFormat(string)
        }

        let redEndIndex = string.index(string.startIndex, offsetBy: 2)
        let greenEndIndex = string.index(redEndIndex, offsetBy: 2)
        let blueEndIndex = string.index(greenEndIndex, offsetBy: 2)

        guard let red = Int(string[..<redEndIndex], radix: 16),
            let green = Int(string[redEndIndex..<greenEndIndex], radix: 16),
            let blue = Int(string[greenEndIndex..<blueEndIndex], radix: 16),
            let opacity = Int(string[blueEndIndex...], radix: 16) else {
                throw Error.unknownFormat(string)
        }

        self.color = Color(
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(opacity) / 255
        )
    }

    public init(from decoder: Decoder) throws {
        let string = try decoder.singleValueContainer()
            .decode(String.self)

        try self.init(string: string)
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }

}

// MARK: - CustomStringConvertible

extension ColorCode: CustomStringConvertible {

    public var description: String {
        fullHex()
    }

    private func fullHex() -> String {
        hex(of: color.red)
        + hex(of: color.green)
        + hex(of: color.blue)
        + hex(of: color.opacity)
    }

    private func hex(of color: Double) -> String {
        let value = Int(color * Double(UInt8.max))
        return String(format: "%02x", value)
    }

}
