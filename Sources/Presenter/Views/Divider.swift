
public struct Divider: SwiftUIView {

    // MARK: Initialization

    public init() {}

}

// MARK: - CustomStringConvertible

extension Divider: CustomStringConvertible {

    public var description: String {
        "Divider()"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Divider {

    public var view: some SwiftUI.View {
        SwiftUI.Divider()
    }

}

#endif
