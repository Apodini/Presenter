public struct ComposedAction: Action {
    // MARK: Stored Properties

    fileprivate var actions: [CoderAction]

    // MARK: Initialization

    public init(_ actions: [Action]) {
        self.actions = actions.map(CoderAction.init)
    }

    // MARK: Methods

    #if canImport(SwiftUI)

    public func perform(on model: Model) {
        actions.forEach { $0.perform(on: model) }
    }

    #endif
}
