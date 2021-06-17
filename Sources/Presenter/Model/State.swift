
@propertyWrapper
public struct State<Content: Codable>: Codable {

    // MARK: Stored Properties

    private let `default`: Content
    private let key: String

    // MARK: Computed Properties

    public var wrappedValue: Value<Content> {
        .at(key, default: self.default)
    }

    public var projectedValue: Binding<Content> {
        .at(key, default: self.default)
    }

    // MARK: Initialization

    public init(_ key: String, default value: Content) {
        self.key = key
        self.default = value
    }

}
