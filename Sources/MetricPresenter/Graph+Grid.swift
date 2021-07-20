#if canImport(SwiftUI)

extension Graph {
    struct Grid {
        let axis: Axis
        let values: [CGFloat]
        let lineWidth: CGFloat
    }
}

extension Graph.Grid: SwiftUI.View {
    var body: some SwiftUI.View {
        GeometryReader { geometry in
            SwiftUI.ZStack(alignment: .topLeading) {
                ForEach(self.values, id: \.self) { value in
                    self.line
                    .offset(self.offset(at: value, size: geometry.size))
                }
            }
        }
    }

    // MARK: Helpers

    private var line: some SwiftUI.View {
        SwiftUI.Color.gray
        .frame(width: requiredWidth, height: requiredHeight)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }

    private func offset(at percentage: CGFloat, size: CGSize) -> CGSize {
        switch axis {
        case .vertical:
            return CGSize(width: percentage * size.width, height: 0)
        case .horizontal:
            return CGSize(width: 0, height: (1 - percentage) * size.height)
        }
    }

    private var requiredWidth: CGFloat? {
        axis == .vertical ? lineWidth : nil
    }

    private var requiredHeight: CGFloat? {
        axis == .horizontal ? lineWidth : nil
    }

    private var maxWidth: CGFloat? {
        axis == .horizontal ? .infinity : nil
    }

    private var maxHeight: CGFloat? {
        axis == .vertical ? .infinity : nil
    }
}

extension SwiftUI.View {
    public func graphGrid(vertical: [CGFloat] = [], horizontal: [CGFloat] = [], width: CGFloat = 8) -> some SwiftUI.View {
        SwiftUI.ZStack {
            Group {
                Graph.Grid(axis: .vertical, values: vertical, lineWidth: width)
                Graph.Grid(axis: .horizontal, values: horizontal, lineWidth: width)
            }

            self
        }
    }
}

#endif
