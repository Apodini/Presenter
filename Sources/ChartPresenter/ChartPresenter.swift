
public struct ChartPresenter: Plugin {

    public init() {}

    public var views: [_CodableView.Type] {
        [
            Chart.self,
        ]
    }

}
