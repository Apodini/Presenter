
internal struct LifecycleModifier: AnyViewModifying {

    // MARK: Stored Properties

    let onAppear: CoderAction?
    let onDisappear: CoderAction?

}

// MARK: - CustomStringConvertible

extension LifecycleModifier: CustomStringConvertible {

    var description: String {
        onAppear != nil
        ? "onAppear(...)"
        : "onDisappear(...)"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension LifecycleModifier: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        ModelView { model in
            content
            .onAppear(perform: model.action(for: self.onAppear))
            .onDisappear(perform: model.action(for: self.onDisappear))
        }
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func onAppear(perform action: Action) -> some View {
        modified(using: LifecycleModifier(onAppear: CoderAction(action), onDisappear: nil))
    }

    public func onDisappear(perform action: Action) -> some View {
        modified(using: LifecycleModifier(onAppear: nil, onDisappear: CoderAction(action)))
    }

}
