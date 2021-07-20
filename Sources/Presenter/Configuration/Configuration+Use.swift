
extension Presenter {

    // MARK: View

    public static func use<V: CodableView>(view: V.Type) {
        CoderView.register(V.self)
    }

    public static func remove<V: CodableView>(view: V.Type) {
        CoderView.unregister(V.self)
    }

    // MARK: View Modifier

    public static func use<Modifier: CodableViewModifier>(modifier: Modifier.Type) {
        CoderViewModifier.register(Modifier.self)
    }

    public static func remove<Modifier: CodableViewModifier>(modifier: Modifier.Type) {
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
