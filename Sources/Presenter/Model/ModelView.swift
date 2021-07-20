#if canImport(SwiftUI)

public struct ModelView<Body: SwiftUI.View>: SwiftUI.View {
    // MARK: Stored Properties

    @EnvironmentObject var model: Model

    let create: (Model) -> Body

    // MARK: Initialization

    public init(@SwiftUI.ViewBuilder create: @escaping (Model) -> Body) {
        self.create = create
    }

    // MARK: Views

    public var body: Body {
        create(model)
    }
}

#endif
