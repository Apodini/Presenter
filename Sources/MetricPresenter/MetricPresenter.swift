
public struct MetricPresenter: Plugin {

    public init() {}

    public var views: [_CodableView.Type] {
        [
            Graph.self,
        ]
    }

    public var viewModifiers: [AnyViewModifying.Type] {
        [
            GaugeModifier.self,
            MetricCard.self,
            Card.self,
        ]
    }

    public var plugins: [Plugin.Type] {
        [
            ChartPresenter.self,
        ]
    }

}
