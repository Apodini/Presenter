
public struct SetAction<T: Codable>: Action {

    // MARK: Stored Properties

    private var key: String
    private var value: T

    // MARK: Initialization

    public init(key: String, to value: T) {
        self.key = key
        self.value = value
    }

    // MARK: Methods

    #if canImport(SwiftUI)

    public func perform(on model: Model) {
        model.state[key] = value
    }

    #endif

}
