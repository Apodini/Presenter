
public enum Presenter {

    // MARK: Decoding

    public static func decode(
        from data: Data,
        decoder: JSONDecoder = .init()
    ) throws -> some View {

        try decoder.decode(CoderView.self, from: data)
    }

    #if canImport(Combine)

    public static func decode<Decoder: TopLevelDecoder>(
        from data: Decoder.Input,
        decoder: Decoder
    ) throws -> some View {

        try decoder.decode(CoderView.self, from: data)
    }

    #endif

    // MARK: Encoding

    public static func encode<V: View>(
        _ view: V,
        encoder: JSONEncoder = .init()
    ) throws -> Data {

        try encoder.encode(CoderView(view))
    }

    #if canImport(Combine)

    public static func encode<V: View, Encoder: TopLevelEncoder>(
        _ view: V,
        encoder: Encoder
    ) throws -> Encoder.Output {

        try encoder.encode(CoderView(view))
    }

    #endif

}
