
public protocol SwiftUIView: View where Body == Never {

    #if canImport(SwiftUI)
    associatedtype SwiftUIBody: SwiftUI.View
    var view: SwiftUIBody { get }
    #endif

}

extension SwiftUIView {

    public var body: Never {
        fatalError()
    }

    #if canImport(SwiftUI)

    public func eraseToAnyView() -> AnyView {
        AnyView(view)
    }

    public func apply<M: ViewModifier>(_ modifier: M) -> _View {
        view.modifier(modifier)
    }

    public func apply(_ modifier: AnyViewModifying) -> _View {
        modifier.apply(to: view)
    }

    #endif

}
