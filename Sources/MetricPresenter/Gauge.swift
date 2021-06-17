
public struct Gauge: View {

    // MARK: Stored Properties

    private let value: CGFloat
    private let thickness: CGFloat
    private let scale: CGFloat
    private let colors: [ColorCode]
    private let content: CoderView

    // MARK: Initialization

    public init<Content: View>(
        value: CGFloat,
        thickness: CGFloat = 6,
        scale: CGFloat = 1.777,
        colors: [ColorCode],
        @ViewBuilder content: () -> Content
    ) {
        self.value = value
        self.thickness = thickness
        self.scale = scale
        self.colors = colors
        self.content = CoderView(content())
    }

    // MARK: Views

    public var body: some View {
        content
            .modified(using:
                GaugeModifier(
                    value: value,
                    thickness: thickness,
                    scale: scale,
                    colors: colors
                )
            )
    }

}

struct GaugeModifier: AnyViewModifying {

    var value: CGFloat
    var thickness: CGFloat
    var scale: CGFloat
    var colors: [ColorCode]

}

#if canImport(SwiftUI)

private struct GaugeView<Content: SwiftUI.View>: SwiftUI.View {

    // MARK: Stored Properties

    let gauge: GaugeModifier
    let content: Content

    // MARK: Computed Properties

    var gradient: SwiftUI.AngularGradient {
        .init(
            gradient: .init(colors: gauge.colors.map { $0.color.view }),
            center: .center,
            startAngle: .degrees(0),
            endAngle: .degrees(270)
        )
    }

    var circleOffset: CGSize {
        let ratio = -(gauge.value * 0.75) * 2 * .pi + CGFloat.pi / 2
        let radius = diameter / 2 - gauge.thickness / 2
        return CGSize(width: sin(ratio) * radius,
                      height: cos(ratio) * radius)
    }

    // MARK: State

    @SwiftUI.State private var diameter = CGFloat.zero

    // MARK: Views

    var body: some SwiftUI.View {
        SwiftUI.ZStack {
            content
            .size(in: GaugeSizePreferenceKey.self)

            SwiftUI.ZStack {
                SwiftUI.Circle()
                .trim(from: 0, to: 0.75)
                .stroke(gradient, style: .init(lineWidth: gauge.thickness, lineCap: .round))

                SwiftUI.Circle()
                .stroke(SwiftUI.Color.white, style: .init(lineWidth: gauge.thickness / 2))
                .frame(width: gauge.thickness * 1.5, height: gauge.thickness * 1.5)
                .offset(circleOffset)
            }
            .padding(gauge.thickness / 2)
            .rotationEffect(.degrees(135))
            .frame(width: diameter, height: diameter)
        }
        .onPreferenceChange(GaugeSizePreferenceKey.self) { size in
            self.diameter = size.width * self.gauge.scale
        }
        .foregroundColor(SwiftUI.Color.black)
    }

}

extension GaugeModifier: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        GaugeView(gauge: self, content: content)
    }

}

private struct GaugeSizePreferenceKey: SizePreferenceKey {}

#endif
