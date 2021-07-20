public struct CoderViewModifier: CodableViewModifier {
    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case type
        case modifiers
    }

    private enum Error: Swift.Error {
        case unregisteredType(String)
        case unexpectedType(ViewModifier.Type, expected: ViewModifier.Type)
    }

    // MARK: Stored Properties

    let element: ViewModifier

    // MARK: Initialization

    internal init(_ element: ViewModifier) {
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
        var decode: (Decoder) throws -> ViewModifier
        var encode: (ViewModifier, Encoder) throws -> Void
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

    public static func register<Modifier: CodableViewModifier>(_: Modifier.Type) {
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

    public static func unregister<Modifier: CodableViewModifier>(_: Modifier.Type) {
        registeredTypes.removeValue(forKey: Modifier.type)
    }
}

// MARK: - AnyViewModifying

#if canImport(SwiftUI)

extension CoderViewModifier {
    public func body<Content: SwiftUI.View>(for content: Content) -> View {
        element.body(for: content)
    }
}

#endif
