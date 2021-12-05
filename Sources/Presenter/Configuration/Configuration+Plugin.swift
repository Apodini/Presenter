import Foundation

extension Presenter {
    private static var didImportPlugins = false

    // MARK: Plugins

    internal static func usePlugins() {
        guard !didImportPlugins else {
            return
        }
        didImportPlugins = true
        use(plugin: DefaultPlugin())
    }

    public static func use<P: Plugin>(plugin: P) {
        plugin.willAdd()
        plugin.views.forEach { $0.use() }
        plugin.viewModifiers.forEach { $0.use() }
        plugin.actions.forEach { $0.use() }
        plugin.plugins.forEach { $0.use() }
        plugin.didAdd()
    }

    public static func remove<P: Plugin>(plugin: P) {
        plugin.willRemove()
        plugin.views.forEach { $0.remove() }
        plugin.viewModifiers.forEach { $0.remove() }
        plugin.actions.forEach { $0.remove() }
        plugin.plugins.forEach { $0.remove() }
        plugin.didRemove()
    }
}

extension View where Self: Decodable {
    fileprivate static func use() {
        Presenter.use(view: Self.self)
    }

    fileprivate static func remove() {
        Presenter.remove(view: Self.self)
    }
}

extension ViewModifier where Self: Codable {
    fileprivate static func use() {
        Presenter.use(modifier: Self.self)
    }

    fileprivate static func remove() {
        Presenter.remove(modifier: Self.self)
    }
}

extension Action {
    fileprivate static func use() {
        Presenter.use(action: Self.self)
    }

    fileprivate static func remove() {
        Presenter.remove(action: Self.self)
    }
}

extension Plugin {
    fileprivate func use() {
        Presenter.use(plugin: self)
    }

    fileprivate func remove() {
        Presenter.remove(plugin: self)
    }
}
