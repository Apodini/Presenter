
internal struct AnimationModifier: AnyViewModifying {

    // MARK: Stored Properties

    let animation: Animation

}

// MARK: - CustomStringConvertible

extension AnimationModifier: CustomStringConvertible {

    var description: String {
        "animation(\(animation))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension AnimationModifier: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.animation(animation.animation)
    }

}

#endif

// MARK: - View Extensions

extension View {

    public func animation(_ animation: Animation?) -> some View {
        modified(using: AnimationModifier(animation: animation ?? .none))
    }

}
