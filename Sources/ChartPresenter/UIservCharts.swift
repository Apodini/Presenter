public struct ChartPresenter: Plugin {
    public init() {}

    public var views: [CodableView.Type] {
        [
            Chart.self
        ]
    }
}
