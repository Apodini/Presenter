#if canImport(SwiftUI)

public class Model: ObservableObject {
    // MARK: Stored Properties

    @Published private var state = [String: Any]()

    // MARK: Initialization

    public init() {}

    // MARK: Methods

    public func binding<T>(for binding: Binding<T>) -> SwiftUI.Binding<T> {
        SwiftUI.Binding(
            get: { (self.state[binding.key] as? T) ?? binding.default },
            set: { self.state[binding.key] = $0 }
        )
    }

    public func binding<T, U>(for binding: Binding<T>, map: (T) -> U) -> SwiftUI.Binding<U> {
        let defaultValue = map(binding.default)
        return SwiftUI.Binding(
            get: { (self.state[binding.key] as? U) ?? defaultValue },
            set: { self.state[binding.key] = $0 }
        )
    }

    public func action(for action: Action?) -> () -> Void {
        { action?.perform(on: self) }
    }

    public func action<T>(for action: Action?) -> (T) -> Void {
        { _ in action?.perform(on: self) }
    }

    public func get(_ key: String) -> Any? {
        state[key]
    }

    public func set(_ key: String, to value: Any?) {
        state[key] = value
    }
}

#endif
