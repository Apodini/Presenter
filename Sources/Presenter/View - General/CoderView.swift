
public struct CoderView: CodableView {

    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case type
        case modifiers
    }

    private enum Error: Swift.Error {
        case unregisteredType(String)
        case unexpectedType(View.Type, expected: View.Type)
    }

    // MARK: Stored Properties

    public let body: View

    // MARK: Initialization

    public init(_ element: View) {
        if let coderView = element as? CoderView {
            self.init(coderView.body)
        } else if Self.registeredTypes[Swift.type(of: element).type] == nil,
           let userView = element as? UserView {
            self.init(userView.body)
        } else {
            self.init(last: element)
        }
    }

    private init(last element: View) {
        self.body = element
    }

    public init(from decoder: Decoder) throws {
        if let singleValueContainer = try? decoder.singleValueContainer() {
            guard !singleValueContainer.decodeNil() else {
                self.body = Nil()
                return
            }
        }

        if var unkeyedContainer = try? decoder.unkeyedContainer() {
            var content = [CoderView]()
            while !unkeyedContainer.isAtEnd {
                content.append(try unkeyedContainer.decode(CoderView.self))
            }
            self.body = ArrayView(content: content)
            return
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        guard let coder = CoderView.registeredTypes[type] else {
            throw Error.unregisteredType(type)
        }

        let element = try coder.decode(decoder)

        if container.contains(.modifiers) {
            let modifiers = try container.decode([CoderViewModifier].self, forKey: .modifiers)
            self.body = ComposedView(content: CoderView(element), modifiers: modifiers)
        } else {
            self.body = element
        }
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        let typeDescription = Swift.type(of: body).type

        if let arrayView = body as? ArrayView {
            var container = encoder.unkeyedContainer()
            for content in arrayView.content {
                try container.encode(content)
            }
            return
        }

        guard let coder = CoderView.registeredTypes[typeDescription] else {
            throw Error.unregisteredType(typeDescription)
        }

        if !coder.isOptional {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(typeDescription, forKey: .type)
        }

        if let composedView = body as? ComposedView {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(composedView.modifiers, forKey: .modifiers)
            try composedView.content.encode(to: encoder)
        } else {
            try coder.encode(body, encoder)
        }
    }

}

// MARK: - View Registration

extension CoderView {

    // MARK: Nested Types

    private struct Coder {
        var isOptional: Bool
        var decode: (Decoder) throws -> View
        var encode: (View, Encoder) throws -> Void
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

    internal static func register<V: CodableView>(_: V.Type) {
        let isOptional = V.type.hasPrefix("Optional<")
        if !isOptional {
            register(Optional<V>.self)
        }
        let coder = Coder(
            isOptional: isOptional,
            decode: { decoder in try V(from: decoder) },
            encode: { view, encoder in
                guard let viewView = view as? V else {
                    throw Error.unexpectedType(Swift.type(of: view), expected: V.self)
                }
                try viewView.encode(to: encoder)
            }
        )
        registeredTypes.updateValue(coder, forKey: V.type)
    }

    internal static func unregister<V: CodableView>(_: V.Type) {
        registeredTypes.removeValue(forKey: V.type)
    }

}

// MARK: - CustomStringConvertible

extension CoderView: CustomStringConvertible {

    public var description: String {
        "\(body)"
    }

}

#if canImport(SwiftUI)

extension CoderView {

    public func eraseToAnyView() -> AnyView {
        body.eraseToAnyView()
    }

    public func apply<Modifier: ViewModifier>(_ modifier: Modifier) -> View {
        body.apply(modifier)
    }

}

#endif
