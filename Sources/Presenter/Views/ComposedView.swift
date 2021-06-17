
struct ComposedView: InternalView, Codable {

    // MARK: Stored Properties

    let content: CoderView
    let modifiers: [CoderViewModifier]

}

// MARK: - CustomStringConvertible

extension ComposedView: CustomStringConvertible {

    public var description: String {
        "\(content)" + modifiers.reduce("") { $0 + ".\($1)" }
    }

}

// MARK: - View

#if canImport(SwiftUI)

extension ComposedView {

    var view: _View {
        modifiers.reduce(content as _View) { $0.apply($1) }
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func modified(using modifier: AnyViewModifying) -> some View {
        if let composition = self as? ComposedView {
            return ComposedView(content: composition.content,
                                modifiers: composition.modifiers + [CoderViewModifier(modifier)])
        }
        return ComposedView(content: CoderView(self),
                            modifiers: [CoderViewModifier(modifier)])
    }

}
