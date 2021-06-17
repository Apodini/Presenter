
public struct Circle: SwiftUIView {

    // MARK: Initialization

    public init() {}

}

// MARK: - CustomStringConvertible

extension Circle: CustomStringConvertible {

    public var description: String {
        "Circle()"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Circle {

    public var view: some SwiftUI.View {
        SwiftUI.Circle()
    }

}

#endif
