public struct TracePresenter: Plugin {
    public init() {}

    public var views: [CodableView.Type] {
        [
            TraceGraph.self
        ]
    }
}
