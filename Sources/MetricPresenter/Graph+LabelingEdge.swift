
#if canImport(SwiftUI)

extension Graph.Edge {

    var axis: Axis {
        switch self {
        case .top, .bottom:
            return .horizontal
        case .leading, .trailing:
            return .vertical
        }
    }

    var alignment: SwiftUI.Alignment {
        switch self {
        case .top, .bottom:
            return .center
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        }
    }

}

extension Graph {

    struct LabelingEdge {

        var labels: [Graph.Label]
        var edge: Graph.Edge

    }

}

extension Graph.LabelingEdge: SwiftUI.View {

    var body: some SwiftUI.View {
        GeometryReader { geometry in
            SwiftUI.ZStack(alignment: self.edge.alignment) {
                ForEach(self.labels) { label in
                    SwiftUI.Text(label.text)
                    .offset(self.offset(value: label.value, size: geometry.size))
                }
            }
        }
        .font(.caption)
    }

    private func offset(value: CGFloat, size: CGSize) -> CGSize {
        switch edge.axis {
        case .vertical:
            return CGSize(width: 0, height: (1 - value) * size.height)
        case .horizontal:
            return CGSize(width: value * size.width, height: 0)
        }
    }

}

#endif
