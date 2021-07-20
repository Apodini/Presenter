public struct Value<Content: Codable>: Codable {
    // MARK: Stored Properties

    let key: String?
    let `default`: Content

    // MARK: Methods

    #if canImport(SwiftUI)

    public func get(from model: Model) -> Content {
        key.flatMap { model.get($0) as? Content } ?? self.default
    }

    #endif

    // MARK: Factory Methods

    public static func `static`(_ value: Content) -> Self {
        .init(key: nil, default: value)
    }

    public static func at(_ key: String, default value: Content) -> Self {
        .init(key: key, default: value)
    }
}
