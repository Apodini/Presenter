
public struct Spacer: SwiftUIView {

    // MARK: Stored Properties

    private let minLength: Value<CGFloat?>

    // MARK: Initialization

    public init(minLength: CGFloat? = nil) {
        self.init(minLength: .static(minLength))
    }

    public init(minLength: Value<CGFloat?>) {
        self.minLength = minLength
    }

}

// MARK: - CustomStringConvertible

extension Spacer: CustomStringConvertible {

    public var description: String {
        "Spacer(minLength: \(minLength))"
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension Spacer {

    public var view: some SwiftUI.View {
        ModelView { model in
            SwiftUI.Spacer(
                minLength: self.minLength.get(from: model)
            )
        }
    }

}

#endif
