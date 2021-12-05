@propertyWrapper
public struct Binding<Content: Codable>: Codable {
    // MARK: Stored Properties

    let key: String
    let `default`: Content

    // MARK: Computed Properties

    public var wrappedValue: Value<Content> {
        .init(key: key, default: self.default)
    }

    // MARK: Factory Methods

    public static func at(_ key: String, default value: Content) -> Self {
        .init(key: key, default: value)
    }
}
