
public protocol AnyViewModifying: Codable, NamedType {

    #if canImport(SwiftUI)

    func apply<V: SwiftUI.View>(to view: V) -> _View

    #endif

}

#if canImport(SwiftUI)

extension AnyViewModifying where Self: ViewModifier {

    public func apply<V: SwiftUI.View>(to view: V) -> _View {
        view.modifier(self)
    }

}

extension ModifiedContent: _View, NamedType where Content: SwiftUI.View, Modifier: ViewModifier {

    public var erasedCodableBody: _CodableView? {
        nil
    }

}

#endif
