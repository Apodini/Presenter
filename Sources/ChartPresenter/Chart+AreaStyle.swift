extension Chart {
    public struct AreaStyle: Codable {
        public internal(set) var lineType: LineType
        public internal(set) var fill: CoderView

        public init(_ lineType: LineType, fill: View) {
            self.lineType = lineType
            self.fill = CoderView(fill)
        }
    }
}
