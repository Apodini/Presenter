
public struct CoderViewModifier: Codable, AnyViewModifying {

    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case type
        case modifiers
    }

    private enum Error: Swift.Error {
        case unregisteredType(String)
        case unexpectedType(AnyViewModifying.Type, expected: AnyViewModifying.Type)
    }

    // MARK: Stored Properties

    let element: AnyViewModifying

    // MARK: Initialization

    internal init(_ element: AnyViewModifying) {
        self.element = element
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .type)

        guard let coder = CoderViewModifier.registeredTypes[type] else {
            throw Error.unregisteredType(type)
        }

        self.element = try coder.decode(decoder)
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        let typeDescription = Swift.type(of: element).type
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(typeDescription, forKey: .type)
        guard let coder = CoderViewModifier.registeredTypes[typeDescription] else {
            throw Error.unregisteredType(typeDescription)
        }
        try coder.encode(element, encoder)
    }

}

// MARK: - CustomStringConvertible

extension CoderViewModifier: CustomStringConvertible {

    public var description: String {
        "\(element)"
    }

}

// MARK: - Registration

extension CoderViewModifier {

    // MARK: Nested Types

    private struct Coder {
        var decode: (Decoder) throws -> AnyViewModifying
        var encode: (AnyViewModifying, Encoder) throws -> Void
    }

    // MARK: Static Properties

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

    public static func register<Modifier: AnyViewModifying>(_: Modifier.Type) {
        let coder = Coder(
            decode: { decoder in try Modifier(from: decoder) },
            encode: { modifier, encoder in
                guard let modifierModifier = modifier as? Modifier else {
                    throw Error.unexpectedType(Swift.type(of: modifier), expected: Modifier.self)
                }
                try modifierModifier.encode(to: encoder)
            }
        )
        registeredTypes.updateValue(coder, forKey: Modifier.type)
    }

    public static func unregister<Modifier: AnyViewModifying>(_: Modifier.Type) {
        registeredTypes.removeValue(forKey: Modifier.type)
    }

}

// MARK: - AnyViewModifying

#if canImport(SwiftUI)

extension CoderViewModifier {

    public func apply<V: SwiftUI.View>(to view: V) -> _View {
        element.apply(to: view)
    }

}

#endif

