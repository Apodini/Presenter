
public protocol InternalView: View where Body == Never {
    var view: _View { get }
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
