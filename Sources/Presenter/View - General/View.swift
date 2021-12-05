public typealias CodableView = View & Decodable

public protocol View: NamedType, Encodable {
    #if canImport(SwiftUI)
    func eraseToAnyView() -> AnyView
    func apply<Modifier: ViewModifier>(_ modifier: Modifier) -> View
    #endif
}

public typealias CodableWrapperView = WrapperView & Decodable

public protocol WrapperView: View {
    #if canImport(SwiftUI)
    var body: View { get }
    #endif
}

#if canImport(SwiftUI)

extension WrapperView {
    public func eraseToAnyView() -> AnyView {
        body.eraseToAnyView()
    }

    public func apply<Modifier: ViewModifier>(_ modifier: Modifier) -> View {
        body.apply(modifier)
    }
}

#endif

public protocol UserView: WrapperView {
    var body: View { get }
}

extension UserView {
    func encode(to encoder: Encoder) throws {
        try body.encode(to: encoder)
    }
}

#if canImport(SwiftUI)

extension View where Self: SwiftUI.View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    public func apply<Modifier: ViewModifier>(_ modifier: Modifier) -> View {
        modifier.body(for: self)
    }
}

#endif
