
#if canImport(Charts)

extension Chart.Style {

    func chart(for data: [[Double]]) -> AnyView {
        switch self {
        case let .line(style):
            return chart(data: data, style: style.chartsValue)
        case let .area(style):
            return chart(data: data, style: style.chartsValue)
        case let .stackedArea(style):
            return chart(data: data, style: style.chartsValue)
        case let .column(style):
            return chart(data: data, style: style.chartsValue)
        }
    }

    private func chart<Style: ChartStyle>(data: [[Double]], style: Style) -> AnyView {
        Charts.Chart(data: data)
        .chartStyle(style)
        .eraseToAnyView()
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

extension SwiftUI.View {

    fileprivate func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

}

#endif
