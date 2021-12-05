extension Optional: View, NamedType, WrapperView where Wrapped: CodableView {
    #if canImport(SwiftUI)

    public var body: View {
        switch self {
        case let .some(view):
            return view
        case .none:
            return Nil()
        }
    }

    #endif
}

struct Nil: CodableView {
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
}

#if canImport(SwiftUI)

extension Nil: SwiftUI.View {
    public var body: some SwiftUI.View {
        EmptyView()
    }
}

#endif

// MARK: - CustomStringConvertible

extension Nil: CustomStringConvertible {
    var description: String {
        "nil"
    }
}
