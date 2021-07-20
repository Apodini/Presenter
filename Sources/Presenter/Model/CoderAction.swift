public struct CoderAction {
    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case type
    }

    private enum Error: Swift.Error {
        case unregisteredType(String)
        case unexpectedType(Action.Type, expected: Action.Type)
    }

    // MARK: Stored Properties

    let element: Action

    // MARK: Initialization

    public init(_ element: Action) {
        self.element = element
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .type)

        guard let coder = Self.registeredTypes[type] else {
            throw Error.unregisteredType(type)
        }

        self.element = try coder.decode(decoder)
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        let typeDescription = Swift.type(of: element).type

        guard let coder = Self.registeredTypes[typeDescription] else {
            throw Error.unregisteredType(typeDescription)
        }

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(typeDescription, forKey: .type)
        try coder.encode(element, encoder)
    }
}

// MARK: - Registration

extension CoderAction {
    // MARK: Nested Types

    private struct Coder {
        var decode: (Decoder) throws -> Action
        var encode: (Action, Encoder) throws -> Void
    }

    // MARK: Static Properties

    // swiftlint:disable:next discouraged_optional_collection
    private static var _registeredTypes: [String: Coder]?

    private static var registeredTypes: [String: Coder] {
        get {
            if let types = _registeredTypes {
                return types
            }
            _registeredTypes = [:]
            Presenter.usePlugins()
            return _registeredTypes ?? [:]
        }
        set {
            _registeredTypes = newValue
        }
    }

    // MARK: Static Functions

    internal static func register<A: Action>(_: A.Type) {
        let coder = Coder(
            decode: { decoder in try A(from: decoder) },
            encode: { action, encoder in
                guard let actionAction = action as? A else {
                    throw Error.unexpectedType(Swift.type(of: action), expected: A.self)
                }
                try actionAction.encode(to: encoder)
            }
        )
        registeredTypes.updateValue(coder, forKey: A.type)
    }

    internal static func unregister<A: Action>(_: A.Type) {
        registeredTypes.removeValue(forKey: A.type)
    }
}

// MARK: - ModelAction

extension CoderAction: Action {
    #if canImport(SwiftUI)

    public func perform(on model: Model) {
        element.perform(on: model)
    }

    #endif
}
