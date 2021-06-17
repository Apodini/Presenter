
#if canImport(SwiftUI)

public struct ModelView<V: SwiftUI.View>: SwiftUI.View {

    // MARK: Stored Properties

    @EnvironmentObject var model: Model

    let create: (Model) -> V

    // MARK: Initialization

    public init(create: @escaping (Model) -> V) {
        self.create = create
    }

    // MARK: Views

    public var body: V {
        create(model)
    }

}

#endif
