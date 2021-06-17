
internal struct Mask: AnyViewModifying {

    // MARK: Stored Properties

    let mask: CoderView

}

// MARK: - CustomStringConvertible

extension Mask: CustomStringConvertible {

    var description: String {
        "mask(\(mask))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Mask: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.mask(mask.eraseToAnyView())
    }
}

#endif

// MARK: - View Extensions

extension View {

    public func mask<M: View>(_ mask: M) -> some View {
        modified(using: Mask(mask: CoderView(mask)))
    }

}
