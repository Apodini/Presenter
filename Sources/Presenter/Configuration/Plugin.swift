
public protocol Plugin {

    func willAdd()
    func didAdd()

    func willRemove()
    func didRemove()

    var views: [_CodableView.Type] { get }
    var viewModifiers: [AnyViewModifying.Type] { get }
    var actions: [Action.Type] { get }
    var plugins: [Plugin] { get }

}

extension Plugin {

    public func willAdd() {}
    public func didAdd() {}

    public func willRemove() {}
    public func didRemove() {}

    public var views: [_CodableView.Type] { [] }
    public var viewModifiers: [AnyViewModifying.Type] { [] }
    public var actions: [Action.Type] { [] }
    public var plugins: [Plugin] { [] }

}
