
extension Chart {

    public struct ColumnStyle: Codable {

        public internal(set) var column: CoderView
        public internal(set) var spacing: CGFloat

        public init(column: View, spacing: CGFloat) {
            self.column = CoderView(column)
            self.spacing = spacing
        }

    }

}
