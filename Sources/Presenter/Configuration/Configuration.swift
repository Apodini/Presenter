public enum Presenter {
    // MARK: Decoding

    public static func decode(
        from data: Data,
        decoder: JSONDecoder = .init()
    ) throws -> View {
        try decoder.decode(CoderView.self, from: data)
    }

    #if canImport(Combine)

    public static func decode<Decoder: TopLevelDecoder>(
        from data: Decoder.Input,
        decoder: Decoder
    ) throws -> View {
        try decoder.decode(CoderView.self, from: data)
    }

    #endif

    // MARK: Encoding

    public static func encode(
        _ view: View,
        encoder: JSONEncoder = .init()
    ) throws -> Data {
        try encoder.encode(CoderView(view))
    }

    #if canImport(Combine)

    public static func encode<Encoder: TopLevelEncoder>(
        _ view: View,
        encoder: Encoder
    ) throws -> Encoder.Output {
        try encoder.encode(CoderView(view))
    }

    #endif
}
