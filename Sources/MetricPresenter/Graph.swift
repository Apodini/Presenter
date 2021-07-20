public struct Graph: CodableView {
    // MARK: Nested Types

    public struct Label: Codable {
        // MARK: Stored Properties

        public var text: String
        public var value: CGFloat

        // MARK: Initialization

        public init(text: String, value: CGFloat) {
            self.text = text
            self.value = value
        }
    }

    public enum Edge: String, Codable {
        case top = "t"
        case trailing = "r"
        case bottom = "b"
        case leading = "l"
    }

    public struct DataSet: Codable {
        // MARK: Stored Properties

        public var title: String
        public var color: ColorCode?
        public var data: [Double]
        public var style: Chart.Style

        // MARK: Initialization

        public init(title: String, color: ColorCode? = nil, data: [Double], style: Chart.Style) {
            self.title = title
            self.color = color
            self.data = data
            self.style = style
        }
    }

    // MARK: Stored Properties

    public var labels: [Edge: [Label]]
    public var data: [DataSet]
    public var gridWidth: CGFloat

    // MARK: Initialization

    public init(
        topLabels: [Graph.Label]? = nil,
        trailingLabels: [Graph.Label]? = nil,
        bottomLabels: [Graph.Label]? = nil,
        leadingLabels: [Graph.Label]? = nil,
        data: [Graph.DataSet],
        gridWidth: CGFloat
    ) {
        self.labels = [
            .top: topLabels,
            .trailing: trailingLabels,
            .bottom: bottomLabels,
            .leading: leadingLabels
        ]
        .compactMapValues { ($0 ?? []).isEmpty ? nil : $0 }

        self.data = data
        self.gridWidth = gridWidth
    }
}

#if canImport(SwiftUI)

extension Graph.Label: Identifiable {
    public var id: CGFloat {
        value
    }
}

extension Graph.DataSet: Identifiable {
    public var id: String {
        title
    }
}

extension Graph.DataSet {
    public var chart: Chart {
        Chart(data: data, style: style)
    }
}

extension Graph: SwiftUI.View {
    public var body: some SwiftUI.View {
        content
        .graphGrid(
            vertical: verticalGridValues,
            horizontal: horizontalGridValues,
            width: gridWidth
        )
        .graphLabeling(
            top: labels[.top] ?? [],
            trailing: labels[.trailing] ?? [],
            bottom: labels[.bottom] ?? [],
            leading: labels[.leading] ?? []
        )
    }

    private var horizontalGridValues: [CGFloat] {
        let horizontalLabels = (labels[.leading] ?? []) + (labels[.trailing] ?? [])
        return Set(horizontalLabels.map { $0.value }).sorted()
    }

    private var verticalGridValues: [CGFloat] {
        let verticalLabels = (labels[.top] ?? []) + (labels[.bottom] ?? [])
        return Set(verticalLabels.map { $0.value }).sorted()
    }

    private var content: some SwiftUI.View {
        SwiftUI.ZStack {
            ForEach(data) { $0.chart.body }
        }
    }
}

#endif
