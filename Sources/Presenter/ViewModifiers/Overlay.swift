
internal struct Overlay: AnyViewModifying {

    // MARK: Stored Properties

    let overlay: CoderView
    let alignment: Alignment?

}

// MARK: - CustomStringConvertible

extension Overlay: CustomStringConvertible {

    var description: String {
        "overlay(\(overlay), alignment: \(alignment ?? .center))"
    }

}

// MARK: - ViewModifier

#if canImport(SwiftUI)

extension Overlay: ViewModifier {

    func body(content: Content) -> some SwiftUI.View {
        content.overlay(overlay.eraseToAnyView(),
                        alignment: alignment?.swiftUIValue ?? .center)
    }
}

#endif

// MARK: - View Extensions

extension View {

    public func overlay<O: View>(_ overlay: O, alignment: Alignment? = nil) -> some View {
        modified(using: Overlay(overlay: CoderView(overlay), alignment: alignment))
    }

}
