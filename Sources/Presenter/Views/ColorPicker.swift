
public struct ColorPicker: SwiftUIView {

    // MARK: Stored Properties

    private let color:  Binding<Color>
    private let supportsOpacity: Bool
    private let label: CoderView

    // MARK: Initialization

    public init<Label: View>(
        color: Binding<Color>,
        supportsOpacity: Bool,
        @ViewBuilder label: () -> Label
    ) {
        self.color = color
        self.supportsOpacity = supportsOpacity
        self.label = CoderView(label())
    }

}

// MARK: - CustomStringConvertible

extension ColorPicker: CustomStringConvertible {

    public var description: String {
        "ColorPicker(color: \(color), supportsOpacity: \(supportsOpacity), label: \(label))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension ColorPicker {

    #if !os(macOS) && !os(tvOS) && !os(watchOS) && !targetEnvironment(macCatalyst)

    @SwiftUI.ViewBuilder
    public var view: some SwiftUI.View {
        if #available(iOS 14.0, *) {
            ModelView { model in
                SwiftUI.ColorPicker(
                    selection: model.binding(for: color) { $0.view },
                    supportsOpacity: supportsOpacity) {
                    label.eraseToAnyView()
                }
            }
        } else {
            SwiftUI.EmptyView()
        }
    }

    #else

    public var view: some SwiftUI.View {
        SwiftUI.EmptyView()
    }

    #endif

}

#endif
