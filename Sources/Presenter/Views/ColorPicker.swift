
public struct ColorPicker: CodableWrapperView {

    // MARK: Stored Properties

    private let color: Binding<Color>
    private let supportsOpacity: Bool
    private let label: CoderView

    // MARK: Initialization

    public init(
        color: Binding<Color>,
        supportsOpacity: Bool,
        @ViewBuilder label: () -> View
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

    public var body: View {
        label.modifier(Modifier(color: color, supportsOpacity: supportsOpacity))
    }

    #else

    public var body: View {
        Nil()
    }

    #endif

}

private struct Modifier: ViewModifier, SwiftUI.ViewModifier {

    let color: Binding<Color>
    let supportsOpacity: Bool

    func body(content: Content) -> some SwiftUI.View {
        if #available(iOS 14.0, macOS 11.0, *) {
            ModelView { model in
                SwiftUI.ColorPicker(
                    selection: model.binding(for: color) { $0.body },
                    supportsOpacity: supportsOpacity) {
                    content
                }
            }
        }
    }

}

#endif
