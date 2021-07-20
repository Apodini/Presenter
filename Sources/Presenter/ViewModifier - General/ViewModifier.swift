
public typealias CodableViewModifier = Codable & ViewModifier

public protocol ViewModifier: NamedType {

    #if canImport(SwiftUI)

    func body<Content: SwiftUI.View>(for content: Content) -> View

    #endif

}

#if canImport(SwiftUI)

extension ViewModifier where Self: SwiftUI.ViewModifier {

    public func body<Content: SwiftUI.View>(for content: Content) -> View {
        content.modifier(self)
    }

}

extension ModifiedContent: View, Encodable, NamedType
    where Content: SwiftUI.View, Modifier: SwiftUI.ViewModifier {

    public func encode(to encoder: Encoder) throws {
        guard let content = content as? View,
              let modifier = modifier as? ViewModifier else {
            assertionFailure("Why?")
            return
        }
        try modifier.encode(with: content, to: encoder)
    }

}

extension ViewModifier {

    fileprivate func encode(with view: View, to encoder: Encoder) throws {
        try CoderView(view)
            .modifier(self)
            .encode(to: encoder)
    }

}

#endif
