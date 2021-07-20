
#if canImport(SwiftUI)

extension Graph {

    struct Labeling {

        // MARK: Stored Properties

        var top: [Graph.Label]
        var trailing: [Graph.Label]
        var bottom: [Graph.Label]
        var leading: [Graph.Label]

        var spacing: CGFloat
        var borderWidth: CGFloat

    }

}

extension Graph.Labeling: SwiftUI.ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        GeometryReader { geometry in
            SwiftUI.HStack(spacing: 0) {
                self.horizontalLabels(isLeading: true, size: geometry.size)
                SwiftUI.VStack(spacing: 0) {
                    self.verticalLabels(isTop: true, size: geometry.size)
                    content
                    self.verticalLabels(isTop: false, size: geometry.size)
                }
                self.horizontalLabels(isLeading: false, size: geometry.size)
            }
        }
    }

    // MARK: Helpers

    private func horizontalLabels(isLeading: Bool, size: CGSize) -> some SwiftUI.View {
        labeling(isLeading ? leading : trailing,
                 at: isLeading ? .leading : .trailing)
        .frame(width: borderWidth,
               height: size.height - (spacing + borderWidth) * 2)
        .padding(isLeading ? .trailing : .leading, spacing)
    }

    private func verticalLabels(isTop: Bool, size: CGSize) -> some SwiftUI.View {
        labeling(isTop ? top : bottom,
                 at: isTop ? .top : .bottom)
        .frame(width: size.width - (spacing + borderWidth) * 2,
               height: borderWidth)
        .padding(isTop ? .bottom : .top, spacing)
    }

    private func labeling(_ labels: [Graph.Label], at edge: Graph.Edge) -> some SwiftUI.View {
        Group {
            if labels.isEmpty {
                SwiftUI.Color.clear
            } else {
                Graph.LabelingEdge(labels: labels, edge: edge)
            }
        }
    }

}

extension SwiftUI.View {

    public func graphLabeling(
        top: [Graph.Label] = [],
        trailing: [Graph.Label] = [],
        bottom: [Graph.Label] = [],
        leading: [Graph.Label] = [],
        spacing: CGFloat = 6,
        borderWidth: CGFloat = 36
    ) -> some SwiftUI.View {

        modifier(
            Graph.Labeling(
                top: top,
                trailing: trailing,
                bottom: bottom,
                leading: leading,
                spacing: spacing,
                borderWidth: borderWidth
            )
        )
    }

}

#endif
