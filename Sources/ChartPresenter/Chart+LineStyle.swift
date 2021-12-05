
extension Chart {

    public struct LineStyle: Codable {
        public internal(set) var lineType: LineType
        public internal(set) var color: ColorCode
        public internal(set) var width: CGFloat

        public init(_ lineType: LineType, color: Color, width: CGFloat) {
            self.lineType = lineType
            self.color = ColorCode(color)
            self.width = width
        }
    }

    public enum LineType: String, Codable {
        case line
        case quadCurve
    }

}
