#if canImport(Charts)

extension Chart.Style {
    @SwiftUI.ViewBuilder
    func chart(for data: [[Double]]) -> some SwiftUI.View {
        switch self {
        case let .line(style):
            Charts.Chart(data: data)
                .chartStyle(style.chartsValue)
        case let .area(style):
            Charts.Chart(data: data)
                .chartStyle(style.chartsValue)
        case let .stackedArea(style):
            Charts.Chart(data: data)
                .chartStyle(style.chartsValue)
        case let .column(style):
            Charts.Chart(data: data)
                .chartStyle(style.chartsValue)
        }
    }

    private func chart<Style: ChartStyle>(data: [[Double]], style: Style) -> some SwiftUI.View {
        Charts.Chart(data: data)
            .chartStyle(style)
    }
}

extension Chart.ColumnStyle {
    fileprivate var chartsValue: ColumnChartStyle<AnyView> {
        .init(column: column.eraseToAnyView(), spacing: spacing)
    }
}

extension Chart.StackedAreaStyle {
    fileprivate var chartsValue: StackedAreaChartStyle {
        .init(lineType.chartsValue, colors: colors.map { $0.color.body })
    }
}


extension Chart.AreaStyle {
    fileprivate var chartsValue: AreaChartStyle<AnyView> {
        .init(lineType.chartsValue, fill: fill.eraseToAnyView())
    }
}

extension Chart.LineStyle {
    fileprivate var chartsValue: LineChartStyle {
        .init(lineType.chartsValue,
              lineColor: color.color.body,
              lineWidth: width)
    }
}

extension Chart.LineType {
    fileprivate var chartsValue: Charts.LineType {
        switch self {
        case .line:
            return .line
        case .quadCurve:
            return .quadCurve
        }
    }
}

#endif
