
public typealias _CodableView = _View & Codable

public protocol _View: NamedType {

    var erasedCodableBody: _CodableView? { get }

    #if canImport(SwiftUI)

    func eraseToAnyView() -> AnyView
    func apply<M: ViewModifier>(_ m: M) -> _View
    func apply(_ modifier: AnyViewModifying) -> _View

    #endif

}

#if canImport(SwiftUI)

extension _View where Self: SwiftUI.View {

    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    public func apply<M: ViewModifier>(_ m: M) -> _View {
        modifier(m)
    }

    public func apply(_ modifier: AnyViewModifying) -> _View {
        modifier.apply(to: self)
    }

}

#endif


public protocol View: _View, Codable {
    associatedtype Body: View
    var body: Body { get }
}

extension Never: View {

    public var body: Never {
        get {
            fatalError("This can't happen.")
        }
    }

    public init(from decoder: Decoder) throws {
        fatalError()
    }

    public func encode(to encoder: Encoder) throws {
        switch self {}
    }

}

extension View {

    public var erasedCodableBody: _CodableView? {
        Body.self == Never.self ? nil : body
    }

}

#if canImport(SwiftUI)

extension View {

    public func eraseToAnyView() -> AnyView {
        body.eraseToAnyView()
    }

    public func apply<M: ViewModifier>(_ modifier: M) -> _View {
        body.apply(modifier)
    }

    public func apply(_ modifier: AnyViewModifying) -> _View {
        body.apply(modifier)
    }

}

#endif
