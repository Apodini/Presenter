
public struct TraceGraph: SwiftUIView {

    // MARK: Stored Properties

    public var spans: [Span]

    // MARK: Initialization

    public init?(spans: [Span]) {
        let children = Dictionary(grouping: spans) { $0.parentService ?? "_" }
            .mapValues { Dictionary(grouping: $0) { $0.parentOperation ?? "_" } }

        guard let rootSpan = spans.first(where: { $0.parentService == nil }) else {
            return nil
        }

        self.spans = [rootSpan]
        var currentIndex = 0

        while currentIndex < self.spans.count {
            let currentSpan = spans[currentIndex]
            if let spanChildren = children[currentSpan.service]?[currentSpan.operation] {
                self.spans.append(contentsOf: spanChildren.sorted { $0.start < $1.start })
            }
            currentIndex += 1
        }
    }

}

extension TraceGraph {

    public struct Span: Codable {

        public let service: String
        public let operation: String

        public let start: CGFloat
        public let end: CGFloat

        public let parentService: String?
        public let parentOperation: String?

        public init(service: String,
                    operation: String,
                    start: CGFloat,
                    end: CGFloat,
                    parentService: String?,
                    parentOperation: String?    ) {
            self.service = service
            self.operation = operation
            self.start = start
            self.end = end
            self.parentService = parentService
            self.parentOperation = parentOperation
        }

    }

}

#if canImport(SwiftUI)

extension TraceGraph {

    public var view: some SwiftUI.View {
        SwiftUI.VStack {
            SwiftUI.ForEach(spans.indices) { index in
                SpanRow(span: spans[index])
                .frame(height: 8)
            }
        }
    }

    private struct SpanRow: SwiftUI.View {

        let span: Span

        var body: some SwiftUI.View {
            GeometryReader { geometry in
                SwiftUI.Capsule()
                .frame(width: (span.end - span.start) * geometry.size.width,
                       height: geometry.size.width,
                       alignment: .leading)
                .offset(x: span.start)
            }
        }

    }

}

#endif
