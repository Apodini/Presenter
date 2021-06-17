
extension Presenter {

    // MARK: View

    public static func use<View: _CodableView>(view: View.Type) {
        CoderView.register(View.self)
    }

    public static func remove<View: _CodableView>(view: View.Type) {
        CoderView.unregister(View.self)
    }

    // MARK: View Modifier

    public static func use<Modifier: AnyViewModifying>(modifier: Modifier.Type) {
        CoderViewModifier.register(Modifier.self)
    }

    public static func remove<Modifier: AnyViewModifying>(modifier: Modifier.Type) {
        CoderViewModifier.unregister(Modifier.self)
    }

    // MARK: Model Action

    public static func use<A: Action>(action: A.Type) {
        CoderAction.register(A.self)
    }

    public static func remove<A: Action>(action: A.Type) {
        CoderAction.unregister(A.self)
    }

}
