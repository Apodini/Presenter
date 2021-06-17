
public struct CoderView: Codable {

    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case type
        case modifiers
    }

    private enum Error: Swift.Error {
        case unregisteredType(String)
        case unexpectedType(_View.Type, expected: _View.Type)
    }

    // MARK: Stored Properties

    public let element: _View

    // MARK: Initialization

    public init(_ element: _CodableView) {
        if let body = element.erasedCodableBody,
           Self.registeredTypes[Swift.type(of: element).type] == nil {
            self.init(body)
        } else {
            self.init(last: element)
        }
    }

    private init(last element: _CodableView) {
        self.element = element
    }

    public init(from decoder: Decoder) throws {
        if let singleValueContainer = try? decoder.singleValueContainer() {
            guard !singleValueContainer.decodeNil() else {
                self.element = Nil()
                return
            }
        }

        if var unkeyedContainer = try? decoder.unkeyedContainer() {
            var content = [CoderView]()
            while !unkeyedContainer.isAtEnd {
                content.append(try unkeyedContainer.decode(CoderView.self))
            }
            self.element = ArrayView(content: content)
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
            self.element = ComposedView(content: CoderView(element as! _CodableView), modifiers: modifiers)
        } else {
            self.element = element
        }
    }

    // MARK: Methods

    public func encode(to encoder: Encoder) throws {
        let typeDescription = Swift.type(of: element).type

        if let arrayView = element as? ArrayView {
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

        if let composedView = element as? ComposedView {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(composedView.modifiers, forKey: .modifiers)
            try composedView.content.encode(to: encoder)
        } else {
            try coder.encode(element, encoder)
        }
    }

}

// MARK: - View Registration

extension CoderView {

    // MARK: Nested Types

    private struct Coder {
        var isOptional: Bool
        var decode: (Decoder) throws -> _View
        var encode: (_View, Encoder) throws -> Void
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

    internal static func register<View: _CodableView>(_: View.Type) {
        let isOptional = View.type.hasPrefix("Optional<")
        if !isOptional {
            register(Optional<View>.self)
        }
        let coder = Coder(
            isOptional: isOptional,
            decode: { decoder in try View(from: decoder) },
            encode: { view, encoder in
                guard let viewView = view as? View else {
                    throw Error.unexpectedType(Swift.type(of: view), expected: View.self)
                }
                try viewView.encode(to: encoder)
            }
        )
        registeredTypes.updateValue(coder, forKey: View.type)
    }

    internal static func unregister<View: _CodableView>(_: View.Type) {
        registeredTypes.removeValue(forKey: View.type)
    }

}

// MARK: - CustomStringConvertible

extension CoderView: CustomStringConvertible {

    public var description: String {
        "\(element)"
    }

}

// MARK: - InternalView

extension CoderView: InternalView {

    #if canImport(SwiftUI)

    public var view: _View {
        element
    }

    #endif

}
