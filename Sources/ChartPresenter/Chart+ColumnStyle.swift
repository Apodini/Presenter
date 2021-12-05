
extension Chart {

    public struct ColumnStyle: Codable {
        public internal(set) var column: CoderView
        public internal(set) var spacing: CGFloat

        public init<Column: View>(column: Column, spacing: CGFloat) {
            self.column = CoderView(column)
            self.spacing = spacing
        }
    }

}
