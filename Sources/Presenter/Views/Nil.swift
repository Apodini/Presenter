
extension Optional: InternalView, View, _View, NamedType where Wrapped: _CodableView {

    #if canImport(SwiftUI)

    public var view: _View {
        self ?? Nil()
    }

    #endif

}

struct Nil: InternalView, Codable {

    // MARK: Initialization

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard container.decodeNil() else {
            throw DecodingError
                .typeMismatch(
                    Nil.self,
                    .init(codingPath: decoder.codingPath,
                          debugDescription: "Could not decode nil from decoder.")
            )
        }
    }

    // MARK: Methods

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }

    #if canImport(SwiftUI)

    public var view: _View {
        EmptyView()
    }

    #endif

}

#if canImport(SwiftUI)

extension SwiftUI.EmptyView: _View {

    public var erasedCodableBody: _CodableView? {
        nil
    }

    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    public func apply<M: ViewModifier>(_ m: M) -> _View {
        modifier(m)
    }

    public func apply(_ modifier: AnyViewModifying) -> _View {
        modifier.apply(to: self)
    }

}

#endif

// MARK: - CustomStringConvertible

extension Nil: CustomStringConvertible {

    var description: String {
        "nil"
    }

}
