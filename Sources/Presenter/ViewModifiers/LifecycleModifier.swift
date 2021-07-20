
internal struct LifecycleModifier: CodableViewModifier {

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

extension LifecycleModifier: SwiftUI.ViewModifier {

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

    public func onAppear(perform action: Action) -> View {
        modifier(LifecycleModifier(onAppear: CoderAction(action), onDisappear: nil))
    }

    public func onDisappear(perform action: Action) -> View {
        modifier(LifecycleModifier(onAppear: nil, onDisappear: CoderAction(action)))
    }

}
