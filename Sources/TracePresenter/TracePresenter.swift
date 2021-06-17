
public struct TracePresenter: Plugin {

    public init() {}

    public var views: [_CodableView.Type] {
        [
            TraceGraph.self,
        ]
    }

}
