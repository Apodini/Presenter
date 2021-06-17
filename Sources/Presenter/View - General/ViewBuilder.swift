
@resultBuilder
public struct ViewBuilder {

    // MARK: Static Functions

    public static func buildBlock<V: View>(_ item: V) -> some View {
        item
    }

    public static func buildBlock(_ items: _CodableView...) -> some View {
        ArrayView(content: items)
    }

    public static func buildBlock(_ items: [_CodableView]) -> some View {
        ArrayView(content: items)
    }

    public static func buildEither<V: View>(first: V) -> V {
        first
    }

    public static func buildEither<V: View>(second: V) -> V {
        second
    }

    static func buildIf<V: View>(_ content: V?) -> V? {
        content
    }

}
