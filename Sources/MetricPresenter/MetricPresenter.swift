public struct MetricPresenter: Plugin {
    public init() {}

    public var views: [CodableView.Type] {
        [
            Graph.self
        ]
    }

    public var viewModifiers: [CodableViewModifier.Type] {
        [
            GaugeModifier.self,
            MetricCard.self,
            Card.self
        ]
    }

    public var plugins: [Plugin.Type] {
        [
            ChartPresenter.self
        ]
    }
}
