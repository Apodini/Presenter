
public struct Capsule: SwiftUIView {

    // MARK: Stored Properties

    private let style: RoundedCornerStyle

    // MARK: Initialization

    public init(style: RoundedCornerStyle) {
        self.style = style
    }

}

// MARK: - CustomStringConvertible

extension Capsule: CustomStringConvertible {

    public var description: String {
        "Capsule(style: \(style))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Capsule {

    public var view: some SwiftUI.View {
        SwiftUI.Capsule(style: style.swiftUIValue)
    }

}

#endif
