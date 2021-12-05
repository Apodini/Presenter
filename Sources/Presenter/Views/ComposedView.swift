struct ComposedView: CodableWrapperView {
    // MARK: Stored Properties

    let content: CoderView
    let modifiers: [CoderViewModifier]
}

// MARK: - CustomStringConvertible

extension ComposedView: CustomStringConvertible {
    public var description: String {
        "\(content)" + modifiers.reduce(into: "") { $0 += ".\($1)" }
    }
}

// MARK: - View

#if canImport(SwiftUI)

extension ComposedView {
    public var body: View {
        modifiers.reduce(content as View) { $0.apply($1) }
    }
}

#endif

// MARK: - View Extensions

extension View {
    public func modifier<Modifier: ViewModifier>(_ modifier: Modifier) -> View {
        if let composition = self as? ComposedView {
            return ComposedView(content: composition.content,
                                modifiers: composition.modifiers + [CoderViewModifier(modifier)])
        }
        return ComposedView(content: CoderView(self),
                            modifiers: [CoderViewModifier(modifier)])
    }
}
