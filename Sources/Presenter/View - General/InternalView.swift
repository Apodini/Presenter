
public protocol InternalView: View where Body == Never {

    #if canImport(SwiftUI)
    var view: _View { get }
    #endif

}

extension InternalView {

    public var body: Never {
        fatalError()
    }

    #if canImport(SwiftUI)

    public func eraseToAnyView() -> AnyView {
        view.eraseToAnyView()
    }

    public func apply<M: ViewModifier>(_ modifier: M) -> _View {
        view.apply(modifier)
    }

    public func apply(_ modifier: AnyViewModifying) -> _View {
        view.apply(modifier)
    }

    #endif

}
