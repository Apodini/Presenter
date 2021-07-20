@resultBuilder
public enum ViewBuilder {
    // MARK: Static Functions

    public static func buildBlock<V: View>(_ item: V) -> View {
        item
    }

    public static func buildBlock(_ items: View...) -> View {
        ArrayView(content: items)
    }

    public static func buildBlock(_ items: [View]) -> View {
        ArrayView(content: items)
    }

    public static func buildEither(first: View) -> View {
        first
    }

    public static func buildEither(second: View) -> View {
        second
    }

    static func buildIf(_ content: View?) -> View? {
        content
    }
}
