public struct Slider: CodableView {
    // MARK: Stored Properties

    private let value: Binding<CGFloat>
    private let minValue: CGFloat
    private let maxValue: CGFloat
    private let onEditingChanged: CoderAction?

    // MARK: Initialization

    public init(value: Binding<CGFloat>,
                in range: ClosedRange<CGFloat>,
                onEditingChanged: Action?) {
        self.value = value
        self.minValue = range.lowerBound
        self.maxValue = range.upperBound
        self.onEditingChanged = onEditingChanged.map(CoderAction.init)
    }
}

// MARK: - CustomStringConvertible

extension Slider: CustomStringConvertible {
    public var description: String {
        "Slider(value: \(value), in: \(minValue...maxValue))"
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension Slider: SwiftUI.View {
    #if os(tvOS)

    public var body: some SwiftUI.View {
        SwiftUI.EmptyView()
    }

    #else

    public var body: some SwiftUI.View {
        ModelView { model in
            SwiftUI.Slider(
                value: model.binding(for: self.value),
                in: self.minValue...self.maxValue,
                onEditingChanged: model.action(for: self.onEditingChanged)
            )
        }
    }

    #endif
}

#endif
