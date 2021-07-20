
public protocol Plugin {

    func willAdd()
    func didAdd()

    func willRemove()
    func didRemove()

    var views: [CodableView.Type] { get }
    var viewModifiers: [CodableViewModifier.Type] { get }
    var actions: [Action.Type] { get }
    var plugins: [Plugin] { get }

}

extension Plugin {

    public func willAdd() {}
    public func didAdd() {}

    public func willRemove() {}
    public func didRemove() {}

    public var views: [CodableView.Type] { [] }
    public var viewModifiers: [CodableViewModifier.Type] { [] }
    public var actions: [Action.Type] { [] }
    public var plugins: [Plugin] { [] }

}
