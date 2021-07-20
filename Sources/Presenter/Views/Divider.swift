
public struct Divider: CodableView {

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

extension Divider: SwiftUI.View {

    public var body: some SwiftUI.View {
        SwiftUI.Divider()
    }

}

#endif
