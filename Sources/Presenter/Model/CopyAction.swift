
public struct CopyAction: Action {

    // MARK: Stored Properties

    private var from: String
    private var to: String

    // MARK: Initialization

    public init(from: String, to: String) {
        self.from = from
        self.to = to
    }

    // MARK: Methods

    #if canImport(SwiftUI)

    public func perform(on model: Model) {
        model.set(to, to: model.get(from))
    }

    #endif

}
