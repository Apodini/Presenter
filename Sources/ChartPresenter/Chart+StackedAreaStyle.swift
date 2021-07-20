
extension Chart {

    public struct StackedAreaStyle: Codable {

        public internal(set) var lineType: LineType
        public internal(set) var colors: [ColorCode]

        public init(_ lineType: LineType, colors: [Color]) {
            self.lineType = lineType
            self.colors = colors.map(ColorCode.init)
        }

    }

}
