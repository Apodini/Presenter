public struct CopyAction: Action {
    // MARK: Stored Properties

    private let fromKey: String
    private let toKey: String

    // MARK: Initialization

    public init(from fromKey: String, to toKey: String) {
        self.fromKey = fromKey
        self.toKey = toKey
    }

    // MARK: Methods

    #if canImport(SwiftUI)

    public func perform(on model: Model) {
        model.set(toKey, to: model.get(fromKey))
    }

    #endif
}
