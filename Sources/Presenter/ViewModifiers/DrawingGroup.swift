
public enum ColorRenderingMode: String, Codable {
    case extendedLinear
    case linear
    case nonLinear
}

internal struct DrawingGroup: AnyViewModifying {

    // MARK: Stored Properties

    let opaque: Bool?
    let colorMode: ColorRenderingMode?

}

// MARK: - CustomStringConvertible

extension DrawingGroup: CustomStringConvertible {

    var description: String {
        "drawingGroup(opaque: \(opaque ?? true), colorMode: \(colorMode ?? .nonLinear))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension DrawingGroup: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.drawingGroup(opaque: opaque ?? false,
                             colorMode: colorMode?.swiftUIValue ?? .nonLinear)
    }

}

extension ColorRenderingMode {

    var swiftUIValue: SwiftUI.ColorRenderingMode {
        switch self {
        case .extendedLinear:
            return .extendedLinear
        case .linear:
            return .linear
        case .nonLinear:
            return .nonLinear
        }
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func drawingGroup(opaque: Bool? = nil, colorMode: ColorRenderingMode? = nil) -> some View {
        modified(using: DrawingGroup(opaque: opaque, colorMode: colorMode))
    }

}
