
internal struct Shadow: CodableViewModifier {

    // MARK: Stored Properties

    let color: ColorCode?
    let radius: CGFloat
    let x: CGFloat?
    let y: CGFloat?

}

// MARK: - CustomStringConvertible

extension Shadow: CustomStringConvertible {

    var description: String {
        if let color = color {
            return "shadow(color: \(color), radius: \(radius), x: \(x ?? 0), y: \(y ?? 0)"
        } else {
            return "shadow(radius: \(radius), x: \(x ?? 0), y: \(y ?? 0)"
        }
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Shadow: SwiftUI.ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        if let color = color {
            return content.shadow(color: color.color.body, radius: radius, x: x ?? 0, y: y ?? 0)
        } else {
            return content.shadow(radius: radius, x: x ?? 0, y: y ?? 0)
        }
    }
}

#endif

// MARK: - View Extensions

extension View {

    public func shadow(color: Color? = nil, radius: CGFloat, x: CGFloat? = nil, y: CGFloat? = nil) -> View {
        modifier(Shadow(color: color.map(ColorCode.init), radius: radius, x: x, y: y))
    }

}
