
extension Chart {

    public struct AreaStyle: Codable {
        public internal(set) var lineType: LineType
        public internal(set) var fill: CoderView

        public init<Fill: View>(_ lineType: LineType, fill: Fill) {
            self.lineType = lineType
            self.fill = CoderView(fill)
        }
    }

}
